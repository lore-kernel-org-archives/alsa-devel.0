From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for
 non-coherent architectures
Date: Fri, 15 Jan 2010 14:28:02 +1100
Message-ID: <1263526082.724.395.camel@pasglop>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<20100101193130.GA21510@rhlx01.hs-esslingen.de>
	<s5haawj7qlv.wl%tiwai@suse.de>  <s5hljg24bl7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EB781037F2
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 04:28:27 +0100 (CET)
In-Reply-To: <s5hljg24bl7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Andreas Mohr <andi@lisas.de>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org


> A quick patch below (totally untested!) might do that.
> It's passing the device struct blindly, so not sure whether this would
> actually work for all dma_alloc_coherent().

On archs that have dma_ops such as powerpc (but I think x86 too
nowadays) you cannot use the USB device for dma_* operations. You need
to get up to the host controller device...

It -might- be worth looking at adding code to the USB stack to propagate
the parent device dma_ops down to USB devices... hard to tell.

Cheers,
Ben.

> 
> Takashi
> 
> ---
> diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
> index 9edef46..6c82026 100644
> --- a/sound/usb/usbaudio.c
> +++ b/sound/usb/usbaudio.c
> @@ -734,7 +734,7 @@ static void snd_complete_sync_urb(struct urb *urb)
>  	}
>  }
>  
> -
> +#ifdef USBAUDIO_VMALLOC_BUFFER
>  /* get the physical page pointer at the given offset */
>  static struct page *snd_pcm_get_vmalloc_page(struct snd_pcm_substream *subs,
>  					     unsigned long offset)
> @@ -769,6 +769,24 @@ static int snd_pcm_free_vmalloc_buffer(struct snd_pcm_substream *subs)
>  	return 0;
>  }
>  
> +#define preallocate_buffer(chip, pcm, stream) /* NOP */
> +
> +#else
> +#define snd_pcm_get_vmalloc_page	NULL
> +#define snd_pcm_alloc_vmalloc_buffer	snd_pcm_lib_malloc_pages
> +#define snd_pcm_free_vmalloc_buffer	snd_pcm_lib_free_pages
> +
> +static int preallocate_buffer(struct snd_usb_audio *chip, struct snd_pcm *pcm,
> +			      int stream)
> +{
> +	struct snd_pcm_substream *subs = pcm->streams[stream].substream;
> +	if (!subs)
> +		return 0;
> +	return snd_pcm_lib_preallocate_pages(subs, SNDRV_DMA_TYPE_DEV,
> +					     chip->card->dev,
> +					     1024 * 64, 1024 * 1024);
> +}
> +#endif
>  
>  /*
>   * unlink active urbs.
> @@ -2328,6 +2346,7 @@ static int add_audio_endpoint(struct snd_usb_audio *chip, int stream, struct aud
>  		err = snd_pcm_new_stream(as->pcm, stream, 1);
>  		if (err < 0)
>  			return err;
> +		preallocate_buffer(chip, as->pcm, stream);
>  		init_substream(as, stream, fp);
>  		return 0;
>  	}
> @@ -2356,6 +2375,7 @@ static int add_audio_endpoint(struct snd_usb_audio *chip, int stream, struct aud
>  	else
>  		strcpy(pcm->name, "USB Audio");
>  
> +	preallocate_buffer(chip, pcm, stream);
>  	init_substream(as, stream, fp);
>  
>  	list_add(&as->list, &chip->pcm_list);
