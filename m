From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH] ASoC: 88pm860x: Don't change pm860x->dir
 setting if pm860x_set_dai_sysclk fails
Date: Mon, 29 Jun 2015 13:19:51 +0800
Message-ID: <1435555191.1744.4.camel@linaro.org>
References: <1435547723.6397.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 17E692651C9
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 07:19:49 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so98981977pac.2
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 22:19:47 -0700 (PDT)
In-Reply-To: <1435547723.6397.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-29 at 11:15 +0800, Axel Lin wrote:
> 88pm860x does not support slave mode, so it returns -EINVAL for
> PM860X_CLK_DIR_IN. Current code changes pm860x->dir setting before
> return error, so it has impact on the logic of pm860x_pcm_set_dai_fmt.
> 
> This patch adds comment for the reason to return -EINVAL for
> PM860X_CLK_DIR_IN, and avoid changing pm860x->dir setting if
> pm860x_set_dai_sysclk fails.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/88pm860x-codec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
> index 38b3dad..4d91a6a 100644
> --- a/sound/soc/codecs/88pm860x-codec.c
> +++ b/sound/soc/codecs/88pm860x-codec.c
> @@ -1028,10 +1028,8 @@ static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>  
>  	if (dir == PM860X_CLK_DIR_OUT)
>  		pm860x->dir = PM860X_CLK_DIR_OUT;
> -	else {
> -		pm860x->dir = PM860X_CLK_DIR_IN;
> +	else	/* Slave mode is not supported */
>  		return -EINVAL;
> -	}
>  
>  	return 0;
>  }

Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Regards
Haojian
