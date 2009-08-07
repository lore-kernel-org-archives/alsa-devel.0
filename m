From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 5/5] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Thu, 06 Aug 2009 19:05:54 -0700
Message-ID: <4A7B8C02.6020902@boundarydevices.com>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>	<1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C85F24399
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 04:06:01 +0200 (CEST)
In-Reply-To: <1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Troy Kisky wrote:
> Fix underruns by using dma to copy 1st to sram
> in a ping/pong buffer style and then copying from
> the sram to the ASP. This also has the advantage
> of tolerating very long interrupt latency on dma
> completion.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>  static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
>  {
> +	struct snd_dma_buffer *iram_dma;
>  	struct davinci_runtime_data *prtd = substream->runtime->private_data;
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
> -	struct edmacc_param p_ram;
> -	int ret;
> +	int lch;
>  
>  	if (!dma_data)
>  		return -ENODEV;
>  
>  	prtd->params = dma_data;
>  
> -	/* Request master DMA channel */
> -	ret = edma_alloc_channel(prtd->params->channel,
> -				  davinci_pcm_dma_irq, substream,
> -				  EVENTQ_0);
> -	if (ret < 0)
> -		return ret;
> -	prtd->asp_master_lch = ret;
> +	/* Request asp master DMA channel */
> +	lch = prtd->asp_master_lch = edma_alloc_channel(dma_data->channel,
> +			davinci_pcm_dma_irq, substream, EVENTQ_0);
> +	if (lch < 0)
> +		goto exit1;
>  
> -	/* Request parameter RAM reload slot */
> -	ret = edma_alloc_slot(EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
> -	if (ret < 0) {
> -		edma_free_channel(prtd->asp_master_lch);
> -		return ret;
> -	}
> -	prtd->asp_link_lch[0] = ret;
> +	/* Request asp link channels */
> +	lch = prtd->asp_link_lch[0] = edma_alloc_slot(
> +			EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
> +	if (lch < 0)
> +		goto exit2;
> +
> +	allocate_sram(substream, dma_data->sram_size);

This is allocated too late for the "ensure that buffer size is a multiple of period size"
constraint.

I have a patch after fixing other feedback.

Troy
