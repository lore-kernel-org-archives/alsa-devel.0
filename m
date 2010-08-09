From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Fixes for multi-component
Date: Mon,  9 Aug 2010 11:55:58 +0300
Message-ID: <1281344158-3563-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 246512459F
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 10:56:02 +0200 (CEST)
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

Small changes int module load sequence.
Keep the codec OFF when not active.
Reading the DAC33 ID at probe time.
In the private struct we need pointer for the codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello Liam, Mark!

This patch is against the multi-comp branch, and makes the tlv320dac33
driver working correctly (in a similar way as it used to work).
I have tested the codec with this patch on top of the multi-comp
branch, and works nicely.

Liam: You can squash this, if you think it's better..

Peter

 sound/soc/codecs/tlv320dac33.c |   61 +++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 2c6793e..a3c5b52 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -91,7 +91,7 @@ struct tlv320dac33_priv {
 	struct mutex mutex;
 	struct workqueue_struct *dac33_wq;
 	struct work_struct work;
-	struct snd_soc_codec codec;
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
 	struct snd_pcm_substream *substream;
 	int power_gpio;
@@ -650,9 +650,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 
 static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec;
-
-	codec = &dac33->codec;
+	struct snd_soc_codec *codec = dac33->codec;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -695,9 +693,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 
 static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec;
-
-	codec = &dac33->codec;
+	struct snd_soc_codec *codec = dac33->codec;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -726,7 +722,7 @@ static void dac33_work(struct work_struct *work)
 	u8 reg;
 
 	dac33 = container_of(work, struct tlv320dac33_priv, work);
-	codec = &dac33->codec;
+	codec = dac33->codec;
 
 	mutex_lock(&dac33->mutex);
 	switch (dac33->state) {
@@ -1389,6 +1385,18 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = dac33->control_data;
 	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->idle_bias_off = 1;
+	dac33->codec = codec;
+
+	/* Read the tlv320dac33 ID registers */
+	ret = dac33_hard_power(codec, 1);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
+		goto err_power;
+	}
+	dac33_read_id(codec);
+	dac33_hard_power(codec, 0);
 
 	/* Check if the IRQ number is valid and request it */
 	if (dac33->irq >= 0) {
@@ -1413,9 +1421,6 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	/* Power up the codec */
-	dac33_hard_power(codec, 1);
-
 	snd_soc_add_controls(codec, dac33_snd_controls,
 			     ARRAY_SIZE(dac33_snd_controls));
 	/* Only add the FIFO controls, if we have valid IRQ number */
@@ -1427,9 +1432,9 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 			snd_soc_add_controls(codec, dac33_fifo_snd_controls,
 					ARRAY_SIZE(dac33_fifo_snd_controls));
 	}
-
 	dac33_add_widgets(codec);
 
+err_power:
 	return ret;
 }
 
@@ -1439,9 +1444,10 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 
 	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (dac33->irq >= 0)
-		free_irq(dac33->irq, &dac33->codec);
-
+	if (dac33->irq >= 0) {
+		free_irq(dac33->irq, dac33->codec);
+		destroy_workqueue(dac33->dac33_wq);
+	}
 	return 0;
 }
 
@@ -1516,6 +1522,8 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 
 	dac33->control_data = client;
 	mutex_init(&dac33->mutex);
+	spin_lock_init(&dac33->lock);
+
 	i2c_set_clientdata(client, dac33);
 
 	dac33->power_gpio = pdata->power_gpio;
@@ -1544,8 +1552,6 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 			goto err_gpio;
 		}
 		gpio_direction_output(dac33->power_gpio, 0);
-	} else {
-		dac33->chip_power = 1;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
@@ -1559,21 +1565,13 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 		goto err_get;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
-				    dac33->supplies);
-	if (ret != 0) {
-		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_enable;
-	}
-
 	ret = snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_tlv320dac33, &dac33_dai, 1);
-
 	if (ret < 0)
-		goto err_enable;
-	return ret;
+		goto err_register;
 
-err_enable:
+	return ret;
+err_register:
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 err_get:
 	if (dac33->power_gpio >= 0)
@@ -1588,17 +1586,16 @@ static int __devexit dac33_i2c_remove(struct i2c_client *client)
 	struct tlv320dac33_priv *dac33 = i2c_get_clientdata(client);
 
 	if (unlikely(dac33->chip_power))
-		dac33_hard_power(&dac33->codec, 0);
+		dac33_hard_power(dac33->codec, 0);
 
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
 
-	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-	destroy_workqueue(dac33->dac33_wq);
 
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+	kfree(dac33);
+
 	return 0;
 }
 
-- 
1.7.2
