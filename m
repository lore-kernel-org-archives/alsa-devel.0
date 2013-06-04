From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 4 Jun 2013 14:39:36 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A89699532@rtitmbs7.realtek.com.tw>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
 <20130603153542.GM31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4746A2655E0
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 08:39:42 +0200 (CEST)
In-Reply-To: <20130603153542.GM31367@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, June 03, 2013 11:36 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> swarren@nvidia.com; swarren@wwwdotorg.org
> Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
> > +	case SND_SOC_BIAS_STANDBY:
> > +		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
> > +			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
> > +				RT5640_PWR_VREF1 | RT5640_PWR_MB |
> > +				RT5640_PWR_BG | RT5640_PWR_VREF2,
> > +				RT5640_PWR_VREF1 | RT5640_PWR_MB |
> > +				RT5640_PWR_BG | RT5640_PWR_VREF2);
> > +			mdelay(10);
> > +			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
> > +				RT5640_PWR_FV1 | RT5640_PWR_FV2,
> > +				RT5640_PWR_FV1 | RT5640_PWR_FV2);
> > +			regcache_cache_only(rt5640->regmap, false);
> > +			regcache_sync(rt5640->regmap);
> 
> This looks wrong - you're writing to the device before you take it out of cache
> only mode so your delay in the above sequence will have no effect.

Actually, I don't know if I need to call "regcache_cache_only(rt5640->regmap, false);" here.
We never call "regcache_cache_only(rt5640->regmap, true);" in the codec driver.
I assume the cache_only flag is default false.
If yes, I think I can remove "regcache_cache_only(rt5640->regmap, false);" from the code driver.
If not, I will move it to the beginning of if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) condition.


> ------Please consider the environment before printing this e-mail.
