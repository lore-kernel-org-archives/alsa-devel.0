From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 09/14] ASoC: wm8955: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:42 +0530
Message-ID: <1353930587-12907-10-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DDA226514E
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:43 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:43 -0800 (PST)
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
 sound/soc/codecs/wm8955.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 2f1c075..7a82b7d 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1023,7 +1023,7 @@ static __devinit int wm8955_i2c_probe(struct i2c_client *i2c,
 	if (wm8955 == NULL)
 		return -ENOMEM;
 
-	wm8955->regmap = regmap_init_i2c(i2c, &wm8955_regmap);
+	wm8955->regmap = devm_regmap_init_i2c(i2c, &wm8955_regmap);
 	if (IS_ERR(wm8955->regmap)) {
 		ret = PTR_ERR(wm8955->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -1035,22 +1035,13 @@ static __devinit int wm8955_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8955, &wm8955_dai, 1);
-	if (ret != 0)
-		goto err;
 
 	return ret;
-
-err:
-	regmap_exit(wm8955->regmap);
-	return ret;
 }
 
 static __devexit int wm8955_i2c_remove(struct i2c_client *client)
 {
-	struct wm8955_priv *wm8955 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8955->regmap);
 
 	return 0;
 }
-- 
1.7.4.1
