From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3] ASoC: fsl_esai: fix channel swap issue
 when stream starts
Date: Tue, 26 Feb 2019 11:10:58 -0800
Message-ID: <20190226191057.GA24082@Asurada-Nvidia.nvidia.com>
References: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D217EF8967C
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 20:11:05 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id h11so6670582pgl.0
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 11:11:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

Two more trivial comments inline.

On Tue, Feb 26, 2019 at 03:12:25AM +0000, S.j. Wang wrote:
> There is very low possibility ( < 0.1% ) that channel swap happened
> in beginning when multi output/input pin is enabled. The issue is
> that hardware can't send data to correct pin in the beginning with
> the normal enable flow.
> 
> This is hardware issue, but there is no errata, the workaround flow
> is that: Each time playback/recording, firstly clear the xSMA/xSMB,
> then enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
> before xSMA). Which is to use the xSMA as the trigger start register,
> previously the xCR_TE or xCR_RE is the bit for starting.
> 
> Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> Cc: <stable@vger.kernel.org>
> Re> @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	esai_priv->slot_width = slot_width;
>  	esai_priv->slots = slots;
> +	esai_priv->tx_mask    = tx_mask;
> +	esai_priv->rx_mask    = rx_mask;

Not necessary to have tabs before "="s.

> @@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
>  				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
> +		mask = tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> +

Please add a line of brief comments for the reason why we are doing
this here, something similar to the commit log, but should have:
1) Clear xSMA/B 2) Set TE/RE before xSMA/B 3)Set xSMB before xSMA.

Apparently having this mask settings in the trigger() does not look
very common, so I believe a line of comments would help a lot.

You may add my Acked-by in your next version:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
> +
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK, 0);
> 
