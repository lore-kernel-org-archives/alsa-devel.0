From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Wed, 23 Jul 2014 14:48:21 +0530
Message-ID: <53CF7DDD.6020908@gmail.com>
References: <1406101453-3088-1-git-send-email-xobs@kosagi.com> <1406101453-3088-4-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406101453-3088-4-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07/23/2014 01:14 PM, Sean Cross wrote:
> +Required properties:
> +- compatible : "fsl,imx-audio-es8328"
> +- model : The user-visible name of this sound complex
> +- ssi-controller : The phandle of the i.MX SSI controller
> +- jack-gpio : Optional GPIO for headphone jack
> +- audio-amp-supply : Power regulator for speaker amps
> +- audio-codec : The phandle of the ES8328 audio codec
> +- audio-routing : A list of the connections between audio components.
> +  Each entry is a pair of strings, the first being the connection's sink,
> +  the second being the connection's source. Valid names could be power
> +  supplies, ES8328 pins, and the jacks on the board:
> +

It would be readable if
Required properties:
- compatible		: "fsl,imx-audio-es8328"
- model			: The user-visible name of this sound complex
- ssi-controller	: The phandle of the i.MX SSI controller
- jack-gpio		: Optional GPIO for headphone jack
...

(...)

> +static int imx_es8328_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *ssi_np, *codec_np;
> +	struct platform_device *ssi_pdev;
> +	struct imx_es8328_data *data;
> +	u32 int_port, ext_port;
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +
> +	ret = of_property_read_u32(np, "mux-int-port", &int_port);
> +	if (ret) {
> +		dev_err(dev, "mux-int-port missing or invalid\n");
> +		goto fail;
> +	}
> +	if (int_port > MUX_PORT_MAX || int_port == 0) {
> +		dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
> +				MUX_PORT_MAX);

should match open parenthesis:
	dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
		MUX_PORT_MAX);

> +		goto fail;
> +	}
> +
> +	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
> +	if (ret) {
> +		dev_err(dev, "mux-ext-port missing or invalid\n");
> +		goto fail;
> +	}
> +	if (ext_port > MUX_PORT_MAX || ext_port == 0) {
> +		dev_err(dev, "mux-ext-port: hardware only has %d mux ports\n",
> +				MUX_PORT_MAX);

Dto..

(...)

> +static struct platform_driver imx_es8328_driver = {
> +	.driver = {
> +		.name = "imx-es8328",
> +		.owner = THIS_MODULE,

This field updated by module_platform_driver()... No need to do manually..


-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
