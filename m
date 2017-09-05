From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v8 1/2] ASoC: rt5514: Add devicetree bindings for
 rt5514-spi
Date: Tue, 5 Sep 2017 10:55:33 -0700
Message-ID: <20170905175532.GA9393@google.com>
References: <20170905042500.25656-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170905042500.25656-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 05, 2017 at 12:24:59PM +0800, Jeffy Chen wrote:
> Add devicetree bindings documentation file for rt5514 spi dsp codec.
> 
> Also update rt5514 i2c dt-binding's compatible.

You should probably describe *why*?

> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v8: None
> 
>  .../devicetree/bindings/sound/rt5514-spi.txt       | 32 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/rt5514.txt |  2 +-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/rt5514-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5514-spi.txt b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
> new file mode 100644
> index 000000000000..8a63d9423dd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rt5514-spi.txt
> @@ -0,0 +1,32 @@
> +RT5514 SPI audio CODEC
> +
> +This device supports SPI only.
> +
> +Required properties:
> +
> +- compatible : "realtek,rt5514".

You list one string here, but there's 2 in the example. The point of
this exercise was to document (not just in an Example) the strings
you're using.

> +
> +- reg : The SPI address of the device.
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
> +        /* May run faster once verified. */

Really? That was barely useful in the rk3399-gru DTSI, but it's
definitely not worth sticking in an example.

Also, you switch between tabs and spaces for indentation. Please be
consistent. (And as with C code, I think the right answer is tabs?)

> +        spi-max-frequency = <10000000>;
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&mic_int>;
> +
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +        wakeup-source;
> +};
> diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
> index 929ca6756b02..12a8c93a67cc 100644
> --- a/Documentation/devicetree/bindings/sound/rt5514.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5514.txt
> @@ -28,6 +28,6 @@ Pins on the device (for linking into audio routes) for RT5514:
>  Example:
>  
>  codec: rt5514@57 {
> -	compatible = "realtek,rt5514";
> +	compatible = "realtek,rt5514", "realtek,rt5514-i2c";

Example != Documentation. Please document the string properly.

Brian

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
