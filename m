From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 08/19] ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API
Date: Wed, 29 Nov 2017 15:32:49 -0600
Message-ID: <20171129213300.20021-9-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129213300.20021-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Move to using newer gpiod_* GPIO handling functions. This simplifies
the code and eases dropping platform data in the next patch. Also
remember GPIO are active low, so set "1" to reset.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c84febd991a0..ab03a19f6aaa 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -157,6 +157,7 @@ struct aic31xx_priv {
 	u8 i2c_regs_status;
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *gpio_reset;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
@@ -1020,8 +1021,8 @@ static int aic31xx_regulator_event(struct notifier_block *nb,
 		 * Put codec to reset and as at least one of the
 		 * supplies was disabled.
 		 */
-		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
-			gpio_set_value(aic31xx->pdata.gpio_reset, 0);
+		if (aic31xx->gpio_reset)
+			gpiod_set_value(aic31xx->gpio_reset, 1);
 
 		regcache_mark_dirty(aic31xx->regmap);
 		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
@@ -1073,8 +1074,8 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	if (gpio_is_valid(aic31xx->pdata.gpio_reset)) {
-		gpio_set_value(aic31xx->pdata.gpio_reset, 1);
+	if (aic31xx->gpio_reset) {
+		gpiod_set_value(aic31xx->gpio_reset, 0);
 		udelay(100);
 	}
 	regcache_cache_only(aic31xx->regmap, false);
@@ -1334,15 +1335,11 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	else if (aic31xx->dev->of_node)
 		aic31xx_pdata_from_of(aic31xx);
 
-	if (aic31xx->pdata.gpio_reset) {
-		ret = devm_gpio_request_one(aic31xx->dev,
-					    aic31xx->pdata.gpio_reset,
-					    GPIOF_OUT_INIT_HIGH,
-					    "aic31xx-reset-pin");
-		if (ret < 0) {
-			dev_err(aic31xx->dev, "not able to acquire gpio\n");
-			return ret;
-		}
+	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(aic31xx->gpio_reset)) {
+		dev_err(aic31xx->dev, "not able to acquire gpio\n");
+		return PTR_ERR(aic31xx->gpio_reset);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
