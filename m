From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: ab8500: Convert register I/O to
	regmap
Date: Fri, 20 Sep 2013 10:39:19 +0100
Message-ID: <1379669959-21517-3-git-send-email-broonie@kernel.org>
References: <1379669959-21517-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D27F261AF6
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 11:40:33 +0200 (CEST)
In-Reply-To: <1379669959-21517-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of a general push to eliminate the duplicated register I/O support
in ASoC convert ab8500 to use regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c | 64 +++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 7990217..ca500fd 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -126,6 +126,8 @@ struct ab8500_codec_drvdata_dbg {
 
 /* Private data for AB8500 device-driver */
 struct ab8500_codec_drvdata {
+	struct regmap *regmap;
+
 	/* Sidetone */
 	long *sid_fir_values;
 	enum sid_state sid_status;
@@ -166,49 +168,35 @@ static inline const char *amic_type_str(enum amic_type type)
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
+	struct device *dev = context;
 
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
-
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
@@ -2488,6 +2476,8 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 	/* Setup AB8500 according to board-settings */
 	pdata = dev_get_platdata(dev->parent);
 
+	codec->control_data = drvdata->regmap;
+
 	if (np) {
 		if (!pdata)
 			pdata = devm_kzalloc(dev,
@@ -2565,9 +2555,6 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver ab8500_codec_driver = {
 	.probe =		ab8500_codec_probe,
-	.read =			ab8500_codec_read_reg,
-	.write =		ab8500_codec_write_reg,
-	.reg_word_size =	sizeof(u8),
 	.controls =		ab8500_ctrls,
 	.num_controls =		ARRAY_SIZE(ab8500_ctrls),
 	.dapm_widgets =		ab8500_dapm_widgets,
@@ -2590,6 +2577,15 @@ static int ab8500_codec_driver_probe(struct platform_device *pdev)
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
1.8.4.rc3
