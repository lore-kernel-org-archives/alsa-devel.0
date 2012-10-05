From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: wm2200: Convert to devm APIs
Date: Fri,  5 Oct 2012 19:55:30 +0100
Message-ID: <1349463336-10871-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF9E32650CA
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 20:55:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c |   39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index eab64a1..6ca9bcc 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2011,7 +2011,7 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	wm2200->dev = &i2c->dev;
 	init_completion(&wm2200->fll_lock);
 
-	wm2200->regmap = regmap_init_i2c(i2c, &wm2200_regmap);
+	wm2200->regmap = devm_regmap_init_i2c(i2c, &wm2200_regmap);
 	if (IS_ERR(wm2200->regmap)) {
 		ret = PTR_ERR(wm2200->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -2027,8 +2027,9 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(wm2200->core_supplies); i++)
 		wm2200->core_supplies[i].supply = wm2200_core_supply_names[i];
 
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm2200->core_supplies),
-				 wm2200->core_supplies);
+	ret = devm_regulator_bulk_get(&i2c->dev,
+				      ARRAY_SIZE(wm2200->core_supplies),
+				      wm2200->core_supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request core supplies: %d\n",
 			ret);
@@ -2044,8 +2045,9 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (wm2200->pdata.ldo_ena) {
-		ret = gpio_request_one(wm2200->pdata.ldo_ena,
-				       GPIOF_OUT_INIT_HIGH, "WM2200 LDOENA");
+		ret = devm_gpio_request_one(&i2c->dev, wm2200->pdata.ldo_ena,
+					    GPIOF_OUT_INIT_HIGH,
+					    "WM2200 LDOENA");
 		if (ret < 0) {
 			dev_err(&i2c->dev, "Failed to request LDOENA %d: %d\n",
 				wm2200->pdata.ldo_ena, ret);
@@ -2055,8 +2057,9 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (wm2200->pdata.reset) {
-		ret = gpio_request_one(wm2200->pdata.reset,
-				       GPIOF_OUT_INIT_HIGH, "WM2200 /RESET");
+		ret = devm_gpio_request_one(&i2c->dev, wm2200->pdata.reset,
+					    GPIOF_OUT_INIT_HIGH,
+					    "WM2200 /RESET");
 		if (ret < 0) {
 			dev_err(&i2c->dev, "Failed to request /RESET %d: %d\n",
 				wm2200->pdata.reset, ret);
@@ -2166,23 +2169,16 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 err_pm_runtime:
 	pm_runtime_disable(&i2c->dev);
 err_reset:
-	if (wm2200->pdata.reset) {
+	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
-		gpio_free(wm2200->pdata.reset);
-	}
 err_ldo:
-	if (wm2200->pdata.ldo_ena) {
+	if (wm2200->pdata.ldo_ena)
 		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
-		gpio_free(wm2200->pdata.ldo_ena);
-	}
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
 			       wm2200->core_supplies);
 err_core:
-	regulator_bulk_free(ARRAY_SIZE(wm2200->core_supplies),
-			    wm2200->core_supplies);
 err_regmap:
-	regmap_exit(wm2200->regmap);
 err:
 	return ret;
 }
@@ -2194,17 +2190,10 @@ static __devexit int wm2200_i2c_remove(struct i2c_client *i2c)
 	snd_soc_unregister_codec(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm2200);
-	if (wm2200->pdata.reset) {
+	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
-		gpio_free(wm2200->pdata.reset);
-	}
-	if (wm2200->pdata.ldo_ena) {
+	if (wm2200->pdata.ldo_ena)
 		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
-		gpio_free(wm2200->pdata.ldo_ena);
-	}
-	regulator_bulk_free(ARRAY_SIZE(wm2200->core_supplies),
-			    wm2200->core_supplies);
-	regmap_exit(wm2200->regmap);
 
 	return 0;
 }
-- 
1.7.10.4
