From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-esai: fix ESAI TDM slot setting
Date: Mon, 10 Feb 2014 15:50:32 +0800
Message-ID: <20140210075031.GA16453@MrMyself>
References: <1392014837-22308-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392014837-22308-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 10, 2014 at 02:47:17PM +0800, Xiubo Li wrote:
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 4 ++--
>  sound/soc/fsl/fsl_esai.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index d0c72ed..c84026c 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -326,7 +326,7 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
>  			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMB_xS(tx_mask));
> +			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
>  
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
>  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
> @@ -334,7 +334,7 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
>  			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMB_xS(rx_mask));
> +			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
>  
>  	esai_priv->slot_width = slot_width;
>  
> diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
> index 9c9f957..75e1403 100644
> --- a/sound/soc/fsl/fsl_esai.h
> +++ b/sound/soc/fsl/fsl_esai.h
> @@ -322,7 +322,7 @@
>  #define ESAI_xSMB_xS_SHIFT	0
>  #define ESAI_xSMB_xS_WIDTH	16
>  #define ESAI_xSMB_xS_MASK	(((1 << ESAI_xSMB_xS_WIDTH) - 1) << ESAI_xSMB_xS_SHIFT)
> -#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) & ESAI_xSMA_xS_MASK)
> +#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) & ESAI_xSMB_xS_MASK)

It should use ESAI_xSMB_xS_WIDTH.

Otherwise, it looks fine. Thank you.

Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

---
>  
>  /* Port C Direction Register -- REG_ESAI_PRRC 0xF8 */
>  #define ESAI_PRRC_PDC_SHIFT	0
> -- 
> 1.8.4
> 
> 
