From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Wed, 14 May 2008 12:50:56 -0600
Message-ID: <200805141250.57115.bjorn.helgaas@hp.com>
References: <4823AAF2.7070102@keyaccess.nl> <482B0807.9050404@keyaccess.nl> <482B3274.2060006@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763270AbYENSv1@vger.kernel.org>
In-Reply-To: <482B3274.2060006@keyaccess.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 14 May 2008 12:41:56 pm Rene Herman wrote:
> On 14-05-08 17:40, Rene Herman wrote:
> 
> CC list trimmed as now PNP and ALSA specific.
> 
> > Like this? With this (on top of the previous patch setting the
> > dma_mask ofcourse) legacy ISA actually appears to be fine but it's
> > then ISAPnP which goes bonkers again. Sigh. Getting an allocation
> > failure. Don't understand why yet since pnp_alloc_dev() definitely
> > sets the mask already. Will stare...
> 
> You're in a maze of struct device *s, all alike... I was passing the 
> pnp_card->dev instead of the initialized pnp_dev->dev.
> 
> And, not doing so brings out a difference between ISAPnP and legacy ISA 
> again insofar that legacy ISA does not consist of cards with multiple 
> devices. We just have the single struct device * for the ISA device.
> 
> This therefore would be the easiest solution (and works fine) but seems 
> a bit of a hack. Bjorn, do you have an opinion? If I abstract things out 
> a bit more I might be able to do this nicer. One might on the other hand 
> argue that the dma_mask is going to be constant for all card devices so 
> might as well just use the card dev.

I agree, it seems a bit of a hack to use a DMA mask from the card
instead of from the device, since the driver should be programming
the device to do the DMA.

But I know very little about pnp_card in general, so don't attach too
much weight to my opinion.

> sound/{isa,oss} together with drivers/isdn/hisax/ are the only pnp_card 
> users.
> 
> diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
> index a762a41..a2842a7 100644
> --- a/drivers/pnp/card.c
> +++ b/drivers/pnp/card.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/ctype.h>
>  #include <linux/slab.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/pnp.h>
>  #include "base.h"
> 
> @@ -167,6 +168,9 @@ struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnp
>  	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number,
>  		card->number);
> 
> +	card->dev.coherent_dma_mask = DMA_24BIT_MASK;
> +	card->dev.dma_mask = &card->dev.coherent_dma_mask;
> +
>  	dev_id = pnp_add_card_id(card, pnpid);
>  	if (!dev_id) {
>  		kfree(card);
> 
> 
