From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8974: Convert to direct regmap API
	usage
Date: Fri,  8 Nov 2013 14:02:06 +0000
Message-ID: <1383919326-13470-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F0944265704
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 15:02:15 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Moves us towards removing the ASoC level I/O functions.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8974.c | 54 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index a2d01d1..15f45c7 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -27,22 +28,22 @@
 
 #include "wm8974.h"
 
-static const u16 wm8974_reg[WM8974_CACHEREGNUM] = {
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0050, 0x0000, 0x0140, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x00ff,
-	0x0000, 0x0000, 0x0100, 0x00ff,
-	0x0000, 0x0000, 0x012c, 0x002c,
-	0x002c, 0x002c, 0x002c, 0x0000,
-	0x0032, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0038, 0x000b, 0x0032, 0x0000,
-	0x0008, 0x000c, 0x0093, 0x00e9,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0003, 0x0010, 0x0000, 0x0000,
-	0x0000, 0x0002, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0039, 0x0000,
-	0x0000,
+static const struct reg_default wm8974_reg_defaults[] = {
+	{  0, 0x0000 }, {  1, 0x0000 }, {  2, 0x0000 }, {  3, 0x0000 },
+	{  4, 0x0050 }, {  5, 0x0000 }, {  6, 0x0140 }, {  7, 0x0000 },
+	{  8, 0x0000 }, {  9, 0x0000 }, { 10, 0x0000 }, { 11, 0x00ff },
+	{ 12, 0x0000 }, { 13, 0x0000 }, { 14, 0x0100 }, { 15, 0x00ff },
+	{ 16, 0x0000 }, { 17, 0x0000 }, { 18, 0x012c }, { 19, 0x002c },
+	{ 20, 0x002c }, { 21, 0x002c }, { 22, 0x002c }, { 23, 0x0000 },
+	{ 24, 0x0032 }, { 25, 0x0000 }, { 26, 0x0000 }, { 27, 0x0000 },
+	{ 28, 0x0000 }, { 29, 0x0000 }, { 30, 0x0000 }, { 31, 0x0000 },
+	{ 32, 0x0038 }, { 33, 0x000b }, { 34, 0x0032 }, { 35, 0x0000 },
+	{ 36, 0x0008 }, { 37, 0x000c }, { 38, 0x0093 }, { 39, 0x00e9 },
+	{ 40, 0x0000 }, { 41, 0x0000 }, { 42, 0x0000 }, { 43, 0x0000 },
+	{ 44, 0x0003 }, { 45, 0x0010 }, { 46, 0x0000 }, { 47, 0x0000 },
+	{ 48, 0x0000 }, { 49, 0x0002 }, { 50, 0x0000 }, { 51, 0x0000 },
+	{ 52, 0x0000 }, { 53, 0x0000 }, { 54, 0x0039 }, { 55, 0x0000 },
+	{ 56, 0x0000 },
 };
 
 #define WM8974_POWER1_BIASEN  0x08
@@ -514,7 +515,7 @@ static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 		power1 |= WM8974_POWER1_BIASEN | WM8974_POWER1_BUFIOEN;
 
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(dev_get_regmap(codec->dev, NULL));
 
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8974_POWER1, power1 | 0x3);
@@ -579,11 +580,20 @@ static int wm8974_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static const struct regmap_config wm8974_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = WM8974_MONOMIX,
+	.reg_defaults = wm8974_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8974_reg_defaults),
+};
+
 static int wm8974_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -613,9 +623,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.suspend = 	wm8974_suspend,
 	.resume =	wm8974_resume,
 	.set_bias_level = wm8974_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8974_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8974_reg,
 
 	.controls = wm8974_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8974_snd_controls),
@@ -628,8 +635,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 static int wm8974_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
+	struct regmap *regmap;
 	int ret;
 
+	regmap = devm_regmap_init_i2c(i2c, &wm8974_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8974, &wm8974_dai, 1);
 
-- 
1.8.4.2
