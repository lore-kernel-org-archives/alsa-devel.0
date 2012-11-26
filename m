From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 11/14] ASoC: wm8962: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:44 +0530
Message-ID: <1353930587-12907-12-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E7126515C
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:50 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4983511pad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:50 -0800 (PST)
In-Reply-To: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_regmap_init_i2c() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8962.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 285a9ef..8fd38cb 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3624,7 +3624,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	wm8962->regmap = regmap_init_i2c(i2c, &wm8962_regmap);
+	wm8962->regmap = devm_regmap_init_i2c(i2c, &wm8962_regmap);
 	if (IS_ERR(wm8962->regmap)) {
 		ret = PTR_ERR(wm8962->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
@@ -3641,20 +3641,20 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	ret = regmap_read(wm8962->regmap, WM8962_SOFTWARE_RESET, &reg);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read ID register\n");
-		goto err_regmap;
+		goto err_enable;
 	}
 	if (reg != 0x6243) {
 		dev_err(&i2c->dev,
 			"Device is not a WM8962, ID %x != 0x6243\n", reg);
 		ret = -EINVAL;
-		goto err_regmap;
+		goto err_enable;
 	}
 
 	ret = regmap_read(wm8962->regmap, WM8962_RIGHT_INPUT_VOLUME, &reg);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read device revision: %d\n",
 			ret);
-		goto err_regmap;
+		goto err_enable;
 	}
 
 	dev_info(&i2c->dev, "customer id %x revision %c\n",
@@ -3667,7 +3667,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	ret = wm8962_reset(wm8962);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to issue reset\n");
-		goto err_regmap;
+		goto err_enable;
 	}
 
 	if (pdata && pdata->in4_dc_measure) {
@@ -3686,15 +3686,13 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
 	if (ret < 0)
-		goto err_regmap;
+		goto err_enable;
 
 	/* The drivers should power up as needed */
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 
 	return 0;
 
-err_regmap:
-	regmap_exit(wm8962->regmap);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 err:
@@ -3703,10 +3701,7 @@ err:
 
 static __devexit int wm8962_i2c_remove(struct i2c_client *client)
 {
-	struct wm8962_priv *wm8962 = dev_get_drvdata(&client->dev);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8962->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
