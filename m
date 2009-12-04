From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Add support for regulator
	framework
Date: Fri,  4 Dec 2009 10:11:57 +0200
Message-ID: <1259914317-6535-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6343D1037F7
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 09:14:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

Take the regulator framework in use for managing the power sources.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   92 ++++++++++++++++++++++++++++++++++------
 1 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 3ca8934..c2510bb 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -58,11 +59,19 @@ enum dac33_state {
 	DAC33_FLUSH,
 };
 
+#define DAC33_NUM_SUPPLIES 3
+static const char *dac33_supply_names[DAC33_NUM_SUPPLIES] = {
+	"AVDD",
+	"DVDD",
+	"IOVDD",
+};
+
 struct tlv320dac33_priv {
 	struct mutex mutex;
 	struct workqueue_struct *dac33_wq;
 	struct work_struct work;
 	struct snd_soc_codec codec;
+	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
 	int power_gpio;
 	int chip_power;
 	int irq;
@@ -297,28 +306,49 @@ static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
 	dac33_write(codec, DAC33_PWR_CTRL, reg);
 }
 
-static void dac33_hard_power(struct snd_soc_codec *codec, int power)
+static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 {
 	struct tlv320dac33_priv *dac33 = codec->private_data;
+	int ret;
 
 	mutex_lock(&dac33->mutex);
 	if (power) {
-		if (dac33->power_gpio >= 0) {
-			gpio_set_value(dac33->power_gpio, 1);
-			dac33->chip_power = 1;
-			/* Restore registers */
-			dac33_restore_regs(codec);
+		ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
+					  dac33->supplies);
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to enable supplies: %d\n", ret);
+				goto exit;
 		}
+
+		if (dac33->power_gpio >= 0)
+			gpio_set_value(dac33->power_gpio, 1);
+
+		dac33->chip_power = 1;
+
+		/* Restore registers */
+		dac33_restore_regs(codec);
+
 		dac33_soft_power(codec, 1);
 	} else {
 		dac33_soft_power(codec, 0);
-		if (dac33->power_gpio >= 0) {
+		if (dac33->power_gpio >= 0)
 			gpio_set_value(dac33->power_gpio, 0);
-			dac33->chip_power = 0;
+
+		ret = regulator_bulk_disable(ARRAY_SIZE(dac33->supplies),
+					     dac33->supplies);
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to disable supplies: %d\n", ret);
+			goto exit;
 		}
+
+		dac33->chip_power = 0;
 	}
-	mutex_unlock(&dac33->mutex);
 
+exit:
+	mutex_unlock(&dac33->mutex);
+	return ret;
 }
 
 static int dac33_get_nsample(struct snd_kcontrol *kcontrol,
@@ -470,6 +500,8 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
 static int dac33_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		dac33_soft_power(codec, 1);
@@ -477,12 +509,19 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF)
-			dac33_hard_power(codec, 1);
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			ret = dac33_hard_power(codec, 1);
+			if (ret != 0)
+				return ret;
+		}
+
 		dac33_soft_power(codec, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
-		dac33_hard_power(codec, 0);
+		ret = dac33_hard_power(codec, 0);
+		if (ret != 0)
+			return ret;
+
 		break;
 	}
 	codec->bias_level = level;
@@ -960,6 +999,9 @@ static int dac33_soc_probe(struct platform_device *pdev)
 	/* power on device */
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
+	/* Bias level configuration has enabled regulator an extra time */
+	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to register card\n");
@@ -1048,7 +1090,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	struct tlv320dac33_platform_data *pdata;
 	struct tlv320dac33_priv *dac33;
 	struct snd_soc_codec *codec;
-	int ret = 0;
+	int ret, i;
 
 	if (client->dev.platform_data == NULL) {
 		dev_err(&client->dev, "Platform data not set\n");
@@ -1138,6 +1180,24 @@ static int dac33_i2c_probe(struct i2c_client *client,
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
+		dac33->supplies[i].supply = dac33_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(dac33->supplies),
+				 dac33->supplies);
+
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
+				    dac33->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_enable;
+	}
+
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
@@ -1157,6 +1217,10 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	return ret;
 
 error_codec:
+	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+err_enable:
+	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+err_get:
 	if (dac33->irq >= 0) {
 		free_irq(dac33->irq, &dac33->codec);
 		destroy_workqueue(dac33->dac33_wq);
@@ -1185,6 +1249,8 @@ static int dac33_i2c_remove(struct i2c_client *client)
 	if (dac33->irq >= 0)
 		free_irq(dac33->irq, &dac33->codec);
 
+	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+
 	destroy_workqueue(dac33->dac33_wq);
 	snd_soc_unregister_dai(&dac33_dai);
 	snd_soc_unregister_codec(&dac33->codec);
-- 
1.6.0.4
