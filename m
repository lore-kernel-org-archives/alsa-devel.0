From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple
 data lines
Date: Mon, 29 Jul 2019 13:21:54 -0700
Message-ID: <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-4-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-4-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 28, 2019 at 10:24:25PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 Rx/Tx data lines which can be enabled
> using TCE/RCE bits of TCR3/RCR3 registers.
> 
> Data lines to be enabled are read from DT fsl,dl-mask property.
> By default (if no DT entry is provided) only data line 0 is enabled.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
>  sound/soc/fsl/fsl_sai.h |  4 +++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 637b1d12a575..5e7cb7fd29f5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  
>  	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
>  			   FSL_SAI_CR3_TRCE_MASK,
> -			   FSL_SAI_CR3_TRCE);
> +			   FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
>  
>  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
>  			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> @@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * active data lines mask for TX/RX, defaults to 1 (only the first
> +	 * data line is enabled
> +	 */
> +	sai->dl_mask[RX] = 1;
> +	sai->dl_mask[TX] = 1;
> +	of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[RX]);
> +	of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[TX]);

Just curious what if we enable 8 data lines through DT bindings
while an audio file only has 1 or 2 channels. Will TRCE bits be
okay to stay with 8 data channels configurations? Btw, how does
DMA work for the data registers? ESAI has one entry at a fixed
address for all data channels while SAI seems to have different
data registers.
