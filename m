From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: uda1380: Request GPIOs at bus probe
	time
Date: Wed, 23 Nov 2016 10:30:11 +0100
Message-ID: <1479893411-32011-2-git-send-email-lars@metafoo.de>
References: <1479893411-32011-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2E5266C4B
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 10:30:21 +0100 (CET)
In-Reply-To: <1479893411-32011-1-git-send-email-lars@metafoo.de>
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

Resources should be requested when the device is probed on the control bus
rather then when the CODEC is bound to the sound card. This allows things
like probe deferring and device managed allocations to work.

So move the GPIO request calls from the CODEC probe to the bus probe and
also make them managed along the way.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda1380.c | 55 +++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 8e52439..2918fdb 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -698,25 +698,10 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->control_data = uda1380->control_data;
 
-	if (!pdata)
-		return -EINVAL;
-
-	if (gpio_is_valid(pdata->gpio_reset)) {
-		ret = gpio_request_one(pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
-				       "uda1380 reset");
-		if (ret)
-			goto err_out;
-	}
-
-	if (gpio_is_valid(pdata->gpio_power)) {
-		ret = gpio_request_one(pdata->gpio_power, GPIOF_OUT_INIT_LOW,
-				   "uda1380 power");
-		if (ret)
-			goto err_free_gpio;
-	} else {
+	if (!gpio_is_valid(pdata->gpio_power)) {
 		ret = uda1380_reset(codec);
 		if (ret)
-			goto err_free_gpio;
+			return ret;
 	}
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
@@ -733,28 +718,10 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	}
 
 	return 0;
-
-err_free_gpio:
-	if (gpio_is_valid(pdata->gpio_reset))
-		gpio_free(pdata->gpio_reset);
-err_out:
-	return ret;
-}
-
-/* power down chip */
-static int uda1380_remove(struct snd_soc_codec *codec)
-{
-	struct uda1380_platform_data *pdata =codec->dev->platform_data;
-
-	gpio_free(pdata->gpio_reset);
-	gpio_free(pdata->gpio_power);
-
-	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
-	.remove =	uda1380_remove,
 	.read =		uda1380_read_reg_cache,
 	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
@@ -778,14 +745,32 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 static int uda1380_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
+	struct uda1380_platform_data *pdata = i2c->dev.platform_data;
 	struct uda1380_priv *uda1380;
 	int ret;
 
+	if (!pdata)
+		return -EINVAL;
+
 	uda1380 = devm_kzalloc(&i2c->dev, sizeof(struct uda1380_priv),
 			       GFP_KERNEL);
 	if (uda1380 == NULL)
 		return -ENOMEM;
 
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		ret = devm_gpio_request_one(&i2c->dev, pdata->gpio_reset,
+			GPIOF_OUT_INIT_LOW, "uda1380 reset");
+		if (ret)
+			return ret;
+	}
+
+	if (gpio_is_valid(pdata->gpio_power)) {
+		ret = devm_gpio_request_one(&i2c->dev, pdata->gpio_power,
+			GPIOF_OUT_INIT_LOW, "uda1380 power");
+		if (ret)
+			return ret;
+	}
+
 	i2c_set_clientdata(i2c, uda1380);
 	uda1380->control_data = i2c;
 
-- 
2.1.4
