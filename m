From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 2/4] ASoC: tlv320dac33: Revised module
	loading, and DAC33 ID read
Date: Fri, 30 Apr 2010 14:59:34 +0300
Message-ID: <1272628776-23185-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A8A55103912
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:59:44 +0200 (CEST)
In-Reply-To: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Optimize the way how tlv320dac33 is powered uppon module and
soc initialization.
Also read the DAC33 ID registers, and update the reg_cache
to reflect it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 329a97f..9944721 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -329,6 +329,15 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
 }
 
+static inline void dac33_read_id(struct snd_soc_codec *codec)
+{
+	u8 reg;
+
+	dac33_read(codec, DAC33_DEVICE_ID_MSB, &reg);
+	dac33_read(codec, DAC33_DEVICE_ID_LSB, &reg);
+	dac33_read(codec, DAC33_DEVICE_REV_ID, &reg);
+}
+
 static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
 {
 	u8 reg;
@@ -1285,9 +1294,6 @@ static int dac33_soc_probe(struct platform_device *pdev)
 	socdev->card->codec = codec;
 	dac33 = snd_soc_codec_get_drvdata(codec);
 
-	/* Power up the codec */
-	dac33_hard_power(codec, 1);
-
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
@@ -1307,9 +1313,6 @@ static int dac33_soc_probe(struct platform_device *pdev)
 	/* power on device */
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	/* Bias level configuration has enabled regulator an extra time */
-	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-
 	return 0;
 
 pcm_err:
@@ -1459,8 +1462,6 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 			goto error_gpio;
 		}
 		gpio_direction_output(dac33->power_gpio, 0);
-	} else {
-		dac33->chip_power = 1;
 	}
 
 	/* Check if the IRQ number is valid and request it */
@@ -1498,12 +1499,14 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 		goto err_get;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
-				    dac33->supplies);
+	/* Read the tlv320dac33 ID registers */
+	ret = dac33_hard_power(codec, 1);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_enable;
+		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
+		goto error_codec;
 	}
+	dac33_read_id(codec);
+	dac33_hard_power(codec, 0);
 
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
@@ -1518,14 +1521,9 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 		goto error_codec;
 	}
 
-	/* Shut down the codec for now */
-	dac33_hard_power(codec, 0);
-
 	return ret;
 
 error_codec:
-	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-err_enable:
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 err_get:
 	if (dac33->irq >= 0) {
@@ -1549,14 +1547,15 @@ static int __devexit dac33_i2c_remove(struct i2c_client *client)
 	struct tlv320dac33_priv *dac33;
 
 	dac33 = i2c_get_clientdata(client);
-	dac33_hard_power(&dac33->codec, 0);
+
+	if (unlikely(dac33->chip_power))
+		dac33_hard_power(&dac33->codec, 0);
 
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
 	if (dac33->irq >= 0)
 		free_irq(dac33->irq, &dac33->codec);
 
-	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 
 	destroy_workqueue(dac33->dac33_wq);
-- 
1.7.0.4
