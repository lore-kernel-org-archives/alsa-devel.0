From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8741: Convert to direct regmap API
	usage
Date: Mon, 10 Sep 2012 18:02:30 +0800
Message-ID: <1347271351-4087-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347271351-4087-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E936265062
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 12:02:43 +0200 (CEST)
In-Reply-To: <1347271351-4087-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8741.c |   86 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 742744b..4281a08 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -40,26 +41,43 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8741_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
-static const u16 wm8741_reg_defaults[WM8741_REGISTER_COUNT] = {
-	0x0000,     /* R0  - DACLLSB Attenuation */
-	0x0000,     /* R1  - DACLMSB Attenuation */
-	0x0000,     /* R2  - DACRLSB Attenuation */
-	0x0000,     /* R3  - DACRMSB Attenuation */
-	0x0000,     /* R4  - Volume Control */
-	0x000A,     /* R5  - Format Control */
-	0x0000,     /* R6  - Filter Control */
-	0x0000,     /* R7  - Mode Control 1 */
-	0x0002,     /* R8  - Mode Control 2 */
-	0x0000,	    /* R9  - Reset */
-	0x0002,     /* R32 - ADDITONAL_CONTROL_1 */
+static const struct reg_default wm8741_reg_defaults[] = {
+	{  0, 0x0000 },     /* R0  - DACLLSB Attenuation */
+	{  1, 0x0000 },     /* R1  - DACLMSB Attenuation */
+	{  2, 0x0000 },     /* R2  - DACRLSB Attenuation */
+	{  3, 0x0000 },     /* R3  - DACRMSB Attenuation */
+	{  4, 0x0000 },     /* R4  - Volume Control */
+	{  5, 0x000A },     /* R5  - Format Control */
+	{  6, 0x0000 },     /* R6  - Filter Control */
+	{  7, 0x0000 },     /* R7  - Mode Control 1 */
+	{  8, 0x0002 },     /* R8  - Mode Control 2 */
+	{ 32, 0x0002 },     /* R32 - ADDITONAL_CONTROL_1 */
 };
 
+static bool wm8741_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8741_DACLLSB_ATTENUATION:
+	case WM8741_DACLMSB_ATTENUATION:
+	case WM8741_DACRLSB_ATTENUATION:
+	case WM8741_DACRMSB_ATTENUATION:
+	case WM8741_VOLUME_CONTROL:
+	case WM8741_FORMAT_CONTROL:
+	case WM8741_FILTER_CONTROL:
+	case WM8741_MODE_CONTROL_1:
+	case WM8741_MODE_CONTROL_2:
+	case WM8741_ADDITIONAL_CONTROL_1:
+		return true;
+	default:
+		return false;
+	}
+}
 
 static int wm8741_reset(struct snd_soc_codec *codec)
 {
@@ -411,7 +429,7 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 		goto err_get;
 	}
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8741->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		goto err_enable;
@@ -439,7 +457,6 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 err_get:
-err:
 	return ret;
 }
 
@@ -456,9 +473,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.probe =	wm8741_probe,
 	.remove =	wm8741_remove,
 	.resume =	wm8741_resume,
-	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8741_reg_defaults,
 
 	.controls = wm8741_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8741_snd_controls),
@@ -474,6 +488,18 @@ static const struct of_device_id wm8741_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8741_of_match);
 
+static const struct regmap_config wm8741_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8741_MAX_REGISTER,
+
+	.reg_defaults = wm8741_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8741_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.readable_reg = wm8741_readable,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int wm8741_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -492,12 +518,18 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8741->supplies),
 				      wm8741->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	wm8741->regmap = regmap_init_i2c(i2c, &wm8741_regmap);
+	if (IS_ERR(wm8741->regmap)) {
+		ret = PTR_ERR(wm8741->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
 	}
 
 	i2c_set_clientdata(i2c, wm8741);
-	wm8741->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8741, &wm8741_dai, 1);
@@ -543,14 +575,20 @@ static int __devinit wm8741_spi_probe(struct spi_device *spi)
 	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
 		wm8741->supplies[i].supply = wm8741_supply_names[i];
 
-	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8741->supplies),
+	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(wm8741->supplies),
 				      wm8741->supplies);
 	if (ret != 0) {
 		dev_err(&spi->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
+	}
+
+	wm8741->regmap = regmap_init_spi(spi, &wm8741_regmap);
+	if (IS_ERR(wm8741->regmap)) {
+		ret = PTR_ERR(wm8741->regmap);
+		dev_err(&spi->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
 	}
 
-	wm8741->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8741);
 
 	ret = snd_soc_register_codec(&spi->dev,
-- 
1.7.10.4
