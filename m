From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9768: Use managed gpio request" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:01:33 +0100
Message-ID: <E1ZFqHd-0001kV-H1@finisterre>
References: <1437074572-3831-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F35266704
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:41 +0200 (CEST)
In-Reply-To: <1437074572-3831-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9768: Use managed gpio request

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d79cca1a994f6f4f1cf3d92909f2a73df6b84874 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 16 Jul 2015 21:22:51 +0200
Subject: [PATCH] ASoC: max9768: Use managed gpio request

Makes the code a bit shorter and simpler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9768.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 1526aef..d70a820 100644
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
