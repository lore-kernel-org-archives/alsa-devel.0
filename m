From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8988: Convert to direct regmap API
	usage
Date: Sun, 12 Feb 2012 18:24:09 +0000
Message-ID: <1329071050-11498-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B52562417E
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:07:09 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [108.60.121.130])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 06BE5110565
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:07:09 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8988.c |  140 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 120 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 4ef9d4c..2470321 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -33,24 +33,89 @@
  * We can't read the WM8988 register space when we
  * are using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8988_reg[] = {
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
+static const struct reg_default wm8988_reg_defaults[] = {
+	{ 0, 0x0097 },
+	{ 1, 0x0097 },
+	{ 2, 0x0079 },
+	{ 3, 0x0079 },
+	{ 5, 0x0008 },
+	{ 7, 0x000a },
+	{ 8, 0x0000 },
+	{ 10, 0x00ff },
+	{ 11, 0x00ff },
+	{ 12, 0x000f },
+	{ 13, 0x000f },
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
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0050 },
+	{ 35, 0x0050 },
+	{ 36, 0x0050 },
+	{ 37, 0x0050 },
+	{ 40, 0x0079 },
+	{ 41, 0x0079 },
+	{ 42, 0x0079 },
 };
 
+static bool wm8988_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8988_LINVOL:
+	case WM8988_RINVOL:
+	case WM8988_LOUT1V:
+	case WM8988_ROUT1V:
+	case WM8988_ADCDAC:
+	case WM8988_IFACE:
+	case WM8988_SRATE:
+	case WM8988_LDAC:
+	case WM8988_RDAC:
+	case WM8988_BASS:
+	case WM8988_TREBLE:
+	case WM8988_RESET:
+	case WM8988_3D:
+	case WM8988_ALC1:
+	case WM8988_ALC2:
+	case WM8988_ALC3:
+	case WM8988_NGATE:
+	case WM8988_LADC:
+	case WM8988_RADC:
+	case WM8988_ADCTL1:
+	case WM8988_ADCTL2:
+	case WM8988_PWR1:
+	case WM8988_PWR2:
+	case WM8988_ADCTL3:
+	case WM8988_ADCIN:
+	case WM8988_LADCIN:
+	case WM8988_RADCIN:
+	case WM8988_LOUTM1:
+	case WM8988_LOUTM2:
+	case WM8988_ROUTM1:
+	case WM8988_ROUTM2:
+	case WM8988_LOUT2V:
+	case WM8988_ROUT2V:
+	case WM8988_LPPB:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* codec private data */
 struct wm8988_priv {
+	struct regmap *regmap;
 	unsigned int sysclk;
-	enum snd_soc_control_type control_type;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
@@ -661,6 +726,7 @@ static int wm8988_mute(struct snd_soc_dai *dai, int mute)
 static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
 	u16 pwr_reg = snd_soc_read(codec, WM8988_PWR1) & ~0x1c1;
 
 	switch (level) {
@@ -674,7 +740,7 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8988->regmap);
 
 			/* VREF, VMID=2x5k */
 			snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
@@ -730,7 +796,10 @@ static struct snd_soc_dai_driver wm8988_dai = {
 
 static int wm8988_suspend(struct snd_soc_codec *codec)
 {
+	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
+
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_mark_dirty(wm8988->regmap);
 	return 0;
 }
 
@@ -745,7 +814,8 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8988->control_type);
+	codec->control_data = wm8988->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -781,9 +851,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.suspend =	wm8988_suspend,
 	.resume =	wm8988_resume,
 	.set_bias_level = wm8988_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8988_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8988_reg,
 
 	.controls = wm8988_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8988_snd_controls),
@@ -793,6 +860,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8988_dapm_routes),
 };
 
+static struct regmap_config wm8988_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = WM8988_LPPB,
+	.writeable_reg = wm8988_writeable,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8988_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8988_reg_defaults),
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8988_spi_probe(struct spi_device *spi)
 {
@@ -804,18 +883,28 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
-	wm8988->control_type = SND_SOC_SPI;
+	wm8988->regmap = regmap_init_spi(spi, &wm8988_regmap);
+	if (IS_ERR(wm8988->regmap)) {
+		ret = PTR_ERR(wm8988->regmap);
+		dev_err(&spi->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
 	spi_set_drvdata(spi, wm8988);
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	if (ret != 0)
+		regmap_exit(wm8988->regmap);
 
 	return ret;
 }
 
 static int __devexit wm8988_spi_remove(struct spi_device *spi)
 {
+	struct wm8988_priv *wm8988 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
+	regmap_exit(wm8988->regmap);
 	return 0;
 }
 
@@ -842,16 +931,27 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8988);
-	wm8988->control_type = SND_SOC_I2C;
+
+	wm8988->regmap = regmap_init_i2c(i2c, &wm8988_regmap);
+	if (IS_ERR(wm8988->regmap)) {
+		ret = PTR_ERR(wm8988->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	if (ret != 0)
+		regmap_exit(wm8988->regmap);
+
 	return ret;
 }
 
 static __devexit int wm8988_i2c_remove(struct i2c_client *client)
 {
+	struct wm8988_priv *wm8988 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
+	regmap_exit(wm8988->regmap);
 	return 0;
 }
 
-- 
1.7.9.rc1
