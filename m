From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCHv7] dmaengine: Add support for BCM2835
Date: Mon, 18 Nov 2013 13:16:26 +0100
Message-ID: <528A051A.7000703@koalo.de>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384768816.14845.186.camel@smile>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Thank you! Few comments below.

> []
>> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
>> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
>> +{
> 
> []
> 
>> +	} else {
>> +		txstate->residue = 0;
> 
> Useless assignment since dmaengine will do this for you in
> dma_cookie_status.

I agree that it is useless, but I think otherwise it might be concealed
that there is a third case left that uses a residue of 0. Do you think a
comment is better? E.g.:

+	} else {
+		/* residue = 0 per default */

>> +	/* Bus width translates to the element size (ES) */
>> +	switch (dev_width) {
>> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +		es = BCM2835_DMA_DATA_TYPE_S32;
>> +		break;
>> +	default:
>> +		return NULL;
>> +	}
> 
> So, you use switch-case on hope to extend it later, correct?

Yes, there is a S128 case left, but that is not implemented yet.

>> +static int bcm2835_dma_probe(struct platform_device *pdev)
>> +{
>> +	struct bcm2835_dmadev *od;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	int rc;
>> +	int i;
>> +	int irq;
>> +	uint32_t chans_available;
> 
> Why uint32_t?

Because it is a bit mask of fixed length that directly comes from the
firmware.

>> +		/* Request DMA channel mask from device tree */
>> +		if (of_property_read_u32(pdev->dev.of_node,
>> +				"brcm,dma-channel-mask",
>> +				&chans_available)) {
>> +			dev_err(&pdev->dev, "Failed to get channel mask\n");
>> +			bcm2835_dma_free(od);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		dev_err(&pdev->dev, "Failed to get channel mask. No device tree.\n");
>> +		bcm2835_dma_free(od);
>> +		return -EINVAL;
>> +	}
> 
>> +	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", i);
>> +
>> +	if (pdev->dev.of_node) {
> 
> Does it make sense?

There was already a discussion about that in PATCHv4. It should be
possible to add board file initialization later with few patching.
Although, maybe this will not be relevant anymore, because device tree
support of this platform is getting better more and more.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
