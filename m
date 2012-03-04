From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: ak4641: Push GPIO allocation out
	into the I2C probe
Date: Sun,  4 Mar 2012 21:31:06 +0000
Message-ID: <1330896666-21877-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1330896666-21877-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47B2D24376
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 22:31:16 +0100 (CET)
In-Reply-To: <1330896666-21877-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Welte <laforge@gnumonks.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's more idiomatic to do this and it means we don't try to bring up the
card if the CODEC didn't manage to bind successfully.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4641.c |   92 +++++++++++++++++++++++---------------------
 1 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 611e8f0..7f42d4a 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -517,67 +517,24 @@ static int ak4641_resume(struct snd_soc_codec *codec)
 
 static int ak4641_probe(struct snd_soc_codec *codec)
 {
-	struct ak4641_platform_data *pdata = codec->dev->platform_data;
 	int ret;
 
-
-	if (pdata) {
-		if (gpio_is_valid(pdata->gpio_power)) {
-			ret = gpio_request_one(pdata->gpio_power,
-					GPIOF_OUT_INIT_LOW, "ak4641 power");
-			if (ret)
-				goto err_out;
-		}
-		if (gpio_is_valid(pdata->gpio_npdn)) {
-			ret = gpio_request_one(pdata->gpio_npdn,
-					GPIOF_OUT_INIT_LOW, "ak4641 npdn");
-			if (ret)
-				goto err_gpio;
-
-			udelay(1); /* > 150 ns */
-			gpio_set_value(pdata->gpio_npdn, 1);
-		}
-	}
-
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err_register;
+		return ret;
 	}
 
 	/* power on device */
 	ak4641_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-
-err_register:
-	if (pdata) {
-		if (gpio_is_valid(pdata->gpio_power))
-			gpio_set_value(pdata->gpio_power, 0);
-		if (gpio_is_valid(pdata->gpio_npdn))
-			gpio_free(pdata->gpio_npdn);
-	}
-err_gpio:
-	if (pdata && gpio_is_valid(pdata->gpio_power))
-		gpio_free(pdata->gpio_power);
-err_out:
-	return ret;
 }
 
 static int ak4641_remove(struct snd_soc_codec *codec)
 {
-	struct ak4641_platform_data *pdata = codec->dev->platform_data;
-
 	ak4641_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (pdata) {
-		if (gpio_is_valid(pdata->gpio_power)) {
-			gpio_set_value(pdata->gpio_power, 0);
-			gpio_free(pdata->gpio_power);
-		}
-		if (gpio_is_valid(pdata->gpio_npdn))
-			gpio_free(pdata->gpio_npdn);
-	}
 	return 0;
 }
 
@@ -604,6 +561,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
 static int __devinit ak4641_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
+	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
 	struct ak4641_priv *ak4641;
 	int ret;
 
@@ -612,16 +570,62 @@ static int __devinit ak4641_i2c_probe(struct i2c_client *i2c,
 	if (!ak4641)
 		return -ENOMEM;
 
+	if (pdata) {
+		if (gpio_is_valid(pdata->gpio_power)) {
+			ret = gpio_request_one(pdata->gpio_power,
+					GPIOF_OUT_INIT_LOW, "ak4641 power");
+			if (ret)
+				goto err_out;
+		}
+		if (gpio_is_valid(pdata->gpio_npdn)) {
+			ret = gpio_request_one(pdata->gpio_npdn,
+					GPIOF_OUT_INIT_LOW, "ak4641 npdn");
+			if (ret)
+				goto err_gpio;
+
+			udelay(1); /* > 150 ns */
+			gpio_set_value(pdata->gpio_npdn, 1);
+		}
+	}
+
 	i2c_set_clientdata(i2c, ak4641);
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_ak4641,
 				ak4641_dai, ARRAY_SIZE(ak4641_dai));
+	if (ret != 0)
+		goto err_gpio2;
+
+	return 0;
+
+err_gpio2:
+	if (pdata) {
+		if (gpio_is_valid(pdata->gpio_power))
+			gpio_set_value(pdata->gpio_power, 0);
+		if (gpio_is_valid(pdata->gpio_npdn))
+			gpio_free(pdata->gpio_npdn);
+	}
+err_gpio:
+	if (pdata && gpio_is_valid(pdata->gpio_power))
+		gpio_free(pdata->gpio_power);
+err_out:
 	return ret;
 }
 
 static int __devexit ak4641_i2c_remove(struct i2c_client *i2c)
 {
+	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
+
 	snd_soc_unregister_codec(&i2c->dev);
+
+	if (pdata) {
+		if (gpio_is_valid(pdata->gpio_power)) {
+			gpio_set_value(pdata->gpio_power, 0);
+			gpio_free(pdata->gpio_power);
+		}
+		if (gpio_is_valid(pdata->gpio_npdn))
+			gpio_free(pdata->gpio_npdn);
+	}
+
 	return 0;
 }
 
-- 
1.7.9.1
