From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Sun, 16 Mar 2014 12:18:59 +0100
Message-ID: <532588A3.4050301@metafoo.de>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D6E92610A0
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 12:18:20 +0100 (CET)
In-Reply-To: <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/14/2014 03:42 PM, Peter Ujfalusi wrote:
> We need to place constraint on the period and buffer size if the read
> or write AFIFO is enabled and it is configured for more than one word
> otherwise the DMA will fail in buffer configuration where the sizes
> are not aligned with the requested FIFO configuration.
>
> Some application (like mplayer) needs the constraint placed on the
> buffer size as well. If only period size is constrained they might
> fail to figure out the allowed buffer configuration.

Hm... the sound like there is still a bug somewhere. We constrain the buffer 
size to be a multiple of the period size. If the period size is constraint 
to be a multiple of a constant then the buffer size should automatically be 
constrained to be a multiple of constant * period count. And just 
constraining the buffer size to be a multiple of the burst size still allows 
buffer sizes that are not a multiple of burst size * period count.

>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   sound/soc/davinci/davinci-mcasp.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index a01ae97c90aa..3ca6e8c4568a 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -720,6 +720,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>   				 struct snd_soc_dai *dai)
>   {
>   	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
> +	int afifo_numevt;
>
>   	if (mcasp->version == MCASP_VERSION_4)
>   		snd_soc_dai_set_dma_data(dai, substream,
> @@ -727,6 +728,21 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>   	else
>   		snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
>
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		afifo_numevt = mcasp->txnumevt;
> +	else
> +		afifo_numevt = mcasp->rxnumevt;

Shouldn't this use the same calculation that's used to set 
dma_data->maxburst? Also we should add this to the dmaengine PCM driver, 
since there will most likely be more DMA controllers with this restriction, 
doesn't necessarily need to be done in this patch series though.

> +
> +	if (afifo_numevt > 1) {
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> +					   afifo_numevt);
> +
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
> +					   afifo_numevt);
> +	}
> +
>   	return 0;
>   }
>
>
