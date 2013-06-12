From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 12 Jun 2013 15:47:08 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A8945AF85@rtitmbs7.realtek.com.tw>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>,
 <20130611091212.GW1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AD937261AFC
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 09:47:15 +0200 (CEST)
In-Reply-To: <20130611091212.GW1403@sirena.org.uk>
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

> > +static int rt5640_set_bias_level(struct snd_soc_codec *codec,
> > +                     enum snd_soc_bias_level level)
> > +{
> > +     struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
> > +     switch (level) {
> > +     case SND_SOC_BIAS_STANDBY:
> > +             if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
> > +                     regcache_cache_only(rt5640->regmap, false);
> 
> You mark the device cache only in suspend so for symmetry this should
> really be in _BIAS_OFF, especially since the device is idle_bias_off so
> it'll be able to power off without a full suspend.

Actually, we prefer turn off the codec fully ,ie. set the LDO pin to low, only in suspend.
Because it need 400 ms when we set the LDO pin to high and reset the codec.
So, may I mark the device cache only in suspend and resume? 

>
> > +     if (rt5640->pdata.ldo1_en) {
> > +             ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
> > +                                         GPIOF_OUT_INIT_HIGH,
> > +                                         "RT5640 LDO1_EN");
> > +             if (ret < 0) {
> > +                     dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
> > +                             rt5640->pdata.ldo1_en, ret);
> > +                     return ret;
> > +             }
> > +             msleep(400);
> > +     }
> 
> I'd expect to see some handling fo the LDO over suspend but that can be
> dealt with in a followup as previously discussed.  Ideally we'd be able
> to power off when in _BIAS_OFF too but if it's going to take 400ms to
> ramp the LDO (which does seem high) that might be an issue.

I think I can't set LDO low in _BIAS_OFF bue to the timing issue.
I will handle in suspend.

> 
> ------Please consider the environment before printing this e-mail.
