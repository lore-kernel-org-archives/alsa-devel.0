From: Timur Tabi <timur@freescale.com>
Subject: [PATCH v2 2.6.30] ASoC: remove stand-alone mode
	support from CS4270 codec driver
Date: Thu, 22 Jan 2009 18:23:39 -0600
Message-ID: <1232670219-16780-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8229C103804
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 01:23:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The CS4270 supports stand-alone mode, where the codec is not connect to the
I2C or SPI buses.  Instead, input voltages configure the codec at power-on.
The CS4270 ASoC device driver has partial support for this mode, but the
code was never tested, and partial support doesn't help anyone.  It also made
the rest of the code more complicated than necessary.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v2: Added Kconfig changes

 sound/soc/codecs/Kconfig  |    1 +
 sound/soc/codecs/cs4270.c |   92 +++++++++++++-------------------------------
 sound/soc/fsl/Kconfig     |    3 +-
 3 files changed, 30 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb5fcd6..136e1bc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -65,6 +65,7 @@ config SND_SOC_AK4535
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
+	depends on I2C
 
 # Cirrus Logic CS4270 Codec Hardware Mute Support
 # Select if you have external muting circuitry attached to your CS4270.
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index f1aa0c3..2e4ce04 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -12,11 +12,7 @@
  *
  * Current features/limitations:
  *
- * 1) Software mode is supported.  Stand-alone mode is automatically
- *    selected if I2C is disabled or if a CS4270 is not found on the I2C
- *    bus.  However, stand-alone mode is only partially implemented because
- *    there is no mechanism yet for this driver and the machine driver to
- *    communicate the values of the M0, M1, MCLK1, and MCLK2 pins.
+ * 1) Software mode is supported.  Stand-alone mode is not supported.
  * 2) Only I2C is supported, not SPI
  * 3) Only Master mode is supported, not Slave.
  * 4) The machine driver's 'startup' function must call
@@ -33,14 +29,6 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 
-#include "cs4270.h"
-
-/* If I2C is defined, then we support software mode.  However, if we're
-   not compiled as module but I2C is, then we can't use I2C calls. */
-#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
-#define USE_I2C
-#endif
-
 /* Private data for the CS4270 */
 struct cs4270_private {
 	unsigned int mclk; /* Input frequency of the MCLK pin */
@@ -60,8 +48,6 @@ struct cs4270_private {
 			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
 			SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
 
-#ifdef USE_I2C
-
 /* CS4270 registers addresses */
 #define CS4270_CHIPID	0x01	/* Chip ID */
 #define CS4270_PWRCTL	0x02	/* Power Control */
@@ -272,17 +258,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 /*
- * A list of addresses on which this CS4270 could use.  I2C addresses are
- * 7 bits.  For the CS4270, the upper four bits are always 1001, and the
- * lower three bits are determined via the AD2, AD1, and AD0 pins
- * (respectively).
- */
-static const unsigned short normal_i2c[] = {
-	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, I2C_CLIENT_END
-};
-I2C_CLIENT_INSMOD;
-
-/*
  * Pre-fill the CS4270 register cache.
  *
  * We use the auto-increment feature of the CS4270 to read all registers in
@@ -476,7 +451,6 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-
 /*
  * Set the CS4270 external mute
  *
@@ -501,32 +475,16 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 
 	return snd_soc_write(codec, CS4270_MUTE, reg6);
 }
-
+#else
+#define cs4270_mute NULL
 #endif
 
-static int cs4270_i2c_probe(struct i2c_client *, const struct i2c_device_id *);
-
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
 		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
 };
 
-static const struct i2c_device_id cs4270_id[] = {
-	{"cs4270", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cs4270_id);
-
-static struct i2c_driver cs4270_i2c_driver = {
-	.driver = {
-		.name = "CS4270 I2C",
-		.owner = THIS_MODULE,
-	},
-	.id_table = cs4270_id,
-	.probe = cs4270_i2c_probe,
-};
-
 /*
  * Global variable to store socdev for i2c probe function.
  *
@@ -633,7 +591,20 @@ error:
 	return ret;
 }
 
-#endif /* USE_I2C*/
+static const struct i2c_device_id cs4270_id[] = {
+	{"cs4270", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4270_id);
+
+static struct i2c_driver cs4270_i2c_driver = {
+	.driver = {
+		.name = "cs4270",
+		.owner = THIS_MODULE,
+	},
+	.id_table = cs4270_id,
+	.probe = cs4270_i2c_probe,
+};
 
 struct snd_soc_dai cs4270_dai = {
 	.name = "CS4270",
@@ -698,7 +669,6 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_codec;
 	}
 
-#ifdef USE_I2C
 	cs4270_socdev = socdev;
 
 	ret = i2c_add_driver(&cs4270_i2c_driver);
@@ -708,20 +678,16 @@ static int cs4270_probe(struct platform_device *pdev)
 	}
 
 	/* Did we find a CS4270 on the I2C bus? */
-	if (codec->control_data) {
-		/* Initialize codec ops */
-		cs4270_dai.ops.hw_params = cs4270_hw_params;
-		cs4270_dai.ops.set_sysclk = cs4270_set_dai_sysclk;
-		cs4270_dai.ops.set_fmt = cs4270_set_dai_fmt;
-#ifdef CONFIG_SND_SOC_CS4270_HWMUTE
-		cs4270_dai.ops.digital_mute = cs4270_mute;
-#endif
-	} else
-		printk(KERN_INFO "cs4270: no I2C device found, "
-			"using stand-alone mode\n");
-#else
-	printk(KERN_INFO "cs4270: I2C disabled, using stand-alone mode\n");
-#endif
+	if (!codec->control_data) {
+		printk(KERN_ERR "cs4270: failed to attach driver");
+		goto error_del_driver;
+	}
+
+	/* Initialize codec ops */
+	cs4270_dai.ops.hw_params = cs4270_hw_params;
+	cs4270_dai.ops.set_sysclk = cs4270_set_dai_sysclk;
+	cs4270_dai.ops.set_fmt = cs4270_set_dai_fmt;
+	cs4270_dai.ops.digital_mute = cs4270_mute;
 
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
@@ -732,11 +698,9 @@ static int cs4270_probe(struct platform_device *pdev)
 	return 0;
 
 error_del_driver:
-#ifdef USE_I2C
 	i2c_del_driver(&cs4270_i2c_driver);
 
 error_free_pcms:
-#endif
 	snd_soc_free_pcms(socdev);
 
 error_free_codec:
@@ -752,9 +716,7 @@ static int cs4270_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 
-#ifdef USE_I2C
 	i2c_del_driver(&cs4270_i2c_driver);
-#endif
 
 	kfree(socdev->codec);
 	socdev->codec = NULL;
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index c7c78c3..9fc9082 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -10,7 +10,8 @@ config SND_SOC_MPC8610
 
 config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
-	depends on MPC8610_HPCD
+	# I2C is necessary for the CS4270 driver
+	depends on MPC8610_HPCD && I2C
 	select SND_SOC_MPC8610
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
-- 
1.5.5
