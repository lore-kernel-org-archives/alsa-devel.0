From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: max9768: Use managed gpio request
Date: Thu, 16 Jul 2015 21:22:51 +0200
Message-ID: <1437074572-3831-3-git-send-email-lars@metafoo.de>
References: <1437074572-3831-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id F1DC42605BD
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 21:22:58 +0200 (CEST)
In-Reply-To: <1437074572-3831-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit shorter and simpler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max9768.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index f987497..381ff8a 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -183,11 +183,13 @@ static int max9768_i2c_probe(struct i2c_client *client,
 
 	if (pdata) {
 		/* Mute on powerup to avoid clicks */
-		err = gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute");
+		err = devm_gpio_request_one(&client->dev, pdata->mute_gpio,
+				GPIOF_INIT_HIGH, "MAX9768 Mute");
 		max9768->mute_gpio = err ?: pdata->mute_gpio;
 
 		/* Activate chip by releasing shutdown, enables I2C */
-		err = gpio_request_one(pdata->shdn_gpio, GPIOF_INIT_HIGH, "MAX9768 Shutdown");
+		err = devm_gpio_request_one(&client->dev, pdata->shdn_gpio,
+				GPIOF_INIT_HIGH, "MAX9768 Shutdown");
 		max9768->shdn_gpio = err ?: pdata->shdn_gpio;
 
 		max9768->flags = pdata->flags;
@@ -199,37 +201,17 @@ static int max9768_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, max9768);
 
 	max9768->regmap = devm_regmap_init_i2c(client, &max9768_i2c_regmap_config);
-	if (IS_ERR(max9768->regmap)) {
-		err = PTR_ERR(max9768->regmap);
-		goto err_gpio_free;
-	}
-
-	err = snd_soc_register_codec(&client->dev, &max9768_codec_driver, NULL, 0);
-	if (err)
-		goto err_gpio_free;
-
-	return 0;
+	if (IS_ERR(max9768->regmap))
+		return PTR_ERR(max9768->regmap);
 
- err_gpio_free:
-	if (gpio_is_valid(max9768->shdn_gpio))
-		gpio_free(max9768->shdn_gpio);
-	if (gpio_is_valid(max9768->mute_gpio))
-		gpio_free(max9768->mute_gpio);
-
-	return err;
+	return snd_soc_register_codec(&client->dev, &max9768_codec_driver,
+		NULL, 0);
 }
 
 static int max9768_i2c_remove(struct i2c_client *client)
 {
-	struct max9768 *max9768 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
 
-	if (gpio_is_valid(max9768->shdn_gpio))
-		gpio_free(max9768->shdn_gpio);
-	if (gpio_is_valid(max9768->mute_gpio))
-		gpio_free(max9768->mute_gpio);
-
 	return 0;
 }
 
-- 
2.1.4
