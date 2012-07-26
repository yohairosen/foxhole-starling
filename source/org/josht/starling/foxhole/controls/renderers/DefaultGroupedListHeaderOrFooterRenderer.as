/*
 Copyright (c) 2012 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package org.josht.starling.foxhole.controls.renderers
{
	import org.josht.starling.foxhole.controls.GroupedList;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.core.FoxholeControl;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * The default renderer used for headers and footers in a GroupedList
	 * control.
	 */
	public class DefaultGroupedListHeaderOrFooterRenderer extends FoxholeControl implements IGroupedListHeaderOrFooterRenderer
	{
		/**
		 * @private
		 */
		protected static function defaultImageFactory(texture:Texture):Image
		{
			return new Image(texture);
		}

		/**
		 * @private
		 */
		protected static function defaultLabelFactory():Label
		{
			return new Label();
		}

		/**
		 * Constructor.
		 */
		public function DefaultGroupedListHeaderOrFooterRenderer()
		{
		}

		/**
		 * @private
		 */
		protected var contentImage:Image;

		/**
		 * @private
		 */
		protected var contentLabel:Label;

		/**
		 * @private
		 */
		protected var content:DisplayObject;

		/**
		 * @private
		 */
		private var _data:Object;

		/**
		 * @inheritDoc
		 */
		public function get data():Object
		{
			return this._data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _groupIndex:int = -1;

		/**
		 * @inheritDoc
		 */
		public function get groupIndex():int
		{
			return this._groupIndex;
		}

		/**
		 * @private
		 */
		public function set groupIndex(value:int):void
		{
			this._groupIndex = value;
		}

		/**
		 * @private
		 */
		protected var _owner:GroupedList;

		/**
		 * @inheritDoc
		 */
		public function get owner():GroupedList
		{
			return this._owner;
		}

		/**
		 * @private
		 */
		public function set owner(value:GroupedList):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentField:String = "content";

		/**
		 * The field in the item that contains a display object to be positioned
		 * in the content position of the renderer. If you wish to display an
		 * <code>Image</code> in the content position, it's better for
		 * performance to use <code>contentTextureField</code> instead.
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentTextureField
		 * @see #contentFunction
		 * @see #contentTextureFunction
		 * @see #contentLabelField
		 * @see #contentLabelFunction
		 */
		public function get contentField():String
		{
			return this._contentField;
		}

		/**
		 * @private
		 */
		public function set contentField(value:String):void
		{
			if(this._contentField == value)
			{
				return;
			}
			this._contentField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentFunction:Function;

		/**
		 * A function that returns a display object to be positioned in the
		 * content position of the renderer. If you wish to display an
		 * <code>Image</code> in the content position, it's better for
		 * performance to use <code>contentTextureFunction</code> instead.
		 *
		 * <p>The function is expected to have the following signature:</p>
		 * <pre>function( item:Object ):DisplayObject</pre>
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentField
		 * @see #contentTextureField
		 * @see #contentTextureFunction
		 * @see #contentLabelField
		 * @see #contentLabelFunction
		 */
		public function get contentFunction():Function
		{
			return this._contentFunction;
		}

		/**
		 * @private
		 */
		public function set contentFunction(value:Function):void
		{
			if(this._contentFunction == value)
			{
				return;
			}
			this._contentFunction = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentTextureField:String = "texture";

		/**
		 * The field in the item that contains a texture to be displayed in a
		 * renderer-managed <code>Image</code> in the content position of the
		 * renderer. The renderer will automatically reuse an internal
		 * <code>Image</code> and swap the texture when the renderer's data
		 * changes. This <code>Image</code> may be customized by
		 * changing the <code>contentImageFactory</code>.
		 *
		 * <p>Using an content texture will result in better performance than
		 * passing in an <code>Image</code> through a <code>contentField</code>
		 * or <code>contentFunction</code> because the renderer can avoid
		 * costly display list manipulation.</p>
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentImageFactory
		 * @see #contentTextureFunction
		 * @see #contentField
		 * @see #contentFunction
		 * @see #contentLabelField
		 * @see #contentLabelFunction
		 */
		public function get contentTextureField():String
		{
			return this._contentTextureField;
		}

		/**
		 * @private
		 */
		public function set contentTextureField(value:String):void
		{
			if(this._contentTextureField == value)
			{
				return;
			}
			this._contentTextureField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentTextureFunction:Function;

		/**
		 * A function that returns a texture to be displayed in a
		 * renderer-managed <code>Image</code> in the content position of the
		 * renderer. The renderer will automatically reuse an internal
		 * <code>Image</code> and swap the texture when the renderer's data
		 * changes. This <code>Image</code> may be customized by
		 * changing the <code>contentImageFactory</code>.
		 *
		 * <p>Using an content texture will result in better performance than
		 * passing in an <code>Image</code> through a <code>contentField</code>
		 * or <code>contentFunction</code> because the renderer can avoid
		 * costly display list manipulation.</p>
		 *
		 * <p>The function is expected to have the following signature:</p>
		 * <pre>function( item:Object ):Texture</pre>
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentImageFactory
		 * @see #contentTextureField
		 * @see #contentField
		 * @see #contentFunction
		 * @see #contentLabelField
		 * @see #contentLabelFunction
		 */
		public function get contentTextureFunction():Function
		{
			return this._contentTextureFunction;
		}

		/**
		 * @private
		 */
		public function set contentTextureFunction(value:Function):void
		{
			if(this.contentTextureFunction == value)
			{
				return;
			}
			this._contentTextureFunction = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentLabelField:String = "label";

		/**
		 * The field in the item that contains a string to be displayed in a
		 * renderer-managed <code>Label</code> in the content position of the
		 * renderer. The renderer will automatically reuse an internal
		 * <code>Label</code> and swap the text when the data changes. This
		 * <code>Label</code> may be skinned by changing the
		 * <code>contentLabelFactory</code>.
		 *
		 * <p>Using an content label will result in better performance than
		 * passing in a <code>Label</code> through a <code>contentField</code>
		 * or <code>contentFunction</code> because the renderer can avoid
		 * costly display list manipulation.</p>
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentLabelFactory
		 * @see #contentLabelFunction
		 * @see #contentField
		 * @see #contentFunction
		 * @see #contentTextureField
		 * @see #contentTextureFunction
		 */
		public function get contentLabelField():String
		{
			return this._contentLabelField;
		}

		/**
		 * @private
		 */
		public function set contentLabelField(value:String):void
		{
			if(this._contentLabelField == value)
			{
				return;
			}
			this._contentLabelField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _contentLabelFunction:Function;

		/**
		 * A function that returns a string to be displayed in a
		 * renderer-managed <code>Label</code> in the content position of the
		 * renderer. The renderer will automatically reuse an internal
		 * <code>Label</code> and swap the text when the data changes. This
		 * <code>Label</code> may be skinned by changing the
		 * <code>contentLabelFactory</code>.
		 *
		 * <p>Using an content label will result in better performance than
		 * passing in a <code>Label</code> through a <code>contentField</code>
		 * or <code>contentFunction</code> because the renderer can avoid
		 * costly display list manipulation.</p>
		 *
		 * <p>The function is expected to have the following signature:</p>
		 * <pre>function( item:Object ):String</pre>
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 *
		 * @see #contentLabelFactory
		 * @see #contentLabelField
		 * @see #contentField
		 * @see #contentFunction
		 * @see #contentTextureField
		 * @see #contentTextureFunction
		 */
		public function get contentLabelFunction():Function
		{
			return this._contentLabelFunction;
		}

		/**
		 * @private
		 */
		public function set contentLabelFunction(value:Function):void
		{
			if(this._contentLabelFunction == value)
			{
				return;
			}
			this._contentLabelFunction = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * Uses the content fields and functions to generate content for a
		 * specific group header or footer.
		 *
		 * <p>All of the content fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>contentTextureFunction</code></li>
		 *     <li><code>contentTextureField</code></li>
		 *     <li><code>contentLabelFunction</code></li>
		 *     <li><code>contentLabelField</code></li>
		 *     <li><code>contentFunction</code></li>
		 *     <li><code>contentField</code></li>
		 * </ol>
		 */
		protected function itemToContent(item:Object):DisplayObject
		{
			if(this._contentTextureFunction != null)
			{
				var texture:Texture = this._contentTextureFunction(item) as Texture;
				this.refreshContentTexture(texture);
				return this.contentImage;
			}
			else if(this._contentTextureField != null && item && item.hasOwnProperty(this._contentTextureField))
			{
				texture = item[this._contentTextureField] as Texture;
				this.refreshContentTexture(texture);
				return this.contentImage;
			}
			else if(this._contentLabelFunction != null)
			{
				var label:String = this._contentLabelFunction(item) as String;
				this.refreshContentLabel(label);
				return this.contentLabel;
			}
			else if(this._contentLabelField != null && item && item.hasOwnProperty(this._contentLabelField))
			{
				label = item[this._contentLabelField] as String;
				this.refreshContentLabel(label);
				return this.contentLabel;
			}
			else if(this._contentFunction != null)
			{
				return this._contentFunction(item) as DisplayObject;
			}
			else if(this._contentField != null && item && item.hasOwnProperty(this._contentField))
			{
				return item[this._contentField] as DisplayObject;
			}
			else if(item)
			{
				this.refreshContentLabel(item.toString());
				return this.contentLabel;
			}

			return null;
		}

		/**
		 * @private
		 */
		protected var _contentImageFactory:Function = defaultImageFactory;

		/**
		 * A function that generates an <code>Image</code> that uses the result
		 * of <code>accessoryTextureField</code> or <code>accessoryTextureFunction</code>.
		 * Useful for transforming the <code>Image</code> in some way. For
		 * example, you might want to scale it for current DPI.
		 *
		 * @see #contentTextureField;
		 * @see #contentTextureFunction;
		 */
		public function get contentImageFactory():Function
		{
			return this._contentImageFactory;
		}

		/**
		 * @private
		 */
		public function set contentImageFactory(value:Function):void
		{
			if(this._contentImageFactory == value)
			{
				return;
			}
			this._contentImageFactory = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var _contentLabelFactory:Function = defaultLabelFactory;

		/**
		 * A function that generates <code>Label</code> that uses the result
		 * of <code>accessoryLabelField</code> or <code>accessoryLabelFunction</code>.
		 * Useful for skinning the <code>Label</code>.
		 *
		 * @see #contentLabelField;
		 * @see #contentLabelFunction;
		 */
		public function get contentLabelFactory():Function
		{
			return this._contentLabelFactory;
		}

		/**
		 * @private
		 */
		public function set contentLabelFactory(value:Function):void
		{
			if(this._contentLabelFactory == value)
			{
				return;
			}
			this._contentLabelFactory = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var originalBackgroundWidth:Number = NaN;

		/**
		 * @private
		 */
		protected var originalBackgroundHeight:Number = NaN;

		/**
		 * @private
		 */
		protected var currentBackgroundSkin:DisplayObject;

		/**
		 * @private
		 */
		private var _backgroundSkin:DisplayObject;

		/**
		 * A background to behind the component's content.
		 */
		public function get backgroundSkin():DisplayObject
		{
			return this._backgroundSkin;
		}

		/**
		 * @private
		 */
		public function set backgroundSkin(value:DisplayObject):void
		{
			if(this._backgroundSkin == value)
			{
				return;
			}

			if(this._backgroundSkin && this._backgroundSkin != this._backgroundDisabledSkin)
			{
				this.removeChild(this._backgroundSkin);
			}
			this._backgroundSkin = value;
			if(this._backgroundSkin && this._backgroundSkin.parent != this)
			{
				this._backgroundSkin.visible = false;
				this.addChildAt(this._backgroundSkin, 0);
			}
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		private var _backgroundDisabledSkin:DisplayObject;

		/**
		 * A background to display when the component is disabled.
		 */
		public function get backgroundDisabledSkin():DisplayObject
		{
			return this._backgroundDisabledSkin;
		}

		/**
		 * @private
		 */
		public function set backgroundDisabledSkin(value:DisplayObject):void
		{
			if(this._backgroundDisabledSkin == value)
			{
				return;
			}

			if(this._backgroundDisabledSkin && this._backgroundDisabledSkin != this._backgroundSkin)
			{
				this.removeChild(this._backgroundDisabledSkin);
			}
			this._backgroundDisabledSkin = value;
			if(this._backgroundDisabledSkin && this._backgroundDisabledSkin.parent != this)
			{
				this._backgroundDisabledSkin.visible = false;
				this.addChildAt(this._backgroundDisabledSkin, 0);
			}
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var _paddingTop:Number = 0;

		/**
		 * The minimum space, in pixels, between the component's top edge and
		 * the component's content.
		 */
		public function get paddingTop():Number
		{
			return this._paddingTop;
		}

		/**
		 * @private
		 */
		public function set paddingTop(value:Number):void
		{
			if(this._paddingTop == value)
			{
				return;
			}
			this._paddingTop = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var _paddingRight:Number = 0;

		/**
		 * The minimum space, in pixels, between the component's right edge
		 * and the component's content.
		 */
		public function get paddingRight():Number
		{
			return this._paddingRight;
		}

		/**
		 * @private
		 */
		public function set paddingRight(value:Number):void
		{
			if(this._paddingRight == value)
			{
				return;
			}
			this._paddingRight = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var _paddingBottom:Number = 0;

		/**
		 * The minimum space, in pixels, between the component's bottom edge
		 * and the component's content.
		 */
		public function get paddingBottom():Number
		{
			return this._paddingBottom;
		}

		/**
		 * @private
		 */
		public function set paddingBottom(value:Number):void
		{
			if(this._paddingBottom == value)
			{
				return;
			}
			this._paddingBottom = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		protected var _paddingLeft:Number = 0;

		/**
		 * The minimum space, in pixels, between the component's left edge
		 * and the component's content.
		 */
		public function get paddingLeft():Number
		{
			return this._paddingLeft;
		}

		/**
		 * @private
		 */
		public function set paddingLeft(value:Number):void
		{
			if(this._paddingLeft == value)
			{
				return;
			}
			this._paddingLeft = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		/**
		 * @private
		 */
		override public function dispose():void
		{
			//the content may have come from outside of this class. it's up
			//to that code to dispose of the content. in fact, if we disposed
			//of it here, we might screw something up!
			if(this.content)
			{
				this.content.removeFromParent();
			}

			//however, we need to dispose these, if they exist, since we made
			//them here.
			if(this.contentImage)
			{
				this.contentImage.dispose();
				this.contentImage = null;
			}
			if(this.contentLabel)
			{
				this.contentLabel.dispose();
				this.contentLabel = null;
			}
			super.dispose();
		}

		/**
		 * @private
		 */
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			const stateInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STATE);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);

			if(stylesInvalid || stateInvalid)
			{
				this.refreshBackgroundSkin();
			}

			if(dataInvalid)
			{
				this.commitData();
			}

			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if(dataInvalid)
			{
				if(this.content)
				{
					this.content.x = this._paddingLeft;
					this.content.y = this._paddingTop;
				}
			}

			if(sizeInvalid || stylesInvalid || stateInvalid)
			{
				if(this.currentBackgroundSkin)
				{
					this.currentBackgroundSkin.width = this.actualWidth;
					this.currentBackgroundSkin.height = this.actualHeight;
				}
			}
		}

		/**
		 * @private
		 */
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			if(this.content is FoxholeControl)
			{
				FoxholeControl(this.content).validate();
			}
			if(!this.content)
			{
				return this.setSizeInternal(0, 0, false);
			}
			var newWidth:Number = this.explicitWidth;
			var newHeight:Number = this.explicitHeight;
			if(needsWidth)
			{
				newWidth = this.content.width + this._paddingLeft + this._paddingRight;
				if(!isNaN(this.originalBackgroundWidth))
				{
					newWidth = Math.max(newWidth, this.originalBackgroundWidth);
				}
			}
			if(needsHeight)
			{
				newHeight = this.content.height + this._paddingTop + this._paddingBottom;
				if(!isNaN(this.originalBackgroundHeight))
				{
					newHeight = Math.max(newHeight, this.originalBackgroundHeight);
				}
			}
			return this.setSizeInternal(newWidth, newHeight, false);
		}

		/**
		 * @private
		 */
		protected function refreshBackgroundSkin():void
		{
			this.currentBackgroundSkin = this._backgroundSkin;
			if(!this._isEnabled && this._backgroundDisabledSkin)
			{
				if(this._backgroundSkin)
				{
					this._backgroundSkin.visible = false;
				}
				this.currentBackgroundSkin = this._backgroundDisabledSkin;
			}
			else if(this._backgroundDisabledSkin)
			{
				this._backgroundDisabledSkin.visible = false;
			}
			if(this.currentBackgroundSkin)
			{
				if(isNaN(this.originalBackgroundWidth))
				{
					this.originalBackgroundWidth = this.currentBackgroundSkin.width;
				}
				if(isNaN(this.originalBackgroundHeight))
				{
					this.originalBackgroundHeight = this.currentBackgroundSkin.height;
				}
				this.currentBackgroundSkin.visible = true;
			}
		}

		/**
		 * @private
		 */
		protected function commitData():void
		{
			if(this._owner)
			{
				const newContent:DisplayObject = this.itemToContent(this._data);
				if(newContent != this.content)
				{
					if(this.content)
					{
						this.content.removeFromParent();
					}
					this.content = newContent;
					if(this.content)
					{
						this.addChild(this.content);
					}
				}
			}
			else
			{
				if(this.content)
				{
					this.content.removeFromParent();
					this.content = null;
				}
			}
		}

		/**
		 * @private
		 */
		protected function refreshContentTexture(texture:Texture):void
		{
			if(texture)
			{
				if(!this.contentImage)
				{
					this.contentImage = this._contentImageFactory(texture);
				}
				else
				{
					this.contentImage.texture = texture;
					this.contentImage.readjustSize();
				}
			}
			else if(this.contentImage)
			{
				this.contentImage.removeFromParent(true);
				this.contentImage = null;
			}
		}

		/**
		 * @private
		 */
		protected function refreshContentLabel(label:String):void
		{
			if(label !== null)
			{
				if(!this.contentLabel)
				{
					this.contentLabel = this._contentLabelFactory();
				}
				this.contentLabel.text = label;
			}
			else if(this.contentLabel)
			{
				this.contentLabel.removeFromParent(true);
				this.contentLabel = null;
			}
		}
	}
}
