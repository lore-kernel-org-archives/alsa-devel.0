From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Convert to
	devm_regulator_bulk_get()
Date: Thu, 26 Jan 2012 18:38:22 +0000
Message-ID: <1327603102-9262-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D580F103846
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 19:38:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index c1c8bdb..39de946 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2504,8 +2504,9 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(wm5100->core_supplies); i++)
 		wm5100->core_supplies[i].supply = wm5100_core_supply_names[i];
 
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm5100->core_supplies),
-				 wm5100->core_supplies);
+	ret = devm_regulator_bulk_get(&i2c->dev,
+				      ARRAY_SIZE(wm5100->core_supplies),
+				      wm5100->core_supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request core supplies: %d\n",
 			ret);
@@ -2517,7 +2518,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable core supplies: %d\n",
 			ret);
-		goto err_core;
+		goto err_regmap;
 	}
 
 	if (wm5100->pdata.ldo_ena) {
@@ -2686,9 +2687,6 @@ err_ldo:
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
 			       wm5100->core_supplies);
-err_core:
-	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
-			    wm5100->core_supplies);
 err_regmap:
 	regmap_exit(wm5100->regmap);
 err:
@@ -2711,8 +2709,6 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *i2c)
 		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
 		gpio_free(wm5100->pdata.ldo_ena);
 	}
-	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
-			    wm5100->core_supplies);
 	regmap_exit(wm5100->regmap);
 
 	return 0;
-- 
1.7.9.rc1
