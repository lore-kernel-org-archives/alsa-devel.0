From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESENT PATCH v9 1/2] ASoC: rt5514: Add devicetree bindings for
 rt5514-spi
Date: Wed, 13 Sep 2017 12:24:52 -0500
Message-ID: <20170913172452.rqy2umufkuh26fzj@rob-hp-laptop>
References: <20170906025010.10750-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170906025010.10750-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 06, 2017 at 10:50:09AM +0800, Jeffy Chen wrote:
> Add devicetree bindings documentation file for rt5514 spi dsp codec.
> 
> Also update rt5514 i2c dt-binding's compatible to distinguish it from
> rt5514 spi.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v9:
> Address comments from Brian.
> 
>  .../devicetree/bindings/sound/rt5514-spi.txt       | 29 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/rt5514.txt |  4 +--
>  2 files changed, 31 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/rt5514-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5514-spi.txt b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
> new file mode 100644
> index 000000000000..7911d1adbd29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
> @@ -0,0 +1,29 @@
> +RT5514 SPI audio CODEC
> +
> +This device supports SPI only.
> +
> +Required properties:
> +
> +- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-spi".
> +
> +- reg : The SPI address of the device.

See below.

> +
> +Optional properties:
> +
> +- interrupt-parent: Should be the phandle for the interrupt controller
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +	      depends on the interrupt controller.
> +
> +Example:
> +
> +codec: rt5514-spi@0 {
> +	compatible = "realtek,rt5514", "realtek,rt5514-spi";
> +	reg = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mic_int>;
> +
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +	wakeup-source;

This needs to be documented too.

> +};
> diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
> index 929ca6756b02..841a1159e234 100644
> --- a/Documentation/devicetree/bindings/sound/rt5514.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5514.txt
> @@ -4,7 +4,7 @@ This device supports I2C only.

SPI support should be added to this document.

>  
>  Required properties:
>  
> -- compatible : "realtek,rt5514".
> +- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-i2c".

There's no need for the -spi or -i2c compatibles. This is implied by 
being a child of those controllers.
  
>  - reg : The I2C address of the device.
>  
> @@ -28,6 +28,6 @@ Pins on the device (for linking into audio routes) for RT5514:
>  Example:
>  
>  codec: rt5514@57 {
> -	compatible = "realtek,rt5514";
> +	compatible = "realtek,rt5514", "realtek,rt5514-i2c";
>  	reg = <0x57>;
>  };
> -- 
> 2.11.0
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
