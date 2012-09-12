From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8510: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 11:57:49 +0800
Message-ID: <1347422270-3249-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA0CA2615F0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 05:57:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |  105 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 98f28a0..d9a3ca6 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -33,22 +34,63 @@
  * We can't read the WM8510 register space when we are
  * using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
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
-	0x0000, 0x0002, 0x0001, 0x0000,
-	0x0000, 0x0000, 0x0039, 0x0000,
-	0x0001,
+static const struct reg_default wm8510_reg_defaults[] = {
+	{  1, 0x0000 },
+	{  2, 0x0000 },
+	{  3, 0x0000 },
+	{  4, 0x0050 },
+	{  5, 0x0000 },
+	{  6, 0x0140 },
+	{  7, 0x0000 },
+	{  8, 0x0000 },
+	{  9, 0x0000 },
+	{ 10, 0x0000 },
+	{ 11, 0x00ff },
+	{ 12, 0x0000 },
+	{ 13, 0x0000 },
+	{ 14, 0x0100 },
+	{ 15, 0x00ff },
+	{ 16, 0x0000 },
+	{ 17, 0x0000 },
+	{ 18, 0x012c },
+	{ 19, 0x002c },
+	{ 20, 0x002c },
+	{ 21, 0x002c },
+	{ 22, 0x002c },
+	{ 23, 0x0000 },
+	{ 24, 0x0032 },
+	{ 25, 0x0000 },
+	{ 26, 0x0000 },
+	{ 27, 0x0000 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0038 },
+	{ 33, 0x000b },
+	{ 34, 0x0032 },
+	{ 35, 0x0000 },
+	{ 36, 0x0008 },
+	{ 37, 0x000c },
+	{ 38, 0x0093 },
+	{ 39, 0x00e9 },
+	{ 40, 0x0000 },
+	{ 41, 0x0000 },
+	{ 42, 0x0000 },
+	{ 43, 0x0000 },
+	{ 44, 0x0003 },
+	{ 45, 0x0010 },
+	{ 46, 0x0000 },
+	{ 47, 0x0000 },
+	{ 48, 0x0000 },
+	{ 49, 0x0002 },
+	{ 50, 0x0001 },
+	{ 51, 0x0000 },
+	{ 52, 0x0000 },
+	{ 53, 0x0000 },
+	{ 54, 0x0039 },
+	{ 55, 0x0000 },
+	{ 56, 0x0001 },
 };
 
 #define WM8510_POWER1_BIASEN  0x08
@@ -58,7 +100,7 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 
 /* codec private data */
 struct wm8510_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 };
 
 static const char *wm8510_companding[] = { "Off", "NC", "u-law", "A-law" };
@@ -454,6 +496,7 @@ static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
 	u16 power1 = snd_soc_read(codec, WM8510_POWER1) & ~0x3;
 
 	switch (level) {
@@ -467,7 +510,7 @@ static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 		power1 |= WM8510_POWER1_BIASEN | WM8510_POWER1_BUFIOEN;
 
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8510->regmap);
 
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8510_POWER1, power1 | 0x3);
@@ -536,10 +579,9 @@ static int wm8510_resume(struct snd_soc_codec *codec)
 
 static int wm8510_probe(struct snd_soc_codec *codec)
 {
-	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9,  wm8510->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -569,9 +611,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
 	.suspend =	wm8510_suspend,
 	.resume =	wm8510_resume,
 	.set_bias_level = wm8510_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8510_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default =wm8510_reg,
 
 	.controls = wm8510_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8510_snd_controls),
@@ -586,6 +625,16 @@ static const struct of_device_id wm8510_of_match[] = {
 	{ },
 };
 
+static const struct regmap_config wm8510_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8510_MONOMIX,
+
+	.reg_defaults = wm8510_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8510_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8510_spi_probe(struct spi_device *spi)
 {
@@ -597,7 +646,10 @@ static int __devinit wm8510_spi_probe(struct spi_device *spi)
 	if (wm8510 == NULL)
 		return -ENOMEM;
 
-	wm8510->control_type = SND_SOC_SPI;
+	wm8510->regmap = devm_regmap_init_spi(spi, &wm8510_regmap);
+	if (IS_ERR(wm8510->regmap))
+		return PTR_ERR(wm8510->regmap);
+
 	spi_set_drvdata(spi, wm8510);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -635,8 +687,11 @@ static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
 	if (wm8510 == NULL)
 		return -ENOMEM;
 
+	wm8510->regmap = devm_regmap_init_i2c(i2c, &wm8510_regmap);
+	if (IS_ERR(wm8510->regmap))
+		return PTR_ERR(wm8510->regmap);
+
 	i2c_set_clientdata(i2c, wm8510);
-	wm8510->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8510, &wm8510_dai, 1);
-- 
1.7.10.4
