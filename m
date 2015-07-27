From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tas2552: Remove unneeded NULL test
	for tas2552->enable_gpio
Date: Mon, 27 Jul 2015 08:19:37 -0500
Message-ID: <55B62FE9.7020501@ti.com>
References: <1437809536.5851.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9433626085B
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 15:19:39 +0200 (CEST)
In-Reply-To: <1437809536.5851.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 07/25/2015 02:32 AM, Axel Lin wrote:
> It's safe to call gpiod_set_value() with NULL desc.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/tas2552.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
> index 2f6a65a..e3a0bca 100644
> --- a/sound/soc/codecs/tas2552.c
> +++ b/sound/soc/codecs/tas2552.c
> @@ -493,8 +493,7 @@ static int tas2552_runtime_suspend(struct device *dev)
>  	regcache_cache_only(tas2552->regmap, true);
>  	regcache_mark_dirty(tas2552->regmap);
>  
> -	if (tas2552->enable_gpio)
> -		gpiod_set_value(tas2552->enable_gpio, 0);
> +	gpiod_set_value(tas2552->enable_gpio, 0);
>  
>  	return 0;
>  }
> @@ -503,8 +502,7 @@ static int tas2552_runtime_resume(struct device *dev)
>  {
>  	struct tas2552_data *tas2552 = dev_get_drvdata(dev);
>  
> -	if (tas2552->enable_gpio)
> -		gpiod_set_value(tas2552->enable_gpio, 1);
> +	gpiod_set_value(tas2552->enable_gpio, 1);
>  
>  	tas2552_sw_shutdown(tas2552, 0);
>  
> @@ -585,8 +583,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
>  		return ret;
>  	}
>  
> -	if (tas2552->enable_gpio)
> -		gpiod_set_value(tas2552->enable_gpio, 1);
> +	gpiod_set_value(tas2552->enable_gpio, 1);
>  
>  	ret = pm_runtime_get_sync(codec->dev);
>  	if (ret < 0) {
> @@ -610,8 +607,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
>  	return 0;
>  
>  probe_fail:
> -	if (tas2552->enable_gpio)
> -		gpiod_set_value(tas2552->enable_gpio, 0);
> +	gpiod_set_value(tas2552->enable_gpio, 0);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(tas2552->supplies),
>  					tas2552->supplies);
> @@ -624,8 +620,7 @@ static int tas2552_codec_remove(struct snd_soc_codec *codec)
>  
>  	pm_runtime_put(codec->dev);
>  
> -	if (tas2552->enable_gpio)
> -		gpiod_set_value(tas2552->enable_gpio, 0);
> +	gpiod_set_value(tas2552->enable_gpio, 0);
>  
>  	return 0;
>  };

Acked-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
