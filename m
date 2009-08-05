From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: move power management
	hooks to	snd_soc_codec_device
Date: Wed, 5 Aug 2009 20:50:43 +0200
Message-ID: <20090805185043.GP13236@buzzloop.caiaq.de>
References: <1249497036-9073-1-git-send-email-daniel@caiaq.de>
	<20090805183700.GA6727@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F35B24585
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:50:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090805183700.GA6727@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 07:37:00PM +0100, Mark Brown wrote:
> On Wed, Aug 05, 2009 at 08:30:36PM +0200, Daniel Mack wrote:
> > Power management for the cs4270 codec is currently implemented as part
> > of the i2c_driver struct. The disadvantage of doing it this way is that
> > the callbacks registered in the snd_soc_card struct are called _before_
> > the codec's callbacks.
> 
> > That doesn't work, because the snd_soc_card callbacks will most likely
> > switch down the codec's power domains or pull the reset GPIOs, and
> > hence make the i2c communication bail out.
> 
> > Fix this by binding the suspend and resume code to the
> > snd_soc_codec_device driver model.
> 
> You should leave the suspend and resume functions for I2C but have them
> call the snd_soc_suspend_device() and snd_soc_resume_device() callbacks
> in the core (which do nothing but will in future ensure that the entire
> card goes down when one of the components goes down to make sure we are
> always able to communicate with all the card components).   The actual
> suspend and resume actions should be moved as you have done.

Like that?


>From f77eef3ad3bf0d84877511eee30e14a1e0fed595 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 5 Aug 2009 20:14:53 +0200
Subject: [PATCH] ALSA: ASoC: cs4270: move power management hooks to snd_soc_codec_device

Power management for the cs4270 codec is currently implemented as part
of the i2c_driver struct. The disadvantage of doing it this way is that
the callbacks registered in the snd_soc_card struct are called _before_
the codec's callbacks.

That doesn't work, because the snd_soc_card callbacks will most likely
switch down the codec's power domains or pull the reset GPIOs, and
hence make the i2c communication bail out.

Fix this by binding the suspend and resume code to the
snd_soc_codec_device driver model and let the I2C functions only call
the SoC core function for resume and suspend, which do nothing currently
but will do later.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index a32b822..ca1e24a 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -806,15 +806,30 @@ static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
 {
 	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
 	struct snd_soc_codec *codec = &cs4270->codec;
-	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
 
-	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+	return snd_soc_suspend_device(codec->dev);
 }
 
 static int cs4270_i2c_resume(struct i2c_client *client)
 {
 	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
 	struct snd_soc_codec *codec = &cs4270->codec;
+
+	return snd_soc_resume_device(codec->dev);
+}
+
+static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct snd_soc_codec *codec = cs4270_codec;
+	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+
+	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+}
+
+static int cs4270_soc_resume(struct platform_device *pdev)
+{
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
@@ -840,6 +855,8 @@ static int cs4270_i2c_resume(struct i2c_client *client)
 #else
 #define cs4270_i2c_suspend	NULL
 #define cs4270_i2c_resume	NULL
+#define cs4270_soc_suspend	NULL
+#define cs4270_soc_resume	NULL
 #endif /* CONFIG_PM */
 
 /*
@@ -868,7 +885,9 @@ static struct i2c_driver cs4270_i2c_driver = {
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
