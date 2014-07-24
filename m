From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Date: Thu, 24 Jul 2014 17:20:45 +0200
Message-ID: <20140724152045.GA3384@distanz.ch>
References: <cover.1406189745.git.nicoleotsuka@gmail.com>
 <2c74a11776ffcc017c80dc31be4a8313755be8f5.1406189745.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2c74a11776ffcc017c80dc31be4a8313755be8f5.1406189745.git.nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2014-07-24 at 10:35:29 +0200, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> signal associated with an input clock into a signal associated with a different
> output clock. The driver currently works as a Front End of DPCM with other Back
> Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
> original sample rate to a common rate supported by Back Ends for playback while
> converts the common rate of Back Ends to a desired rate for capture. It has 3
> pairs to support three different substreams within totally 10 channels.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

[...]

> --- /dev/null
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -0,0 +1,1031 @@

[...]

> +static struct platform_driver fsl_asrc_driver = {
> +	.probe = fsl_asrc_probe,
> +	.driver = {
> +		.name = "fsl-asrc",
> +		.owner = THIS_MODULE,

Not necessary, this will be set by module_platform_driver (or
the expansion of platform_driver_register, respectively).

> +		.of_match_table = fsl_asrc_ids,
> +		.pm = &fsl_asrc_pm,
> +	},
> +};
> +module_platform_driver(fsl_asrc_driver);

[...]

> --- /dev/null
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -0,0 +1,384 @@

[...]

> +static int fsl_asrc_dma_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_card *card = rtd->card->snd_card;
> +	struct snd_pcm_substream *substream;
> +	struct snd_pcm *pcm = rtd->pcm;
> +	u64 dma_mask = DMA_BIT_MASK(32);
> +	int ret, i;
> +
> +	if (!card->dev->dma_mask)
> +		card->dev->dma_mask = &dma_mask;

dma_mask will go out of scope after fsl_asrc_dma_pcm_new returns,
resulting in a stray pointer in card->dev->dma_mask.

> +	if (!card->dev->coherent_dma_mask)
> +		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_LAST; i++) {
> +		substream = pcm->streams[i].substream;
> +
> +		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
> +				FSL_ASRC_DMABUF_SIZE, &substream->dma_buffer);
> +		if (ret) {
> +			dev_err(card->dev, "failed to allocate DMA buffer\n");
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (--i == 0)
> +		snd_dma_free_pages(&pcm->streams[i].substream->dma_buffer);
> +
> +	return ret;
> +}
> +
> +static void fsl_asrc_dma_pcm_free(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream;
> +	int i;
> +
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_LAST; i++) {
> +		substream = pcm->streams[i].substream;
> +		if (!substream)
> +			continue;
> +
> +		snd_dma_free_pages(&substream->dma_buffer);
> +		substream->dma_buffer.area = NULL;
> +		substream->dma_buffer.addr = 0;
> +	}
> +}
> +
> +struct snd_soc_platform_driver fsl_asrc_platform = {
> +	.ops		= &fsl_asrc_dma_pcm_ops,
> +	.pcm_new	= fsl_asrc_dma_pcm_new,
> +	.pcm_free	= fsl_asrc_dma_pcm_free,
> +};
> +EXPORT_SYMBOL_GPL(fsl_asrc_platform);
> -- 
> 1.8.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
