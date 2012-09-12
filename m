From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8728: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 12:32:21 +0800
Message-ID: <1347424341-10127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAB28261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:32:43 +0200 (CEST)
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
 sound/soc/codecs/wm8728.c |   45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index f274c25..00a12a0 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -35,16 +36,16 @@
  * the volume update bits, mute the output and enable infinite zero
  * detect.
  */
-static const u16 wm8728_reg_defaults[] = {
-	0x1ff,
-	0x1ff,
-	0x001,
-	0x100,
+static const struct reg_default wm8728_reg_defaults[] = {
+	{ 0, 0x1ff },
+	{ 1, 0x1ff },
+	{ 2, 0x001 },
+	{ 3, 0x100 },
 };
 
 /* codec private data */
 struct wm8728_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 };
 
 static const DECLARE_TLV_DB_SCALE(wm8728_tlv, -12750, 50, 1);
@@ -162,8 +163,8 @@ static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8728_priv *wm8728 = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
-	int i;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -175,9 +176,7 @@ static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_write(codec, WM8728_DACCTL, reg & ~0x4);
 
 			/* ..then sync in the register cache. */
-			for (i = 0; i < ARRAY_SIZE(wm8728_reg_defaults); i++)
-				snd_soc_write(codec, i,
-					     snd_soc_read(codec, i));
+			regcache_sync(wm8728->regmap);
 		}
 		break;
 
@@ -229,10 +228,9 @@ static int wm8728_resume(struct snd_soc_codec *codec)
 
 static int wm8728_probe(struct snd_soc_codec *codec)
 {
-	struct wm8728_priv *wm8728 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8728->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to configure cache I/O: %d\n",
 		       ret);
@@ -257,9 +255,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.suspend =	wm8728_suspend,
 	.resume =	wm8728_resume,
 	.set_bias_level = wm8728_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8728_reg_defaults,
 	.controls = wm8728_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8728_snd_controls),
 	.dapm_widgets = wm8728_dapm_widgets,
@@ -274,6 +269,16 @@ static const struct of_device_id wm8728_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8728_of_match);
 
+static const struct regmap_config wm8728_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8728_IFCTL,
+
+	.reg_defaults = wm8728_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8728_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8728_spi_probe(struct spi_device *spi)
 {
@@ -285,7 +290,10 @@ static int __devinit wm8728_spi_probe(struct spi_device *spi)
 	if (wm8728 == NULL)
 		return -ENOMEM;
 
-	wm8728->control_type = SND_SOC_SPI;
+	wm8728->regmap = devm_regmap_init_spi(spi, &wm8728_regmap);
+	if (IS_ERR(wm8728->regmap))
+		return PTR_ERR(wm8728->regmap);
+
 	spi_set_drvdata(spi, wm8728);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -324,8 +332,11 @@ static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
 	if (wm8728 == NULL)
 		return -ENOMEM;
 
+	wm8728->regmap = devm_regmap_init_i2c(i2c, &wm8728_regmap);
+	if (IS_ERR(wm8728->regmap))
+		return PTR_ERR(wm8728->regmap);
+
 	i2c_set_clientdata(i2c, wm8728);
-	wm8728->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8728, &wm8728_dai, 1);
-- 
1.7.10.4
