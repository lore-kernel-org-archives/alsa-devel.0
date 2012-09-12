From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8711: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 12:16:06 +0800
Message-ID: <1347423366-8490-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 727D8261657
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:21:40 +0200 (CEST)
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
 sound/soc/codecs/wm8711.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 1b1209a..5c165d0 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -32,7 +33,7 @@
 
 /* codec private data */
 struct wm8711_priv {
-	enum snd_soc_control_type bus_type;
+	struct regmap *regmap;
 	unsigned int sysclk;
 };
 
@@ -42,9 +43,9 @@ struct wm8711_priv {
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 wm8711_reg[WM8711_CACHEREGNUM] = {
-	0x0079, 0x0079, 0x000a, 0x0008,
-	0x009f, 0x000a, 0x0000, 0x0000
+static const struct reg_default wm8711_reg_defaults[] = {
+	{ 0, 0x0079 }, { 1, 0x0079 }, { 2, 0x000a }, { 3, 0x0008 },
+	{ 4, 0x009f }, { 5, 0x000a }, { 6, 0x0000 }, { 7, 0x0000 },
 };
 
 #define wm8711_reset(c)	snd_soc_write(c, WM8711_RESET, 0)
@@ -289,6 +290,7 @@ static int wm8711_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int wm8711_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
 	u16 reg = snd_soc_read(codec, WM8711_PWR) & 0xff7f;
 
 	switch (level) {
@@ -299,7 +301,7 @@ static int wm8711_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8711->regmap);
 
 		snd_soc_write(codec, WM8711_PWR, reg | 0x0040);
 		break;
@@ -353,10 +355,9 @@ static int wm8711_resume(struct snd_soc_codec *codec)
 
 static int wm8711_probe(struct snd_soc_codec *codec)
 {
-	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8711->bus_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -391,9 +392,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.suspend =	wm8711_suspend,
 	.resume =	wm8711_resume,
 	.set_bias_level = wm8711_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8711_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8711_reg,
 	.controls = wm8711_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8711_snd_controls),
 	.dapm_widgets = wm8711_dapm_widgets,
@@ -408,6 +406,16 @@ static const struct of_device_id wm8711_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8711_of_match);
 
+static const struct regmap_config wm8711_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8711_RESET,
+
+	.reg_defaults = wm8711_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8711_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8711_spi_probe(struct spi_device *spi)
 {
@@ -419,8 +427,11 @@ static int __devinit wm8711_spi_probe(struct spi_device *spi)
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
+	wm8711->regmap = devm_regmap_init_spi(spi, &wm8711_regmap);
+	if (IS_ERR(wm8711->regmap))
+		return PTR_ERR(wm8711->regmap);
+
 	spi_set_drvdata(spi, wm8711);
-	wm8711->bus_type = SND_SOC_SPI;
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8711, &wm8711_dai, 1);
@@ -458,8 +469,11 @@ static __devinit int wm8711_i2c_probe(struct i2c_client *client,
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
+	wm8711->regmap = devm_regmap_init_i2c(client, &wm8711_regmap);
+	if (IS_ERR(wm8711->regmap))
+		return PTR_ERR(wm8711->regmap);
+
 	i2c_set_clientdata(client, wm8711);
-	wm8711->bus_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_wm8711, &wm8711_dai, 1);
-- 
1.7.10.4
