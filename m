From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for
	pcm_mmap
Date: Thu, 28 Jun 2012 13:09:36 +0200
Message-ID: <4FEC3B70.5030902@metafoo.de>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-120.synserver.de (smtp-out-130.synserver.de
	[212.40.185.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FBEA103FD2
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 13:05:47 +0200 (CEST)
In-Reply-To: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/28/2012 09:01 AM, Laxman Dewangan wrote:
> The pcm mmap for the substream dma buffer is done using the
> dma_mmap_writecombine().
> Some of the chip sound driver like Spear, Tegra, Davinci,
> ep93xx,snd_imx, snd_mxs, NUC900, OMAP, Samsung are doing this
> mapping locally.
> Add api in the snd dmaengine driver so that different client of
> snd dmaengine can use this rather than implementing locally.
> 

This is not really related to the dmaengine pcm driver. It's more of a
coincidence that all upstream drivers which use the dmaengine pcm driver
also use write-combined memory. In my opinion it would be better to add this
to the ALSA core. Now that there is a generic dma_mmap_writecombine it may
make sense to integrate this with snd_pcm_lib_default_mmap.

- Lars

> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  include/sound/dmaengine_pcm.h |    2 ++
>  sound/soc/soc-dmaengine-pcm.c |   17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index b877334..15c0d3c 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -47,4 +47,6 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
>  
>  struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
>  
> +int snd_dmaengine_pcm_mmap_writecombine(struct snd_pcm_substream *substream,
> +		struct vm_area_struct *vma);
>  #endif
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 5df529e..6535eb3 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -313,3 +314,19 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
> +
> +/**
> + * snd_dmaengine_pcm_mmap_writecombine - mmap stream dma buffer using
> + * dma_mmap_writecombine().
> + * @substream: PCM substream
> + * @vma: VM area.
> + */
> +int snd_dmaengine_pcm_mmap_writecombine(struct snd_pcm_substream *substream,
> +			struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_mmap_writecombine);
