From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 06/14] ASoC: da7210: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:39 +0530
Message-ID: <1353930587-12907-7-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F8D265149
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:33 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4983511pad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:33 -0800 (PST)
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
 sound/soc/codecs/da7210.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index af5db70..ab1ee5b 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1231,7 +1231,7 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, da7210);
 
-	da7210->regmap = regmap_init_i2c(i2c, &da7210_regmap_config_i2c);
+	da7210->regmap = devm_regmap_init_i2c(i2c, &da7210_regmap_config_i2c);
 	if (IS_ERR(da7210->regmap)) {
 		ret = PTR_ERR(da7210->regmap);
 		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
@@ -1245,24 +1245,15 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_da7210, &da7210_dai, 1);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
-		goto err_regmap;
-	}
-	return ret;
-
-err_regmap:
-	regmap_exit(da7210->regmap);
 
 	return ret;
 }
 
 static int __devexit da7210_i2c_remove(struct i2c_client *client)
 {
-	struct da7210_priv *da7210 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(da7210->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
