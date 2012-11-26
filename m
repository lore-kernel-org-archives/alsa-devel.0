From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 05/14] ASoC: ak4535: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:38 +0530
Message-ID: <1353930587-12907-6-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 76058265147
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:31 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so4983511pad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:30 -0800 (PST)
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
 sound/soc/codecs/ak4535.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 618fdc3..fc55810 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -447,7 +447,7 @@ static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 	if (ak4535 == NULL)
 		return -ENOMEM;
 
-	ak4535->regmap = regmap_init_i2c(i2c, &ak4535_regmap);
+	ak4535->regmap = devm_regmap_init_i2c(i2c, &ak4535_regmap);
 	if (IS_ERR(ak4535->regmap)) {
 		ret = PTR_ERR(ak4535->regmap);
 		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
@@ -458,18 +458,13 @@ static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ak4535, &ak4535_dai, 1);
-	if (ret != 0)
-		regmap_exit(ak4535->regmap);
 
 	return ret;
 }
 
 static __devexit int ak4535_i2c_remove(struct i2c_client *client)
 {
-	struct ak4535_priv *ak4535 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(ak4535->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
