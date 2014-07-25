From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
Date: Fri, 25 Jul 2014 13:05:05 +0530
Message-ID: <53D208A9.3040903@gmail.com>
References: <cover.1406271541.git.nicoleotsuka@gmail.com> <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07/25/2014 12:49 PM, Nicolin Chen wrote:

(...)

> +
> +	div[IN] = clk_get_rate(clk) / inrate;
> +	if (div[IN] == 0) {
> +		pair_err("failed to support input sample rate %dHz by asrck_%x",
> +				inrate, clk_index[ideal ? OUT : IN]);

Ohhhhh... missed terminating new line...

> +		return -EINVAL;
> +	}
> +
> +	clk = asrc_priv->asrck_clk[clk_index[OUT]];
> +
> +	/* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
> +	if (ideal)
> +		div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
> +	else
> +		div[OUT] = clk_get_rate(clk) / outrate;
> +
> +	if (div[OUT] == 0) {
> +		pair_err("failed to support output sample rate %dHz by asrck_%x",
> +				outrate, clk_index[OUT]);

same..

> +		return -EINVAL;
> +	}
> +
> +	

(...)

> +static int fsl_asrc_init(struct fsl_asrc *asrc_priv)
> +{
> +	/* Halt ASRC internal FP when input FIFO needs data for pair A, B, C */
> +	regmap_write(asrc_priv->regmap, REG_ASRCTR, ASRCTR_ASRCEN);
> +
> +	/* Disable interrupt by default */
> +	regmap_write(asrc_priv->regmap, REG_ASRIER, 0x0);
> +
> +	/* Apply recommended settings for parameters from Reference Manual */
> +	regmap_write(asrc_priv->regmap, REG_ASRPM1, 0x7fffff);
> +	regmap_write(asrc_priv->regmap, REG_ASRPM2, 0x255555);
> +	regmap_write(asrc_priv->regmap, REG_ASRPM3, 0xff7280);
> +	regmap_write(asrc_priv->regmap, REG_ASRPM4, 0xff7280);
> +	regmap_write(asrc_priv->regmap, REG_ASRPM5, 0xff7280);
> +
> +	/* Base address for task queue FIFO. Set to 0x7C */
> +	regmap_update_bits(asrc_priv->regmap, REG_ASRTFR1,
> +			   ASRTFR1_TF_BASE_MASK, ASRTFR1_TF_BASE(0xfc));
> +
> +	/* Set the processing clock for 76KHz to 133M */
> +	regmap_write(asrc_priv->regmap, REG_ASR76K, 0x06D6);
> +
> +	/* Set the processing clock for 56KHz to 133M */
> +	regmap_write(asrc_priv->regmap, REG_ASR56K, 0x0947);

No where we are checking the return value here, but return zero...?

check the regmap_write return value then return or implement this to void...

> +
> +	return 0;
> +}
> +
> +/**
> + * Interrupt handler for ASRC
> + */
> +

(...)

> +static const struct platform_device_id fsl_asrc_devtype[] = {
> +	{
> +		.name = "imx35-asrc",
> +		.driver_data = IMX35_ASRC,
> +	}, {
> +		.name = "imx53-asrc",
> +		.driver_data = IMX53_ASRC,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
> +

where are you using fsl_asrc_devtype,,,?

> +static const struct of_device_id fsl_asrc_ids[] = {
> +	{
> +		.compatible = "fsl,imx35-asrc",
> +		.data = &fsl_asrc_devtype[IMX35_ASRC],

Ya here ... but what is the use...?

> +	}, {
> +		.compatible = "fsl,imx53-asrc",
> +		.data = &fsl_asrc_devtype[IMX53_ASRC],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
> +

(...)

> +	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +			"mem", regs, &fsl_asrc_regmap_config);

devm_regmap_init_mmio_clk(&pdev->dev,
			  "mem", regs,
			  &fsl_asrc_regmap_config);

> +	if (IS_ERR(asrc_priv->regmap)) {
> +		dev_err(&pdev->dev, "failed to init regmap\n");
> +		return PTR_ERR(asrc_priv->regmap);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
> +			       asrc_priv->name, asrc_priv);

same...

Thanks...


-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
