From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: ak4104: Convert to direct regmap API
	usage
Date: Fri, 17 Feb 2012 12:23:12 -0800
Message-ID: <1329510192-4442-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
	<1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FE95103FE1
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:23:20 +0100 (CET)
In-Reply-To: <1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Since the cache is currently open coded this is more of a win than for
most devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |  119 +++++++++++++++++----------------------------
 1 files changed, 44 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 34a840c..ceb96ec 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -46,69 +46,15 @@
 #define DRV_NAME "ak4104-codec"
 
 struct ak4104_private {
-	enum snd_soc_control_type control_type;
-	void *control_data;
+	struct regmap *regmap;
 };
 
-static int ak4104_fill_cache(struct snd_soc_codec *codec)
-{
-	int i;
-	u8 *reg_cache = codec->reg_cache;
-	struct spi_device *spi = codec->control_data;
-
-	for (i = 0; i < codec->driver->reg_cache_size; i++) {
-		int ret = spi_w8r8(spi, i | AK4104_READ);
-		if (ret < 0) {
-			dev_err(&spi->dev, "SPI write failure\n");
-			return ret;
-		}
-
-		reg_cache[i] = ret;
-	}
-
-	return 0;
-}
-
-static unsigned int ak4104_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	u8 *reg_cache = codec->reg_cache;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return -EINVAL;
-
-	return reg_cache[reg];
-}
-
-static int ak4104_spi_write(struct snd_soc_codec *codec, unsigned int reg,
-			    unsigned int value)
-{
-	u8 *cache = codec->reg_cache;
-	struct spi_device *spi = codec->control_data;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return -EINVAL;
-
-	/* only write to the hardware if value has changed */
-	if (cache[reg] != value) {
-		u8 tmp[2] = { (reg & AK4104_REG_MASK) | AK4104_WRITE, value };
-
-		if (spi_write(spi, tmp, sizeof(tmp))) {
-			dev_err(&spi->dev, "SPI write failed\n");
-			return -EIO;
-		}
-
-		cache[reg] = value;
-	}
-
-	return 0;
-}
-
 static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	int val = 0;
+	int ret;
 
 	/* set DAI format */
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -192,23 +138,12 @@ static struct snd_soc_dai_driver ak4104_dai = {
 static int ak4104_probe(struct snd_soc_codec *codec)
 {
 	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
-	int ret, val;
-
-	codec->control_data = ak4104->control_data;
+	int ret;
 
-	/* read all regs and fill the cache */
-	ret = ak4104_fill_cache(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to fill register cache\n");
+	codec->control_data = ak4104->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
+	if (ret != 0)
 		return ret;
-	}
-
-	/* read the 'reserved' register - according to the datasheet, it
-	 * should contain 0x5b. Not a good way to verify the presence of
-	 * the device, but there is no hardware ID register. */
-	if (ak4104_read_reg_cache(codec, AK4104_REG_RESERVED) !=
-					 AK4104_RESERVED_VAL)
-		return -ENODEV;
 
 	/* set power-up and non-reset bits */
 	ret = snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
@@ -237,13 +172,23 @@ static int ak4104_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
 	.probe =	ak4104_probe,
 	.remove =	ak4104_remove,
-	.reg_cache_size = AK4104_NUM_REGS,
-	.reg_word_size = sizeof(u8),
+};
+
+static const struct regmap_config ak4104_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4104_NUM_REGS - 1,
+	.read_flag_mask = AK4104_READ,
+	.write_flag_mask = AK4104_WRITE,
+
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int ak4104_spi_probe(struct spi_device *spi)
 {
 	struct ak4104_private *ak4104;
+	unsigned int val;
 	int ret;
 
 	spi->bits_per_word = 8;
@@ -257,17 +202,41 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	if (ak4104 == NULL)
 		return -ENOMEM;
 
-	ak4104->control_data = spi;
-	ak4104->control_type = SND_SOC_SPI;
+	ak4104->regmap = regmap_init_spi(spi, &ak4104_regmap);
+	if (IS_ERR(ak4104->regmap)) {
+		ret = PTR_ERR(ak4104->regmap);
+		return ret;
+	}
+
+	/* read the 'reserved' register - according to the datasheet, it
+	 * should contain 0x5b. Not a good way to verify the presence of
+	 * the device, but there is no hardware ID register. */
+	ret = regmap_read(ak4104->regmap, AK4104_REG_RESERVED, &val);
+	if (ret != 0)
+		goto err;
+	if (val != AK4104_RESERVED_VAL) {
+		ret = -ENODEV;
+		goto err;
+	}
+
 	spi_set_drvdata(spi, ak4104);
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_device_ak4104, &ak4104_dai, 1);
+	if (ret != 0)
+		goto err;
+
+	return 0;
+
+err:
+	regmap_exit(ak4104->regmap);
 	return ret;
 }
 
 static int __devexit ak4104_spi_remove(struct spi_device *spi)
 {
+	struct ak4104_private *ak4101 = spi_get_drvdata(spi);
+	regmap_exit(ak4101->regmap);
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
-- 
1.7.9
