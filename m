From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] ad1938: use soc-cache framework for codec
	registers access
Date: Wed, 27 Jan 2010 11:46:18 +0800
Message-ID: <1264563978-18927-2-git-send-email-21cnbao@gmail.com>
References: <1264563978-18927-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id BE5771038BA
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 04:46:38 +0100 (CET)
In-Reply-To: <1264563978-18927-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Barry Song <Barry.Song@analog.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <Barry.Song@analog.com>
---
 sound/soc/codecs/ad1938.c |  164 ++++++++++-----------------------------------
 sound/soc/soc-cache.c     |  108 +++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 128 deletions(-)

diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index 47d9ac0..c233810 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -46,6 +46,11 @@ struct ad1938_priv {
 	u8 reg_cache[AD1938_NUM_REGS];
 };
 
+/* ad1938 register cache & default register settings */
+static const u8 ad1938_reg[AD1938_NUM_REGS] = {
+	0, 0, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0, 0, 0,
+};
+
 static struct snd_soc_codec *ad1938_codec;
 struct snd_soc_codec_device soc_codec_dev_ad1938;
 static int ad1938_register(struct ad1938_priv *ad1938);
@@ -129,10 +134,10 @@ static int ad1938_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_codec *codec = dai->codec;
 	int reg;
 
-	reg = codec->read(codec, AD1938_DAC_CTRL2);
+	reg = snd_soc_read(codec, AD1938_DAC_CTRL2);
 	reg = (mute > 0) ? reg | AD1938_DAC_MASTER_MUTE : reg &
 		(~AD1938_DAC_MASTER_MUTE);
-	codec->write(codec, AD1938_DAC_CTRL2, reg);
+	snd_soc_write(codec, AD1938_DAC_CTRL2, reg);
 
 	return 0;
 }
@@ -141,8 +146,8 @@ static int ad1938_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int width)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	int dac_reg = codec->read(codec, AD1938_DAC_CTRL1);
-	int adc_reg = codec->read(codec, AD1938_ADC_CTRL2);
+	int dac_reg = snd_soc_read(codec, AD1938_DAC_CTRL1);
+	int adc_reg = snd_soc_read(codec, AD1938_ADC_CTRL2);
 
 	dac_reg &= ~AD1938_DAC_CHAN_MASK;
 	adc_reg &= ~AD1938_ADC_CHAN_MASK;
@@ -168,8 +173,8 @@ static int ad1938_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
-	codec->write(codec, AD1938_DAC_CTRL1, dac_reg);
-	codec->write(codec, AD1938_ADC_CTRL2, adc_reg);
+	snd_soc_write(codec, AD1938_DAC_CTRL1, dac_reg);
+	snd_soc_write(codec, AD1938_ADC_CTRL2, adc_reg);
 
 	return 0;
 }
@@ -180,8 +185,8 @@ static int ad1938_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	int adc_reg, dac_reg;
 
-	adc_reg = codec->read(codec, AD1938_ADC_CTRL2);
-	dac_reg = codec->read(codec, AD1938_DAC_CTRL1);
+	adc_reg = snd_soc_read(codec, AD1938_ADC_CTRL2);
+	dac_reg = snd_soc_read(codec, AD1938_DAC_CTRL1);
 
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
 	 * with TDM) and ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A)
@@ -258,8 +263,8 @@ static int ad1938_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	codec->write(codec, AD1938_ADC_CTRL2, adc_reg);
-	codec->write(codec, AD1938_DAC_CTRL1, dac_reg);
+	snd_soc_write(codec, AD1938_ADC_CTRL2, adc_reg);
+	snd_soc_write(codec, AD1938_DAC_CTRL1, dac_reg);
 
 	return 0;
 }
@@ -288,116 +293,13 @@ static int ad1938_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	reg = codec->read(codec, AD1938_DAC_CTRL2);
+	reg = snd_soc_read(codec, AD1938_DAC_CTRL2);
 	reg = (reg & (~AD1938_DAC_WORD_LEN_MASK)) | word_len;
-	codec->write(codec, AD1938_DAC_CTRL2, reg);
+	snd_soc_write(codec, AD1938_DAC_CTRL2, reg);
 
-	reg = codec->read(codec, AD1938_ADC_CTRL1);
+	reg = snd_soc_read(codec, AD1938_ADC_CTRL1);
 	reg = (reg & (~AD1938_ADC_WORD_LEN_MASK)) | word_len;
