From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 07/14] ASoC: lm49453: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:40 +0530
Message-ID: <1353930587-12907-8-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4B92650F3
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:37 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so5190394pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:37 -0800 (PST)
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
 sound/soc/codecs/lm49453.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 99b0a9d..096b6aa 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1497,7 +1497,7 @@ static __devinit int lm49453_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, lm49453);
 
-	lm49453->regmap = regmap_init_i2c(i2c, &lm49453_regmap_config);
+	lm49453->regmap = devm_regmap_init_i2c(i2c, &lm49453_regmap_config);
 	if (IS_ERR(lm49453->regmap)) {
 		ret = PTR_ERR(lm49453->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -1508,21 +1508,15 @@ static __devinit int lm49453_i2c_probe(struct i2c_client *i2c,
 	ret =  snd_soc_register_codec(&i2c->dev,
 				      &soc_codec_dev_lm49453,
 				      lm49453_dai, ARRAY_SIZE(lm49453_dai));
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
-		regmap_exit(lm49453->regmap);
-		return ret;
-	}
 
 	return ret;
 }
 
 static int __devexit lm49453_i2c_remove(struct i2c_client *client)
 {
-	struct lm49453_priv *lm49453 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(lm49453->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
