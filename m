From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: add additional controls to the
	CS4270 codec driver
Date: Tue,  3 Feb 2009 11:09:32 -0600
Message-ID: <1233680972-1443-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 93EF0103864
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 18:09:56 +0100 (CET)
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

Update the CS4270 codec driver to allow applications to use the mixer to
control Digital Loopback, Soft Ramp, Zero Cross, Popguard, and Auto-Mute.
Soft Ramp, Zero Cross, and Auto-Mute are disabled by the driver when it first
initializes the hardware, but these features either don't work or interfere
with normal ALSA behavior.  However, they can now be re-enabled by an
application if desired.

Remove CONFIG_SND_SOC_CS4270_HWMUTE and always allow ASoC to control the mute
bits.  The driver previously and erroneously assumed that these bits
control only external muting circuitry, but they also control internal
muting circuitry, so they should always be used.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/Kconfig  |    6 ---
 sound/soc/codecs/cs4270.c |   93 +++++++++++++++++++-------------------------
 2 files changed, 40 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a195303..628a591 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -67,12 +67,6 @@ config SND_SOC_AK4535
 config SND_SOC_CS4270
 	tristate
 
-# Cirrus Logic CS4270 Codec Hardware Mute Support
-# Select if you have external muting circuitry attached to your CS4270.
-config SND_SOC_CS4270_HWMUTE
-	bool
-	depends on SND_SOC_CS4270
-
 # Cirrus Logic CS4270 Codec VD = 3.3V Errata
 # Select if you are affected by the errata where the part will not function
 # if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 2c79a24..cd4a9ee 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -395,17 +395,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Freeze and power-down the codec */
-
-	ret = snd_soc_write(codec, CS4270_PWRCTL, CS4270_PWRCTL_FREEZE |
-			    CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC |
-			    CS4270_PWRCTL_PDN);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
-
-	/* Program the mode control register */
+	/* Set the sample rate */
 
 	reg = snd_soc_read(codec, CS4270_MODE);
 	reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
@@ -417,7 +407,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* Program the format register */
+	/* Set the DAI format */
 
 	reg = snd_soc_read(codec, CS4270_FORMAT);
 	reg &= ~(CS4270_FORMAT_DAC_MASK | CS4270_FORMAT_ADC_MASK);
@@ -440,42 +430,9 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* Disable auto-mute.  This feature appears to be buggy, because in
-	   some situations, auto-mute will not deactivate when it should. */
-
-	reg = snd_soc_read(codec, CS4270_MUTE);
-	reg &= ~CS4270_MUTE_AUTO;
-	ret = snd_soc_write(codec, CS4270_MUTE, reg);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
-
-	/* Disable automatic volume control.  It's enabled by default, and
-	 * it causes volume change commands to be delayed, sometimes until
-	 * after playback has started.
-	 */
-
-	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
-	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
-	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
-
-	/* Thaw and power-up the codec */
-
-	ret = snd_soc_write(codec, CS4270_PWRCTL, 0);
-	if (ret < 0) {
-		dev_err(codec->dev, "i2c write failed\n");
-		return ret;
-	}
-
 	return ret;
 }
 
-#ifdef CONFIG_SND_SOC_CS4270_HWMUTE
 /**
  * cs4270_mute - enable/disable the CS4270 external mute
  * @dai: the SOC DAI
@@ -494,22 +451,23 @@ static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 	reg6 = snd_soc_read(codec, CS4270_MUTE);
 
 	if (mute)
-		reg6 |= CS4270_MUTE_ADC_A | CS4270_MUTE_ADC_B |
-			CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
+		reg6 |= CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
 	else
-		reg6 &= ~(CS4270_MUTE_ADC_A | CS4270_MUTE_ADC_B |
-			  CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B);
+		reg6 &= ~(CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B);
 
 	return snd_soc_write(codec, CS4270_MUTE, reg6);
 }
-#else
-#define cs4270_mute NULL
-#endif
 
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
-		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1)
+		CS4270_VOLA, CS4270_VOLB, 0, 0xFF, 1),
+	SOC_SINGLE("Digital Sidetone Switch", CS4270_FORMAT, 5, 1, 0),
+	SOC_SINGLE("Soft Ramp Switch", CS4270_TRANS, 6, 1, 0),
+	SOC_SINGLE("Zero Cross Switch", CS4270_TRANS, 5, 1, 0),
+	SOC_SINGLE("Popguard Switch", CS4270_MODE, 0, 1, 1),
+	SOC_SINGLE("Auto-Mute Switch", CS4270_MUTE, 5, 1, 0),
+	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 0)
 };
 
 /*
@@ -637,6 +595,7 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 {
 	struct snd_soc_codec *codec;
 	struct cs4270_private *cs4270;
+	unsigned int reg;
 	int ret;
 
 	/* For now, we only support one cs4270 device in the system.  See the
@@ -702,6 +661,34 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		goto error_free_codec;
 	}
 
+	/* Disable auto-mute.  This feature appears to be buggy.  In some
+	 * situations, auto-mute will not deactivate when it should, so we want
+	 * this feature disabled by default.  An application (e.g. alsactl) can
+	 * re-enabled it by using the controls.
+	 */
+
+	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
+	reg &= ~CS4270_MUTE_AUTO;
+	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	/* Disable automatic volume control.  The hardware enables, and it
+	 * causes volume change commands to be delayed, sometimes until after
+	 * playback has started.  An application (e.g. alsactl) can
+	 * re-enabled it by using the controls.
+	 */
+
+	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
+	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
+	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "i2c write failed\n");
+		return ret;
+	}
+
 	/* Initialize the DAI. Normally, we'd prefer to have a kmalloc'd DAI
 	 * structure for each CS4270 device, but the machine driver needs to
 	 * have a pointer to the DAI structure, so for now it must be a global
-- 
1.5.5
