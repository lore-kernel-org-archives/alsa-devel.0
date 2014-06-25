From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Wed, 25 Jun 2014 12:00:49 +0100
Message-ID: <20140625110049.GF14495@leverpostej>
References: <1403519742-4076-1-git-send-email-xobs@kosagi.com>
 <1403519742-4076-4-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403519742-4076-4-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org" <bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 23, 2014 at 11:35:42AM +0100, Sean Cross wrote:
> This adds an initial machine driver for the ES8328 audio codec on Freescale
> boards.  The driver supports headphones and an audio regulator for an onboard
> speaker amp.
> 
> Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/imx-audio-es8328.txt |  61 ++++++
>  sound/soc/fsl/Kconfig                              |  14 ++
>  sound/soc/fsl/Makefile                             |   2 +
>  sound/soc/fsl/imx-es8328.c                         | 224 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
>  create mode 100644 sound/soc/fsl/imx-es8328.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
> new file mode 100644
> index 0000000..89a9a58f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt

[...]

> +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
> +- mux-ext-port : The external port of the i.MX audio muxer
> +
> +Note: The AUDMUX port numbering should start at 1, which is consistent with
> +hardware manual.

Is this true for both internal and external? The code implies so, but
the lack of "(AUDMUX)" in the mux-ext-port description implies not.

[...]

> +static int imx_es8328_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *ssi_np, *codec_np;
> +	struct platform_device *ssi_pdev;
> +	struct imx_es8328_data *data;
> +	int int_port, ext_port;

You use these as u32 below. Please match the types.

> +	int ret;
> +	struct device *dev = &pdev->dev;
> +
> +	ret = of_property_read_u32(np, "mux-int-port", &int_port);
> +	if (ret) {
> +		dev_err(dev, "mux-int-port missing or invalid\n");
> +		return ret;
> +	}
> +	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
> +	if (ret) {
> +		dev_err(dev, "mux-ext-port missing or invalid\n");
> +		return ret;
> +	}

Both int_port and ex_port are defined as int but used as u32. Could you
match the types? It looks like they're never expected to be negative, so
changing them to u32 should be fine.

It's also probably worth sanity checking the values before using them.

[...]

> +fail:
> +	if (ssi_np)
> +		of_node_put(ssi_np);
> +	if (codec_np)
> +		of_node_put(codec_np);

You can avoid the checks; of_node_put handles NULL gracefully.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
