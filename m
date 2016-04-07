From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC: Davinci: McBSP: add device tree
 support for McBSP
Date: Thu, 7 Apr 2016 15:32:10 +0200
Message-ID: <5706615A.1080805@barix.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-3-git-send-email-petr@barix.com> <570655BE.7030109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570655BE.7030109-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 07.04.2016 14:42, Peter Ujfalusi wrote:
> On 04/06/16 16:21, Petr Kulhavy wrote:
>
>>    */
>>   
>>   #include <linux/init.h>
>> @@ -648,15 +654,82 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
>>   	.name		= "davinci-i2s",
>>   };
>>   
>> +static struct snd_platform_data*
>> +davinci_i2s_set_pdata_from_of(struct platform_device *pdev)
>> +{
>> +	struct snd_platform_data *pdata = NULL;
>> +	struct device_node *np;
>> +	struct of_phandle_args dma_spec;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
>> +		return dev_get_platdata(&pdev->dev);
>> +
>> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	np = pdev->dev.of_node;
>> +
>> +	ret = of_property_match_string(np, "dma-names", "tx");
>> +	if (ret >= 0) {
>> +		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
>> +						 &dma_spec);
>> +		if (ret >= 0)
>> +			pdata->tx_dma_channel = dma_spec.args[0];
>> +	}
>> +
>> +	ret = of_property_match_string(np, "dma-names", "rx");
>> +	if (ret >= 0) {
>> +		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
>> +						 &dma_spec);
>> +		if (ret >= 0)
>> +			pdata->rx_dma_channel = dma_spec.args[0];
>> +	}
> Why would you do this? If we booted with DT the only thing needed by the
> edma-pcm (dmaengine) is the name of the DMA channel...
I don't like this code either. But I have tried just to set the 
dma_filter to "rx" or "tx" and it didn't work.
Perhaps because the edma pcm filter function filters by channel number 
and not by name?
Or do you see an easier way of getting the channel number from the name?

>
>> +
>> +	/* optional parameters */
>> +
>> +	pdata->enable_channel_combine =
>> +		of_property_read_bool(np, "channel-combine");
> This can only be done when the McBSP is used in DSP_x mode since this will
> make the McBSP to transmit the stereo audio as mono on the bus.
I have actually never used this option and don't see a benefit of it.
Is it just some workaround that should not be included in the binding?

> After a quick look at the relevant parts in the driver, I think most of the
> things are pretty much broken or at least they are not totally correct. McBSP
> do support real I2S (SRGR:FWID), and the phase setup is wrong in the code. IMO.
> I don't have HW to test the daVinci-MCBSP or the ASP so I can not comment on
> how well things are working.
The I2S worked for me if the frame size equalled the PCM data size. E.g. 
16-bit audio, 2 channels, 16 bit frame size -> 32 clock ticks per sample 
in total.
However with bigger frame sizes it didn't work because it cannot insert 
"blanks" between the channels.
E.g. with 32-bit wide slots and 16-bit audio it sends both left and 
right data in the first 32 clock ticks (i.e. still the first channel) 
and then the during the other channel the data line goes to high 
impedance which results in effectively playing only the left channel 
(and noise in the other channel).

That's probably what the comment about broken I2S is trying to say.
I couldn't find any help in the datasheet either.

On some codecs the frame size is configurable and there it works, but 
codecs that require 32-bit frames don't work with 16-bit audio or need 
to use DSP_x format.
>
>> +
>> +	return pdata;
>> +}
>> +
>>   static int davinci_i2s_probe(struct platform_device *pdev)
>>   {
>> +	struct snd_platform_data *pdata;
>>   	struct davinci_mcbsp_dev *dev;
>>   	struct resource *mem, *res;
>>   	void __iomem *io_base;
>>   	int *dma;
>>   	int ret;
>>   
>> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pdata = davinci_i2s_set_pdata_from_of(pdev);
>> +	if (IS_ERR(pdata)) {
>> +		dev_err(&pdev->dev, "Error populating platform data, err %ld\n",
>> +			PTR_ERR(pdata));
>> +		return PTR_ERR(pdata);
>> +	}
>> +
>> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>> +	if (!mem) {
>> +		dev_warn(&pdev->dev,
>> +			 "\"mpu\" mem resource not found, using index 0\n");
>> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!mem) {
>> +			dev_err(&pdev->dev, "no mem resource?\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>>   	io_base = devm_ioremap_resource(&pdev->dev, mem);
>>   	if (IS_ERR(io_base))
>>   		return PTR_ERR(io_base);
>> @@ -680,25 +753,21 @@ static int davinci_i2s_probe(struct platform_device *pdev)
>>   	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
>>   
>>   	/* first TX, then RX */
>> -	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> -	if (!res) {
>> -		dev_err(&pdev->dev, "no DMA resource\n");
>> -		ret = -ENXIO;
>> -		goto err_release_clk;
>> -	}
>>   	dma = &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
>> -	*dma = res->start;
>>   	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = dma;
>> +	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> +	if (res)
>> +		*dma = res->start;
>> +	else
>> +		*dma = pdata->tx_dma_channel;
> Please follow the way davinci-mcasp does it right now:
> 	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> 	...
> 	dma = &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
> 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> 	if (res)
> 		*dma = res->start;
> 	else
> 		*dma = pdata->tx_dma_channel;
>
> 	/* dmaengine filter data for DT and non-DT boot */
> 	if (pdev->dev.of_node)
> 		dma_data->filter_data = "tx";
> 	else
> 		dma_data->filter_data = dma;
>
> while we are here, I think the tx/rx_dma_channel is something we should just
> get rid of. It is not used as far as I can tell.
> Something like this would do I think:
> 	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> 	...
> 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> 	if (res) {
> 		dma = &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
> 		*dma = res->start;
> 		dma_data->filter_data = dma;
> 	} else if (pdev->dev.of_node) {
> 		dma_data->filter_data = "tx";
> 	} else {
> 		dev_err(&pdev->dev, "Missing DMA tx resource\n");
> 		return -ENODEV;
> 	}
Is the edma pcm filter function able to filter in once case by the dma 
number and in the other case by the dma name?
See my above comment as well...

>>   
>>   	dev->dev = &pdev->dev;
>>   	dev_set_drvdata(&pdev->dev, dev);
>> @@ -737,11 +806,18 @@ static int davinci_i2s_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static const struct of_device_id davinci_mcbsp_match[] = {
>> +	{ .compatible = "ti,da850-mcbsp-audio" },
> I would drop the "-audio" for the binding...
I was trying to stay consistent with the mcasp. But I don't mind keeping 
the name shorter :-)
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, davinci_mcbsp_match);
>> +
>>   static struct platform_driver davinci_mcbsp_driver = {
>>   	.probe		= davinci_i2s_probe,
>>   	.remove		= davinci_i2s_remove,
>>   	.driver		= {
>>   		.name	= "davinci-mcbsp",
>> +		.of_match_table = of_match_ptr(davinci_mcbsp_match),
> The driver calls itself davinci-i2s.c and the prefixes internally used are
> davinci_i2s_*.
> The driver name is "davinci-mcbsp".
> And it is basically a driver for daVinci ASP (the McBSP additions are not
> configured at all).
> I still think we should keep the davinci_i2s_* when adding new code, or rename
> the whole driver and it's prefixes to something more sensible?
Good point, thanks! I will rename the table to davinci_i2s_match to stay 
consistent.

Petr


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
