From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH 3.1]ASoC: ad193x: add spi_hw_read,
 fix sysclk and register definition
Date: Thu, 11 Aug 2011 17:04:08 +0800
Message-ID: <CAHG8p1AJ66K8yjiEz3HXv64JB0C4OrCPbCFV+Gu5jQkvB5cibA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CE4C42437C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 11:04:11 +0200 (CEST)
Received: by qyk35 with SMTP id 35so1255165qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 02:04:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

asoc cache layer can't support this kind of spi registers,
so bypass cache and read regiters directly

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad193x.c |    2 +-
 sound/soc/codecs/ad193x.c         |    8 ++++++--
 sound/soc/codecs/ad193x.h         |    5 +++--
 sound/soc/soc-io.c                |   23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad193x.c
b/sound/soc/blackfin/bf5xx-ad193x.c
index d6651c0..a118a0f 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -56,7 +56,7 @@ static int bf5xx_ad193x_hw_params(struct
snd_pcm_substream *substream,

 	switch (params_rate(params)) {
 	case 48000:
-		clk = 12288000;
+		clk = 24576000;
 		break;
 	}

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 2374ca5..1447cc8 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -307,7 +307,8 @@ static int ad193x_hw_params(struct
snd_pcm_substream *substream,
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);

 	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
-	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
+	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
+		| (word_len << AD193X_DAC_WORD_LEN_SHFT);
 	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);

 	reg = snd_soc_read(codec, AD193X_ADC_CTRL1);
@@ -361,7 +362,10 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
-
+#if defined(CONFIG_SPI_MASTER)
+	/* asoc cache layer can't support this kind of spi registers now */
+	codec->cache_bypass = 1;
+#endif
 	/* default setting for ad193x */

 	/* unmute dac channels */
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 9747b54..cccc2e8 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -34,7 +34,8 @@
 #define AD193X_DAC_LEFT_HIGH    (1 << 3)
 #define AD193X_DAC_BCLK_INV     (1 << 7)
 #define AD193X_DAC_CTRL2        0x804
-#define AD193X_DAC_WORD_LEN_MASK	0xC
+#define AD193X_DAC_WORD_LEN_SHFT        3
+#define AD193X_DAC_WORD_LEN_MASK        0x18
 #define AD193X_DAC_MASTER_MUTE  1
 #define AD193X_DAC_CHNL_MUTE    0x805
 #define AD193X_DACL1_MUTE       0
@@ -63,7 +64,7 @@
 #define AD193X_ADC_CTRL1        0x80f
 #define AD193X_ADC_SERFMT_MASK		0x60
 #define AD193X_ADC_SERFMT_STEREO	(0 << 5)
-#define AD193X_ADC_SERFMT_TDM		(1 << 2)
+#define AD193X_ADC_SERFMT_TDM		(1 << 5)
 #define AD193X_ADC_SERFMT_AUX		(2 << 5)
 #define AD193X_ADC_WORD_LEN_MASK	0x3
 #define AD193X_ADC_CTRL2        0x810
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index cca490c..a62f7dd 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -205,6 +205,25 @@ static unsigned int snd_soc_16_8_read_i2c(struct
snd_soc_codec *codec,
 #define snd_soc_16_8_read_i2c NULL
 #endif

+#if defined(CONFIG_SPI_MASTER)
+static unsigned int snd_soc_16_8_read_spi(struct snd_soc_codec *codec,
+		                          unsigned int r)
+{
+	struct spi_device *spi = codec->control_data;
+
+	const u16 reg = cpu_to_be16(r | 0x100);
+	u8 data;
+	int ret;
+
+	ret = spi_write_then_read(spi, &reg, 2, &data, 1);
+	if (ret < 0)
+		return 0;
+	return data;
+}
+#else
+#define snd_soc_16_8_read_spi NULL
+#endif
+
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -295,6 +314,7 @@ static struct {
 	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
+	unsigned int (*spi_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{
 		.addr_bits = 4, .data_bits = 12,
@@ -318,6 +338,7 @@ static struct {
 		.addr_bits = 16, .data_bits = 8,
 		.write = snd_soc_16_8_write,
 		.i2c_read = snd_soc_16_8_read_i2c,
+		.spi_read = snd_soc_16_8_read_spi,
 	},
 	{
 		.addr_bits = 16, .data_bits = 16,
@@ -383,6 +404,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 #ifdef CONFIG_SPI_MASTER
 		codec->hw_write = do_spi_write;
 #endif
+		if (io_types[i].spi_read)
+			codec->hw_read = io_types[i].spi_read;

 		codec->control_data = container_of(codec->dev,
 						   struct spi_device,
-- 
1.7.0.4
