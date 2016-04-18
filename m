From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/6] ASoC: Davinci: McBSP: add device tree
 support for McBSP
Date: Mon, 18 Apr 2016 11:27:00 +0200
Message-ID: <5714A864.5050505@barix.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-3-git-send-email-petr@barix.com> <5710B516.2000006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5710B516.2000006-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 15.04.2016 11:32, Peter Ujfalusi wrote:
> On 04/11/16 14:45, Petr Kulhavy wrote:
>> This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.
>>
>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> ---
>> v1: initial
>> v2: remove "-audio" postfix from the compatible string
>>      of_match_table renamed consistently with the rest of the file (davinci_i2s_match)
>>      "channel-combine" property removed
>>      devicetree DMA configuration in probe simplified
>>
>>   sound/soc/davinci/Kconfig       |   6 ++-
>>   sound/soc/davinci/davinci-i2s.c | 116 +++++++++++++++++++++++++++++++---------
>>   2 files changed, 95 insertions(+), 27 deletions(-)
>>
>> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
>> index 50ca291cc225..6b732d8e5896 100644
>> --- a/sound/soc/davinci/Kconfig
>> +++ b/sound/soc/davinci/Kconfig
>> @@ -16,7 +16,11 @@ config SND_EDMA_SOC
>>   	  - DRA7xx family
>>   
>>   config SND_DAVINCI_SOC_I2S
>> -	tristate
>> +	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
>> +	depends on SND_EDMA_SOC
>> +	help
>> +	  Say Y or M here if you want to have support for McBSP IP found in
>> +	  Texas Instruments DaVinci DA850 SoCs.
>>   
>>   config SND_DAVINCI_SOC_MCASP
>>   	tristate "Multichannel Audio Serial Port (McASP) support"
>> diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
>> index ec98548a5fc9..a3f82d1a73dc 100644
>> --- a/sound/soc/davinci/davinci-i2s.c
>> +++ b/sound/soc/davinci/davinci-i2s.c
>> @@ -4,9 +4,15 @@
>>    * Author:      Vladimir Barinov, <vbarinov-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
>>    * Copyright:   (C) 2007 MontaVista Software, Inc., <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
>>    *
>> + * DT support	(c) 2016 Petr Kulhavy, Barix AG <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> + *		based on davinci-mcasp.c DT support
>> + *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 as
>>    * published by the Free Software Foundation.
>> + *
>> + * TODO:
>> + * on DA850 implement HW FIFOs instead of DMA into DXR and DRR registers
>>    */
>>   
>>   #include <linux/init.h>
>> @@ -648,15 +654,62 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
>>   	.name		= "davinci-i2s",
>>   };
>>   
>> +static struct snd_platform_data*
>> +davinci_i2s_set_pdata_from_of(struct platform_device *pdev)
> It is a bit misleading function name, would be better to name it as
> davinci_i2s_get_pdata()
>
> as it will fetch the legacy pdata or craft one when booting with DT.
Thanks, I will change the name.
> +
> +	/* parse properties here */
> +
> +	/*
> +	 * pdata->clk_input_pin is deliberately not exported to DT
> +	 * and the default value of the clk_input_pin is MCBSP_CLKR.
> +	 * The value MCBSP_CLKS makes no sense as it turns the CPU
> +	 * to a bit clock master in the SND_SOC_DAIFMT_CBM_CFS mode
> +	 * where it should be bit clock slave!
> +	 */
> +
> +	return pdata;
> +}
> +
>   static int davinci_i2s_probe(struct platform_device *pdev)
>   {
> +	struct snd_dmaengine_dai_dma_data *dma_data;
> +	struct snd_platform_data *pdata;
>   	struct davinci_mcbsp_dev *dev;
>   	struct resource *mem, *res;
>   	void __iomem *io_base;
>   	int *dma;
>   	int ret;
>   
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pdata = davinci_i2s_set_pdata_from_of(pdev);
> +	if (IS_ERR(pdata)) {
> +		dev_err(&pdev->dev, "Error populating platform data, err %ld\n",
> +			PTR_ERR(pdata));
> +		return PTR_ERR(pdata);
> +	}
> The current driver does not use the pdata as far as I can see. Kind of
> strange. So now in DT boot you will allocate memory for the pdata, which is
> not used by the driver at all.
> I think we should implement the pdata handling in the driver first for the
> legacy mode, then probably having pdata allocated for DT case might make sense.
Indeed the current driver does not use pdata. Neither the legacy board 
drivers in arch/mach-davinci do.
Well, except for the dm365_evm which sets the asp_chan_q which is later 
not used:

static struct snd_platform_data dm365_evm_snd_data __maybe_unused = {
         .asp_chan_q = EVENTQ_3,
};


If the pdata is not used at all I would completely drop it.
Or what do you think the pdata should carry?

Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
