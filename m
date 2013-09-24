From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: tlv320aic23: Convert to direct
	regmap API usage
Date: Tue, 24 Sep 2013 19:27:18 +0100
Message-ID: <1380047238-16909-3-git-send-email-broonie@kernel.org>
References: <1380047238-16909-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 20216261A9D
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 20:27:27 +0200 (CEST)
In-Reply-To: <1380047238-16909-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This moves us towards being able to remove the duplicated register I/O
code in ASoC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic23.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 3a6be8c..f961e1e 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -37,11 +38,27 @@
 /*
  * AIC23 register cache
  */
-static const u16 tlv320aic23_reg[] = {
-	0x0097, 0x0097, 0x00F9, 0x00F9,	/* 0 */
-	0x001A, 0x0004, 0x0007, 0x0001,	/* 4 */
-	0x0020, 0x0000, 0x0000, 0x0000,	/* 8 */
-	0x0000, 0x0000, 0x0000, 0x0000,	/* 12 */
+static const struct reg_default tlv320aic23_reg[] = {
+	{  0, 0x0097 },
+	{  1, 0x0097 },
+	{  2, 0x00F9 },
+	{  3, 0x00F9 },
+	{  4, 0x001A },
+	{  5, 0x0004 },
+	{  6, 0x0007 },
+	{  7, 0x0001 },
+	{  8, 0x0020 },
+	{  9, 0x0000 },
+};
+
+static const struct regmap_config tlv320aic23_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = TLV320AIC23_RESET,
+	.reg_defaults = tlv320aic23_reg,
+	.num_reg_defaults = ARRAY_SIZE(tlv320aic23_reg),
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static const char *rec_src_text[] = { "Line", "Mic" };
@@ -171,7 +188,7 @@ static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
 
 /* AIC23 driver data */
 struct aic23 {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int mclk;
 	int requested_adc;
 	int requested_dac;
@@ -532,7 +549,9 @@ static int tlv320aic23_suspend(struct snd_soc_codec *codec)
 
 static int tlv320aic23_resume(struct snd_soc_codec *codec)
 {
-	snd_soc_cache_sync(codec);
+	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
+	regcache_mark_dirty(aic23->regmap);
+	regcache_sync(aic23->regmap);
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -543,7 +562,7 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, aic23->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -552,16 +571,6 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 	/* Reset codec */
 	snd_soc_write(codec, TLV320AIC23_RESET, 0);
 
-	/* Write the register default value to cache for reserved registers,
-	 * so the write to the these registers are suppressed by the cache
-	 * restore code when it skips writes of default registers.
-	 */
-	snd_soc_cache_write(codec, 0x0A, 0);
-	snd_soc_cache_write(codec, 0x0B, 0);
-	snd_soc_cache_write(codec, 0x0C, 0);
-	snd_soc_cache_write(codec, 0x0D, 0);
-	snd_soc_cache_write(codec, 0x0E, 0);
-
 	/* power on device */
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -596,9 +605,6 @@ static int tlv320aic23_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
-	.reg_cache_size = ARRAY_SIZE(tlv320aic23_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = tlv320aic23_reg,
 	.probe = tlv320aic23_probe,
 	.remove = tlv320aic23_remove,
 	.suspend = tlv320aic23_suspend,
@@ -629,8 +635,11 @@ static int tlv320aic23_codec_probe(struct i2c_client *i2c,
 	if (aic23 == NULL)
 		return -ENOMEM;
 
+	aic23->regmap = devm_regmap_init_i2c(i2c, &tlv320aic23_regmap);
+	if (IS_ERR(aic23->regmap))
+		return PTR_ERR(aic23->regmap);
+
 	i2c_set_clientdata(i2c, aic23);
-	aic23->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_tlv320aic23, &tlv320aic23_dai, 1);
-- 
1.8.4.rc3
