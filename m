From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max9850: Convert to direct regmap API
	usage
Date: Mon, 23 Sep 2013 18:16:12 +0100
Message-ID: <1379956572-15885-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 390DB2610AC
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 19:17:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Glindkamp <christian.glindkamp@taskit.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This prepares for removal of the duplicated register I/O functionality in
ASoC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max9850.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 58c38a5..c5dd617 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -27,18 +28,26 @@
 #include "max9850.h"
 
 struct max9850_priv {
+	struct regmap *regmap;
 	unsigned int sysclk;
 };
 
 /* max9850 register cache */
-static const u8 max9850_reg[MAX9850_CACHEREGNUM] = {
-	0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+static const struct reg_default max9850_reg[] = {
+	{  2, 0x0c },
+	{  3, 0x00 },
+	{  4, 0x00 },
+	{  5, 0x00 },
+	{  6, 0x00 },
+	{  7, 0x00 },
+	{  8, 0x00 },
+	{  9, 0x00 },
+	{ 10, 0x00 },
 };
 
 /* these registers are not used at the moment but provided for the sake of
  * completeness */
-static int max9850_volatile_register(struct snd_soc_codec *codec,
-		unsigned int reg)
+static bool max9850_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX9850_STATUSA:
@@ -49,6 +58,15 @@ static int max9850_volatile_register(struct snd_soc_codec *codec,
 	}
 }
 
+static const struct regmap_config max9850_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MAX9850_DIGITAL_AUDIO,
+	.volatile_reg = max9850_volatile_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static const unsigned int max9850_tlv[] = {
 	TLV_DB_RANGE_HEAD(4),
 	0x18, 0x1f, TLV_DB_SCALE_ITEM(-7450, 400, 0),
@@ -225,6 +243,7 @@ static int max9850_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 static int max9850_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
+	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
@@ -234,7 +253,7 @@ static int max9850_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(max9850->regmap);
 			if (ret) {
 				dev_err(codec->dev,
 					"Failed to sync cache: %d\n", ret);
@@ -295,7 +314,7 @@ static int max9850_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -316,10 +335,6 @@ static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
 	.suspend =	max9850_suspend,
 	.resume =	max9850_resume,
 	.set_bias_level = max9850_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(max9850_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = max9850_reg,
-	.volatile_register = max9850_volatile_register,
 
 	.controls = max9850_controls,
 	.num_controls = ARRAY_SIZE(max9850_controls),
@@ -340,6 +355,10 @@ static int max9850_i2c_probe(struct i2c_client *i2c,
 	if (max9850 == NULL)
 		return -ENOMEM;
 
+	max9850->regmap = devm_regmap_init_i2c(i2c, &max9850_regmap);
+	if (IS_ERR(max9850->regmap))
+		return PTR_ERR(max9850->regmap);
+
 	i2c_set_clientdata(i2c, max9850);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.8.4.rc3
