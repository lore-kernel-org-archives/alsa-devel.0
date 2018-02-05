From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Mon, 5 Feb 2018 00:09:38 -0600
Message-ID: <20180205025914.jy4wdan3gibyyzxe@rob-hp-laptop>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1517588406-3295-3-git-send-email-daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 02, 2018 at 06:20:06PM +0200, Daniel Baluta wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..61c85568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,23 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device for I2C.
> +
> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the GPIO controlling
> +	the power down & reset pin.
> +
> +Example:
> +
> +&i2c {
> +	ak5558: ak5558@10 {

adc@10

> +		compatible = "asahi-kasei,ak5558";
> +		reg = <0x10>;
> +		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +	};
> +};
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
