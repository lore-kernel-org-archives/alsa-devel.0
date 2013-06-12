From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 12 Jun 2013 15:56:48 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A8945AF86@rtitmbs7.realtek.com.tw>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>,
 <51B7615D.7040408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F30261B1E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 09:56:51 +0200 (CEST)
In-Reply-To: <51B7615D.7040408@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> On 06/10/2013 11:10 PM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > This patch adds the ALC5640 codec driver.
> 
> > diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> 
> > +static int rt5640_i2c_probe(struct i2c_client *i2c,
> 
> > +     rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
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
> Oh I see this is the only place ldo1_en is touched. I had assumed you
> were going to add code to turn it off/on based on bias level. That's why
> I had asked you to add that feature, since you'd know any HW
> requirements for doing that. Still, as Mark mentioned, that can
> certainly be added later.

I think we can't turn on/off ldo1_en based on bias level.
Because it will take too long from _BIAS_OFF to _BIAS_ON.
I think we can do it in suspend/resume function.

> 
> One question though: Don't you want to initially enable ldo1_en before
> you create the regmap? At least some regmap_init() calls end up trying
> to read from the device to populate the register cache, and that won't
> work until ldo1_en is active.
> 

Sure, it is better. Thanks for reminding me.
