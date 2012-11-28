From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: wm9090: Use devm_regmap_init_i2c()
Date: Wed, 28 Nov 2012 14:43:52 +0530
Message-ID: <1354094032-1701-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 241F1261570
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 10:20:25 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so6627567pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 01:20:25 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

devm_regmap_init_i2c() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm9090.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index c7ddc56..bb55a70 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -628,7 +628,7 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
-	wm9090->regmap = regmap_init_i2c(i2c, &wm9090_regmap);
+	wm9090->regmap = devm_regmap_init_i2c(i2c, &wm9090_regmap);
 	if (IS_ERR(wm9090->regmap)) {
 		ret = PTR_ERR(wm9090->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
@@ -637,16 +637,16 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 	ret = regmap_read(wm9090->regmap, WM9090_SOFTWARE_RESET, &reg);
 	if (ret < 0)
-		goto err;
+		return ret;
+
 	if (reg != 0x9093) {
 		dev_err(&i2c->dev, "Device is not a WM9090, ID=%x\n", reg);
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	ret = regmap_write(wm9090->regmap, WM9090_SOFTWARE_RESET, 0);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	if (i2c->dev.platform_data)
 		memcpy(&wm9090->pdata, i2c->dev.platform_data,
@@ -658,23 +658,15 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 			&soc_codec_dev_wm9090,  NULL, 0);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	return 0;
-
-err:
-	regmap_exit(wm9090->regmap);
-	return ret;
 }
 
 static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
-	regmap_exit(wm9090->regmap);
-
 	return 0;
 }
 
-- 
1.7.4.1
