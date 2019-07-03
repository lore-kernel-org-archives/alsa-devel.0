From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Wed, 3 Jul 2019 02:32:10 -0700
Message-ID: <20190703093209.GB8764@Asurada>
References: <cover.1562136119.git.shengjiu.wang@nxp.com>
 <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shengjiu.wang@nxp.com
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 03, 2019 at 02:42:05PM +0800, shengjiu.wang@nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> There is chip errata ERR008000, the reference doc is
> (https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf),
> 
> The issue is "While using ESAI transmit or receive and
> an underrun/overrun happens, channel swap may occur.
> The only recovery mechanism is to reset the ESAI."
> 
> This issue exist in imx3/imx5/imx6(partial) series.
> 
> In this commit add a tasklet to handle reset of ESAI
> after xrun happens to recover the channel swap.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 76 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 20039ae9893b..8c92e49ad6d8 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c

> +static void fsl_esai_reset(unsigned long arg)

Similarly fsl_esai_hw_reset? This one isn't really that bad though,
yet it feels better to have function naming in a similar style.

> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
> +	u32 saisr, tfcr, rfcr;
> +
> +	/* save the registers */
> +	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);

Instead of having this implicit comments, we could have:
+	bool tx = true, rx = false, enabled[2];
+
+	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
+	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
+	enabled[tx] = tfcr & ESAI_xFCR_xFEN;
+	enabled[rx] = rfcr & ESAI_xFCR_xFEN;

> +
> +	/* stop the tx & rx */
> +	fsl_esai_trigger_stop(esai_priv, 1);
> +	fsl_esai_trigger_stop(esai_priv, 0);

And we could reuse the boolean 'tx' and 'rx' here.

> +
> +	/* reset the esai, and restore the registers */
> +	fsl_esai_init(esai_priv);
> +

[...]
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);

Mask and value might fit into one line?

> +
> +	/* restore registers by regcache_sync */
> +	fsl_esai_register_restore(esai_priv);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK, 0);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK, 0);

And just for curious, can (or shall) we stuff this personal reset
to the reset() function? I found this one is a part of the reset
routine being mentioned in the RM -- it was done after ESAI reset
is done via ECR register.

[...]
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> +			   ESAI_PRRC_PDC_MASK,
> +			   ESAI_PRRC_PDC(ESAI_GPIO));
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> +			   ESAI_PCRC_PC_MASK,
> +			   ESAI_PCRC_PC(ESAI_GPIO));

Mask and value might fit into one line?
