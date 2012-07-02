From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Mon, 02 Jul 2012 14:50:58 +0200
Message-ID: <02c301cd5851$572fd440$058f7cc0$%szyprowski@samsung.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
 <4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de>
 <20120628121816.GB21029@sirena.org.uk> <4FEC4E62.3020101@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4FEC4E62.3020101@metafoo.de>
Content-language: pl
Sender: linux-kernel-owner@vger.kernel.org
To: 'Lars-Peter Clausen' <lars@metafoo.de>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org, swarren@nvidia.com, linux-kernel@vger.kernel.org, 'Laxman Dewangan' <ldewangan@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hello,

On Thursday, June 28, 2012 2:30 PM Lars-Peter Clausen wrote:

> On 06/28/2012 02:18 PM, Mark Brown wrote:
> > On Thu, Jun 28, 2012 at 02:15:38PM +0200, Takashi Iwai wrote:
> >> Lars-Peter Clausen wrote:
> >
> >>> to the ALSA core. Now that there is a generic dma_mmap_writecombine it may
> >>> make sense to integrate this with snd_pcm_lib_default_mmap.
> >
> >> Agreed.
> >
> >> Also, it must be portable.  So far, only ARM has
> >> dma_mmap_writecombine(), thus the build on other arch would fail as
> >> is.
> >
> > Oh, dear - this means we don't actually have a generic API at all.  Is
> > there any effort being made to make this generally available?
> 
> Yes there is, and in fact in next/master there is generic
> dma_mmap_writecombine. I'm not quite sure how it behaves on non ARM archs
> though. But in theory it should fallback to a normal coherent mapping. Marek
> did a lot of work on this, I've put him on Cc.

On architectures which don't support DMA_ATTR_WRITECOMBINE attribute it falls
back to standard 'coherent' implementation, so it is equivalent to 
dma_mmap_coherent(). If architecture doesn't provide mmap callback, my patch
provides a so called 'generic' implementation based on virt_to_phys() macro.
Once this patch gets merged, I hope that each architecture will be reviewed 
if such implementation is correct. If not, some architectures might need to
provide their own implementations, but at least we can get the buffer-mmap
related hacks from the device drivers.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
