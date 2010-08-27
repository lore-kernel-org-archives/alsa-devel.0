From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: ad1980: verify writes
Date: Fri, 27 Aug 2010 19:25:25 +0100
Message-ID: <20100827182525.GF30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1282655384-13357-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E0C4D24679
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:25:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-6-git-send-email-u.kleine-koenig@pengutronix.de>
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

On Tue, Aug 24, 2010 at 03:09:44PM +0200, Uwe Kleine-K??nig wrote:
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Again, please remember to CC maintainers on patches and doing this as
driver-specific code feels like we're solving things at the wrong level
- register I/O is something that could potentially be dodgy for any
device.

> ---
>  sound/soc/codecs/ad1980.c |   41 ++++++++++++++++++++++++++++++-----------
>  1 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index a3e78d4..2851ca1 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -34,6 +34,8 @@
>  #include "ad1980.h"
>  
>  #define AC97_USE_CACHE 1
> +#define AC97_VERIFY_WRITE 0
> +
>  #if AC97_USE_CACHE
>  /*
>   * AD1980 register cache
> @@ -100,13 +102,8 @@ SOC_ENUM("Capture Source", ad1980_cap_src),
>  SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
>  };
>  
> -static unsigned int ac97_read(struct snd_soc_codec *codec,
> -	unsigned int reg)
> +static int ac97_reg_cacheable(unsigned int reg)
>  {
> -	u16 *cache = codec->reg_cache;
> -	int ret;
> -
> -#if AC97_USE_CACHE
>  	switch (reg) {
>  	case AC97_RESET:
>  	case AC97_INT_PAGING:
> @@ -114,18 +111,30 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
>  	case AC97_EXTENDED_STATUS:
>  	case AC97_VENDOR_ID1:
>  	case AC97_VENDOR_ID2:
> -#endif
> -		ret = soc_ac97_ops.read(codec->ac97, reg);
> -#if AC97_USE_CACHE
> +		return 0;
>  	default:
> -		reg = reg >> 1;
> +		return 1;
> +	}
> +}
> +
> +static unsigned int ac97_read(struct snd_soc_codec *codec,
> +	unsigned int reg)
> +{
> +	int ret;
> +
> +#if AC97_USE_CACHE
> +	if (ac97_reg_cacheable(reg)) {
> +		u16 *cache = codec->reg_cache;
> +
> +		reg >>= 1;
>  
>  		if (reg >= ARRAY_SIZE(ad1980_reg))
>  			ret = -EINVAL;
>  		else
>  			ret = cache[reg];
> -	}
> +	} else
>  #endif
> +		ret = soc_ac97_ops.read(codec->ac97, reg);
>  
>  	pr_debug("%s: reg=0x%02x, val=0x%04x\n", __func__, reg, ret);
>  
> @@ -146,6 +155,16 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
>  		cache[reg] = val;
>  	}
>  #endif
> +
> +#if AC97_VERIFY_WRITE
> +	if (ac97_reg_cacheable(reg)) {
> +		unsigned int valread = soc_ac97_ops.read(codec->ac97, reg);
> +		if (valread != val)
> +			pr_err("%s: reg=0x%02x, val=0x%04x, readback=0x%04x\n",
> +					__func__, reg, val, valread);
> +	}
> +#endif
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
