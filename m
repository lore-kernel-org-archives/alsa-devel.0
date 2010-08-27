From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: ad1980: make usage of
	register	cache optional
Date: Fri, 27 Aug 2010 19:20:28 +0100
Message-ID: <20100827182028.GD30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1282655384-13357-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 22784103882
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:20:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-4-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:09:42PM +0200, Uwe Kleine-K??nig wrote:
> I'm hunting some problems where reading and writing to the codec doesn't
> work.  In this case caching is in the way.
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Once more please remember to CC maintainers on patches.

The commit message here could've done with a description of what the
actual change you've implemented to bypass the register cache here is.
What you've done is to add an ifdef AC97_USE_CACHE which cuts out the
cache parts of the I/O functions and the register defaults.  You've also
introduced a number of unrelated changes which add logging to the I/O
functions.

It strikes me that this is a fairly invasive way of implementing this
functionality and that it's probably at the wrong level - it'd seem
better to do this by supporting volatility and then marking all the
registers as volatile, and that doing this with a debugfs setting in the
core (or the soc-cache code anyway) would be even better.  This would
fall fairly naturally out of factoring the AC97 register I/O into
soc-cache.

> ---
>  sound/soc/codecs/ad1980.c |   36 +++++++++++++++++++++++++++++-------
>  1 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 82267e5..864e65d 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -33,6 +33,8 @@
>  
>  #include "ad1980.h"
>  
> +#define AC97_USE_CACHE 1
> +#if AC97_USE_CACHE
>  /*
>   * AD1980 register cache
>   */
> @@ -54,6 +56,7 @@ static const u16 ad1980_reg[] = {
>  	0x0000, 0x0000, 0x1001, 0x0000, /* 70 - 76 */
>  	0x0000, 0x0000, 0x4144, 0x5370  /* 78 - 7e */
>  };
> +#endif
>  
>  static const char *ad1980_rec_sel[] = {"Mic", "CD", "NC", "AUX", "Line",
>  		"Stereo Mix", "Mono Mix", "Phone"};
> @@ -101,7 +104,9 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
>  	unsigned int reg)
>  {
>  	u16 *cache = codec->reg_cache;
> +	int ret;
>  
> +#if AC97_USE_CACHE
>  	switch (reg) {
>  	case AC97_RESET:
>  	case AC97_INT_PAGING:
> @@ -109,27 +114,38 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
>  	case AC97_EXTENDED_STATUS:
>  	case AC97_VENDOR_ID1:
>  	case AC97_VENDOR_ID2:
> -		return soc_ac97_ops.read(codec->ac97, reg);
> +#endif
> +		ret = soc_ac97_ops.read(codec->ac97, reg);
> +#if AC97_USE_CACHE
>  	default:
>  		reg = reg >> 1;
>  
>  		if (reg >= ARRAY_SIZE(ad1980_reg))
> -			return -EINVAL;
> -
> -		return cache[reg];
> +			ret = -EINVAL;
> +		else
> +			ret = cache[reg];
>  	}
> +#endif
> +
> +	pr_debug("%s: reg=0x%02x, val=0x%04x\n", __func__, reg, ret);
> +
> +	return ret;
>  }
>  
>  static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
>  	unsigned int val)
>  {
> -	u16 *cache = codec->reg_cache;
> +	pr_debug("%s: reg=0x%02x, val=0x%04x\n", __func__, reg, val);
>  
>  	soc_ac97_ops.write(codec->ac97, reg, val);
> +
> +#if AC97_USE_CACHE
>  	reg = reg >> 1;
> -	if (reg < ARRAY_SIZE(ad1980_reg))
> +	if (reg < ARRAY_SIZE(ad1980_reg)) {
> +		u16 *cache = codec->reg_cache;
>  		cache[reg] = val;
> -
> +	}
> +#endif
>  	return 0;
>  }
>  
> @@ -204,6 +220,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
>  	codec = socdev->card->codec;
>  	mutex_init(&codec->mutex);
>  
> +#if AC97_USE_CACHE
>  	codec->reg_cache =
>  		kzalloc(sizeof(u16) * ARRAY_SIZE(ad1980_reg), GFP_KERNEL);
>  	if (codec->reg_cache == NULL) {
> @@ -214,6 +231,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
>  			ARRAY_SIZE(ad1980_reg));
>  	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(ad1980_reg);
>  	codec->reg_cache_step = 2;
> +#endif
>  	codec->name = "AD1980";
>  	codec->owner = THIS_MODULE;
>  	codec->dai = &ad1980_dai;
> @@ -279,9 +297,11 @@ pcm_err:
>  	snd_soc_free_ac97_codec(codec);
>  
>  codec_err:
> +#if AC97_USE_CACHE
>  	kfree(codec->reg_cache);
>  
>  cache_err:
> +#endif
>  	kfree(socdev->card->codec);
>  	socdev->card->codec = NULL;
>  	return ret;
> @@ -298,7 +318,9 @@ static int ad1980_soc_remove(struct platform_device *pdev)
>  	snd_soc_dapm_free(socdev);
>  	snd_soc_free_pcms(socdev);
>  	snd_soc_free_ac97_codec(codec);
> +#if AC97_USE_CACHE
>  	kfree(codec->reg_cache);
> +#endif
>  	kfree(codec);
>  	return 0;
>  }
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
