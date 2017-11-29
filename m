From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 14/19] ASoC: tlv320aic31xx: Remove regulator notification handling
Date: Wed, 29 Nov 2017 15:32:55 -0600
Message-ID: <20171129213300.20021-15-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

A regulator being forcefully disabled is a catastrophic event that
should never happen to most devices, especially not sound CODECs.
In addition, our handler sets the reset line but never disables it
as no one is listening for an enable event, this is certainly broken
and was mosy likely just copied from other CODECs, lets just remove
this code.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index f7b1ec96d826..b51c2777e8d1 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -161,7 +161,6 @@ struct aic31xx_priv {
 	struct gpio_desc *gpio_reset;
 	int micbias_vg;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
-	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1032,28 +1031,6 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int aic31xx_regulator_event(struct notifier_block *nb,
-				   unsigned long event, void *data)
-{
-	struct aic31xx_disable_nb *disable_nb =
-		container_of(nb, struct aic31xx_disable_nb, nb);
-	struct aic31xx_priv *aic31xx = disable_nb->aic31xx;
-
-	if (event & REGULATOR_EVENT_DISABLE) {
-		/*
-		 * Put codec to reset and as at least one of the
-		 * supplies was disabled.
-		 */
-		if (aic31xx->gpio_reset)
-			gpiod_set_value(aic31xx->gpio_reset, 1);
-
-		regcache_mark_dirty(aic31xx->regmap);
-		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
-	}
-
-	return 0;
-}
-
 static void aic31xx_clk_on(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
@@ -1167,20 +1144,6 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 
 	aic31xx->codec = codec;
 
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
-		aic31xx->disable_nb[i].nb.notifier_call =
-			aic31xx_regulator_event;
-		aic31xx->disable_nb[i].aic31xx = aic31xx;
-		ret = regulator_register_notifier(aic31xx->supplies[i].consumer,
-						  &aic31xx->disable_nb[i].nb);
-		if (ret) {
-			dev_err(codec->dev,
-				"Failed to request regulator notifier: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	regcache_cache_only(aic31xx->regmap, true);
 	regcache_mark_dirty(aic31xx->regmap);
 
@@ -1195,21 +1158,8 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int aic31xx_codec_remove(struct snd_soc_codec *codec)
-{
-	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-		regulator_unregister_notifier(aic31xx->supplies[i].consumer,
-					      &aic31xx->disable_nb[i].nb);
-
-	return 0;
-}
-
 static const struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
-	.remove			= aic31xx_codec_remove,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.suspend_bias_off	= true,
 
-- 
2.15.0
