From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: add tdm slots operation
 support
Date: Tue, 24 Nov 2015 00:50:11 -0800
Message-ID: <20151124085011.GB14109@Asurada-CZ80>
References: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1432614A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 09:50:46 +0100 (CET)
Received: by pabfh17 with SMTP id fh17so16322386pab.0
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 00:50:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 03:31:54PM +0800, Zidan Wang wrote:
> Add tdm slots operation support. If tdm slots and slot width have
> been configured in machine driver, we should use these values.
> Otherwise, using relevant channels and word length to set slots
> and slot width.
> 
> SAI will generate BCLK depends on sample rate, slots and slot width.
> And there may be unused BCLK cycles before each LRCLK transition.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 31 +++++++++++++++++++++++++------
>  sound/soc/fsl/fsl_sai.h |  3 +++
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 4b042fd..c01322c 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -126,6 +126,17 @@ out:
>  		return IRQ_HANDLED;
>  }
>  
> +static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
> +				u32 rx_mask, int slots, int slot_width)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	sai->slots = slots;
> +	sai->slot_width = slot_width;
> +
> +	return 0;
> +}
> +
>  static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
>  		int clk_id, unsigned int freq, int fsl_dir)
>  {
> @@ -395,11 +406,19 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	unsigned int channels = params_channels(params);
>  	u32 word_width = snd_pcm_format_width(params_format(params));
>  	u32 val_cr4 = 0, val_cr5 = 0;
> +	u32 slots = (channels == 1) ? 2 : channels;
> +	u32 slot_width = word_width;
>  	int ret;
>  
> +	if (sai->slots)
> +		slots = sai->slots;
> +
> +	if (sai->slot_width)
> +		slot_width = sai->slot_width;
> +
>  	if (!sai->is_slave_mode) {
>  		ret = fsl_sai_set_bclk(cpu_dai, tx,
> -			2 * word_width * params_rate(params));
> +				slots * slot_width * params_rate(params));
>  		if (ret)
>  			return ret;
>  
> @@ -411,21 +430,20 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  
>  			sai->mclk_streams |= BIT(substream->stream);
>  		}
> -
>  	}
>  
>  	if (!sai->is_dsp_mode)
> -		val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
> +		val_cr4 |= FSL_SAI_CR4_SYWD(slot_width);
>  
> -	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
> -	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
> +	val_cr5 |= FSL_SAI_CR5_WNW(slot_width);
> +	val_cr5 |= FSL_SAI_CR5_W0W(slot_width);
>  
>  	if (sai->is_lsb_first)
>  		val_cr5 |= FSL_SAI_CR5_FBT(0);
>  	else
>  		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
>  
> -	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
> +	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
>  
>  	/*
>  	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
> @@ -592,6 +610,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
>  	.set_sysclk	= fsl_sai_set_dai_sysclk,
>  	.set_fmt	= fsl_sai_set_dai_fmt,
> +	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
>  	.hw_params	= fsl_sai_hw_params,
>  	.hw_free	= fsl_sai_hw_free,
>  	.trigger	= fsl_sai_trigger,
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b95fbc3..d9ed7be 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -143,6 +143,9 @@ struct fsl_sai {
>  
>  	unsigned int mclk_id[2];
>  	unsigned int mclk_streams;
> +	unsigned int slots;
> +	unsigned int slot_width;
> +
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  };
> -- 
> 1.9.1
> 
