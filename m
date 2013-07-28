From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: lm4857: Convert to regmap
Date: Sun, 28 Jul 2013 18:45:29 +0200
Message-ID: <1375029929-19036-2-git-send-email-lars@metafoo.de>
References: <1375029929-19036-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-015.synserver.de
 [212.40.185.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B4226179C
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 18:44:37 +0200 (CEST)
In-Reply-To: <1375029929-19036-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use regmap for IO for the lm4857 driver instead of open-coding the IO read/write
functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm4857.c | 85 +++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 5ea2ed0..0e5743e 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <sound/core.h>
@@ -23,12 +24,15 @@
 #include <sound/tlv.h>
 
 struct lm4857 {
-	struct i2c_client *i2c;
+	struct regmap *regmap;
 	uint8_t mode;
 };
 
-static const uint8_t lm4857_default_regs[] = {
-	0x00, 0x00, 0x00, 0x00,
+static const struct reg_default lm4857_default_regs[] = {
+	{ 0x0, 0x00 },
+	{ 0x1, 0x00 },
+	{ 0x2, 0x00 },
+	{ 0x3, 0x00 },
 };
 
 /* The register offsets in the cache array */
@@ -42,39 +46,6 @@ static const uint8_t lm4857_default_regs[] = {
 #define LM4857_WAKEUP 5
 #define LM4857_EPGAIN 4
 
-static int lm4857_write(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int value)
-{
-	uint8_t data;
-	int ret;
-
-	ret = snd_soc_cache_write(codec, reg, value);
-	if (ret < 0)
-		return ret;
-
-	data = (reg << 6) | value;
-	ret = i2c_master_send(codec->control_data, &data, 1);
-	if (ret != 1) {
-		dev_err(codec->dev, "Failed to write register: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static unsigned int lm4857_read(struct snd_soc_codec *codec,
-		unsigned int reg)
-{
-	unsigned int val;
-	int ret;
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret)
-		return -1;
-
-	return val;
-}
-
 static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -96,7 +67,7 @@ static int lm4857_set_mode(struct snd_kcontrol *kcontrol,
 	lm4857->mode = value;
 
 	if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
-		snd_soc_update_bits(codec, LM4857_CTRL, 0x0F, value + 6);
+		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F, value + 6);
 
 	return 1;
 }
@@ -108,10 +79,11 @@ static int lm4857_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		snd_soc_update_bits(codec, LM4857_CTRL, 0x0F, lm4857->mode + 6);
+		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F,
+			lm4857->mode + 6);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_update_bits(codec, LM4857_CTRL, 0x0F, 0);
+		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F, 0);
 		break;
 	default:
 		break;
@@ -171,22 +143,7 @@ static const struct snd_soc_dapm_route lm4857_routes[] = {
 	{"EP", NULL, "IN"},
 };
 
-static int lm4857_probe(struct snd_soc_codec *codec)
-{
-	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
-
-	codec->control_data = lm4857->i2c;
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
-	.write = lm4857_write,
-	.read = lm4857_read,
-	.probe = lm4857_probe,
-	.reg_cache_size = ARRAY_SIZE(lm4857_default_regs),
-	.reg_word_size = sizeof(uint8_t),
-	.reg_cache_default = lm4857_default_regs,
 	.set_bias_level = lm4857_set_bias_level,
 
 	.controls = lm4857_controls,
@@ -197,11 +154,21 @@ static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
 	.num_dapm_routes = ARRAY_SIZE(lm4857_routes),
 };
 
+static const struct regmap_config lm4857_regmap_config = {
+	.val_bits = 6,
+	.reg_bits = 2,
+
+	.max_register = LM4857_CTRL,
+
+	.cache_type = REGCACHE_FLAT,
+	.reg_defaults = lm4857_default_regs,
+	.num_reg_defaults = ARRAY_SIZE(lm4857_default_regs),
+};
+
 static int lm4857_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct lm4857 *lm4857;
-	int ret;
 
 	lm4857 = devm_kzalloc(&i2c->dev, sizeof(*lm4857), GFP_KERNEL);
 	if (!lm4857)
@@ -209,11 +176,11 @@ static int lm4857_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, lm4857);
 
-	lm4857->i2c = i2c;
-
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_lm4857, NULL, 0);
+	lm4857->regmap = devm_regmap_init_i2c(i2c, &lm4857_regmap_config);
+	if (IS_ERR(lm4857->regmap))
+		return PTR_ERR(lm4857->regmap);
 
-	return ret;
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_lm4857, NULL, 0);
 }
 
 static int lm4857_i2c_remove(struct i2c_client *i2c)
-- 
1.8.0
