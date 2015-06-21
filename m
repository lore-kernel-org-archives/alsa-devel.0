From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fsl_spdif: Check for
 clk_prepare_enable() error
Date: Sat, 20 Jun 2015 18:55:28 -0700
Message-ID: <20150621015528.GA9340@Asurada>
References: <1434835086-27176-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C4160260468
 for <alsa-devel@alsa-project.org>; Sun, 21 Jun 2015 03:55:43 +0200 (CEST)
Received: by pacyo7 with SMTP id yo7so6672219pac.2
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 18:55:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434835086-27176-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 20, 2015 at 06:18:06PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
>  sound/soc/fsl/fsl_spdif.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 8e93221..489fa86 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -482,13 +482,18 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
>  		mask = SCR_TXFIFO_AUTOSYNC_MASK | SCR_TXFIFO_CTRL_MASK |
>  			SCR_TXSEL_MASK | SCR_USRC_SEL_MASK |
>  			SCR_TXFIFO_FSEL_MASK;
> -		for (i = 0; i < SPDIF_TXRATE_MAX; i++)
> -			clk_prepare_enable(spdif_priv->txclk[i]);
> +		for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
> +			ret = clk_prepare_enable(spdif_priv->txclk[i]);
> +			if (ret)
> +				goto disable_txclk;
> +		}
>  	} else {
>  		scr = SCR_RXFIFO_FSEL_IF8 | SCR_RXFIFO_AUTOSYNC;
>  		mask = SCR_RXFIFO_FSEL_MASK | SCR_RXFIFO_AUTOSYNC_MASK|
>  			SCR_RXFIFO_CTL_MASK | SCR_RXFIFO_OFF_MASK;
> -		clk_prepare_enable(spdif_priv->rxclk);
> +		ret = clk_prepare_enable(spdif_priv->rxclk);
> +		if (ret)
> +			goto err;
>  	}
>  	regmap_update_bits(regmap, REG_SPDIF_SCR, mask, scr);
>  
> @@ -497,6 +502,9 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
>  
>  	return 0;
>  
> +disable_txclk:
> +	for (i--; i >= 0; i--)
> +		clk_disable_unprepare(spdif_priv->txclk[i]);
>  err:
>  	clk_disable_unprepare(spdif_priv->coreclk);
>  
> -- 
> 1.9.1
> 
