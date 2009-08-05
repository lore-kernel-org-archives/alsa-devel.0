From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: cs4270: move power management
	hooks to snd_soc_codec_device
Date: Wed,  5 Aug 2009 20:30:36 +0200
Message-ID: <1249497036-9073-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC8224570
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:30:44 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Power management for the cs4270 codec is currently implemented as part
of the i2c_driver struct. The disadvantage of doing it this way is that
the callbacks registered in the snd_soc_card struct are called _before_
the codec's callbacks.

That doesn't work, because the snd_soc_card callbacks will most likely
switch down the codec's power domains or pull the reset GPIOs, and
hence make the i2c communication bail out.

Fix this by binding the suspend and resume code to the
snd_soc_codec_device driver model.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   55 ++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index a32b822..69b794b 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -791,6 +791,22 @@ static struct i2c_device_id cs4270_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4270_id);
 
+/*
+ * cs4270_i2c_driver - I2C device identification
+ *
+ * This structure tells the I2C subsystem how to identify and support a
+ * given I2C device type.
+ */
+static struct i2c_driver cs4270_i2c_driver = {
+	.driver = {
+		.name = "cs4270",
+		.owner = THIS_MODULE,
+	},
+	.id_table = cs4270_id,
+	.probe = cs4270_i2c_probe,
+	.remove = cs4270_i2c_remove,
+};
+
 #ifdef CONFIG_PM
 
 /* This suspend/resume implementation can handle both - a simple standby
@@ -802,19 +818,18 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
  * and all registers are written back to the hardware when resuming.
  */
 
-static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
+static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
-	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
-	struct snd_soc_codec *codec = &cs4270->codec;
+	struct snd_soc_codec *codec = cs4270_codec;
 	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
 
 	return snd_soc_write(codec, CS4270_PWRCTL, reg);
 }
 
-static int cs4270_i2c_resume(struct i2c_client *client)
+static int cs4270_soc_resume(struct platform_device *pdev)
 {
-	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
-	struct snd_soc_codec *codec = &cs4270->codec;
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct i2c_client *i2c_client = codec->control_data;
 	int reg;
 
 	/* In case the device was put to hard reset during sleep, we need to
@@ -825,7 +840,7 @@ static int cs4270_i2c_resume(struct i2c_client *client)
 	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
 		u8 val = snd_soc_read(codec, reg);
 
-		if (i2c_smbus_write_byte_data(client, reg, val)) {
+		if (i2c_smbus_write_byte_data(i2c_client, reg, val)) {
 			dev_err(codec->dev, "i2c write failed\n");
 			return -EIO;
 		}
@@ -838,29 +853,11 @@ static int cs4270_i2c_resume(struct i2c_client *client)
 	return snd_soc_write(codec, CS4270_PWRCTL, reg);
 }
 #else
-#define cs4270_i2c_suspend	NULL
-#define cs4270_i2c_resume	NULL
+#define cs4270_soc_suspend	NULL
+#define cs4270_soc_resume	NULL
 #endif /* CONFIG_PM */
 
 /*
- * cs4270_i2c_driver - I2C device identification
- *
- * This structure tells the I2C subsystem how to identify and support a
- * given I2C device type.
- */
-static struct i2c_driver cs4270_i2c_driver = {
-	.driver = {
-		.name = "cs4270",
-		.owner = THIS_MODULE,
-	},
-	.id_table = cs4270_id,
-	.probe = cs4270_i2c_probe,
-	.remove = cs4270_i2c_remove,
-	.suspend = cs4270_i2c_suspend,
-	.resume = cs4270_i2c_resume,
-};
-
-/*
  * ASoC codec device structure
  *
  * Assign this variable to the codec_dev field of the machine driver's
@@ -868,7 +865,9 @@ static struct i2c_driver cs4270_i2c_driver = {
  */
 struct snd_soc_codec_device soc_codec_device_cs4270 = {
 	.probe = 	cs4270_probe,
-	.remove = 	cs4270_remove
+	.remove = 	cs4270_remove,
+	.suspend =	cs4270_soc_suspend,
+	.resume =	cs4270_soc_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
 
-- 
1.6.3.3
