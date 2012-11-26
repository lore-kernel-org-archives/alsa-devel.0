From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 08/14] ASoC: max9768: Use devm_regmap_init_i2c()
Date: Mon, 26 Nov 2012 17:19:41 +0530
Message-ID: <1353930587-12907-9-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B1B5726514C
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:40 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:40 -0800 (PST)
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
 sound/soc/codecs/max9768.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 17b3ec2..a777de6 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -187,7 +187,7 @@ static int __devinit max9768_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, max9768);
 
-	max9768->regmap = regmap_init_i2c(client, &max9768_i2c_regmap_config);
+	max9768->regmap = devm_regmap_init_i2c(client, &max9768_i2c_regmap_config);
 	if (IS_ERR(max9768->regmap)) {
 		err = PTR_ERR(max9768->regmap);
 		goto err_gpio_free;
@@ -195,12 +195,10 @@ static int __devinit max9768_i2c_probe(struct i2c_client *client,
 
 	err = snd_soc_register_codec(&client->dev, &max9768_codec_driver, NULL, 0);
 	if (err)
-		goto err_regmap_free;
+		goto err_gpio_free;
 
 	return 0;
 
- err_regmap_free:
-	regmap_exit(max9768->regmap);
  err_gpio_free:
 	if (gpio_is_valid(max9768->shdn_gpio))
 		gpio_free(max9768->shdn_gpio);
@@ -215,7 +213,6 @@ static int __devexit max9768_i2c_remove(struct i2c_client *client)
 	struct max9768 *max9768 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(max9768->regmap);
 
 	if (gpio_is_valid(max9768->shdn_gpio))
 		gpio_free(max9768->shdn_gpio);
-- 
1.7.4.1
