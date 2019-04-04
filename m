From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Date: Thu, 4 Apr 2019 06:29:39 +0000
Message-ID: <VE1PR04MB6479E9E8A536F7EEFE78A3A1E3500@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
 <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140057.outbound.protection.outlook.com [40.107.14.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02223F8075B
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 08:29:40 +0200 (CEST)
In-Reply-To: <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi

> 
> This looks better :)
> 
> On Wed, Apr 03, 2019 at 10:07:40AM +0000, S.j. Wang wrote:
> > @@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct
> > snd_soc_dai *dai, int clk_id,  {
> >  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
> >  	struct clk *clksrc = esai_priv->extalclk;
> > -	bool tx = clk_id <= ESAI_HCKT_EXTAL;
> > +	bool tx = (clk_id <= ESAI_HCKT_EXTAL || esai_priv->synchronous);
> >  	bool in = dir == SND_SOC_CLOCK_IN;
> >  	u32 ratio, ecr = 0;
> >  	unsigned long clk_rate;
> > @@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct
> snd_soc_dai *dai, int clk_id,
> >  		ecr |= ESAI_ECR_ETI;
> >  		/* fall through */
> 
> Btw, I am also wondering if the fall through here is a bug....
> Because I don't recall that there is a specific reason to fall through here.
> Can you please help confirm? Perhaps we need to submit a separate fix as
> well by replacing it with a "break;".
Yes, I think there is issue here, will submit another patch for it.
> 
> >  	case ESAI_HCKR_EXTAL:
> > -		ecr |= ESAI_ECR_ERI;
> > +		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI :
> ESAI_ECR_ERI;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> 
> > @@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct
> > snd_pcm_substream *substream,
> >
> >  	bclk = params_rate(params) * slot_width * esai_priv->slots;
> >
> > -	ret = fsl_esai_set_bclk(dai, tx, bclk);
> > +	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
> >  	if (ret)
> >  		return ret;
> >
> > +	mask = ESAI_xCR_xSWS_MASK;
> > +	val = ESAI_xCR_xSWS(slot_width, width);
> > +
> > +	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask,
> val);
> > +	/* Recording in synchronous mode needs to set TCR also */
> > +	if (!tx && esai_priv->synchronous)
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> mask, val);
> > +
> >  	/* Use Normal mode to support monaural audio */
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  			   ESAI_xCR_xMOD_MASK,
> params_channels(params) > 1 ?
> > @@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct
> > snd_pcm_substream *substream,
> >
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask,
> val);
> >
> > -	mask = ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
> > -	val = ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
> > -
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask,
> val);
> > +	if (tx)
> > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +					ESAI_xCR_PADC, ESAI_xCR_PADC);
> 
> Mind aligning the indentation here like the one below?
> 		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> 				   ESAI_xCR_PADC, ESAI_xCR_PADC);

Ok. Will send v3.
> 
> Once you fix the indentation, add this:
> 
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Thanks
