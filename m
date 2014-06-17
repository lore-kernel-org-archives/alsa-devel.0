From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: fsl: add imx-es8328 machine driver
Date: Tue, 17 Jun 2014 17:07:00 +0100
Message-ID: <20140617160700.GE8930@leverpostej>
References: <1402997571-1255-1-git-send-email-xobs@kosagi.com>
 <1402997571-1255-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402997571-1255-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org" <bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 17, 2014 at 10:32:51AM +0100, Sean Cross wrote:
> This adds an initial machine driver for the ES8328 audio codec.  The
> driver supports headphones, an audio regulator for both the codec itself
> and a speaker amp, and supports reparenting and adjusting clocks to supply
> the audio codec with the unusual frequency it requires.
> 
> Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/imx-audio-es8328.txt |  60 ++++
>  sound/soc/fsl/Kconfig                              |  14 +
>  sound/soc/fsl/Makefile                             |   2 +
>  sound/soc/fsl/imx-es8328.c                         | 359 +++++++++++++++++++++
>  4 files changed, 435 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
>  create mode 100644 sound/soc/fsl/imx-es8328.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
> new file mode 100644
> index 0000000..bd614a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
> @@ -0,0 +1,60 @@
> +Freescale i.MX audio complex with ES8328 codec
> +
> +Required properties:
> +- compatible : "fsl,imx-audio-es8328"
> +- model : The user-visible name of this sound complex
> +- clocks : A list of clocks required to run the codec at 22.5792 MHz

The driver seems to acquire these by name.

Please document the names you expect.

[...]

> +static int imx_es8328_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *ssi_np, *codec_np;
> +       struct platform_device *ssi_pdev;
> +       struct imx_es8328_data *data;
> +       int int_port, ext_port;
> +       int ret;
> +       struct device *dev = &pdev->dev;
> +
> +       ret = of_property_read_u32(np, "mux-int-port", &int_port);

I see int_port is defined as an int; please make it a u32 to match the
prototype of of_property_read_u32.

> +       if (ret) {
> +               dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
> +               return ret;
> +       }
> +       ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
> +       if (ret) {
> +               dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
> +               return ret;
> +       }

As with int_port, please define ext_port as a u32.

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
