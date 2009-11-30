From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Mon, 30 Nov 2009 11:12:23 +0100
Message-ID: <20091130101223.GZ29442@buzzloop.caiaq.de>
References: <20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
	<4B11A19D.4070301@freescale.com>
	<20091129004433.GZ14091@buzzloop.caiaq.de>
	<ed82fe3e0911282034t6bb8fa87o5141e48f7b0e6a7f@mail.gmail.com>
	<20091129083554.GC14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D5E18103825
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 11:12:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091129083554.GC14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 29, 2009 at 09:35:54AM +0100, Daniel Mack wrote:
> Anyway - I'll rebase the driver to 'for-2.6.33' so you can give it a
> try.

See below.

Daniel


>From 40f036c11cf36d6832431a4fda4e1ab1a2cf5b2e Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 25 Nov 2009 15:31:25 +0100
Subject: [PATCH] ALSA: ASoc: Add regulator support to CS4270 codec driver

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c |  114 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index ffe122d..279a644 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -28,6 +28,7 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs4270.h"
 
@@ -114,6 +115,12 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
 	unsigned int manual_mute;
+
+	/* power domain regulators */
+	struct regulator *va_reg;
+	struct regulator *vd_reg;
+	struct regulator *vlc_reg;
+	bool va_reg_enabled;
 };
 
 /**
@@ -458,6 +465,50 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 }
 
 /**
+ * cs4270_set_bias_level - catches BIAS level changes
+ * @dai: the SOC DAI
+ * @level: the new BIAS level
+ *
+ * This function controls the voltage regulators to properly
+ * power up/down the voltage regulator domains
+ */
+
+static int cs4270_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	int ret;
+	struct cs4270_private *cs4270 = codec->private_data;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		if (!cs4270->va_reg_enabled) {
+			ret = regulator_enable(cs4270->va_reg);
+			if (ret < 0)
+				return ret;
+
+			cs4270->va_reg_enabled = true;
+		}
+
+		break;
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
+		if (cs4270->va_reg_enabled) {
+			ret = regulator_disable(cs4270->va_reg);
+			if (ret < 0)
+				return ret;
+
+			cs4270->va_reg_enabled = false;
+		}
+
+		break;
+	}
+
+	codec->bias_level = level;
+	return 0;
+}
+
+/**
  * cs4270_dai_mute - enable/disable the CS4270 external mute
  * @dai: the SOC DAI
  * @mute: 0 = disable mute, 1 = enable mute
@@ -579,6 +630,7 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	int ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
@@ -599,9 +651,32 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_pcms;
 	}
 
+	/* get the power supply regulators */
+	cs4270->va_reg = regulator_get(codec->dev, "va");
+	cs4270->vd_reg = regulator_get(codec->dev, "vd");
+	cs4270->vlc_reg = regulator_get(codec->dev, "vlc");
+
+	if (IS_ERR(cs4270->va_reg) ||
+	    IS_ERR(cs4270->vd_reg) ||
+	    IS_ERR(cs4270->vlc_reg)) {
+		dev_err(codec->dev,
+			"failed to get supplies for device %s\n",
+			dev_name(codec->dev));
+		goto error_free_pcms;
+	}
+
+	regulator_enable(cs4270->vd_reg);
+	regulator_enable(cs4270->vlc_reg);
+
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	return 0;
 
 error_free_pcms:
+	regulator_put(cs4270->va_reg);
+	regulator_put(cs4270->vd_reg);
+	regulator_put(cs4270->vlc_reg);
+
 	snd_soc_free_pcms(socdev);
 
 	return ret;
@@ -616,9 +691,21 @@ error_free_pcms:
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
 
+	if (cs4270->va_reg_enabled)
+		regulator_disable(cs4270->va_reg);
+
+	regulator_disable(cs4270->vd_reg);
+	regulator_disable(cs4270->vlc_reg);
+
+	regulator_put(cs4270->va_reg);
+	regulator_put(cs4270->vd_reg);
+	regulator_put(cs4270->vlc_reg);
+
 	return 0;
 };
 
@@ -692,6 +779,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	codec->write = cs4270_i2c_write;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->reg_cache_size = CS4270_NUMREGS;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = cs4270_set_bias_level;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 
@@ -799,17 +888,38 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
 static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct snd_soc_codec *codec = cs4270_codec;
-	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+	struct cs4270_private *cs4270 = codec->private_data;
+	int reg, ret;
 
-	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+	reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+	if (reg < 0)
+		return reg;
+
+	ret = snd_soc_write(codec, CS4270_PWRCTL, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	if (ret < 0)
+		return ret;
+
+	regulator_disable(cs4270->vd_reg);
+	regulator_disable(cs4270->vlc_reg);
+
+	return 0;
 }
 
 static int cs4270_soc_resume(struct platform_device *pdev)
 {
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	struct i2c_client *i2c_client = codec->control_data;
 	int reg;
 
+	regulator_enable(cs4270->vd_reg);
+	regulator_enable(cs4270->vlc_reg);
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	/* In case the device was put to hard reset during sleep, we need to
 	 * wait 500ns here before any I2C communication. */
 	ndelay(500);
-- 
1.6.5.2
