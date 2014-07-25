From: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Date: Fri, 25 Jul 2014 15:57:56 +0800
Message-ID: <20140725075755.GA29564@MrMyself>
References: <cover.1406271541.git.nicoleotsuka@gmail.com>
 <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka@gmail.com>
 <53D208A9.3040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53D208A9.3040903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Varka,

Thank you for the comments!

On Fri, Jul 25, 2014 at 01:05:05PM +0530, Varka Bhadram wrote:
> On 07/25/2014 12:49 PM, Nicolin Chen wrote:
> (...)
> 
> >+static const struct platform_device_id fsl_asrc_devtype[] = {
> >+	{
> >+		.name = "imx35-asrc",
> >+		.driver_data = IMX35_ASRC,
> >+	}, {
> >+		.name = "imx53-asrc",
> >+		.driver_data = IMX53_ASRC,
> >+	}, {
> >+		/* sentinel */
> >+	}
> >+};
> >+MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
> >+
> 
> where are you using fsl_asrc_devtype,,,?
> 
> >+static const struct of_device_id fsl_asrc_ids[] = {
> >+	{
> >+		.compatible = "fsl,imx35-asrc",
> >+		.data = &fsl_asrc_devtype[IMX35_ASRC],
> 
> Ya here ... but what is the use...?

I got your point. I will drop all these and move ids behind probe/remove()
as you suggested at the first place and then use of_device_is_compatible()
inside the probe() instead.

> >+	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> >+			"mem", regs, &fsl_asrc_regmap_config);
> 
> devm_regmap_init_mmio_clk(&pdev->dev,
> 			  "mem", regs,
> 			  &fsl_asrc_regmap_config);

I'll refine to

 devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
                           &fsl_asrc_regmap_config);

> 
> >+	if (IS_ERR(asrc_priv->regmap)) {
> >+		dev_err(&pdev->dev, "failed to init regmap\n");
> >+		return PTR_ERR(asrc_priv->regmap);
> >+	}
> >+
> >+	irq = platform_get_irq(pdev, 0);
> >+	if (irq < 0) {
> >+		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> >+		return irq;
> >+	}
> >+
> >+	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
> >+			       asrc_priv->name, asrc_priv);
>
> same...

Sorry I don't see any problem with this devm_request_irq()...

Thank you,
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
