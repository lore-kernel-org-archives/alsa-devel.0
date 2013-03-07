From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3] ALSA: ASoC: cs4271: convert to direct
	regmap API usage
Date: Thu,  7 Mar 2013 23:53:12 +0100
Message-ID: <1362696792-11681-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF5F265DC6
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 23:53:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, subaparts@yandex.ru, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

By using the regmap API directly, we can make use of the
.write_flag_mask for SPI, which allows us to drop the strange register
hacks that were necessary so far.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
v3: dropped one more (now misleading) comment
v2: added a .write_flag_mask

 sound/soc/codecs/cs4271.c | 159 ++++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 68 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 2415a41..ac0d3b4 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -39,17 +39,15 @@
 
 /*
  * CS4271 registers
- * High byte represents SPI chip address (0x10) + write command (0)
- * Low byte - codec register address
  */
-#define CS4271_MODE1	0x2001	/* Mode Control 1 */
-#define CS4271_DACCTL	0x2002	/* DAC Control */
-#define CS4271_DACVOL	0x2003	/* DAC Volume & Mixing Control */
-#define CS4271_VOLA	0x2004	/* DAC Channel A Volume Control */
-#define CS4271_VOLB	0x2005	/* DAC Channel B Volume Control */
-#define CS4271_ADCCTL	0x2006	/* ADC Control */
-#define CS4271_MODE2	0x2007	/* Mode Control 2 */
-#define CS4271_CHIPID	0x2008	/* Chip ID */
+#define CS4271_MODE1	0x01	/* Mode Control 1 */
+#define CS4271_DACCTL	0x02	/* DAC Control */
+#define CS4271_DACVOL	0x03	/* DAC Volume & Mixing Control */
+#define CS4271_VOLA	0x04	/* DAC Channel A Volume Control */
+#define CS4271_VOLB	0x05	/* DAC Channel B Volume Control */
+#define CS4271_ADCCTL	0x06	/* ADC Control */
+#define CS4271_MODE2	0x07	/* Mode Control 2 */
+#define CS4271_CHIPID	0x08	/* Chip ID */
 
 #define CS4271_FIRSTREG	CS4271_MODE1
 #define CS4271_LASTREG	CS4271_MODE2
@@ -144,23 +142,27 @@
  * Array do not include Chip ID, as codec driver does not use
  * registers read operations at all
  */
-static const u8 cs4271_dflt_reg[CS4271_NR_REGS] = {
-	0,
-	0,
-	CS4271_DACCTL_AMUTE,
-	CS4271_DACVOL_SOFT | CS4271_DACVOL_ATAPI_AL_BR,
-	0,
-	0,
-	0,
-	0,
+static const struct reg_default cs4271_reg_defaults[] = {
+	{ CS4271_MODE1,		0, },
+	{ CS4271_DACCTL,	CS4271_DACCTL_AMUTE, },
+	{ CS4271_DACVOL,	CS4271_DACVOL_SOFT | CS4271_DACVOL_ATAPI_AL_BR, },
+	{ CS4271_VOLA,		0, },
+	{ CS4271_VOLB,		0, },
+	{ CS4271_ADCCTL,	0, },
+	{ CS4271_MODE2,		0, },
 };
 
+static bool cs4271_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == CS4271_CHIPID;
+}
+
 struct cs4271_private {
 	/* SND_SOC_I2C or SND_SOC_SPI */
-	enum snd_soc_control_type	bus_type;
 	unsigned int			mclk;
 	bool				master;
 	bool				deemph;
+	struct regmap			*regmap;
 	/* Current sample rate for de-emphasis control */
 	int				rate;
 	/* GPIO driving Reset pin, if any */
@@ -210,14 +212,14 @@ static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_LEFT_J:
 		val |= CS4271_MODE1_DAC_DIF_LJ;
-		ret = snd_soc_update_bits(codec, CS4271_ADCCTL,
+		ret = regmap_update_bits(cs4271->regmap, CS4271_ADCCTL,
 			CS4271_ADCCTL_ADC_DIF_MASK, CS4271_ADCCTL_ADC_DIF_LJ);
 		if (ret < 0)
 			return ret;
 		break;
 	case SND_SOC_DAIFMT_I2S:
 		val |= CS4271_MODE1_DAC_DIF_I2S;
-		ret = snd_soc_update_bits(codec, CS4271_ADCCTL,
+		ret = regmap_update_bits(cs4271->regmap, CS4271_ADCCTL,
 			CS4271_ADCCTL_ADC_DIF_MASK, CS4271_ADCCTL_ADC_DIF_I2S);
 		if (ret < 0)
 			return ret;
@@ -227,7 +229,7 @@ static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_update_bits(codec, CS4271_MODE1,
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE1,
 		CS4271_MODE1_DAC_DIF_MASK | CS4271_MODE1_MASTER, val);
 	if (ret < 0)
 		return ret;
@@ -252,7 +254,7 @@ static int cs4271_set_deemph(struct snd_soc_codec *codec)
 		val <<= 4;
 	}
 
-	ret = snd_soc_update_bits(codec, CS4271_DACCTL,
+	ret = regmap_update_bits(cs4271->regmap, CS4271_DACCTL,
 		CS4271_DACCTL_DEM_MASK, val);
 	if (ret < 0)
 		return ret;
@@ -341,14 +343,14 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 		     !dai->capture_active) ||
 		    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
 		     !dai->playback_active)) {
-			ret = snd_soc_update_bits(codec, CS4271_MODE2,
-						  CS4271_MODE2_PDN,
-						  CS4271_MODE2_PDN);
+			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+						 CS4271_MODE2_PDN,
+						 CS4271_MODE2_PDN);
 			if (ret < 0)
 				return ret;
 
