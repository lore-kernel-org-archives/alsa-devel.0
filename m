From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 1/2] ALSA: Add SoC on-chip internal
 memory support for DMA buffer allocation
Date: Wed, 16 Oct 2013 17:51:24 +0800
Message-ID: <20131016095124.GC24805@MrMyself>
References: <61709896cb0bac221df2a7717b157d5b884dfd78.1381915852.git.b42378@freescale.com>
 <s5heh7lmtgh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 0090A2650CE
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 11:55:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heh7lmtgh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 16, 2013 at 11:54:38AM +0200, Takashi Iwai wrote:
> At Wed, 16 Oct 2013 17:34:45 +0800,
> Nicolin Chen wrote:
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> > @@ -3201,12 +3201,18 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
> >  	area->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
> >  #ifdef ARCH_HAS_DMA_MMAP_COHERENT
> >  	if (!substream->ops->page &&
> > -	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
> > +	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV) {
> >  		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
> >  					 area,
> >  					 substream->runtime->dma_area,
> >  					 substream->runtime->dma_addr,
> >  					 area->vm_end - area->vm_start);
> > +	} else if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV_IRAM) {
> > +		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
> > +		return remap_pfn_range(area, area->vm_start,
> > +				substream->dma_buffer.addr >> PAGE_SHIFT,
> > +				area->vm_end - area->vm_start, area->vm_page_prot);
> > +	}
> 
> Here is a wrong place to put.  The handling of SNDRV_DMA_TYPE_IRAM
> must be irrelevant with the existence of dma_mmap_coherent(), thus it
> should be outside the ifdef block.
> 
> In addition, you need the check whether SNDRV_DMA_TYPE_DEV_IRAM !=
> SNDRV_DMA_TYPE_DEV.

Thank you, Iwai-san.
I'll fix it in v3.

> 
> 
> thanks,
> 
> Takashi
> 
