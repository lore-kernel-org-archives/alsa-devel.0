From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 11 Jun 2013 11:41:49 -0600
Message-ID: <51B7615D.7040408@wwwdotorg.org>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 49BED261A9E
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 19:41:53 +0200 (CEST)
In-Reply-To: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/10/2013 11:10 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> This patch adds the ALC5640 codec driver.

> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c

> +static int rt5640_i2c_probe(struct i2c_client *i2c,

> +	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);

> +	if (rt5640->pdata.ldo1_en) {
> +		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
> +					    GPIOF_OUT_INIT_HIGH,
> +					    "RT5640 LDO1_EN");
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
> +				rt5640->pdata.ldo1_en, ret);
> +			return ret;
> +		}
> +		msleep(400);
> +	}

Oh I see this is the only place ldo1_en is touched. I had assumed you
were going to add code to turn it off/on based on bias level. That's why
I had asked you to add that feature, since you'd know any HW
requirements for doing that. Still, as Mark mentioned, that can
certainly be added later.

One question though: Don't you want to initially enable ldo1_en before
you create the regmap? At least some regmap_init() calls end up trying
to read from the device to populate the register cache, and that won't
work until ldo1_en is active.

Anyway, I'll go test this again, and work on the patch to pull the
platform data from DT.
