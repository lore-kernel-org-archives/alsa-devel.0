From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Thu, 26 Nov 2009 16:48:07 +0100
Message-ID: <20091126154807.GI14091@buzzloop.caiaq.de>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A3E2210389F
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 16:48:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125153804.GA12750@rakim.wolfsonmicro.main>
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

Hi Mark,

On Wed, Nov 25, 2009 at 03:38:04PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 04:20:52PM +0100, Daniel Mack wrote:
> 
> > Ok - which place would you suggest for it? Is there an ASoC callback I
> > can hook on to tell me when the whole codec isn't used anymore? I can
> > only see startup/shutdown, but I would need to my own snd_pc_substream
> > handling login in there. Other drivers do that in the probe/remove
> 
> set_bias_level().  If the device is idle then the bias will be held in
> STANDBY (or OFF in future).  If you are happy switching off the analogue
> supply separately to the others then turn that one on when in PREPARE or
> ON, and kill the others only in OFF.

I implemented that now and it seems to work fine. However, I'm unsure
about two details:

- I only added VA for now because when VD is disabled, we need to
  restore all codec information, and I can't test that here. We can
  still add that later, right?

- I'm tracking the va_reg enable state inside the driver to take anyone
  else's reference. Is that the way do do it?

Thanks,
Daniel


>From ab10605ccad8d4409e541deb530b03e418435b8f Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 25 Nov 2009 15:31:25 +0100
Subject: [PATCH] ALSA: ASoc: Add regulator support to CS4270 codec driver

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c |   62 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8069023..acbe961 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -28,6 +28,7 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs4270.h"
 
@@ -114,6 +115,10 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
 	unsigned int manual_mute;
+
+	/* power domain regulators (optional) */
+	struct regulator *va_reg;
+	bool va_reg_enabled;
 };
 
 /**
@@ -458,6 +463,42 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
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
+	struct cs4270_private *cs4270 = codec->private_data;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		/* Full power on */
+		if (cs4270->va_reg && !cs4270->va_reg_enabled) {
+			regulator_enable(cs4270->va_reg);
+			cs4270->va_reg_enabled = true;
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
+		if (cs4270->va_reg && cs4270->va_reg_enabled) {
+			regulator_disable(cs4270->va_reg);
+			cs4270->va_reg_enabled = false;
+		}
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
@@ -579,6 +620,7 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	int ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
@@ -599,6 +641,13 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_pcms;
 	}
 
+	/* get the power supply regulators (optional) */
+	cs4270->va_reg = regulator_get(&pdev->dev, "va");
+	if (IS_ERR(cs4270->va_reg))
+		cs4270->va_reg = NULL;
+
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	/* And finally, register the socdev */
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
@@ -623,9 +672,13 @@ error_free_pcms:
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
 
+	regulator_put(cs4270->va_reg);
+
 	return 0;
 };
 
@@ -699,6 +752,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	codec->write = cs4270_i2c_write;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->reg_cache_size = CS4270_NUMREGS;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = cs4270_set_bias_level;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 
@@ -808,6 +863,8 @@ static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
 	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
 	struct snd_soc_codec *codec = &cs4270->codec;
 
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
 	return snd_soc_suspend_device(codec->dev);
 }
 
@@ -816,6 +873,11 @@ static int cs4270_i2c_resume(struct i2c_client *client)
 	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
 	struct snd_soc_codec *codec = &cs4270->codec;
 
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		cs4270_set_bias_level(codec, SND_SOC_BIAS_ON);
+
 	return snd_soc_resume_device(codec->dev);
 }
 
-- 
1.6.5.2
