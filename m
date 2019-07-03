From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Wed, 3 Jul 2019 22:56:19 +0200
Message-ID: <3238f813-ac71-69e2-45bf-badb461dac82@intel.com>
References: <cover.1562136119.git.shengjiu.wang@nxp.com>
 <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: shengjiu.wang@nxp.com
Cc: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019-07-03 08:42, shengjiu.wang@nxp.com wrote:
> +static void fsl_esai_reset(unsigned long arg)
> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
> +	u32 saisr, tfcr, rfcr;
> +
> +	/* save the registers */
> +	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
> +
> +	/* stop the tx & rx */
> +	fsl_esai_trigger_stop(esai_priv, 1);
> +	fsl_esai_trigger_stop(esai_priv, 0);
> +
> +	/* reset the esai, and restore the registers */
> +	fsl_esai_init(esai_priv);

<comment below applies>

> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);
> +
> +	/* restore registers by regcache_sync */
> +	fsl_esai_register_restore(esai_priv);
> +

Both _init and _restore may fail given their declaration in 1/2 "ASoC: 
fsl_esai: Wrap some operations to be functions" yet here you simply 
ignore the return values.

If failure of said functions is permissive, it might be a good place for 
a comment.

Czarek
