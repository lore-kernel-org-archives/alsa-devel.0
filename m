From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Handle slave mode per TX/RX direction
Date: Tue, 13 Aug 2019 18:02:15 -0700
Message-ID: <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
References: <20190811194517.19314-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190811194517.19314-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, festevam@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, Viorel Suman <viorel.suman@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 11, 2019 at 10:45:17PM +0300, Daniel Baluta wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> The SAI interface can be a clock supplier or consumer
> as a function of stream direction. e.g SAI can be master
> for Tx and slave for Rx.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 18 +++++++++---------
>  sound/soc/fsl/fsl_sai.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 4a346fcb5630..69cf3678c859 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -273,18 +273,18 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,

This function is called for both TX and RX at the same time from
fsl_sai_set_dai_fmt() so I don't actually see how it can operate
in two opposite directions from this change alone. Anything that
I have missed?

Thanks
Nicolin

>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -		sai->is_slave_mode = false;
> +		sai->is_slave_mode[tx] = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
> -		sai->is_slave_mode = true;
> +		sai->is_slave_mode[tx] = true;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
> -		sai->is_slave_mode = false;
> +		sai->is_slave_mode[tx] = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFS:
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -		sai->is_slave_mode = true;
> +		sai->is_slave_mode[tx] = true;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -326,7 +326,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
>  	int ret = 0;
>  
>  	/* Don't apply to slave mode */
> -	if (sai->is_slave_mode)
> +	if (sai->is_slave_mode[tx])
>  		return 0;
>  
>  	for (id = 0; id < FSL_SAI_MCLK_MAX; id++) {
> @@ -422,7 +422,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	if (sai->slot_width)
>  		slot_width = sai->slot_width;
>  
> -	if (!sai->is_slave_mode) {
> +	if (!sai->is_slave_mode[tx]) {
>  		ret = fsl_sai_set_bclk(cpu_dai, tx,
>  				slots * slot_width * params_rate(params));
>  		if (ret)
> @@ -458,7 +458,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	 * error.
>  	 */
>  
> -	if (!sai->is_slave_mode) {
> +	if (!sai->is_slave_mode[tx]) {
>  		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
>  			regmap_update_bits(sai->regmap, FSL_SAI_TCR4(ofs),
>  				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
> @@ -497,7 +497,7 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  
> -	if (!sai->is_slave_mode &&
> +	if (!sai->is_slave_mode[tx] &&
>  			sai->mclk_streams & BIT(substream->stream)) {
>  		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
>  		sai->mclk_streams &= ~BIT(substream->stream);
> @@ -581,7 +581,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  			 * This is a hardware bug, and will be fix in the
>  			 * next sai version.
>  			 */
> -			if (!sai->is_slave_mode) {
> +			if (!sai->is_slave_mode[tx]) {
>  				/* Software Reset for both Tx and Rx */
>  				regmap_write(sai->regmap, FSL_SAI_TCSR(ofs),
>  					     FSL_SAI_CSR_SR);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b89b0ca26053..c2c43a7d9ba1 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -167,7 +167,7 @@ struct fsl_sai {
>  	struct clk *bus_clk;
>  	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
>  
> -	bool is_slave_mode;
> +	bool is_slave_mode[2];
>  	bool is_lsb_first;
>  	bool is_dsp_mode;
>  	bool synchronous[2];
> -- 
> 2.17.1
> 
