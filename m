From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 14/14] ASoC: wm9081: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:47 +0530
Message-ID: <1353930587-12907-15-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E98F4265122
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:57:00 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so5190394pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:57:00 -0800 (PST)
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
 sound/soc/codecs/wm9081.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 2de74e1..860144e 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1341,28 +1341,27 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm9081);
 
-	wm9081->regmap = regmap_init_i2c(i2c, &wm9081_regmap);
+	wm9081->regmap = devm_regmap_init_i2c(i2c, &wm9081_regmap);
 	if (IS_ERR(wm9081->regmap)) {
 		ret = PTR_ERR(wm9081->regmap);
 		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regmap_read(wm9081->regmap, WM9081_SOFTWARE_RESET, &reg);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
-		goto err_regmap;
+		return ret;
 	}
 	if (reg != 0x9081) {
 		dev_err(&i2c->dev, "Device is not a WM9081: ID=0x%x\n", reg);
-		ret = -EINVAL;
-		goto err_regmap;
+		return -EINVAL;
 	}
 
 	ret = wm9081_reset(wm9081->regmap);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to issue reset\n");
-		goto err_regmap;
+		return ret;
 	}
 
 	if (dev_get_platdata(&i2c->dev))
@@ -1382,23 +1381,14 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9081, &wm9081_dai, 1);
 	if (ret < 0)
-		goto err_regmap;
+		return ret;
 
 	return 0;
-
-err_regmap:
-	regmap_exit(wm9081->regmap);
-err:
-
-	return ret;
 }
 
 static __devexit int wm9081_i2c_remove(struct i2c_client *client)
 {
-	struct wm9081_priv *wm9081 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm9081->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
