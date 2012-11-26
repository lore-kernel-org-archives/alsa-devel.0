From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 12/14] ASoC: wm8978: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:45 +0530
Message-ID: <1353930587-12907-13-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B754265162
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:54 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4983511pad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:54 -0800 (PST)
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
 sound/soc/codecs/wm8978.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8c1dac9..ef46700 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1046,7 +1046,7 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 	if (wm8978 == NULL)
 		return -ENOMEM;
 
-	wm8978->regmap = regmap_init_i2c(i2c, &wm8978_regmap_config);
+	wm8978->regmap = devm_regmap_init_i2c(i2c, &wm8978_regmap_config);
 	if (IS_ERR(wm8978->regmap)) {
 		ret = PTR_ERR(wm8978->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
@@ -1059,29 +1059,22 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 	ret = regmap_write(wm8978->regmap, WM8978_RESET, 0);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8978, &wm8978_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	return 0;
-
-err:
-	regmap_exit(wm8978->regmap);
-	return ret;
 }
 
 static __devexit int wm8978_i2c_remove(struct i2c_client *client)
 {
-	struct wm8978_priv *wm8978 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8978->regmap);
 
 	return 0;
 }
-- 
1.7.4.1
