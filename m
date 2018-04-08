From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Sat, 7 Apr 2018 18:14:55 -0700
Message-ID: <20180408011454.GA2997@Asurada-CZ80>
References: <20180407130221.24770-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFAA266FD1
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 03:15:02 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id u86so3420192pfd.2
 for <alsa-devel@alsa-project.org>; Sat, 07 Apr 2018 18:15:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180407130221.24770-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 07, 2018 at 03:02:21PM +0200, Marek Vasut wrote:
> When setting xFP directly, set the xPM predivider to 1, otherwise
> it could remain set to previously set incorrect value and interfere
> with the correct clocking.

This doesn't sound right to me. Could you please provide a failed
instance? It's been a while since I wrote the code. But I can tell
that PM is supposed to be called by set_sysclk() only, while FP is
used for bclk. If you clear PM when setting FP, the output of HCK
could be messed.

Thanks
Nicolin

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/fsl/fsl_esai.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 40a700493f4c..9f69823b50d7 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -128,8 +128,11 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
>  
>  	maxfp = usefp ? 16 : 1;
>  
> -	if (usefp && fp)
> +	if (usefp && fp) {
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCCR(tx),
> +				   ESAI_xCCR_xPM_MASK, 0);
>  		goto out_fp;
> +	}
>  
>  	if (ratio > 2 * 8 * 256 * maxfp || ratio < 2) {
>  		dev_err(dai->dev, "the ratio is out of range (2 ~ %d)\n",
> -- 
> 2.16.2
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