-			ret = snd_soc_update_bits(codec, CS4271_MODE2,
-						  CS4271_MODE2_PDN, 0);
+			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+						 CS4271_MODE2_PDN, 0);
 			if (ret < 0)
 				return ret;
 		}
@@ -378,7 +380,7 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 
 	val |= cs4271_clk_tab[i].ratio_mask;
 
-	ret = snd_soc_update_bits(codec, CS4271_MODE1,
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE1,
 		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK, val);
 	if (ret < 0)
 		return ret;
@@ -389,6 +391,7 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	int val_a = 0;
 	int val_b = 0;
@@ -398,10 +401,13 @@ static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
 		val_b = CS4271_VOLB_MUTE;
 	}
 
-	ret = snd_soc_update_bits(codec, CS4271_VOLA, CS4271_VOLA_MUTE, val_a);
+	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLA,
+				 CS4271_VOLA_MUTE, val_a);
 	if (ret < 0)
 		return ret;
-	ret = snd_soc_update_bits(codec, CS4271_VOLB, CS4271_VOLB_MUTE, val_b);
+
+	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLB,
+				 CS4271_VOLB_MUTE, val_b);
 	if (ret < 0)
 		return ret;
 
@@ -463,25 +469,33 @@ static struct snd_soc_dai_driver cs4271_dai = {
 static int cs4271_soc_suspend(struct snd_soc_codec *codec)
 {
 	int ret;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
 	/* Set power-down bit */
-	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
-				  CS4271_MODE2_PDN);
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+				 CS4271_MODE2_PDN, CS4271_MODE2_PDN);
 	if (ret < 0)
 		return ret;
+
 	return 0;
 }
 
 static int cs4271_soc_resume(struct snd_soc_codec *codec)
 {
 	int ret;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
 	/* Restore codec state */
-	ret = snd_soc_cache_sync(codec);
+	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
 		return ret;
+
 	/* then disable the power-down bit */
-	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
 		return ret;
+
 	return 0;
 }
 #else
@@ -542,40 +556,22 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 
 	cs4271->gpio_nreset = gpio_nreset;
 
-	/*
-	 * In case of I2C, chip address specified in board data.
-	 * So cache IO operations use 8 bit codec register address.
-	 * In case of SPI, chip address and register address
-	 * passed together as 16 bit value.
-	 * Anyway, register address is masked with 0xFF inside
-	 * soc-cache code.
-	 */
-	if (cs4271->bus_type == SND_SOC_SPI)
-		ret = snd_soc_codec_set_cache_io(codec, 16, 8,
-			cs4271->bus_type);
-	else
-		ret = snd_soc_codec_set_cache_io(codec, 8, 8,
-			cs4271->bus_type);
-	if (ret) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_update_bits(codec, CS4271_MODE2,
-				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
-				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
+				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
 		return ret;
-	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
 		return ret;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
 	if (amutec_eq_bmutec)
-		snd_soc_update_bits(codec, CS4271_MODE2,
-				    CS4271_MODE2_MUTECAEQUB,
-				    CS4271_MODE2_MUTECAEQUB);
+		regmap_update_bits(cs4271->regmap, CS4271_MODE2,
+				   CS4271_MODE2_MUTECAEQUB,
+				   CS4271_MODE2_MUTECAEQUB);
 
 	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
 		ARRAY_SIZE(cs4271_snd_controls));
@@ -597,13 +593,24 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
 	.remove			= cs4271_remove,
 	.suspend		= cs4271_soc_suspend,
 	.resume			= cs4271_soc_resume,
-	.reg_cache_default	= cs4271_dflt_reg,
-	.reg_cache_size		= ARRAY_SIZE(cs4271_dflt_reg),
-	.reg_word_size		= sizeof(cs4271_dflt_reg[0]),
-	.compress_type		= SND_SOC_FLAT_COMPRESSION,
 };
 
 #if defined(CONFIG_SPI_MASTER)
+
+static const struct regmap_config cs4271_spi_regmap = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = CS4271_LASTREG,
+	.read_flag_mask = 0x21,
+	.write_flag_mask = 0x20,
+
+	.reg_defaults = cs4271_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs4271_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = cs4271_volatile_reg,
+};
+
 static int cs4271_spi_probe(struct spi_device *spi)
 {
 	struct cs4271_private *cs4271;
@@ -613,7 +620,9 @@ static int cs4271_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, cs4271);
-	cs4271->bus_type = SND_SOC_SPI;
+	cs4271->regmap = devm_regmap_init_spi(spi, &cs4271_spi_regmap);
+	if (IS_ERR(cs4271->regmap))
+		return PTR_ERR(cs4271->regmap);
 
 	return snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
 		&cs4271_dai, 1);
@@ -643,6 +652,18 @@ static const struct i2c_device_id cs4271_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
 
+static const struct regmap_config cs4271_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CS4271_LASTREG,
+
+	.reg_defaults = cs4271_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs4271_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = cs4271_volatile_reg,
+};
+
 static int cs4271_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -653,7 +674,9 @@ static int cs4271_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, cs4271);
-	cs4271->bus_type = SND_SOC_I2C;
+	cs4271->regmap = devm_regmap_init_i2c(client, &cs4271_i2c_regmap);
+	if (IS_ERR(cs4271->regmap))
+		return PTR_ERR(cs4271->regmap);
 
 	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4271,
 		&cs4271_dai, 1);
-- 
1.8.1.4
