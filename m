From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Thu, 26 Nov 2009 18:42:45 +0100
Message-ID: <20091126174245.GJ14091@buzzloop.caiaq.de>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0EC244F5
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 18:42:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091126160351.GB10674@rakim.wolfsonmicro.main>
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

On Thu, Nov 26, 2009 at 04:03:51PM +0000, Mark Brown wrote:
> On Thu, Nov 26, 2009 at 04:48:07PM +0100, Daniel Mack wrote:
> 
> > - I only added VA for now because when VD is disabled, we need to
> >   restore all codec information, and I can't test that here. We can
> >   still add that later, right?
> 
> I'd suggest just adding it blind.  The code is very simple and it's much
> easier to fix if there's a problem than it is to go through retrofit the
> additional regulator hookups to boards if the other supplies are added
> later.
> 
> You can test the flow by defining a fixed voltage regulator with no soft
> control, obviously it won't actually turn the power on or off but the
> code will run.

Ok. I couldn't find a dummy framework for such cases, and registering a
full regulator just to satisfy the codec code seems a litte cumbersome.
Is there anything like that? Or should there be?

> Just fail if you can't get the supply.  If you can't get the regulator
> then you've no analogue supply and the CODEC isn't going to work
> terribly well.  Currently the assumption is that if you've built in the
> regulator API you intend to use it, otherwise it's very hard to tell if
> the operation failed and broke something or failed because the API isn't
> in use.

Hmm - that will break all existing platforms that use this codec and
need regulators for other drivers. But ok, I'm fine with forcing
everyone to innovation :)

> >  	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
> >  	struct snd_soc_codec *codec = &cs4270->codec;
> >  
> > +	cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > +
> >  	return snd_soc_suspend_device(codec->dev);
> >  }
> 
> This patch isn't against current for-2.6.33 - those functions have been
> removed.  Better to do the bias management in the ASoC suspend/resume
> callbacks anyway so that it's joined up with the register save/restore.
> Until we get the pm_link stuff in the next merge window there's no link
> between the I2C bus suspend and the platform bus suspend for the ASoC
> core.

Ok, done - see the new patch below. I did use the regulator_bulk
functions in the first place, but due to the VA special case, I had to
extract the single regulators again from the bulk struct which turned
out to mess the code quite a bit. Looks better this way.

Thanks,
Daniel


>From dedbbb7ee101f635e9682559d31e48b4c57722a3 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 25 Nov 2009 15:31:25 +0100
Subject: [PATCH] ALSA: ASoc: Add regulator support to CS4270 codec driver

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c |   90 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8069023..e79d30d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -28,6 +28,7 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs4270.h"
 
@@ -114,6 +115,11 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
 	unsigned int manual_mute;
+
+	/* power domain regulators (optional) */
+	struct regulator *va_reg;
+	struct regulator *vd_reg;
+	struct regulator *vlc_reg;
 };
 
 /**
@@ -458,6 +464,56 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
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
+		ret = regulator_enable(cs4270->vd_reg);
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_enable(cs4270->vlc_reg);
+		if (ret < 0)
+			return ret;
+		/* fall thru */
+	case SND_SOC_BIAS_PREPARE:
+		ret = regulator_enable(cs4270->va_reg);
+		if (ret < 0)
+			return ret;
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* OFF -> STANDBY */
+			ret = regulator_enable(cs4270->va_reg);
+			if (ret < 0)
+				return ret;
+		} else
+			regulator_disable(cs4270->va_reg);
+		break;
+	case SND_SOC_BIAS_OFF:
+		regulator_disable(cs4270->va_reg);
+		regulator_disable(cs4270->vd_reg);
+		regulator_disable(cs4270->vlc_reg);
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
@@ -579,6 +635,7 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	int ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
@@ -599,6 +656,20 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_pcms;
 	}
 
+	/* get the power supply regulators */
+	cs4270->va_reg = regulator_get(&pdev->dev, "va");
+	cs4270->vd_reg = regulator_get(&pdev->dev, "vd");
+	cs4270->vlc_reg = regulator_get(&pdev->dev, "vlc");
+
+	if (IS_ERR(cs4270->va_reg) ||
+	    IS_ERR(cs4270->vd_reg) ||
+	    IS_ERR(cs4270->vlc_reg)) {
+		dev_err(codec->dev, "failed to get supplies %s\n", dev_name(codec->dev));
+		goto error_free_pcms;
+	}
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
@@ -623,9 +698,15 @@ error_free_pcms:
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
 
+	regulator_put(cs4270->va_reg);
+	regulator_put(cs4270->vd_reg);
+	regulator_put(cs4270->vlc_reg);
+
 	return 0;
 };
 
@@ -699,6 +780,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	codec->write = cs4270_i2c_write;
 	codec->reg_cache = cs4270->reg_cache;
 	codec->reg_cache_size = CS4270_NUMREGS;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = cs4270_set_bias_level;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 
@@ -824,6 +907,8 @@ static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct snd_soc_codec *codec = cs4270_codec;
 	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
 
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
 	return snd_soc_write(codec, CS4270_PWRCTL, reg);
 }
 
@@ -833,6 +918,11 @@ static int cs4270_soc_resume(struct platform_device *pdev)
 	struct i2c_client *i2c_client = codec->control_data;
 	int reg;
 
+	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		cs4270_set_bias_level(codec, SND_SOC_BIAS_ON);
+
 	/* In case the device was put to hard reset during sleep, we need to
 	 * wait 500ns here before any I2C communication. */
 	ndelay(500);
-- 
1.6.5.2
