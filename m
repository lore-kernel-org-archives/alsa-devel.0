From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] ad1836: use soc-cache framework for codec
	registers access
Date: Wed, 27 Jan 2010 11:46:17 +0800
Message-ID: <1264563978-18927-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B1C31037F8
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 04:46:25 +0100 (CET)
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
 sound/soc/codecs/ad1836.c |   92 +++++++++++---------------------------------
 sound/soc/soc-cache.c     |   67 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 83add2f..3c80137 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -171,58 +171,6 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-
-/*
- * interface to read/write ad1836 register
- */
-#define AD1836_SPI_REG_SHFT 12
-#define AD1836_SPI_READ     (1 << 11)
-#define AD1836_SPI_VAL_MSK  0x3FF
-
-/*
- * write to the ad1836 register space
- */
-
-static int ad1836_write_reg(struct snd_soc_codec *codec, unsigned int reg,
-		unsigned int value)
-{
-	u16 *reg_cache = codec->reg_cache;
-	int ret = 0;
-
-	if (value != reg_cache[reg]) {
-		unsigned short buf;
-		struct spi_transfer t = {
-			.tx_buf = &buf,
-			.len = 2,
-		};
-		struct spi_message m;
-
-		buf = (reg << AD1836_SPI_REG_SHFT) |
-			(value & AD1836_SPI_VAL_MSK);
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
- * read from the ad1836 register space cache
- */
-static unsigned int ad1836_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	u16 *reg_cache = codec->reg_cache;
-
-	if (reg >= codec->reg_cache_size)
-		return -EINVAL;
-
-	return reg_cache[reg];
-}
-
 #ifdef CONFIG_PM
 static int ad1836_soc_suspend(struct platform_device *pdev,
 		pm_message_t state)
@@ -231,10 +179,10 @@ static int ad1836_soc_suspend(struct platform_device *pdev,
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	/* reset clock control mode */
-	u16 adc_ctrl2 =  codec->read(codec, AD1836_ADC_CTRL2);
+	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
 	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
 
-	return codec->write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
 }
 
 static int ad1836_soc_resume(struct platform_device *pdev)
@@ -243,10 +191,10 @@ static int ad1836_soc_resume(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	/* restore clock control mode */
-	u16 adc_ctrl2 = codec->read(codec, AD1836_ADC_CTRL2);
+	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
 	adc_ctrl2 |= AD1836_ADC_AUX;
 
-	return codec->write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
 }
 #else
 #define ad1836_soc_suspend NULL
@@ -336,32 +284,38 @@ static int ad1836_register(struct ad1836_priv *ad1836)
 	codec->owner = THIS_MODULE;
 	codec->dai = &ad1836_dai;
 	codec->num_dai = 1;
-	codec->write = ad1836_write_reg;
-	codec->read = ad1836_read_reg_cache;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	ad1836_dai.dev = codec->dev;
 	ad1836_codec = codec;
 
+	ret = snd_soc_codec_set_cache_io(codec, 4, 12, SND_SOC_SPI);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to set cache I/O: %d\n",
+				ret);
+		kfree(ad1836);
+		return ret;
+	}
+
 	/* default setting for ad1836 */
 	/* de-emphasis: 48kHz, power-on dac */
-	codec->write(codec, AD1836_DAC_CTRL1, 0x300);
+	snd_soc_write(codec, AD1836_DAC_CTRL1, 0x300);
 	/* unmute dac channels */
-	codec->write(codec, AD1836_DAC_CTRL2, 0x0);
+	snd_soc_write(codec, AD1836_DAC_CTRL2, 0x0);
 	/* high-pass filter enable, power-on adc */
-	codec->write(codec, AD1836_ADC_CTRL1, 0x100);
+	snd_soc_write(codec, AD1836_ADC_CTRL1, 0x100);
 	/* unmute adc channles, adc aux mode */
-	codec->write(codec, AD1836_ADC_CTRL2, 0x180);
+	snd_soc_write(codec, AD1836_ADC_CTRL2, 0x180);
 	/* left/right diff:PGA/MUX */
-	codec->write(codec, AD1836_ADC_CTRL3, 0x3A);
+	snd_soc_write(codec, AD1836_ADC_CTRL3, 0x3A);
 	/* volume */
-	codec->write(codec, AD1836_DAC_L1_VOL, 0x3FF);
-	codec->write(codec, AD1836_DAC_R1_VOL, 0x3FF);
-	codec->write(codec, AD1836_DAC_L2_VOL, 0x3FF);
-	codec->write(codec, AD1836_DAC_R2_VOL, 0x3FF);
-	codec->write(codec, AD1836_DAC_L3_VOL, 0x3FF);
-	codec->write(codec, AD1836_DAC_R3_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_L1_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_R1_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_L2_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_R2_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_L3_VOL, 0x3FF);
+	snd_soc_write(codec, AD1836_DAC_R3_VOL, 0x3FF);
 
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 02c2357..cde7b63 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -15,6 +15,68 @@
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
 
+static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= codec->reg_cache_size)
+		return -1;
+	return cache[reg];
+}
+
+static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	u8 data[2];
+	int ret;
+
+	BUG_ON(codec->volatile_register);
+
+	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
+	data[1] = value & 0x00ff;
+
+	if (reg < codec->reg_cache_size)
+		cache[reg] = value;
+	ret = codec->hw_write(codec->control_data, data, 2);
+	if (ret == 2)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+#if defined(CONFIG_SPI_MASTER)
+static int snd_soc_4_12_spi_write(void *control_data, const char *data,
+				 int len)
+{
+	struct spi_device *spi = control_data;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[2];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[1];
+	msg[1] = data[0];
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
+#define snd_soc_4_12_spi_write NULL
+#endif
+
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -180,6 +242,11 @@ static struct {
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{
+		.addr_bits = 4, .data_bits = 12,
+		.write = snd_soc_4_12_write, .read = snd_soc_4_12_read,
+		.spi_write = snd_soc_4_12_spi_write,
+	},
+	{
 		.addr_bits = 7, .data_bits = 9,
 		.write = snd_soc_7_9_write, .read = snd_soc_7_9_read,
 		.spi_write = snd_soc_7_9_spi_write,
-- 
1.5.6.3
