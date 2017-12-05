From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 08/19] ASoC: tlv320aic31xx: Switch GPIO
 handling to use gpiod_* API
Date: Tue, 5 Dec 2017 15:23:49 -0600
Message-ID: <17fcc926-9ee8-1229-ea3d-f38347cb9a23@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-9-afd@ti.com>
 <537c8d62-de11-15e8-11bc-08e8334d4322@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 5335F267800
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 22:24:11 +0100 (CET)
In-Reply-To: <537c8d62-de11-15e8-11bc-08e8334d4322@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/04/2017 10:47 AM, Andrew F. Davis wrote:
> On 11/29/2017 03:32 PM, Andrew F. Davis wrote:
>> Move to using newer gpiod_* GPIO handling functions. This simplifies
>> the code and eases dropping platform data in the next patch. Also
>> remember GPIO are active low, so set "1" to reset.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
> 
> 
> Kbuild bot seems mad a this one, looks like I need to include
> linux/gpio/consumer.h, will fix for v3.
> 

Looks like you already have this in your -next branch, how do you want
this fix, I can send a delta patch with the added include, a new v3
version that you can replace the patch in-tree with, or if it's easier
for you manually fix in-tree?

> 
>>  sound/soc/codecs/tlv320aic31xx.c | 23 ++++++++++-------------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
>> index c84febd991a0..ab03a19f6aaa 100644
>> --- a/sound/soc/codecs/tlv320aic31xx.c
>> +++ b/sound/soc/codecs/tlv320aic31xx.c
>> @@ -157,6 +157,7 @@ struct aic31xx_priv {
>>  	u8 i2c_regs_status;
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	struct gpio_desc *gpio_reset;
>>  	struct aic31xx_pdata pdata;
>>  	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
>>  	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
>> @@ -1020,8 +1021,8 @@ static int aic31xx_regulator_event(struct notifier_block *nb,
>>  		 * Put codec to reset and as at least one of the
>>  		 * supplies was disabled.
>>  		 */
>> -		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
>> -			gpio_set_value(aic31xx->pdata.gpio_reset, 0);
>> +		if (aic31xx->gpio_reset)
>> +			gpiod_set_value(aic31xx->gpio_reset, 1);
>>  
>>  		regcache_mark_dirty(aic31xx->regmap);
>>  		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
>> @@ -1073,8 +1074,8 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (gpio_is_valid(aic31xx->pdata.gpio_reset)) {
>> -		gpio_set_value(aic31xx->pdata.gpio_reset, 1);
>> +	if (aic31xx->gpio_reset) {
>> +		gpiod_set_value(aic31xx->gpio_reset, 0);
>>  		udelay(100);
>>  	}
>>  	regcache_cache_only(aic31xx->regmap, false);
>> @@ -1334,15 +1335,11 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
>>  	else if (aic31xx->dev->of_node)
>>  		aic31xx_pdata_from_of(aic31xx);
>>  
>> -	if (aic31xx->pdata.gpio_reset) {
>> -		ret = devm_gpio_request_one(aic31xx->dev,
>> -					    aic31xx->pdata.gpio_reset,
>> -					    GPIOF_OUT_INIT_HIGH,
>> -					    "aic31xx-reset-pin");
>> -		if (ret < 0) {
>> -			dev_err(aic31xx->dev, "not able to acquire gpio\n");
>> -			return ret;
>> -		}
>> +	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
>> +						      GPIOD_OUT_LOW);
>> +	if (IS_ERR(aic31xx->gpio_reset)) {
>> +		dev_err(aic31xx->dev, "not able to acquire gpio\n");
>> +		return PTR_ERR(aic31xx->gpio_reset);
>>  	}
>>  
>>  	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
>>
