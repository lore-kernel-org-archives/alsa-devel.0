From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ab8500-codec: Revert back to regmap
Date: Mon, 25 Aug 2014 10:20:44 +0200
Message-ID: <1408954845-19022-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 13AA0264F22
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 10:20:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Commit ff795d614bfa ("ASoC: ab8500: Convert register I/O to regmap")
initially converted the ab8500 CODEC driver to use regmap rather than
legacy ASoC IO. This was reverted though in commit 63e6d43bf80d ("ASoC:
ab8500: Revert to using custom I/O functions") since the inital conversion
was not working properly. This was presumebly because the SOC_SINGLE_XR_SX
controls, which are used by this driver, did not properly support regmap at
that point. This has since been fixed in commit 6137a5ca326d ("ASoC: Prepare
SOC_SINGLE_XR_SX controls for regmap"). So revert back to regmap again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I don't have the hardware, so I haven't been able to verify that it actually
works now, but I think there is a very good chance. Lee, do you have access
to a Snowball board and can give this a test?
---
 sound/soc/codecs/ab8500-codec.c | 62 +++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 62cf231..fd43827 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -125,6 +125,8 @@ struct ab8500_codec_drvdata_dbg {
 
 /* Private data for AB8500 device-driver */
 struct ab8500_codec_drvdata {
+	struct regmap *regmap;
+
 	/* Sidetone */
 	long *sid_fir_values;
 	enum sid_state sid_status;
@@ -165,49 +167,35 @@ static inline const char *amic_type_str(enum amic_type type)
  */
 
 /* Read a register from the audio-bank of AB8500 */
-static unsigned int ab8500_codec_read_reg(struct snd_soc_codec *codec,
-					unsigned int reg)
+static int ab8500_codec_read_reg(void *context, unsigned int reg,
+				 unsigned int *value)
 {
+	struct device *dev = context;
 	int status;
-	unsigned int value = 0;
 
 	u8 value8;
-	status = abx500_get_register_interruptible(codec->dev, AB8500_AUDIO,
-						reg, &value8);
-	if (status < 0) {
-		dev_err(codec->dev,
-			"%s: ERROR: Register (0x%02x:0x%02x) read failed (%d).\n",
-			__func__, (u8)AB8500_AUDIO, (u8)reg, status);
-	} else {
-		dev_dbg(codec->dev,
-			"%s: Read 0x%02x from register 0x%02x:0x%02x\n",
-			__func__, value8, (u8)AB8500_AUDIO, (u8)reg);
-		value = (unsigned int)value8;
-	}
+	status = abx500_get_register_interruptible(dev, AB8500_AUDIO,
+						   reg, &value8);
+	*value = (unsigned int)value8;
 
-	return value;
+	return status;
 }
 
 /* Write to a register in the audio-bank of AB8500 */
-static int ab8500_codec_write_reg(struct snd_soc_codec *codec,
-				unsigned int reg, unsigned int value)
+static int ab8500_codec_write_reg(void *context, unsigned int reg,
+				  unsigned int value)
 {
-	int status;
-
-	status = abx500_set_register_interruptible(codec->dev, AB8500_AUDIO,
-						reg, value);
-	if (status < 0)
-		dev_err(codec->dev,
-			"%s: ERROR: Register (%02x:%02x) write failed (%d).\n",
-			__func__, (u8)AB8500_AUDIO, (u8)reg, status);
-	else
-		dev_dbg(codec->dev,
-			"%s: Wrote 0x%02x into register %02x:%02x\n",
-			__func__, (u8)value, (u8)AB8500_AUDIO, (u8)reg);
+	struct device *dev = context;
 
-	return status;
+	return abx500_set_register_interruptible(dev, AB8500_AUDIO,
+						 reg, value);
 }
 
+static const struct regmap_config ab8500_codec_regmap = {
+	.reg_read = ab8500_codec_read_reg,
+	.reg_write = ab8500_codec_write_reg,
+};
+
 /*
  * Controls - DAPM
  */
@@ -2564,9 +2552,6 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver ab8500_codec_driver = {
 	.probe =		ab8500_codec_probe,
-	.read =			ab8500_codec_read_reg,
-	.write =		ab8500_codec_write_reg,
-	.reg_word_size =	sizeof(u8),
 	.controls =		ab8500_ctrls,
 	.num_controls =		ARRAY_SIZE(ab8500_ctrls),
 	.dapm_widgets =		ab8500_dapm_widgets,
@@ -2591,6 +2576,15 @@ static int ab8500_codec_driver_probe(struct platform_device *pdev)
 	drvdata->anc_status = ANC_UNCONFIGURED;
 	dev_set_drvdata(&pdev->dev, drvdata);
 
+	drvdata->regmap = devm_regmap_init(&pdev->dev, NULL, &pdev->dev,
+					   &ab8500_codec_regmap);
+	if (IS_ERR(drvdata->regmap)) {
+		status = PTR_ERR(drvdata->regmap);
+		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
+			__func__, status);
+		return status;
+	}
+
 	dev_dbg(&pdev->dev, "%s: Register codec.\n", __func__);
 	status = snd_soc_register_codec(&pdev->dev, &ab8500_codec_driver,
 				ab8500_codec_dai,
-- 
1.8.0
