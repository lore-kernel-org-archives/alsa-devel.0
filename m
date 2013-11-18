From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCHv7] dmaengine: Add support for BCM2835
Date: Mon, 18 Nov 2013 15:37:01 +0100
Message-ID: <528A260D.7090807@koalo.de>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>	 <528A051A.7000703@koalo.de> <1384785017.14845.214.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384785017.14845.214.camel@smile>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

>>>> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>>>> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>> +{
>>>
>>> []
>>>
>>>> +	} else {
>>>> +		txstate->residue = 0;
>>>
>>> Useless assignment since dmaengine will do this for you in
>>> dma_cookie_status.
>>
>> I agree that it is useless, but I think otherwise it might be concealed
>> that there is a third case left that uses a residue of 0. Do you think a
>> comment is better? E.g.:
>>
>> +	} else {
>> +		/* residue = 0 per default */
> 
> I think like in many other DMA drivers either you have separate function
> to get residue, which returns 0, or just not include this case.

You mean like in the omap-dma.c? ;-P

>>>> +static int bcm2835_dma_probe(struct platform_device *pdev)
>>>> +{
> 
>>>> +	uint32_t chans_available;
>>>
>>> Why uint32_t?
>>
>> Because it is a bit mask of fixed length that directly comes from the
>> firmware.
> 
> Like one already told you in your i2s patch, please, change that to
> corresponding u* value, namely u32.

I have no problem with changing that, but why?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
