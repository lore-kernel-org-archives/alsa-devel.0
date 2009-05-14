From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/13] Main rewite of the mpc5200
	audio	DMA code
Date: Thu, 14 May 2009 11:51:32 +0100
Message-ID: <20090514105131.GG28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015918.28145.19103.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DFF4F24442
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 12:51:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015918.28145.19103.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:18PM -0400, Jon Smirl wrote:

> -static const struct snd_pcm_hardware psc_dma_pcm_hardware = {
> +static const struct snd_pcm_hardware psc_dma_hardware = {
>  	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_BATCH,
> -	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
> -		   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
> +	.formats = SNDRV_PCM_FMTBIT_S32_BE,

This seems like a major and very surprising reduction in functionality.
Why is this required?

> +	if (!psc_dma->playback.active &&
> +	    !psc_dma->capture.active) {
> +		/* Setup the IRQs */
> +	}

Should this be implemented or removed?

> +	if (!psc_dma->playback.active &&
> +	    !psc_dma->capture.active) {
> +
> +		/* Disable all interrupts and reset the PSC */
> +		out_be16(&psc_dma->psc_regs->isr_imr.imr, psc_dma->imr);
> +		//out_8(&psc_dma->psc_regs->command, 3 << 4); /* reset tx */
> +		//out_8(&psc_dma->psc_regs->command, 2 << 4); /* reset rx */
> +		//out_8(&psc_dma->psc_regs->command, 1 << 4); /* reset mode */
> +		//out_8(&psc_dma->psc_regs->command, 4 << 4); /* reset error */
> +
> +	}
> +

The commented code should go.
