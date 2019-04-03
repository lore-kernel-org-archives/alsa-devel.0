From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Date: Wed, 3 Apr 2019 11:57:16 -0700
Message-ID: <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
References: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D9D0F806EF
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 20:57:22 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id f6so8768910pgs.8
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2019 11:57:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
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

This looks better :)

On Wed, Apr 03, 2019 at 10:07:40AM +0000, S.j. Wang wrote:
> @@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  {
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
>  	struct clk *clksrc = esai_priv->extalclk;
> -	bool tx = clk_id <= ESAI_HCKT_EXTAL;
> +	bool tx = (clk_id <= ESAI_HCKT_EXTAL || esai_priv->synchronous);
>  	bool in = dir == SND_SOC_CLOCK_IN;
>  	u32 ratio, ecr = 0;
>  	unsigned long clk_rate;
> @@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		ecr |= ESAI_ECR_ETI;
>  		/* fall through */

Btw, I am also wondering if the fall through here is a bug....
Because I don't recall that there is a specific reason to fall
through here. Can you please help confirm? Perhaps we need to
submit a separate fix as well by replacing it with a "break;".

>  	case ESAI_HCKR_EXTAL:
> -		ecr |= ESAI_ECR_ERI;
> +		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
>  		break;
>  	default:
>  		return -EINVAL;

> @@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  
>  	bclk = params_rate(params) * slot_width * esai_priv->slots;
>  
> -	ret = fsl_esai_set_bclk(dai, tx, bclk);
> +	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
>  	if (ret)
>  		return ret;
>  
> +	mask = ESAI_xCR_xSWS_MASK;
> +	val = ESAI_xCR_xSWS(slot_width, width);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
> +	/* Recording in synchronous mode needs to set TCR also */
> +	if (!tx && esai_priv->synchronous)
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
> +
>  	/* Use Normal mode to support monaural audio */
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
> @@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);
>  
> -	mask = ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
> -	val = ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
> -
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
> +	if (tx)
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +					ESAI_xCR_PADC, ESAI_xCR_PADC);

Mind aligning the indentation here like the one below?
		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
				   ESAI_xCR_PADC, ESAI_xCR_PADC);

Once you fix the indentation, add this:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
