From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8750: Convert to direct regmap API
	usage
Date: Wed, 10 Oct 2012 21:55:42 +0900
Message-ID: <1349873742-2968-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EDBD265095
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:26 +0200 (CEST)
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
 sound/soc/codecs/wm8750.c |   86 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 89151ca..7665d68 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -34,24 +35,55 @@
  * We can't read the WM8750 register space when we
  * are using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8750_reg[] = {
-	0x0097, 0x0097, 0x0079, 0x0079,  /*  0 */
-	0x0000, 0x0008, 0x0000, 0x000a,  /*  4 */
-	0x0000, 0x0000, 0x00ff, 0x00ff,  /*  8 */
-	0x000f, 0x000f, 0x0000, 0x0000,  /* 12 */
-	0x0000, 0x007b, 0x0000, 0x0032,  /* 16 */
-	0x0000, 0x00c3, 0x00c3, 0x00c0,  /* 20 */
-	0x0000, 0x0000, 0x0000, 0x0000,  /* 24 */
-	0x0000, 0x0000, 0x0000, 0x0000,  /* 28 */
-	0x0000, 0x0000, 0x0050, 0x0050,  /* 32 */
-	0x0050, 0x0050, 0x0050, 0x0050,  /* 36 */
-	0x0079, 0x0079, 0x0079,          /* 40 */
+static const struct reg_default wm8750_reg_defaults[] = {
+	{  0, 0x0097 },
+	{  1, 0x0097 },
+	{  2, 0x0079 },
+	{  3, 0x0079 },
+	{  4, 0x0000 },
+	{  5, 0x0008 },
+	{  6, 0x0000 },
+	{  7, 0x000a },
+	{  8, 0x0000 },
+	{  9, 0x0000 },
+	{ 10, 0x00ff },
+	{ 11, 0x00ff },
+	{ 12, 0x000f },
+	{ 13, 0x000f },
+	{ 14, 0x0000 },
+	{ 15, 0x0000 },
+	{ 16, 0x0000 },
+	{ 17, 0x007b },
+	{ 18, 0x0000 },
+	{ 19, 0x0032 },
+	{ 20, 0x0000 },
+	{ 21, 0x00c3 },
+	{ 22, 0x00c3 },
+	{ 23, 0x00c0 },
+	{ 24, 0x0000 },
+	{ 25, 0x0000 },
+	{ 26, 0x0000 },
+	{ 27, 0x0000 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0050 },
+	{ 35, 0x0050 },
+	{ 36, 0x0050 },
+	{ 37, 0x0050 },
+	{ 38, 0x0050 },
+	{ 39, 0x0050 },
+	{ 40, 0x0079 },
+	{ 41, 0x0079 },
+	{ 42, 0x0079 },
 };
 
 /* codec private data */
 struct wm8750_priv {
 	unsigned int sysclk;
-	enum snd_soc_control_type control_type;
 };
 
 #define wm8750_reset(c)	snd_soc_write(c, WM8750_RESET, 0)
@@ -668,10 +700,9 @@ static int wm8750_resume(struct snd_soc_codec *codec)
 
 static int wm8750_probe(struct snd_soc_codec *codec)
 {
-	struct wm8750_priv *wm8750 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8750->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -711,9 +742,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.suspend =	wm8750_suspend,
 	.resume =	wm8750_resume,
 	.set_bias_level = wm8750_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8750_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8750_reg,
 
 	.controls = wm8750_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8750_snd_controls),
@@ -730,10 +758,21 @@ static const struct of_device_id wm8750_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8750_of_match);
 
+static const struct regmap_config wm8750_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8750_MOUTV,
+
+	.reg_defaults = wm8750_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8750_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8750_spi_probe(struct spi_device *spi)
 {
 	struct wm8750_priv *wm8750;
+	struct regmap *regmap;
 	int ret;
 
 	wm8750 = devm_kzalloc(&spi->dev, sizeof(struct wm8750_priv),
@@ -741,7 +780,10 @@ static int __devinit wm8750_spi_probe(struct spi_device *spi)
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
-	wm8750->control_type = SND_SOC_SPI;
+	regmap = devm_regmap_init_spi(spi, &wm8750_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	spi_set_drvdata(spi, wm8750);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -779,6 +821,7 @@ static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8750_priv *wm8750;
+	struct regmap *regmap;
 	int ret;
 
 	wm8750 = devm_kzalloc(&i2c->dev, sizeof(struct wm8750_priv),
@@ -787,7 +830,10 @@ static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8750);
-	wm8750->control_type = SND_SOC_I2C;
+
+	regmap = devm_regmap_init_i2c(i2c, &wm8750_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8750, &wm8750_dai, 1);
-- 
1.7.10.4
