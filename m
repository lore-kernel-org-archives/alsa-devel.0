From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCHv9] dmaengine: Add support for BCM2835
Date: Thu, 02 Jan 2014 19:03:34 +0100
Message-ID: <1964639.FVztRK0HBK@wuerfel>
References: <52C5A6A3.8000405@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52C5A6A3.8000405-oZ8rN/sblLk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 02 January 2014 18:49:23 Florian Meier wrote:
> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> Currently it only supports cyclic DMA.

Looks very nice. Just a few details I noticed:

> +#if defined(CONFIG_OF)
> +static const struct of_device_id bcm2835_dma_of_match[] = {
> +	{ .compatible = "brcm,bcm2835-dma", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
> +#endif

I doubt we are going to see non-DT versions of this driver, so the #ifdef
can just get removed here.

> +static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
> +					   struct of_dma *ofdma)
> +{
> +	struct bcm2835_dmadev *d = ofdma->of_dma_data;
> +	struct dma_chan *chan, *candidate;
> +
> +retry:
> +	candidate = NULL;
> +
> +	/*
> +	 * Walk the list of channels registered with the current instance and
> +	 * find one that is currently unused.
> +	 */
> +	list_for_each_entry(chan, &d->ddev.channels, device_node)
> +		if (chan->client_count == 0) {
> +			candidate = chan;
> +			break;
> +		}
> +
> +	if (!candidate)
> +		return NULL;
> +
> +	/*
> +	 * dma_get_slave_channel will return NULL if we lost a race between
> +	 * the lookup and the reservation.
> +	 */
> +	chan = dma_get_slave_channel(candidate);
> +
> +	if (!chan)
> +		goto retry;
> +
> +	/* Set DREQ from param */
> +	to_bcm2835_dma_chan(chan)->dreq = spec->args[0];
> +
> +	return chan;
> +}

This can now be simplified using the dma_get_any_slave_channel() interface
taht Stephen Warren introduced.

> +
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +
> +	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	if (rc)
> +		return rc;
> +	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));

dma_set_mask_and_coherent()

> +	if (pdev->dev.of_node) {
> +		/* Device-tree DMA controller registration */
> +		rc = of_dma_controller_register(pdev->dev.of_node,
> +				bcm2835_dma_xlate, od);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Failed to register DMA controller\n");
> +			goto err_no_dma;
> +		}
> +	}

If pdev->dev.of_node isn't set, you didn't get here, so the if() can be removed.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
