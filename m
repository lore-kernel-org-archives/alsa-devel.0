From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [DEVICE MODEL] dev->dma_mask
Date: Fri, 30 May 2008 23:28:15 +0200
Message-ID: <4840716F.9000309@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B0807.9050404@keyaccess.nl>
	<482B3274.2060006@keyaccess.nl>
	<200805141250.57115.bjorn.helgaas@hp.com>
	<482B38D6.5030804@keyaccess.nl> <48406E8D.8050408@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 63120243E6
	for <alsa-devel@alsa-project.org>;
	Fri, 30 May 2008 23:25:09 +0200 (CEST)
In-Reply-To: <48406E8D.8050408@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 30-05-08 23:15, Rene Herman wrote:

On ...

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

... this note by the way I believe pnp_dev might as well get rid of its 
dma_mask as well. As far I've googled up the history of that the reason 
why dev->dma_mask is a pointer is only that it's been moved into struct 
device from struct pci_dev where the latter location was kept as the 
main one so as to not upset then current code.

Everyone else seems to have then faithfully cloned pci_dev and stuck it 
in their private structs as well but for no good reason it would appear.

And in the case of the PnP ISA masks, we're talking about constant 
masks, dictated by the shared global DMA controller and not the card 
itself (there are a few ISA cards that do their own busmastering but 
they're special) so the mask might as well just point to the coherent mask.

Unless I'm missing something ofcourse...

Rene.
