From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoc: Add regulator support to CS4270
	codec driver
Date: Wed, 25 Nov 2009 15:36:27 +0100
Message-ID: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D0AE42434C
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 15:36:37 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8069023..b1d4b5d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -28,6 +28,7 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs4270.h"
 
@@ -114,6 +115,7 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
 	unsigned int manual_mute;
+	struct regulator *va_reg;
 };
 
 /**
@@ -462,27 +464,38 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
  * @dai: the SOC DAI
  * @mute: 0 = disable mute, 1 = enable mute
  *
- * This function toggles the mute bits in the MUTE register.  The CS4270's
+ * This function toggles the mute bits in the MUTE register and switches
+ * the registered VA power regulator, if it was registered. The CS4270's
  * mute capability is intended for external muting circuitry, so if the
  * board does not have the MUTEA or MUTEB pins connected to such circuitry,
- * then this function will do nothing.
+ * and no power regulator was specified, then this function will do nothing.
  */
 static int cs4270_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct cs4270_private *cs4270 = codec->private_data;
-	int reg6;
+	int reg6, err;
 
 	reg6 = snd_soc_read(codec, CS4270_MUTE);
 
 	if (mute)
 		reg6 |= CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
 	else {
+		if (cs4270->va_reg)
+			regulator_enable(cs4270->va_reg);
+
 		reg6 &= ~(CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B);
 		reg6 |= cs4270->manual_mute;
 	}
 
-	return snd_soc_write(codec, CS4270_MUTE, reg6);
+	err = snd_soc_write(codec, CS4270_MUTE, reg6);
+	if (err)
+		return err;
+
+	if (cs4270->va_reg && mute)
+		regulator_disable(cs4270->va_reg);
+
+	return 0;
 }
 
 /**
@@ -579,6 +592,7 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	int ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
@@ -606,6 +620,14 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_pcms;
 	}
 
+#ifdef CONFIG_REGULATOR
+	/* get the regulator if there is one read<y for us */
+	cs4270->va_reg = regulator_get(&pdev->dev, "va");
+
+	if (IS_ERR(cs4270->va_reg))
+		cs4270->va_reg = NULL;
+#endif
+
 	return 0;
 
 error_free_pcms:
@@ -623,9 +645,14 @@ error_free_pcms:
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
 
+	if (cs4270->va_reg)
+		regulator_put(cs4270->va_reg);
+
 	return 0;
 };
 
-- 
1.6.5.2
