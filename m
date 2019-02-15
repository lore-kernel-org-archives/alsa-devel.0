From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Date: Fri, 15 Feb 2019 10:55:15 -0800
Message-ID: <20190215185514.GA19299@Asurada-Nvidia.nvidia.com>
References: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "festevam@gmail.com" <festevam@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 15, 2019 at 11:04:38AM +0000, S.j. Wang wrote:
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Would need this for stable kernel too.

Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.

> ---
>  sound/soc/fsl/fsl_esai.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 57b484768a58..afe67c865330 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -398,7 +398,8 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		break;
>  	case SND_SOC_DAIFMT_RIGHT_J:
>  		/* Data on rising edge of bclk, frame high, right aligned */
> -		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
> +		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
> +		xcr  |= ESAI_xCR_xWA;
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* Data on rising edge of bclk, frame high, 1clk before data */
> @@ -455,12 +456,12 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		return -EINVAL;
>  	}
>  
> -	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR;
> +	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR | ESAI_xCR_xWA;
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, xcr);
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR, mask, xcr);
>  
>  	mask = ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCCR_xFSP |
> -		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD | ESAI_xCR_xWA;
> +		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD;
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR, mask, xccr);
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR, mask, xccr);
>  
> -- 
> 1.9.1
> 
