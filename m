From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ASoC: dmaengine-pcm: Add support for querying
	stream position from DMA device
Date: Mon, 11 Jun 2012 14:24:09 +0100
Message-ID: <20120611132409.GG11168@n2100.arm.linux.org.uk>
References: <1339416253-4121-1-git-send-email-lars@metafoo.de> <1339416253-4121-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339416253-4121-2-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 11, 2012 at 02:04:13PM +0200, Lars-Peter Clausen wrote:
> @@ -202,7 +203,27 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
>  snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
>  {
>  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> -	return bytes_to_frames(substream->runtime, prtd->pos);
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +	unsigned int pos;
> +
> +	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
> +	if (status != DMA_IN_PROGRESS && status != DMA_PAUSED) {
> +		pos = 0;
> +	} else if (state.residue == 0) {
> +		/* This should never happen with cyclic transfers, so assume
> +		 * that the dmaengine driver does not support reporting residue
> +		 * and fall back to counting periods. */
> +		pos = prtd->pos;

That is an incorrect assumption.

The current DMA position is defined by the DMA pointer.  When the DMA
engine has transferred the last few bytes of the DMA, the DMA pointer
will be pointing to the byte _after_ the last byte transferred in the
buffer.

Therefore, when you calculate the residue as (buf_start + buf_len -
current_pointer) you end up with zero.

What we need to do is to get rid of this idea that reporting the residue
is optional for DMA engine drivers.  Let's make it absolutely required
in order to support cyclic transfers.
