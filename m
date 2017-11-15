From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: Add PCM186x binding documentation
Date: Wed, 15 Nov 2017 13:56:04 -0600
Message-ID: <20171115195604.ftnk2rwojkhpow4p@rob-hp-laptop>
References: <20171110195711.24210-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171110195711.24210-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 10, 2017 at 01:57:10PM -0600, Andrew F. Davis wrote:
> Add the dt-binding documentation for the TI PCM186x 2ch and 4ch Audio
> ADCs With Universal Front End.
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/pcm186x.txt          | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
> new file mode 100644
> index 000000000000..0bc7d265c7bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm186x.txt
> @@ -0,0 +1,42 @@
> +Texas Instruments PCM186x Universal Audio ADC
> +
> +These devices support both I2C and SPI (configured with pin strapping
> +on the board).
> +
> +Required properties:
> +
> + - compatible : "ti,pcm1862",
> +                "ti,pcm1863",
> +                "ti,pcm1864",
> +                "ti,pcm1865"
> +
> + - reg : The I2C address of the device for I2C, the chip select
> +         number for SPI.
> +
> + - avdd-supply: Analog core power supply (3.3v)
> + - dvdd-supply: Digital core power supply
> + - iovdd-supply: Digital IO power supply
> +        See regulator/regulator.txt for more information
> +
> +CODEC input pins:
> + * VINL1
> + * VINR1
> + * VINL2
> + * VINR2
> + * VINL3
> + * VINR3
> + * VINL4
> + * VINR4
> +
> +The pins can be used in referring sound node's audio-routing property.
> +
> +Example:
> +
> +	pcm186x: pcm186x@4a {

audio-codec@4a

With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +		compatible = "ti,pcm1865";
> +		reg = <0x4a>;
> +
> +		avdd-supply = <&reg_3v3_analog>;
> +		dvdd-supply = <&reg_3v3>;
> +		iovdd-supply = <&reg_1v8>;
> +	};
> -- 
> 2.15.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
