From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: rt5645: change gpio to gpiod
 APIs
Date: Fri, 29 May 2015 18:31:08 +0200
Message-ID: <5568944C.2060509@metafoo.de>
References: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-030.synserver.de (smtp-out-030.synserver.de
 [212.40.185.30])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D732606E1
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 18:31:16 +0200 (CEST)
In-Reply-To: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Leilk.Liu@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 05/29/2015 12:16 PM, Bard Liao wrote:
> @@ -3253,19 +3247,17 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>   	} else {
>   		if (dmi_check_system(dmi_platform_intel_braswell)) {
>   			rt5645->pdata = *rt5645_pdata;
> -			gpiod = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);
> -
> -			if (IS_ERR(gpiod) || gpiod_direction_input(gpiod)) {
> -				rt5645->pdata.hp_det_gpio = -1;
> -				dev_err(&i2c->dev, "failed to initialize gpiod\n");
> -			} else {
> -				rt5645->pdata.hp_det_gpio = desc_to_gpio(gpiod);
> -				rt5645->pdata.gpio_hp_det_active_high
> -						= !gpiod_is_active_low(gpiod);
> -			}
>   		}
>   	}
>
> +	rt5645->gpiod_hp_det = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);

Three things, don't use the _index API if there is only a single gpio for 
the property, either don't use a name at all or use a descriptive name 
something like "hp-detect" and use the new version of the API which has the 
flags parameter.

So this should be: devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);

and then drop the gpiod_direction_input()...
