From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Remove regulator
	notification handling
Date: Fri, 31 Aug 2018 13:17:37 -0500
Message-ID: <20180831181737.29516-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 013F826766C
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 20:17:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The notification handler sets the reset line but never re-enables it
as no one is listening for an enable event, this is certainly broken
and was most likely just copied from other CODECs, remove this code.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 +-------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7d87df518fed..f8d0f3ebed9c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -147,11 +147,6 @@ static const char * const aic31xx_supply_names[] = {
 
 #define AIC31XX_NUM_SUPPLIES ARRAY_SIZE(aic31xx_supply_names)
 
-struct aic31xx_disable_nb {
-	struct notifier_block nb;
-	struct aic31xx_priv *aic31xx;
-};
-
 struct aic31xx_priv {
 	struct snd_soc_component *component;
 	u8 i2c_regs_status;
@@ -162,7 +157,6 @@ struct aic31xx_priv {
 	int micbias_vg;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
-	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1116,28 +1110,6 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
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
 static int aic31xx_reset(struct aic31xx_priv *aic31xx)
 {
 	int ret = 0;
@@ -1263,26 +1235,12 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 static int aic31xx_codec_probe(struct snd_soc_component *component)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
-	int i, ret;
+	int ret;
 
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
 
 	aic31xx->component = component;
 
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
-		aic31xx->disable_nb[i].nb.notifier_call =
-			aic31xx_regulator_event;
-		aic31xx->disable_nb[i].aic31xx = aic31xx;
-		ret = regulator_register_notifier(aic31xx->supplies[i].consumer,
-						  &aic31xx->disable_nb[i].nb);
-		if (ret) {
-			dev_err(component->dev,
-				"Failed to request regulator notifier: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	regcache_cache_only(aic31xx->regmap, true);
 	regcache_mark_dirty(aic31xx->regmap);
 
@@ -1297,19 +1255,8 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static void aic31xx_codec_remove(struct snd_soc_component *component)
-{
-	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-		regulator_unregister_notifier(aic31xx->supplies[i].consumer,
-					      &aic31xx->disable_nb[i].nb);
-}
-
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
-	.remove			= aic31xx_codec_remove,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.controls		= common31xx_snd_controls,
 	.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
-- 
2.18.0
