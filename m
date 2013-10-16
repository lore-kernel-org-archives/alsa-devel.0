From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: generic-dmaengine-pcm: Support
 on-chip internal memory for DMA buffer
Date: Wed, 16 Oct 2013 10:56:06 +0200
Message-ID: <525E54A6.80303@metafoo.de>
References: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
 <764ec7a383968296dbd3988aee2f3e30b951c7d1.1381911378.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-202.synserver.de (smtp-out-202.synserver.de
 [212.40.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E7B265080
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 10:53:57 +0200 (CEST)
In-Reply-To: <764ec7a383968296dbd3988aee2f3e30b951c7d1.1381911378.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 10:18 AM, Nicolin Chen wrote:
[...]
>   * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index e29ec3c..dd72964 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -142,7 +142,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
>  	const struct snd_dmaengine_pcm_config *config = pcm->config;
>  	struct snd_pcm_substream *substream;
> -	unsigned int i;
> +	unsigned int i, type = SNDRV_DMA_TYPE_DEV;
>  	int ret;
>  
>  	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> @@ -162,8 +162,10 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  			goto err_free;
>  		}
>  
> -		ret = snd_pcm_lib_preallocate_pages(substream,
> -				SNDRV_DMA_TYPE_DEV,
> +		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_DMA_IRAM)
> +			type = SNDRV_DMA_TYPE_DEV_IRAM;

Should we just make this the default, after all it will fallback to normal
memory if no iram region has been specified.

> +
> +		ret = snd_pcm_lib_preallocate_pages(substream, type,
>  				dmaengine_dma_dev(pcm, substream),
>  				config->prealloc_buffer_size,
>  				config->pcm_hardware->buffer_bytes_max);
> 
