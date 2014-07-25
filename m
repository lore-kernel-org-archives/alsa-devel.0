From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
Date: Fri, 25 Jul 2014 14:13:10 +0530
Message-ID: <53D2189E.4030108@gmail.com>
References: <cover.1406271541.git.nicoleotsuka@gmail.com> <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka@gmail.com> <53D208A9.3040903@gmail.com> <20140725075755.GA29564@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140725075755.GA29564@MrMyself>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, timur@tabi.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org, b02247@freescale.com, b42378@freescale.com, tklauser@distanz.ch
List-Id: alsa-devel@alsa-project.org

On 07/25/2014 01:27 PM, Nicolin Chen wrote:
> Hi Varka,
>
> Thank you for the comments!
>
> On Fri, Jul 25, 2014 at 01:05:05PM +0530, Varka Bhadram wrote:
>> On 07/25/2014 12:49 PM, Nicolin Chen wrote:
>> (...)
>>
>>> +static const struct platform_device_id fsl_asrc_devtype[] = {
>>> +	{
>>> +		.name = "imx35-asrc",
>>> +		.driver_data = IMX35_ASRC,
>>> +	}, {
>>> +		.name = "imx53-asrc",
>>> +		.driver_data = IMX53_ASRC,
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
>>> +
>> where are you using fsl_asrc_devtype,,,?
>>
>>> +static const struct of_device_id fsl_asrc_ids[] = {
>>> +	{
>>> +		.compatible = "fsl,imx35-asrc",
>>> +		.data = &fsl_asrc_devtype[IMX35_ASRC],
>> Ya here ... but what is the use...?
> I got your point. I will drop all these and move ids behind probe/remove()
> as you suggested at the first place and then use of_device_is_compatible()
> inside the probe() instead.
>
>>> +	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
>>> +			"mem", regs, &fsl_asrc_regmap_config);
>> devm_regmap_init_mmio_clk(&pdev->dev,
>> 			  "mem", regs,
>> 			  &fsl_asrc_regmap_config);
> I'll refine to
>
>   devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
>                             &fsl_asrc_regmap_config);
>
>>> +	if (IS_ERR(asrc_priv->regmap)) {
>>> +		dev_err(&pdev->dev, "failed to init regmap\n");
>>> +		return PTR_ERR(asrc_priv->regmap);
>>> +	}
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0) {
>>> +		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
>>> +		return irq;
>>> +	}
>>> +
>>> +	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
>>> +			       asrc_priv->name, asrc_priv);
>> same...
> Sorry I don't see any problem with this devm_request_irq()...

Ohhh... This is the problem with my email client... Sorry...

Thanks...

-- 
Regards,
Varka Bhadram.
