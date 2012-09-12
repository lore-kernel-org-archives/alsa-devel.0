From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8776: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 20:16:14 +0800
Message-ID: <1347452175-30506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2CC30261694
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 14:16:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8776.c |   75 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 879c356..c32249d 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -37,18 +38,46 @@ enum wm8776_chip_type {
 
 /* codec private data */
 struct wm8776_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int sysclk[2];
 };
 
-static const u16 wm8776_reg[WM8776_CACHEREGNUM] = {
-	0x79, 0x79, 0x79, 0xff, 0xff,  /* 4 */
-	0xff, 0x00, 0x90, 0x00, 0x00,  /* 9 */
-	0x22, 0x22, 0x22, 0x08, 0xcf,  /* 14 */
-	0xcf, 0x7b, 0x00, 0x32, 0x00,  /* 19 */
-	0xa6, 0x01, 0x01
+static const struct reg_default wm8776_reg_defaults[] = {
+	{  0, 0x79 },
+	{  1, 0x79 },
+	{  2, 0x79 },
+	{  3, 0xff },
+	{  4, 0xff },
+	{  5, 0xff },
+	{  6, 0x00 },
+	{  7, 0x90 },
+	{  8, 0x00 },
+	{  9, 0x00 },
+	{ 10, 0x22 },
+	{ 11, 0x22 },
+	{ 12, 0x22 },
+	{ 13, 0x08 },
+	{ 14, 0xcf },
+	{ 15, 0xcf },
+	{ 16, 0x7b },
+	{ 17, 0x00 },
+	{ 18, 0x32 },
+	{ 19, 0x00 },
+	{ 20, 0xa6 },
+	{ 21, 0x01 },
+	{ 22, 0x01 },
 };
 
+static bool wm8776_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8776_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int wm8776_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8776_RESET, 0);
@@ -306,6 +335,8 @@ static int wm8776_set_sysclk(struct snd_soc_dai *dai,
 static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -313,7 +344,7 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8776->regmap);
 
 			/* Disable the global powerdown; DAPM does the rest */
 			snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 0);
@@ -396,10 +427,9 @@ static int wm8776_resume(struct snd_soc_codec *codec)
 
 static int wm8776_probe(struct snd_soc_codec *codec)
 {
-	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8776->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -434,9 +464,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.suspend = 	wm8776_suspend,
 	.resume =	wm8776_resume,
 	.set_bias_level = wm8776_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8776_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8776_reg,
 
 	.controls = wm8776_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8776_snd_controls),
@@ -452,6 +479,18 @@ static const struct of_device_id wm8776_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8776_of_match);
 
+static const struct regmap_config wm8776_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8776_RESET,
+
+	.reg_defaults = wm8776_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8776_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8776_volatile,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8776_spi_probe(struct spi_device *spi)
 {
@@ -463,7 +502,10 @@ static int __devinit wm8776_spi_probe(struct spi_device *spi)
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
-	wm8776->control_type = SND_SOC_SPI;
+	wm8776->regmap = devm_regmap_init_spi(spi, &wm8776_regmap);
+	if (IS_ERR(wm8776->regmap))
+		return PTR_ERR(wm8776->regmap);
+
 	spi_set_drvdata(spi, wm8776);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -501,8 +543,11 @@ static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
+	wm8776->regmap = devm_regmap_init_i2c(i2c, &wm8776_regmap);
+	if (IS_ERR(wm8776->regmap))
+		return PTR_ERR(wm8776->regmap);
+
 	i2c_set_clientdata(i2c, wm8776);
-	wm8776->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
-- 
1.7.10.4
