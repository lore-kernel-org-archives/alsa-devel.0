From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8900: Convert to direct regmap API
	usage
Date: Tue, 11 Sep 2012 09:27:12 +0800
Message-ID: <1347326833-2019-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347326833-2019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1413264F02
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 03:27:20 +0200 (CEST)
In-Reply-To: <1347326833-2019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8900.c |  148 +++++++++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 5f7a78e..5bc877b 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -137,7 +138,7 @@
 #define WM8900_LRC_MASK 0x03ff
 
 struct wm8900_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 
 	u32 fll_in; /* FLL input frequency */
 	u32 fll_out; /* FLL output frequency */
@@ -147,54 +148,77 @@ struct wm8900_priv {
  * wm8900 register cache.  We can't read the entire register space and we
  * have slow control buses so we cache the registers.
  */
-static const u16 wm8900_reg_defaults[WM8900_MAXREG] = {
-	0x8900, 0x0000,
-	0xc000, 0x0000,
-	0x4050, 0x4000,
-	0x0008, 0x0000,
-	0x0040, 0x0040,
-	0x1004, 0x00c0,
-	0x00c0, 0x0000,
-	0x0100, 0x00c0,
-	0x00c0, 0x0000,
-	0xb001, 0x0000,
-	0x0000, 0x0044,
-	0x004c, 0x004c,
-	0x0044, 0x0044,
-	0x0000, 0x0044,
-	0x0000, 0x0000,
-	0x0002, 0x0000,
-	0x0000, 0x0000,
-	0x0000, 0x0000,
-	0x0008, 0x0000,
-	0x0000, 0x0008,
-	0x0097, 0x0100,
-	0x0000, 0x0000,
-	0x0050, 0x0050,
-	0x0055, 0x0055,
-	0x0055, 0x0000,
-	0x0000, 0x0079,
-	0x0079, 0x0079,
-	0x0079, 0x0000,
-	/* Remaining registers all zero */
+static const struct reg_default wm8900_reg_defaults[] = {
+	{  1, 0x0000 },
+	{  2, 0xc000 },
+	{  3, 0x0000 },
+	{  4, 0x4050 },
+	{  5, 0x4000 },
+	{  6, 0x0008 },
+	{  7, 0x0000 },
+	{  8, 0x0040 },
+	{  9, 0x0040 },
+	{ 10, 0x1004 },
+	{ 11, 0x00c0 },
+	{ 12, 0x00c0 },
+	{ 13, 0x0000 },
+	{ 14, 0x0100 },
+	{ 15, 0x00c0 },
+	{ 16, 0x00c0 },
+	{ 17, 0x0000 },
+	{ 18, 0xb001 },
+	{ 19, 0x0000 },
+	{ 20, 0x0000 },
+	{ 21, 0x0044 },
+	{ 22, 0x004c },
+	{ 23, 0x004c },
+	{ 24, 0x0044 },
+	{ 25, 0x0044 },
+	{ 26, 0x0000 },
+	{ 27, 0x0044 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0002 },
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0000 },
+	{ 35, 0x0000 },
+	{ 36, 0x0008 },
+	{ 37, 0x0000 },
+	{ 38, 0x0000 },
+	{ 39, 0x0008 },
+	{ 40, 0x0097 },
+	{ 41, 0x0100 },
+	{ 42, 0x0000 },
+	{ 43, 0x0000 },
+	{ 44, 0x0050 },
+	{ 45, 0x0050 },
+	{ 46, 0x0055 },
+	{ 47, 0x0055 },
+	{ 48, 0x0055 },
+	{ 49, 0x0000 },
+	{ 50, 0x0000 },
+	{ 51, 0x0079 },
+	{ 52, 0x0079 },
+	{ 53, 0x0079 },
+	{ 54, 0x0079 },
+	{ 55, 0x0000 },
 };
 
-static int wm8900_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8900_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8900_REG_ID:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
 static void wm8900_reset(struct snd_soc_codec *codec)
 {
 	snd_soc_write(codec, WM8900_REG_RESET, 0);
-
-	memcpy(codec->reg_cache, wm8900_reg_defaults,
-	       sizeof(wm8900_reg_defaults));
 }
 
 static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
@@ -1119,13 +1143,16 @@ static int wm8900_suspend(struct snd_soc_codec *codec)
 static int wm8900_resume(struct snd_soc_codec *codec)
 {
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache;
-	int i, ret;
-
-	cache = kmemdup(codec->reg_cache, sizeof(wm8900_reg_defaults),
-			GFP_KERNEL);
+	int ret;
 
 	wm8900_reset(codec);
+
+	ret = regcache_sync(wm8900->regmap);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to restore cache: %d\n", ret);
+		return ret;
+	}
+
 	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Restart the FLL? */
@@ -1139,27 +1166,18 @@ static int wm8900_resume(struct snd_soc_codec *codec)
 		ret = wm8900_set_fll(codec, 0, fll_in, fll_out);
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to restart FLL\n");
-			kfree(cache);
 			return ret;
 		}
 	}
 
-	if (cache) {
-		for (i = 0; i < WM8900_MAXREG; i++)
-			snd_soc_write(codec, i, cache[i]);
-		kfree(cache);
-	} else
-		dev_err(codec->dev, "Unable to allocate register cache\n");
-
 	return 0;
 }
 
 static int wm8900_probe(struct snd_soc_codec *codec)
 {
-	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8900->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1207,10 +1225,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.suspend =	wm8900_suspend,
 	.resume =	wm8900_resume,
 	.set_bias_level = wm8900_set_bias_level,
-	.volatile_register = wm8900_volatile_register,
-	.reg_cache_size = ARRAY_SIZE(wm8900_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8900_reg_defaults,
 
 	.controls = wm8900_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8900_snd_controls),
@@ -1220,6 +1234,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8900_dapm_routes),
 };
 
+static const struct regmap_config wm8900_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = WM8900_MAXREG,
+
+	.reg_defaults = wm8900_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8900_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8900_volatile_register,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8900_spi_probe(struct spi_device *spi)
 {
@@ -1231,7 +1257,10 @@ static int __devinit wm8900_spi_probe(struct spi_device *spi)
 	if (wm8900 == NULL)
 		return -ENOMEM;
 
-	wm8900->control_type = SND_SOC_SPI;
+	wm8900->regmap = devm_regmap_init_spi(spi, &wm8900_regmap);
+	if (IS_ERR(wm8900->regmap))
+		return PTR_ERR(wm8900->regmap);
+
 	spi_set_drvdata(spi, wm8900);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -1268,8 +1297,11 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 	if (wm8900 == NULL)
 		return -ENOMEM;
 
+	wm8900->regmap = devm_regmap_init_i2c(i2c, &wm8900_regmap);
+	if (IS_ERR(wm8900->regmap))
+		return PTR_ERR(wm8900->regmap);
+
 	i2c_set_clientdata(i2c, wm8900);
-	wm8900->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8900, &wm8900_dai, 1);
-- 
1.7.10.4
