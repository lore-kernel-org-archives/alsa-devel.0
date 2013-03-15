From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 2/2] ASoC: dmaengine_pcm: add
	snd_dmaengine_generic_pcm_open()
Date: Fri, 15 Mar 2013 11:00:46 +0100
Message-ID: <5142F14E.7040503@ti.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 406482625FE
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 11:01:32 +0100 (CET)
In-Reply-To: <1363318601-31505-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


Test on OMAP with patches
  http://www.spinics.net/lists/linux-omap/msg87893.html

Tested-by: Sebastien Guiriec <s-guiriec@ti.com>

On 03/15/2013 04:36 AM, Shawn Guo wrote:
> With generic DMA device tree binding and helper function
> dma_request_slave_channel() in place, dmaengine_pcm should support
> that in requesting DMA channel for users that support generic DMA
> device tree binding.
>
> Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> and slave channel name as arguments and calls generic DMA helper
> dma_request_slave_channel() to request DMA channel from dmaengine.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: alsa-devel@alsa-project.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/sound/dmaengine_pcm.h |    2 ++
>   sound/soc/soc-dmaengine-pcm.c |   39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
>
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index b877334..452df15 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -43,6 +43,8 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
>
>   int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
>   	dma_filter_fn filter_fn, void *filter_data);
> +int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
> +				   struct device *dev, const char *name);
>   int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
>
>   struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
> diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
> index 111b7d92..970eb2b 100644
> --- a/sound/soc/soc-dmaengine-pcm.c
> +++ b/sound/soc/soc-dmaengine-pcm.c
> @@ -304,6 +304,45 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
>   EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
>
>   /**
> + * snd_dmaengine_generic_pcm_open - Open a dmaengine based PCM substream
> + * @substream: PCM substream
> + * @dev: pointer to DMA client device structure
> + * @name: DMA slave channel name
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * This function is a variant of snd_dmaengine_pcm_open(). It takes different
> + * parameters and calls generic DMA helper dma_request_slave_channel() to
> + * request a DMA channel from dmaengine.
> + */
> +int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
> +				   struct device *dev, const char *name)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd;
> +	int ret;
> +
> +	ret = snd_pcm_hw_constraint_integer(substream->runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		return ret;
> +
> +	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
> +	if (!prtd)
> +		return -ENOMEM;
> +
> +	prtd->dma_chan = dma_request_slave_channel(dev, name);
> +	if (!prtd->dma_chan) {
> +		kfree(prtd);
> +		return -ENXIO;
> +	}
> +
> +	substream->runtime->private_data = prtd;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_generic_pcm_open);
> +
> +/**
>    * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
>    * @substream: PCM substream
>    */
>
