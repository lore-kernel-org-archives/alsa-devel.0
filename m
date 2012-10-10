From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: davinci-pcm: stub out gen_pool
 functions for !CONFIG_GENERIC_ALLOCATOR
Date: Wed, 10 Oct 2012 15:27:51 +0200
Message-ID: <507577D7.5090906@gmail.com>
References: <1349873388-32331-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 777C126509B
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 15:27:54 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so263087bku.38
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 06:27:54 -0700 (PDT)
In-Reply-To: <1349873388-32331-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Matt Porter <mporter@ti.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Anil Kumar <anilkumar.v@ti.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 10.10.2012 14:49, Daniel Mack wrote:
> On platforms without CONFIG_GENERIC_ALLOCATOR, these functions can be
> no-ops. The code that uses the memory buffers does the right thing if
> they are NULL.

To avoid confusion: this is meant to go on top of Matt Porter's two sram
related patches for this driver.




> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Cc: Matt Porter <mporter@ti.com>
> Cc: Anil Kumar <anilkumar.v@ti.com>
> ---
> Alternatively, the gen_pool functions could stub out themselves for
> !CONFIG_GENERIC_ALLOCATOR.
> 
>  sound/soc/davinci/davinci-pcm.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index 01b3f17..afab81f 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -251,6 +251,7 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
>  	}
>  }
>  
> +#ifdef CONFIG_GENERIC_ALLOCATOR
>  static int allocate_sram(struct snd_pcm_substream *substream,
>  		struct gen_pool *sram_pool, unsigned size,
>  		struct snd_pcm_hardware *ppcm)
> @@ -284,6 +285,28 @@ exit1:
>  	return -ENOMEM;
>  }
>  
> +static void davinci_free_sram(struct snd_pcm_substream *substream,
> +			      struct snd_dma_buffer *iram_dma)
> +{
> +	struct davinci_runtime_data *prtd = substream->runtime->private_data;
> +	struct gen_pool *sram_pool = prtd->params->sram_pool;
> +
> +	gen_pool_free(sram_pool, (unsigned) iram_dma->area, iram_dma->bytes);
> +}
> +#else
> +static int allocate_sram(struct snd_pcm_substream *substream,
> +		struct gen_pool *sram_pool, unsigned size,
> +		struct snd_pcm_hardware *ppcm)
> +{
> +	return 0;
> +}
> +
> +static void davinci_free_sram(struct snd_pcm_substream *substream,
> +			      struct snd_dma_buffer *iram_dma)
> +{
> +}
> +#endif
> +
>  /*
>   * Only used with ping/pong.
>   * This is called after runtime->dma_addr, period_bytes and data_type are valid
> @@ -813,11 +836,7 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
>  		buf->area = NULL;
>  		iram_dma = buf->private_data;
>  		if (iram_dma) {
> -			struct davinci_runtime_data *prtd =
> -				substream->runtime->private_data;
> -			struct gen_pool *sram_pool = prtd->params->sram_pool;
> -			gen_pool_free(sram_pool, (unsigned)iram_dma->area,
> -				      iram_dma->bytes);
> +			davinci_free_sram(substream, iram_dma);
>  			kfree(iram_dma);
>  		}
>  	}
> 
