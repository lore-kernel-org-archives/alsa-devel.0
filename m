From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Fri, 27 Nov 2009 13:41:39 +0100
Message-ID: <20091127124139.GR14091@buzzloop.caiaq.de>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BAC26103949
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 13:41:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091127112550.GA29821@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 27, 2009 at 11:25:51AM +0000, Mark Brown wrote:
> On Thu, Nov 26, 2009 at 06:42:45PM +0100, Daniel Mack wrote:
> > +
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +		ret = regulator_enable(cs4270->vd_reg);
> > +		if (ret < 0)
> > +			return ret;
> > +		ret = regulator_enable(cs4270->vlc_reg);
> > +		if (ret < 0)
> > +			return ret;
> > +		/* fall thru */
> 
> I'd expect these to just be enabled on OFF->STANDBY (or in the suspend
> code indeed) - you'll need to restore the register cache after the
> digital comes up anyway.
> 
> Also, you'll leak references since you only turn them off when going
> into OFF but enable them every time you go to ON.

Ok, agreed. Next try below.

Thanks,
Daniel


>From 2a36f34232b060ad6a12e4260e24d70d491e7dcb Mon Sep 17 00:00:00 2001
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
index 8069023..34cd97d 100644
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
@@ -599,6 +651,25 @@ static int cs4270_probe(struct platform_device *pdev)
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
 	/* And finally, register the socdev */
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
@@ -609,6 +680,10 @@ static int cs4270_probe(struct platform_device *pdev)
 	return 0;
 
 error_free_pcms:
+	regulator_put(cs4270->va_reg);
+	regulator_put(cs4270->vd_reg);
+	regulator_put(cs4270->vlc_reg);
+
 	snd_soc_free_pcms(socdev);
 
 	return ret;
@@ -623,9 +698,21 @@ error_free_pcms:
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
 
@@ -699,6 +786,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	codec->write = cs4270_i2c_write;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->reg_cache_size = CS4270_NUMREGS;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = cs4270_set_bias_level;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 
@@ -822,17 +911,38 @@ static int cs4270_i2c_resume(struct i2c_client *client)
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
