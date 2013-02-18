From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/5] ASoC: max98090: Convert to
	devm_regmap_init_i2c()
Date: Mon, 18 Feb 2013 17:02:11 +0530
Message-ID: <1361187134-7525-2-git-send-email-sachin.kamat@linaro.org>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f52.google.com (mail-da0-f52.google.com
 [209.85.210.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5AB264FA2
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 12:42:12 +0100 (CET)
Received: by mail-da0-f52.google.com with SMTP id f10so2437647dak.39
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 03:42:11 -0800 (PST)
In-Reply-To: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

devm_regmap_init_i2c() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/max98090.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 9ea73aa..fef370e 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2322,7 +2322,7 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	max98090->pdata = i2c->dev.platform_data;
 	max98090->irq = i2c->irq;
 
-	max98090->regmap = regmap_init_i2c(i2c, &max98090_regmap);
+	max98090->regmap = devm_regmap_init_i2c(i2c, &max98090_regmap);
 	if (IS_ERR(max98090->regmap)) {
 		ret = PTR_ERR(max98090->regmap);
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
@@ -2332,18 +2332,13 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_max98090, max98090_dai,
 			ARRAY_SIZE(max98090_dai));
-	if (ret < 0)
-		regmap_exit(max98090->regmap);
-
 err_enable:
 	return ret;
 }
 
 static int max98090_i2c_remove(struct i2c_client *client)
 {
-	struct max98090_priv *max98090 = dev_get_drvdata(&client->dev);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(max98090->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
