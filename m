From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 3/5] ALSA: pcm - fix page conversion on non-coherent
 MIPS arch
Date: Fri, 27 Nov 2009 11:52:58 +0800
Message-ID: <1259293978.3197.92.camel@falcon.domain.org>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
         <1259248388-20095-2-git-send-email-tiwai@suse.de>
         <1259248388-20095-3-git-send-email-tiwai@suse.de>
         <1259248388-20095-4-git-send-email-tiwai@suse.de>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1259248388-20095-4-git-send-email-tiwai@suse.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@gate.crashing.org>, Becky Bruce <beckyb@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-11-26 at 16:13 +0100, Takashi Iwai wrote:
> The non-coherent MIPS arch doesn't give the correct address by a simple
> virt_to_page() for pages allocated via dma_alloc_coherent().
> 
> Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
> buffer allocation type was added to avoid the wrong conversion.
> 
> Note that this doesn't fix perfectly: the pages should be marked with
> proper pgprot value.  This will be done in a future implementation like
> the conversion to dma_mmap_coherent().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index c906be2..e48c5f6 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3066,6 +3066,10 @@ static inline struct page *
>  snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
>  {
>  	void *vaddr = substream->runtime->dma_area + ofs;
> +#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
> +	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
> +		return virt_to_page(CAC_ADDR(vaddr));
> +#endif
>  	return virt_to_page(vaddr);
>  }

Works well on Loongson family machines, thanks!

Regards,
	Wu Zhangjin