-	codec->write(codec, AD1938_ADC_CTRL1, reg);
-
-	return 0;
-}
-
-/*
- * interface to read/write ad1938 register
- */
-
-#define AD1938_SPI_ADDR    0x4
-#define AD1938_SPI_READ    0x1
-#define AD1938_SPI_BUFLEN  3
-
-/*
- * write to the ad1938 register space
- */
-
-static int ad1938_write_reg(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int value)
-{
-	u8 *reg_cache = codec->reg_cache;
-	int ret = 0;
-
-	if (value != reg_cache[reg]) {
-		uint8_t buf[AD1938_SPI_BUFLEN];
-		struct spi_transfer t = {
-			.tx_buf = buf,
-			.len = AD1938_SPI_BUFLEN,
-		};
-		struct spi_message m;
-
-		buf[0] = AD1938_SPI_ADDR << 1;
-		buf[1] = reg;
-		buf[2] = value;
-		spi_message_init(&m);
-		spi_message_add_tail(&t, &m);
-		ret = spi_sync(codec->control_data, &m);
-		if (ret == 0)
-			reg_cache[reg] = value;
-	}
-
-	return ret;
-}
-
-/*
- * read from the ad1938 register space cache
- */
-
-static unsigned int ad1938_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	u8 *reg_cache = codec->reg_cache;
-
-	if (reg >= codec->reg_cache_size)
-		return -EINVAL;
-
-	return reg_cache[reg];
-}
-
-/*
- * read from the ad1938 register space
- */
-
-static unsigned int ad1938_read_reg(struct snd_soc_codec *codec,
-						unsigned int reg)
-{
-	char w_buf[AD1938_SPI_BUFLEN];
-	char r_buf[AD1938_SPI_BUFLEN];
-	int ret;
-
-	struct spi_transfer t = {
-		.tx_buf = w_buf,
-		.rx_buf = r_buf,
-		.len = AD1938_SPI_BUFLEN,
-	};
-	struct spi_message m;
-
-	w_buf[0] = (AD1938_SPI_ADDR << 1) | AD1938_SPI_READ;
-	w_buf[1] = reg;
-	w_buf[2] = 0;
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-	ret = spi_sync(codec->control_data, &m);
-	if (ret == 0)
-		return	r_buf[2];
-	else
-		return -EIO;
-}
-
-static int ad1938_fill_cache(struct snd_soc_codec *codec)
-{
-	int i;
-	u8 *reg_cache = codec->reg_cache;
-	struct spi_device *spi = codec->control_data;
-
-	for (i = 0; i < codec->reg_cache_size; i++) {
-		int ret = ad1938_read_reg(codec, i);
-		if (ret == -EIO) {
-			dev_err(&spi->dev, "AD1938 SPI read failure\n");
-			return ret;
-		}
-		reg_cache[i] = ret;
-	}
+	snd_soc_write(codec, AD1938_ADC_CTRL1, reg);
 
 	return 0;
 }
@@ -487,31 +389,37 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 	codec->owner = THIS_MODULE;
 	codec->dai = &ad1938_dai;
 	codec->num_dai = 1;
-	codec->write = ad1938_write_reg;
-	codec->read = ad1938_read_reg_cache;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	ad1938_dai.dev = codec->dev;
 	ad1938_codec = codec;
 
+	memcpy(codec->reg_cache, ad1938_reg, AD1938_NUM_REGS);
+
+	ret = snd_soc_codec_set_cache_io(codec, 16, 8, SND_SOC_SPI);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to set cache I/O: %d\n",
+				ret);
+		kfree(ad1938);
+		return ret;
+	}
+
 	/* default setting for ad1938 */
 
 	/* unmute dac channels */
-	codec->write(codec, AD1938_DAC_CHNL_MUTE, 0x0);
+	snd_soc_write(codec, AD1938_DAC_CHNL_MUTE, 0x0);
 	/* de-emphasis: 48kHz, powedown dac */
-	codec->write(codec, AD1938_DAC_CTRL2, 0x1A);
+	snd_soc_write(codec, AD1938_DAC_CTRL2, 0x1A);
 	/* powerdown dac, dac in tdm mode */
-	codec->write(codec, AD1938_DAC_CTRL0, 0x41);
+	snd_soc_write(codec, AD1938_DAC_CTRL0, 0x41);
 	/* high-pass filter enable */
-	codec->write(codec, AD1938_ADC_CTRL0, 0x3);
+	snd_soc_write(codec, AD1938_ADC_CTRL0, 0x3);
 	/* sata delay=1, adc aux mode */
-	codec->write(codec, AD1938_ADC_CTRL1, 0x43);
+	snd_soc_write(codec, AD1938_ADC_CTRL1, 0x43);
 	/* pll input: mclki/xi */
-	codec->write(codec, AD1938_PLL_CLK_CTRL0, 0x9D);
-	codec->write(codec, AD1938_PLL_CLK_CTRL1, 0x04);
-
-	ad1938_fill_cache(codec);
+	snd_soc_write(codec, AD1938_PLL_CLK_CTRL0, 0x9D);
+	snd_soc_write(codec, AD1938_PLL_CLK_CTRL1, 0x04);
 
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index cde7b63..097e335 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -233,6 +233,108 @@ static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
 #define snd_soc_8_16_read_i2c NULL
 #endif
 
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	struct i2c_msg xfer[2];
+	u16 reg = r;
+	u8 data;
+	int ret;
+	struct i2c_client *client = codec->control_data;
+
+	/* Write register */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 2;
+	xfer[0].buf = (u8 *)&reg;
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 1;
+	xfer[1].buf = &data;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+		return 0;
+	}
+
+	return data;
+}
+#else
+#define snd_soc_16_8_read_i2c NULL
+#endif
+
+static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	reg &= 0xff;
+	if (reg >= codec->reg_cache_size)
+		return -1;
+	return cache[reg];
+}
+
+static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	u8 data[3];
+	int ret;
+
+	BUG_ON(codec->volatile_register);
+
+	data[0] = (reg >> 8) & 0xff;
+	data[1] = reg & 0xff;
+	data[2] = value;
+
+	reg &= 0xff;
+	if (reg < codec->reg_cache_size)
+		cache[reg] = value;
+	ret = codec->hw_write(codec->control_data, data, 3);
+	if (ret == 3)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_16_8_spi_write(void *control_data, const char *data,
+				 int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[3];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+	msg[2] = data[2];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#else
+#define snd_soc_16_8_spi_write NULL
+#endif
+
+
 static struct {
 	int addr_bits;
 	int data_bits;
@@ -260,6 +362,12 @@ static struct {
 		.write = snd_soc_8_16_write, .read = snd_soc_8_16_read,
 		.i2c_read = snd_soc_8_16_read_i2c,
 	},
+	{
+		.addr_bits = 16, .data_bits = 8,
+		.write = snd_soc_16_8_write, .read = snd_soc_16_8_read,
+		.i2c_read = snd_soc_16_8_read_i2c,
+		.spi_write = snd_soc_16_8_spi_write,
+	},
 };
 
 /**
-- 
1.5.6.3
