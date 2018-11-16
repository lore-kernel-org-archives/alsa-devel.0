From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: rt5663: Fix error handling of regulator_set_load
Date: Fri, 16 Nov 2018 17:28:56 +0800
Message-ID: <20181116092856.47815-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

The default implementation of regulator_set_load returns
REGULATOR_MODE_NORMAL, which is positive.

rt5663_i2c_probe should only do error handling when return value of
regulator_set_load is negative.
In this case, rt5663_i2c_probe should return error.

Also, consolidate err_irq into err_enable.

Fix the missing goto for temporary regmap and rt5663->regmap.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 This patch is the fixup of the patch
 e81a2a6d12e85 ASoC: rt5663: Add regulator support
 sound/soc/codecs/rt5663.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index bb2c1ee4a836f..473a54d1ae2c5 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3522,10 +3522,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
 		ret = regulator_set_load(rt5663->supplies[i].consumer,
 					 RT5663_SUPPLY_CURRENT_UA);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(&i2c->dev,
-				"Failed to set regulator %s, ret: %d\n",
+				"Failed to set regulator load on %s, ret: %d\n",
 				rt5663->supplies[i].supply, ret);
+			return ret;
 		}
 	}
 
@@ -3543,7 +3544,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
@@ -3576,7 +3577,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(rt5663->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	/* reset and calibrate */
@@ -3686,17 +3687,19 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
 	if (ret)
-		goto err_irq;
+		goto err_enable;
 
 	return 0;
 
-err_irq:
+
+	/*
+	 * Error after enabling regulators should goto err_enable
+	 * to disable regulators.
+	 */
+err_enable:
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
-err_enable:
-	dev_err(&i2c->dev,
-		"%s: Disable regulator after probe error\n", __func__);
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
-- 
2.19.1.1215.g8438c0b245-goog
