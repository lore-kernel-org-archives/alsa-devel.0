From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/5] ASoC: fsl_sai: Update Tx/Rx channel enable mask
Date: Tue, 6 Aug 2019 18:17:59 -0700
Message-ID: <20190807011758.GE8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-3-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-3-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 06, 2019 at 06:12:11PM +0300, Daniel Baluta wrote:
> Tx channel enable (TCE) / Rx channel enable (RCE) bits
> enable corresponding data channel for Tx/Rx operation.
> 
> Because SAI supports up the 8 channels TCE/RCE occupy
> up the 8 bits inside TCR3/RCR3 registers we need to extend
> the mask to reflect this.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 6 ++++--
>  sound/soc/fsl/fsl_sai.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 17b0aff4ee8b..637b1d12a575 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -599,7 +599,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	int ret;
>  
> -	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
> +	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> +			   FSL_SAI_CR3_TRCE_MASK,
>  			   FSL_SAI_CR3_TRCE);
>  
>  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> @@ -614,7 +615,8 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  
> -	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> +	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> +			   FSL_SAI_CR3_TRCE_MASK, 0);
>  }
>  
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 4bb478041d67..20c5b9b1e8bc 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -110,6 +110,7 @@
>  
>  /* SAI Transmit and Receive Configuration 3 Register */
>  #define FSL_SAI_CR3_TRCE	BIT(16)
> +#define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
>  #define FSL_SAI_CR3_WDFL(x)	(x)
>  #define FSL_SAI_CR3_WDFL_MASK	0x1f
>  
> -- 
> 2.17.1
> 
