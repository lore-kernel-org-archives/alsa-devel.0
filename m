From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: add rockchip i2s bindings
Date: Fri, 4 Jul 2014 17:55:31 +0100
Message-ID: <20140704165531.GD7106@leverpostej>
References: <1404203860-30712-2-git-send-email-xjq@rock-chips.com>
 <1404458796-6818-1-git-send-email-xjq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404458796-6818-1-git-send-email-xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, kfx@rock-chips
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2014 at 08:26:36AM +0100, jianqun wrote:
> From: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> Add devicetree bindings for i2s controller found on
> rk3066, rk3188 and rk3288 processors from rockchip.
> 
> Signed-off-by: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes since v1:
> - modify the description of clock-names property, adviced by Mark Rutland.
> - modify the example to fit for rk3288.
> 
>  .../devicetree/bindings/sound/rockchip-i2s.txt     |   36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> new file mode 100644
> index 0000000..9fc577d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> @@ -0,0 +1,36 @@
> +* Rockchip I2S controller
> +
> +The I2S bus (Inter-IC sound bus) is a serial link for digital
> +audio data transfer between devices in the system.
> +
> +Required properties:
> +
> +- compatible: should be one of the followings
> +   - "rockchip,rk3066-i2s": for rk3066
> +   - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
> +   - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +  depends on the interrupt controller.

Just state _which_ interrupt this is from the view of the device.

> +- #address-cells: should be 1.
> +- #size-cells: should be 0.
> +- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> +	Documentation/devicetree/bindings/dma/dma.txt
> +- dma-names: DMA request names should include "tx" and "rx" if present.

Just say:

- dma-names: should include "tx" and "rx"

If we need more DMAs or descriptions thereof, expand into a bulleted
list.

> +- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
> +- clock-names: Shall be "i2s_hclk" for I2S bus and "i2s_clk" for master clock

This was easier to read as a bulleted list than inline:

- clock-names: should include:
  - "i2s_hclk" for the I2S bus clock
  - "i2s_clk" for the master clock

> +
> +Example, for rk3288 I2S controller:
> +
> +i2s0: i2s@ff890000 {
> +	compatible = "rockchip,rk3066-i2s", "rockchip,rk3288-i2s";

This is the wrong way around per the documentation of the compatible
string.

Thanks,
Mark.

> +	reg = <0xff890000 0x10000>;
> +	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	dmas = <&pdma1 0>, <&pdma1 1>;
> +	dma-names = "rx", "tx";
> +	clock-names = "i2s_hclk", "i2s_clk";
> +	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
> +};
> -- 
> 1.7.9.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
