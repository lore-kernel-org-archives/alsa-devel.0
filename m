From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Re: 2.6.26-rc1 regression: ISA DMA broken
	(bisected)
Date: Fri, 30 May 2008 15:43:41 -0600
Message-ID: <200805301543.42208.bjorn.helgaas@hp.com>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 58F8A243F3
	for <alsa-devel@alsa-project.org>;
	Fri, 30 May 2008 23:43:40 +0200 (CEST)
In-Reply-To: <48406E8D.8050408@keyaccess.nl>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 May 2008 03:15:57 pm Rene Herman wrote:
> On 14-05-08 21:09, Rene Herman wrote:
> 
> > On 14-05-08 20:50, Bjorn Helgaas wrote:
> 
> >> I agree, it seems a bit of a hack to use a DMA mask from the card
> >> instead of from the device, since the driver should be programming
> >> the device to do the DMA.
> >>
> >> But I know very little about pnp_card in general, so don't attach too
> >> much weight to my opinion.
> > 
> > Okay, I'll sit on this for a bit. Right now we're using a global device 
> > even but this is exactly about cleaning that up so couldn't convince 
> > myself. Will see what happens when I try to make it nice...
> 
> It gets uglier. ALSA ISA drivers (for cards that exist both as legacy 
> and as ISAPnP at least) keep a merged legacy/isapnp model; PnP is used 
> mostly for initializing global variables that the same old legacy probe 
> routines then reference. This means that beyond that global resource 
> init step the specific struct device is no longer available. Without 
> restructuring too many things really only fixable through other hacks 
> again such as a global dma_dev[] array or some such.
> 
>  From the viewpoint of PnP itself setting the dma_mask for a pnp_card (a 
> pnp_dev collection) makes isolated sense so if no objections, I'll 
> submit the attached after all. From the ALSA side we'd then pass the 
> card dev (which we'd also do for isa_dev) and keep in mind that we might 
> want to get more specific if over time structure permits it.
> 
> struct snd_pcm already has its own struct device * which would be the 
> right one here but it's setting that which gets ugly...

Looks good to me.  It does sound like a lot of work and possibly
more risk than it's worth to fix up some of this stuff.

I do still wonder whether any non-x86 architectures need similar
fixes in dma_alloc_coherent(), i.e., check for dev==NULL and fall
back to a 24-bit DMA mask.

Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
