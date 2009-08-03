From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: Begin to factor out register cache
	I/O functions
Date: Mon,  3 Aug 2009 17:09:43 +0100
Message-ID: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 950B424797
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A lot of CODECs share the same register data formats and therefore
replicate the code to manage access to and caching of the register
map. In order to reduce code duplication centralised versions of
this code will be introduced with drivers able to configure the use
of the common code by calling the new snd_soc_codec_set_cache_io()
API call during startup.

As an initial user the 7 bit address/9 bit data format used by many
Wolfson devices is supported for write only CODECs and the drivers
with straightforward register cache implementations are converted to
use it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h       |    2 +
 sound/soc/Makefile        |    2 +-
 sound/soc/codecs/wm8510.c |  141 +++++++++++---------------------
 sound/soc/codecs/wm8728.c |   78 +++++-------------
 sound/soc/codecs/wm8731.c |  108 +++++++------------------
 sound/soc/codecs/wm8750.c |  121 ++++++++++------------------
 sound/soc/codecs/wm8960.c |  194 +++++++++++++++++----------------------------
 sound/soc/codecs/wm8971.c |  121 ++++++++++------------------
 sound/soc/codecs/wm8988.c |  105 ++++++++-----------------
 sound/soc/soc-cache.c     |  105 ++++++++++++++++++++++++
 10 files changed, 400 insertions(+), 577 deletions(-)
 create mode 100644 sound/soc/soc-cache.c

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 94fcc65..27409dd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -192,6 +192,8 @@ void snd_soc_unregister_platform(struct snd_soc_platform *platform);
 int snd_soc_register_codec(struct snd_soc_codec *codec);
 void snd_soc_unregister_codec(struct snd_soc_codec *codec);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
+int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
+			       int addr_bits, int data_bits);
 
 #ifdef CONFIG_PM
 int snd_soc_suspend_device(struct device *dev);
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 6f1e28d..4eaf48a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,4 @@
-snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o
+snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index c8b8dba..7a169bf 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -58,55 +58,7 @@ static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
 #define WM8510_POWER1_BIASEN  0x08
 #define WM8510_POWER1_BUFIOEN 0x10
 
-/*
- * read wm8510 register cache
- */
-static inline unsigned int wm8510_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg == WM8510_RESET)
-		return 0;
-	if (reg >= WM8510_CACHEREGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write wm8510 register cache
- */
-static inline void wm8510_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg >= WM8510_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-/*
- * write to the WM8510 register space
- */
-static int wm8510_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8510 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8510_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8510_reset(c)	wm8510_write(c, WM8510_RESET, 0)
+#define wm8510_reset(c)	snd_soc_write(c, WM8510_RESET, 0)
 
 static const char *wm8510_companding[] = { "Off", "NC", "u-law", "A-law" };
 static const char *wm8510_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
@@ -327,27 +279,27 @@ static int wm8510_set_dai_pll(struct snd_soc_dai *codec_dai,
 
 	if (freq_in == 0 || freq_out == 0) {
 		/* Clock CODEC directly from MCLK */
-		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK);
-		wm8510_write(codec, WM8510_CLOCK, reg & 0x0ff);
+		reg = snd_soc_read(codec, WM8510_CLOCK);
+		snd_soc_write(codec, WM8510_CLOCK, reg & 0x0ff);
 
 		/* Turn off PLL */
-		reg = wm8510_read_reg_cache(codec, WM8510_POWER1);
-		wm8510_write(codec, WM8510_POWER1, reg & 0x1df);
+		reg = snd_soc_read(codec, WM8510_POWER1);
+		snd_soc_write(codec, WM8510_POWER1, reg & 0x1df);
 		return 0;
 	}
 
 	pll_factors(freq_out*4, freq_in);
 
-	wm8510_write(codec, WM8510_PLLN, (pll_div.pre_div << 4) | pll_div.n);
-	wm8510_write(codec, WM8510_PLLK1, pll_div.k >> 18);
-	wm8510_write(codec, WM8510_PLLK2, (pll_div.k >> 9) & 0x1ff);
-	wm8510_write(codec, WM8510_PLLK3, pll_div.k & 0x1ff);
-	reg = wm8510_read_reg_cache(codec, WM8510_POWER1);
-	wm8510_write(codec, WM8510_POWER1, reg | 0x020);
+	snd_soc_write(codec, WM8510_PLLN, (pll_div.pre_div << 4) | pll_div.n);
+	snd_soc_write(codec, WM8510_PLLK1, pll_div.k >> 18);
+	snd_soc_write(codec, WM8510_PLLK2, (pll_div.k >> 9) & 0x1ff);
+	snd_soc_write(codec, WM8510_PLLK3, pll_div.k & 0x1ff);
+	reg = snd_soc_read(codec, WM8510_POWER1);
+	snd_soc_write(codec, WM8510_POWER1, reg | 0x020);
 
 	/* Run CODEC from PLL instead of MCLK */
-	reg = wm8510_read_reg_cache(codec, WM8510_CLOCK);
-	wm8510_write(codec, WM8510_CLOCK, reg | 0x100);
+	reg = snd_soc_read(codec, WM8510_CLOCK);
+	snd_soc_write(codec, WM8510_CLOCK, reg | 0x100);
 
 	return 0;
 }
@@ -363,24 +315,24 @@ static int wm8510_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8510_OPCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_GPIO) & 0x1cf;
-		wm8510_write(codec, WM8510_GPIO, reg | div);
+		reg = snd_soc_read(codec, WM8510_GPIO) & 0x1cf;
+		snd_soc_write(codec, WM8510_GPIO, reg | div);
 		break;
 	case WM8510_MCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK) & 0x11f;
-		wm8510_write(codec, WM8510_CLOCK, reg | div);
+		reg = snd_soc_read(codec, WM8510_CLOCK) & 0x11f;
+		snd_soc_write(codec, WM8510_CLOCK, reg | div);
 		break;
 	case WM8510_ADCCLK:
-		reg = wm8510_read_reg_cache(codec, WM8510_ADC) & 0x1f7;
-		wm8510_write(codec, WM8510_ADC, reg | div);
+		reg = snd_soc_read(codec, WM8510_ADC) & 0x1f7;
+		snd_soc_write(codec, WM8510_ADC, reg | div);
 		break;
 	case WM8510_DACCLK:
-		reg = wm8510_read_reg_cache(codec, WM8510_DAC) & 0x1f7;
-		wm8510_write(codec, WM8510_DAC, reg | div);
+		reg = snd_soc_read(codec, WM8510_DAC) & 0x1f7;
+		snd_soc_write(codec, WM8510_DAC, reg | div);
 		break;
 	case WM8510_BCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK) & 0x1e3;
-		wm8510_write(codec, WM8510_CLOCK, reg | div);
+		reg = snd_soc_read(codec, WM8510_CLOCK) & 0x1e3;
+		snd_soc_write(codec, WM8510_CLOCK, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -394,7 +346,7 @@ static int wm8510_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 iface = 0;
-	u16 clk = wm8510_read_reg_cache(codec, WM8510_CLOCK) & 0x1fe;
+	u16 clk = snd_soc_read(codec, WM8510_CLOCK) & 0x1fe;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -441,8 +393,8 @@ static int wm8510_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8510_write(codec, WM8510_IFACE, iface);
-	wm8510_write(codec, WM8510_CLOCK, clk);
+	snd_soc_write(codec, WM8510_IFACE, iface);
+	snd_soc_write(codec, WM8510_CLOCK, clk);
 	return 0;
 }
 
@@ -453,8 +405,8 @@ static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 iface = wm8510_read_reg_cache(codec, WM8510_IFACE) & 0x19f;
-	u16 adn = wm8510_read_reg_cache(codec, WM8510_ADD) & 0x1f1;
+	u16 iface = snd_soc_read(codec, WM8510_IFACE) & 0x19f;
+	u16 adn = snd_soc_read(codec, WM8510_ADD) & 0x1f1;
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -493,20 +445,20 @@ static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8510_write(codec, WM8510_IFACE, iface);
-	wm8510_write(codec, WM8510_ADD, adn);
+	snd_soc_write(codec, WM8510_IFACE, iface);
+	snd_soc_write(codec, WM8510_ADD, adn);
 	return 0;
 }
 
 static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8510_read_reg_cache(codec, WM8510_DAC) & 0xffbf;
+	u16 mute_reg = snd_soc_read(codec, WM8510_DAC) & 0xffbf;
 
 	if (mute)
-		wm8510_write(codec, WM8510_DAC, mute_reg | 0x40);
+		snd_soc_write(codec, WM8510_DAC, mute_reg | 0x40);
 	else
-		wm8510_write(codec, WM8510_DAC, mute_reg);
+		snd_soc_write(codec, WM8510_DAC, mute_reg);
 	return 0;
 }
 
@@ -514,13 +466,13 @@ static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
-	u16 power1 = wm8510_read_reg_cache(codec, WM8510_POWER1) & ~0x3;
+	u16 power1 = snd_soc_read(codec, WM8510_POWER1) & ~0x3;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		power1 |= 0x1;  /* VMID 50k */
-		wm8510_write(codec, WM8510_POWER1, power1);
+		snd_soc_write(codec, WM8510_POWER1, power1);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -528,18 +480,18 @@ static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Initial cap charge at VMID 5k */
-			wm8510_write(codec, WM8510_POWER1, power1 | 0x3);
+			snd_soc_write(codec, WM8510_POWER1, power1 | 0x3);
 			mdelay(100);
 		}
 
 		power1 |= 0x2;  /* VMID 500k */
-		wm8510_write(codec, WM8510_POWER1, power1);
+		snd_soc_write(codec, WM8510_POWER1, power1);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		wm8510_write(codec, WM8510_POWER1, 0);
-		wm8510_write(codec, WM8510_POWER2, 0);
-		wm8510_write(codec, WM8510_POWER3, 0);
+		snd_soc_write(codec, WM8510_POWER1, 0);
+		snd_soc_write(codec, WM8510_POWER2, 0);
+		snd_soc_write(codec, WM8510_POWER3, 0);
 		break;
 	}
 
@@ -619,8 +571,6 @@ static int wm8510_init(struct snd_soc_device *socdev)
 
 	codec->name = "WM8510";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8510_read_reg_cache;
-	codec->write = wm8510_write;
 	codec->set_bias_level = wm8510_set_bias_level;
 	codec->dai = &wm8510_dai;
 	codec->num_dai = 1;
@@ -630,13 +580,20 @@ static int wm8510_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n",
+		       ret);
+		goto err;
+	}
+
 	wm8510_reset(codec);
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8510: failed to create pcms\n");
-		goto pcm_err;
+		goto err;
 	}
 
 	/* power on device */
@@ -655,7 +612,7 @@ static int wm8510_init(struct snd_soc_device *socdev)
 card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-pcm_err:
+err:
 	kfree(codec->reg_cache);
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index e7ff212..66da44b 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -43,45 +43,6 @@ static const u16 wm8728_reg_defaults[] = {
 	0x100,
 };
 
-static inline unsigned int wm8728_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg >= ARRAY_SIZE(wm8728_reg_defaults));
-	return cache[reg];
-}
-
-static inline void wm8728_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg >= ARRAY_SIZE(wm8728_reg_defaults));
-	cache[reg] = value;
-}
-
-/*
- * write to the WM8728 register space
- */
-static int wm8728_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8728 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8728_write_reg_cache(codec, reg, value);
-
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
 static const DECLARE_TLV_DB_SCALE(wm8728_tlv, -12750, 50, 1);
 
 static const struct snd_kcontrol_new wm8728_snd_controls[] = {
@@ -121,12 +82,12 @@ static int wm8728_add_widgets(struct snd_soc_codec *codec)
 static int wm8728_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+	u16 mute_reg = snd_soc_read(codec, WM8728_DACCTL);
 
 	if (mute)
-		wm8728_write(codec, WM8728_DACCTL, mute_reg | 1);
+		snd_soc_write(codec, WM8728_DACCTL, mute_reg | 1);
 	else
-		wm8728_write(codec, WM8728_DACCTL, mute_reg & ~1);
+		snd_soc_write(codec, WM8728_DACCTL, mute_reg & ~1);
 
 	return 0;
 }
@@ -138,7 +99,7 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 dac = wm8728_read_reg_cache(codec, WM8728_DACCTL);
+	u16 dac = snd_soc_read(codec, WM8728_DACCTL);
 
 	dac &= ~0x18;
 
@@ -155,7 +116,7 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	wm8728_write(codec, WM8728_DACCTL, dac);
+	snd_soc_write(codec, WM8728_DACCTL, dac);
 
 	return 0;
 }
@@ -164,7 +125,7 @@ static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = wm8728_read_reg_cache(codec, WM8728_IFCTL);
+	u16 iface = snd_soc_read(codec, WM8728_IFCTL);
 
 	/* Currently only I2S is supported by the driver, though the
 	 * hardware is more flexible.
@@ -204,7 +165,7 @@ static int wm8728_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8728_write(codec, WM8728_IFCTL, iface);
+	snd_soc_write(codec, WM8728_IFCTL, iface);
 	return 0;
 }
 
@@ -220,19 +181,19 @@ static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Power everything up... */
-			reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
-			wm8728_write(codec, WM8728_DACCTL, reg & ~0x4);
+			reg = snd_soc_read(codec, WM8728_DACCTL);
+			snd_soc_write(codec, WM8728_DACCTL, reg & ~0x4);
 
 			/* ..then sync in the register cache. */
 			for (i = 0; i < ARRAY_SIZE(wm8728_reg_defaults); i++)
-				wm8728_write(codec, i,
-					     wm8728_read_reg_cache(codec, i));
+				snd_soc_write(codec, i,
+					     snd_soc_read(codec, i));
 		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		reg = wm8728_read_reg_cache(codec, WM8728_DACCTL);
-		wm8728_write(codec, WM8728_DACCTL, reg | 0x4);
+		reg = snd_soc_read(codec, WM8728_DACCTL);
+		snd_soc_write(codec, WM8728_DACCTL, reg | 0x4);
 		break;
 	}
 	codec->bias_level = level;
@@ -294,8 +255,6 @@ static int wm8728_init(struct snd_soc_device *socdev)
 
 	codec->name = "WM8728";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8728_read_reg_cache;
-	codec->write = wm8728_write;
 	codec->set_bias_level = wm8728_set_bias_level;
 	codec->dai = &wm8728_dai;
 	codec->num_dai = 1;
@@ -307,11 +266,18 @@ static int wm8728_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8728: failed to configure cache I/O: %d\n",
+		       ret);
+		goto err;
+	}
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to create pcms\n");
-		goto pcm_err;
+		goto err;
 	}
 
 	/* power on device */
@@ -331,7 +297,7 @@ static int wm8728_init(struct snd_soc_device *socdev)
 card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-pcm_err:
+err:
 	kfree(codec->reg_cache);
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index dfbc1bb..4eb84ff 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -50,60 +50,12 @@ static int wm8731_spi_write(struct spi_device *spi, const char *data, int len);
  * There is no point in caching the reset register
  */
 static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
-    0x0097, 0x0097, 0x0079, 0x0079,
-    0x000a, 0x0008, 0x009f, 0x000a,
-    0x0000, 0x0000
+	0x0097, 0x0097, 0x0079, 0x0079,
+	0x000a, 0x0008, 0x009f, 0x000a,
+	0x0000, 0x0000
 };
 
-/*
- * read wm8731 register cache
- */
-static inline unsigned int wm8731_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg == WM8731_RESET)
-		return 0;
-	if (reg >= WM8731_CACHEREGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write wm8731 register cache
- */
-static inline void wm8731_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg >= WM8731_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-/*
- * write to the WM8731 register space
- */
-static int wm8731_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8731 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8731_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8731_reset(c)	wm8731_write(c, WM8731_RESET, 0)
+#define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
 static const char *wm8731_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
@@ -260,12 +212,12 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8731_priv *wm8731 = codec->private_data;
-	u16 iface = wm8731_read_reg_cache(codec, WM8731_IFACE) & 0xfff3;
+	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
 	int i = get_coeff(wm8731->sysclk, params_rate(params));
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
 
-	wm8731_write(codec, WM8731_SRATE, srate);
+	snd_soc_write(codec, WM8731_SRATE, srate);
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -279,7 +231,7 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8731_write(codec, WM8731_IFACE, iface);
+	snd_soc_write(codec, WM8731_IFACE, iface);
 	return 0;
 }
 
@@ -291,7 +243,7 @@ static int wm8731_pcm_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	/* set active */
-	wm8731_write(codec, WM8731_ACTIVE, 0x0001);
+	snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
 
 	return 0;
 }
@@ -306,19 +258,19 @@ static void wm8731_shutdown(struct snd_pcm_substream *substream,
 	/* deactivate */
 	if (!codec->active) {
 		udelay(50);
-		wm8731_write(codec, WM8731_ACTIVE, 0x0);
+		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
 	}
 }
 
 static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8731_read_reg_cache(codec, WM8731_APDIGI) & 0xfff7;
+	u16 mute_reg = snd_soc_read(codec, WM8731_APDIGI) & 0xfff7;
 
 	if (mute)
-		wm8731_write(codec, WM8731_APDIGI, mute_reg | 0x8);
+		snd_soc_write(codec, WM8731_APDIGI, mute_reg | 0x8);
 	else
-		wm8731_write(codec, WM8731_APDIGI, mute_reg);
+		snd_soc_write(codec, WM8731_APDIGI, mute_reg);
 	return 0;
 }
 
@@ -396,7 +348,7 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	wm8731_write(codec, WM8731_IFACE, iface);
+	snd_soc_write(codec, WM8731_IFACE, iface);
 	return 0;
 }
 
@@ -412,12 +364,12 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* Clear PWROFF, gate CLKOUT, everything else as-is */
-		reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
-		wm8731_write(codec, WM8731_PWR, reg | 0x0040);
+		reg = snd_soc_read(codec, WM8731_PWR) & 0xff7f;
+		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
-		wm8731_write(codec, WM8731_ACTIVE, 0x0);
-		wm8731_write(codec, WM8731_PWR, 0xffff);
+		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
+		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		break;
 	}
 	codec->bias_level = level;
@@ -466,7 +418,7 @@ static int wm8731_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
 
-	wm8731_write(codec, WM8731_ACTIVE, 0x0);
+	snd_soc_write(codec, WM8731_ACTIVE, 0x0);
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
@@ -556,7 +508,6 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 {
 	int ret;
 	struct snd_soc_codec *codec = &wm8731->codec;
-	u16 reg;
 
 	if (wm8731_codec) {
 		dev_err(codec->dev, "Another WM8731 is registered\n");
@@ -571,8 +522,6 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 	codec->private_data = wm8731;
 	codec->name = "WM8731";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8731_read_reg_cache;
-	codec->write = wm8731_write;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8731_set_bias_level;
 	codec->dai = &wm8731_dai;
@@ -582,6 +531,12 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 
 	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	ret = wm8731_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
@@ -593,18 +548,13 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-	reg = wm8731_read_reg_cache(codec, WM8731_LOUT1V);
-	wm8731_write(codec, WM8731_LOUT1V, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_ROUT1V);
-	wm8731_write(codec, WM8731_ROUT1V, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_LINVOL);
-	wm8731_write(codec, WM8731_LINVOL, reg & ~0x0100);
-	reg = wm8731_read_reg_cache(codec, WM8731_RINVOL);
-	wm8731_write(codec, WM8731_RINVOL, reg & ~0x0100);
+	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
+	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
+	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
+	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
 
 	/* Disable bypass path by default */
-	reg = wm8731_read_reg_cache(codec, WM8731_APANA);
-	wm8731_write(codec, WM8731_APANA, reg & ~0x4);
+	snd_soc_update_bits(codec, WM8731_APANA, 0x4, 0);
 
 	wm8731_codec = codec;
 
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b64509b..ed09043 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -55,50 +55,7 @@ static const u16 wm8750_reg[] = {
 	0x0079, 0x0079, 0x0079,          /* 40 */
 };
 
-/*
- * read wm8750 register cache
- */
-static inline unsigned int wm8750_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg > WM8750_CACHE_REGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write wm8750 register cache
- */
-static inline void wm8750_write_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg > WM8750_CACHE_REGNUM)
-		return;
-	cache[reg] = value;
-}
-
-static int wm8750_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8753 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8750_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8750_reset(c)	wm8750_write(c, WM8750_RESET, 0)
+#define wm8750_reset(c)	snd_soc_write(c, WM8750_RESET, 0)
 
 /*
  * WM8750 Controls
@@ -594,7 +551,7 @@ static int wm8750_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8750_write(codec, WM8750_IFACE, iface);
+	snd_soc_write(codec, WM8750_IFACE, iface);
 	return 0;
 }
 
@@ -606,8 +563,8 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8750_priv *wm8750 = codec->private_data;
-	u16 iface = wm8750_read_reg_cache(codec, WM8750_IFACE) & 0x1f3;
-	u16 srate = wm8750_read_reg_cache(codec, WM8750_SRATE) & 0x1c0;
+	u16 iface = snd_soc_read(codec, WM8750_IFACE) & 0x1f3;
+	u16 srate = snd_soc_read(codec, WM8750_SRATE) & 0x1c0;
 	int coeff = get_coeff(wm8750->sysclk, params_rate(params));
 
 	/* bit size */
@@ -626,9 +583,9 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	wm8750_write(codec, WM8750_IFACE, iface);
+	snd_soc_write(codec, WM8750_IFACE, iface);
 	if (coeff >= 0)
-		wm8750_write(codec, WM8750_SRATE, srate |
+		snd_soc_write(codec, WM8750_SRATE, srate |
 			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
@@ -637,35 +594,35 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 static int wm8750_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8750_read_reg_cache(codec, WM8750_ADCDAC) & 0xfff7;
+	u16 mute_reg = snd_soc_read(codec, WM8750_ADCDAC) & 0xfff7;
 
 	if (mute)
-		wm8750_write(codec, WM8750_ADCDAC, mute_reg | 0x8);
+		snd_soc_write(codec, WM8750_ADCDAC, mute_reg | 0x8);
 	else
-		wm8750_write(codec, WM8750_ADCDAC, mute_reg);
+		snd_soc_write(codec, WM8750_ADCDAC, mute_reg);
 	return 0;
 }
 
 static int wm8750_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 pwr_reg = wm8750_read_reg_cache(codec, WM8750_PWR1) & 0xfe3e;
+	u16 pwr_reg = snd_soc_read(codec, WM8750_PWR1) & 0xfe3e;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x00c0);
+		snd_soc_write(codec, WM8750_PWR1, pwr_reg | 0x00c0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* set vmid to 5k for quick power up */
-		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x01c1);
+		snd_soc_write(codec, WM8750_PWR1, pwr_reg | 0x01c1);
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* mute dac and set vmid to 500k, enable VREF */
-		wm8750_write(codec, WM8750_PWR1, pwr_reg | 0x0141);
+		snd_soc_write(codec, WM8750_PWR1, pwr_reg | 0x0141);
 		break;
 	case SND_SOC_BIAS_OFF:
-		wm8750_write(codec, WM8750_PWR1, 0x0001);
+		snd_soc_write(codec, WM8750_PWR1, 0x0001);
 		break;
 	}
 	codec->bias_level = level;
@@ -761,8 +718,6 @@ static int wm8750_init(struct snd_soc_device *socdev)
 
 	codec->name = "WM8750";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8750_read_reg_cache;
-	codec->write = wm8750_write;
 	codec->set_bias_level = wm8750_set_bias_level;
 	codec->dai = &wm8750_dai;
 	codec->num_dai = 1;
@@ -771,13 +726,23 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	wm8750_reset(codec);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	ret = wm8750_reset(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8750: failed to reset: %d\n", ret);
+		goto err;
+	}
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to create pcms\n");
-		goto pcm_err;
+		goto err;
 	}
 
 	/* charge output caps */
@@ -786,22 +751,22 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	schedule_delayed_work(&codec->delayed_work, msecs_to_jiffies(1000));
 
 	/* set the update bits */
-	reg = wm8750_read_reg_cache(codec, WM8750_LDAC);
-	wm8750_write(codec, WM8750_LDAC, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_RDAC);
-	wm8750_write(codec, WM8750_RDAC, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_LOUT1V);
-	wm8750_write(codec, WM8750_LOUT1V, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_ROUT1V);
-	wm8750_write(codec, WM8750_ROUT1V, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_LOUT2V);
-	wm8750_write(codec, WM8750_LOUT2V, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_ROUT2V);
-	wm8750_write(codec, WM8750_ROUT2V, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_LINVOL);
-	wm8750_write(codec, WM8750_LINVOL, reg | 0x0100);
-	reg = wm8750_read_reg_cache(codec, WM8750_RINVOL);
-	wm8750_write(codec, WM8750_RINVOL, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_LDAC);
+	snd_soc_write(codec, WM8750_LDAC, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_RDAC);
+	snd_soc_write(codec, WM8750_RDAC, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_LOUT1V);
+	snd_soc_write(codec, WM8750_LOUT1V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_ROUT1V);
+	snd_soc_write(codec, WM8750_ROUT1V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_LOUT2V);
+	snd_soc_write(codec, WM8750_LOUT2V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_ROUT2V);
+	snd_soc_write(codec, WM8750_ROUT2V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_LINVOL);
+	snd_soc_write(codec, WM8750_LINVOL, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8750_RINVOL);
+	snd_soc_write(codec, WM8750_RINVOL, reg | 0x0100);
 
 	snd_soc_add_controls(codec, wm8750_snd_controls,
 				ARRAY_SIZE(wm8750_snd_controls));
@@ -816,7 +781,7 @@ static int wm8750_init(struct snd_soc_device *socdev)
 card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-pcm_err:
+err:
 	kfree(codec->reg_cache);
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d1769e6..c529ffc 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -69,61 +69,7 @@ struct wm8960_priv {
 	struct snd_soc_codec codec;
 };
 
-/*
- * read wm8960 register cache
- */
-static inline unsigned int wm8960_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg == WM8960_RESET)
-		return 0;
-	if (reg >= WM8960_CACHEREGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write wm8960 register cache
- */
-static inline void wm8960_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg >= WM8960_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-static inline unsigned int wm8960_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	return wm8960_read_reg_cache(codec, reg);
-}
-
-/*
- * write to the WM8960 register space
- */
-static int wm8960_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8960 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8960_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8960_reset(c)	wm8960_write(c, WM8960_RESET, 0)
+#define wm8960_reset(c)	snd_soc_write(c, WM8960_RESET, 0)
 
 /* enumerated controls */
 static const char *wm8960_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
@@ -420,7 +366,7 @@ static int wm8960_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	wm8960_write(codec, WM8960_IFACE1, iface);
+	snd_soc_write(codec, WM8960_IFACE1, iface);
 	return 0;
 }
 
@@ -431,7 +377,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 iface = wm8960_read(codec, WM8960_IFACE1) & 0xfff3;
+	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -446,19 +392,19 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface */
-	wm8960_write(codec, WM8960_IFACE1, iface);
+	snd_soc_write(codec, WM8960_IFACE1, iface);
 	return 0;
 }
 
 static int wm8960_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8960_read(codec, WM8960_DACCTL1) & 0xfff7;
+	u16 mute_reg = snd_soc_read(codec, WM8960_DACCTL1) & 0xfff7;
 
 	if (mute)
-		wm8960_write(codec, WM8960_DACCTL1, mute_reg | 0x8);
+		snd_soc_write(codec, WM8960_DACCTL1, mute_reg | 0x8);
 	else
-		wm8960_write(codec, WM8960_DACCTL1, mute_reg);
+		snd_soc_write(codec, WM8960_DACCTL1, mute_reg);
 	return 0;
 }
 
@@ -474,16 +420,16 @@ static int wm8960_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* Set VMID to 2x50k */
-		reg = wm8960_read(codec, WM8960_POWER1);
+		reg = snd_soc_read(codec, WM8960_POWER1);
 		reg &= ~0x180;
 		reg |= 0x80;
-		wm8960_write(codec, WM8960_POWER1, reg);
+		snd_soc_write(codec, WM8960_POWER1, reg);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable anti-pop features */
-			wm8960_write(codec, WM8960_APOP1,
+			snd_soc_write(codec, WM8960_APOP1,
 				     WM8960_POBCTRL | WM8960_SOFT_ST |
 				     WM8960_BUFDCOPEN | WM8960_BUFIOEN);
 
@@ -491,43 +437,43 @@ static int wm8960_set_bias_level(struct snd_soc_codec *codec,
 			reg = WM8960_DISOP;
 			if (pdata)
 				reg |= pdata->dres << 4;
-			wm8960_write(codec, WM8960_APOP2, reg);
+			snd_soc_write(codec, WM8960_APOP2, reg);
 
 			msleep(400);
 
-			wm8960_write(codec, WM8960_APOP2, 0);
+			snd_soc_write(codec, WM8960_APOP2, 0);
 
 			/* Enable & ramp VMID at 2x50k */
-			reg = wm8960_read(codec, WM8960_POWER1);
+			reg = snd_soc_read(codec, WM8960_POWER1);
 			reg |= 0x80;
-			wm8960_write(codec, WM8960_POWER1, reg);
+			snd_soc_write(codec, WM8960_POWER1, reg);
 			msleep(100);
 
 			/* Enable VREF */
-			wm8960_write(codec, WM8960_POWER1, reg | WM8960_VREF);
+			snd_soc_write(codec, WM8960_POWER1, reg | WM8960_VREF);
 
 			/* Disable anti-pop features */
-			wm8960_write(codec, WM8960_APOP1, WM8960_BUFIOEN);
+			snd_soc_write(codec, WM8960_APOP1, WM8960_BUFIOEN);
 		}
 
 		/* Set VMID to 2x250k */
-		reg = wm8960_read(codec, WM8960_POWER1);
+		reg = snd_soc_read(codec, WM8960_POWER1);
 		reg &= ~0x180;
 		reg |= 0x100;
-		wm8960_write(codec, WM8960_POWER1, reg);
+		snd_soc_write(codec, WM8960_POWER1, reg);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Enable anti-pop features */
-		wm8960_write(codec, WM8960_APOP1,
+		snd_soc_write(codec, WM8960_APOP1,
 			     WM8960_POBCTRL | WM8960_SOFT_ST |
 			     WM8960_BUFDCOPEN | WM8960_BUFIOEN);
 
 		/* Disable VMID and VREF, let them discharge */
-		wm8960_write(codec, WM8960_POWER1, 0);
+		snd_soc_write(codec, WM8960_POWER1, 0);
 		msleep(600);
 
-		wm8960_write(codec, WM8960_APOP1, 0);
+		snd_soc_write(codec, WM8960_APOP1, 0);
 		break;
 	}
 
@@ -610,33 +556,33 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai,
 
 	/* Disable the PLL: even if we are changing the frequency the
 	 * PLL needs to be disabled while we do so. */
-	wm8960_write(codec, WM8960_CLOCK1,
-		     wm8960_read(codec, WM8960_CLOCK1) & ~1);
-	wm8960_write(codec, WM8960_POWER2,
-		     wm8960_read(codec, WM8960_POWER2) & ~1);
+	snd_soc_write(codec, WM8960_CLOCK1,
+		     snd_soc_read(codec, WM8960_CLOCK1) & ~1);
+	snd_soc_write(codec, WM8960_POWER2,
+		     snd_soc_read(codec, WM8960_POWER2) & ~1);
 
 	if (!freq_in || !freq_out)
 		return 0;
 
-	reg = wm8960_read(codec, WM8960_PLL1) & ~0x3f;
+	reg = snd_soc_read(codec, WM8960_PLL1) & ~0x3f;
 	reg |= pll_div.pre_div << 4;
 	reg |= pll_div.n;
 
 	if (pll_div.k) {
 		reg |= 0x20;
 
-		wm8960_write(codec, WM8960_PLL2, (pll_div.k >> 18) & 0x3f);
-		wm8960_write(codec, WM8960_PLL3, (pll_div.k >> 9) & 0x1ff);
-		wm8960_write(codec, WM8960_PLL4, pll_div.k & 0x1ff);
+		snd_soc_write(codec, WM8960_PLL2, (pll_div.k >> 18) & 0x3f);
+		snd_soc_write(codec, WM8960_PLL3, (pll_div.k >> 9) & 0x1ff);
+		snd_soc_write(codec, WM8960_PLL4, pll_div.k & 0x1ff);
 	}
-	wm8960_write(codec, WM8960_PLL1, reg);
+	snd_soc_write(codec, WM8960_PLL1, reg);
 
 	/* Turn it on */
-	wm8960_write(codec, WM8960_POWER2,
-		     wm8960_read(codec, WM8960_POWER2) | 1);
+	snd_soc_write(codec, WM8960_POWER2,
+		     snd_soc_read(codec, WM8960_POWER2) | 1);
 	msleep(250);
-	wm8960_write(codec, WM8960_CLOCK1,
-		     wm8960_read(codec, WM8960_CLOCK1) | 1);
+	snd_soc_write(codec, WM8960_CLOCK1,
+		     snd_soc_read(codec, WM8960_CLOCK1) | 1);
 
 	return 0;
 }
@@ -649,28 +595,28 @@ static int wm8960_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8960_SYSCLKSEL:
-		reg = wm8960_read(codec, WM8960_CLOCK1) & 0x1fe;
-		wm8960_write(codec, WM8960_CLOCK1, reg | div);
+		reg = snd_soc_read(codec, WM8960_CLOCK1) & 0x1fe;
+		snd_soc_write(codec, WM8960_CLOCK1, reg | div);
 		break;
 	case WM8960_SYSCLKDIV:
-		reg = wm8960_read(codec, WM8960_CLOCK1) & 0x1f9;
-		wm8960_write(codec, WM8960_CLOCK1, reg | div);
+		reg = snd_soc_read(codec, WM8960_CLOCK1) & 0x1f9;
+		snd_soc_write(codec, WM8960_CLOCK1, reg | div);
 		break;
 	case WM8960_DACDIV:
-		reg = wm8960_read(codec, WM8960_CLOCK1) & 0x1c7;
-		wm8960_write(codec, WM8960_CLOCK1, reg | div);
+		reg = snd_soc_read(codec, WM8960_CLOCK1) & 0x1c7;
+		snd_soc_write(codec, WM8960_CLOCK1, reg | div);
 		break;
 	case WM8960_OPCLKDIV:
-		reg = wm8960_read(codec, WM8960_PLL1) & 0x03f;
-		wm8960_write(codec, WM8960_PLL1, reg | div);
+		reg = snd_soc_read(codec, WM8960_PLL1) & 0x03f;
+		snd_soc_write(codec, WM8960_PLL1, reg | div);
 		break;
 	case WM8960_DCLKDIV:
-		reg = wm8960_read(codec, WM8960_CLOCK2) & 0x03f;
-		wm8960_write(codec, WM8960_CLOCK2, reg | div);
+		reg = snd_soc_read(codec, WM8960_CLOCK2) & 0x03f;
+		snd_soc_write(codec, WM8960_CLOCK2, reg | div);
 		break;
 	case WM8960_TOCLKSEL:
-		reg = wm8960_read(codec, WM8960_ADDCTL1) & 0x1fd;
-		wm8960_write(codec, WM8960_ADDCTL1, reg | div);
+		reg = snd_soc_read(codec, WM8960_ADDCTL1) & 0x1fd;
+		snd_soc_write(codec, WM8960_ADDCTL1, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -830,8 +776,6 @@ static int wm8960_register(struct wm8960_priv *wm8960)
 	codec->private_data = wm8960;
 	codec->name = "WM8960";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8960_read_reg_cache;
-	codec->write = wm8960_write;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8960_set_bias_level;
 	codec->dai = &wm8960_dai;
@@ -841,6 +785,12 @@ static int wm8960_register(struct wm8960_priv *wm8960)
 
 	memcpy(codec->reg_cache, wm8960_reg, sizeof(wm8960_reg));
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	ret = wm8960_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
@@ -852,26 +802,26 @@ static int wm8960_register(struct wm8960_priv *wm8960)
 	wm8960_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
-	reg = wm8960_read(codec, WM8960_LINVOL);
-	wm8960_write(codec, WM8960_LINVOL, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_RINVOL);
-	wm8960_write(codec, WM8960_RINVOL, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_LADC);
-	wm8960_write(codec, WM8960_LADC, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_RADC);
-	wm8960_write(codec, WM8960_RADC, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_LDAC);
-	wm8960_write(codec, WM8960_LDAC, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_RDAC);
-	wm8960_write(codec, WM8960_RDAC, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_LOUT1);
-	wm8960_write(codec, WM8960_LOUT1, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_ROUT1);
-	wm8960_write(codec, WM8960_ROUT1, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_LOUT2);
-	wm8960_write(codec, WM8960_LOUT2, reg | 0x100);
-	reg = wm8960_read(codec, WM8960_ROUT2);
-	wm8960_write(codec, WM8960_ROUT2, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_LINVOL);
+	snd_soc_write(codec, WM8960_LINVOL, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_RINVOL);
+	snd_soc_write(codec, WM8960_RINVOL, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_LADC);
+	snd_soc_write(codec, WM8960_LADC, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_RADC);
+	snd_soc_write(codec, WM8960_RADC, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_LDAC);
+	snd_soc_write(codec, WM8960_LDAC, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_RDAC);
+	snd_soc_write(codec, WM8960_RDAC, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_LOUT1);
+	snd_soc_write(codec, WM8960_LOUT1, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_ROUT1);
+	snd_soc_write(codec, WM8960_ROUT1, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_LOUT2);
+	snd_soc_write(codec, WM8960_LOUT2, reg | 0x100);
+	reg = snd_soc_read(codec, WM8960_ROUT2);
+	snd_soc_write(codec, WM8960_ROUT2, reg | 0x100);
 
 	wm8960_codec = codec;
 
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 032dca2..53f3bc9 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -59,44 +59,7 @@ static const u16 wm8971_reg[] = {
 	0x0079, 0x0079, 0x0079,          /* 40 */
 };
 
-static inline unsigned int wm8971_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg < WM8971_REG_COUNT)
-		return cache[reg];
-
-	return -1;
-}
-
-static inline void wm8971_write_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg < WM8971_REG_COUNT)
-		cache[reg] = value;
-}
-
-static int wm8971_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8753 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8971_write_reg_cache (codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8971_reset(c)	wm8971_write(c, WM8971_RESET, 0)
+#define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
 
 /* WM8971 Controls */
 static const char *wm8971_bass[] = { "Linear Control", "Adaptive Boost" };
@@ -521,7 +484,7 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8971_write(codec, WM8971_IFACE, iface);
+	snd_soc_write(codec, WM8971_IFACE, iface);
 	return 0;
 }
 
@@ -533,8 +496,8 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8971_priv *wm8971 = codec->private_data;
-	u16 iface = wm8971_read_reg_cache(codec, WM8971_IFACE) & 0x1f3;
-	u16 srate = wm8971_read_reg_cache(codec, WM8971_SRATE) & 0x1c0;
+	u16 iface = snd_soc_read(codec, WM8971_IFACE) & 0x1f3;
+	u16 srate = snd_soc_read(codec, WM8971_SRATE) & 0x1c0;
 	int coeff = get_coeff(wm8971->sysclk, params_rate(params));
 
 	/* bit size */
@@ -553,9 +516,9 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	wm8971_write(codec, WM8971_IFACE, iface);
+	snd_soc_write(codec, WM8971_IFACE, iface);
 	if (coeff >= 0)
-		wm8971_write(codec, WM8971_SRATE, srate |
+		snd_soc_write(codec, WM8971_SRATE, srate |
 			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
@@ -564,33 +527,33 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8971_read_reg_cache(codec, WM8971_ADCDAC) & 0xfff7;
+	u16 mute_reg = snd_soc_read(codec, WM8971_ADCDAC) & 0xfff7;
 
 	if (mute)
-		wm8971_write(codec, WM8971_ADCDAC, mute_reg | 0x8);
+		snd_soc_write(codec, WM8971_ADCDAC, mute_reg | 0x8);
 	else
-		wm8971_write(codec, WM8971_ADCDAC, mute_reg);
+		snd_soc_write(codec, WM8971_ADCDAC, mute_reg);
 	return 0;
 }
 
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
-	u16 pwr_reg = wm8971_read_reg_cache(codec, WM8971_PWR1) & 0xfe3e;
+	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		wm8971_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
+		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* mute dac and set vmid to 500k, enable VREF */
-		wm8971_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
+		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
 		break;
 	case SND_SOC_BIAS_OFF:
-		wm8971_write(codec, WM8971_PWR1, 0x0001);
+		snd_soc_write(codec, WM8971_PWR1, 0x0001);
 		break;
 	}
 	codec->bias_level = level;
@@ -667,8 +630,8 @@ static int wm8971_resume(struct platform_device *pdev)
 
 	/* charge wm8971 caps */
 	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
-		reg = wm8971_read_reg_cache(codec, WM8971_PWR1) & 0xfe3e;
-		wm8971_write(codec, WM8971_PWR1, reg | 0x01c0);
+		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
+		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 		codec->bias_level = SND_SOC_BIAS_ON;
 		queue_delayed_work(wm8971_workq, &codec->delayed_work,
 			msecs_to_jiffies(1000));
@@ -684,8 +647,6 @@ static int wm8971_init(struct snd_soc_device *socdev)
 
 	codec->name = "WM8971";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8971_read_reg_cache;
-	codec->write = wm8971_write;
 	codec->set_bias_level = wm8971_set_bias_level;
 	codec->dai = &wm8971_dai;
 	codec->reg_cache_size = ARRAY_SIZE(wm8971_reg);
@@ -695,42 +656,48 @@ static int wm8971_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8971: failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	wm8971_reset(codec);
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to create pcms\n");
-		goto pcm_err;
+		goto err;
 	}
 
 	/* charge output caps - set vmid to 5k for quick power up */
-	reg = wm8971_read_reg_cache(codec, WM8971_PWR1) & 0xfe3e;
-	wm8971_write(codec, WM8971_PWR1, reg | 0x01c0);
+	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
+	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 	codec->bias_level = SND_SOC_BIAS_STANDBY;
 	queue_delayed_work(wm8971_workq, &codec->delayed_work,
 		msecs_to_jiffies(1000));
 
 	/* set the update bits */
-	reg = wm8971_read_reg_cache(codec, WM8971_LDAC);
-	wm8971_write(codec, WM8971_LDAC, reg | 0x0100);
-	reg = wm8971_read_reg_cache(codec, WM8971_RDAC);
-	wm8971_write(codec, WM8971_RDAC, reg | 0x0100);
-
-	reg = wm8971_read_reg_cache(codec, WM8971_LOUT1V);
-	wm8971_write(codec, WM8971_LOUT1V, reg | 0x0100);
-	reg = wm8971_read_reg_cache(codec, WM8971_ROUT1V);
-	wm8971_write(codec, WM8971_ROUT1V, reg | 0x0100);
-
-	reg = wm8971_read_reg_cache(codec, WM8971_LOUT2V);
-	wm8971_write(codec, WM8971_LOUT2V, reg | 0x0100);
-	reg = wm8971_read_reg_cache(codec, WM8971_ROUT2V);
-	wm8971_write(codec, WM8971_ROUT2V, reg | 0x0100);
-
-	reg = wm8971_read_reg_cache(codec, WM8971_LINVOL);
-	wm8971_write(codec, WM8971_LINVOL, reg | 0x0100);
-	reg = wm8971_read_reg_cache(codec, WM8971_RINVOL);
-	wm8971_write(codec, WM8971_RINVOL, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8971_LDAC);
+	snd_soc_write(codec, WM8971_LDAC, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8971_RDAC);
+	snd_soc_write(codec, WM8971_RDAC, reg | 0x0100);
+
+	reg = snd_soc_read(codec, WM8971_LOUT1V);
+	snd_soc_write(codec, WM8971_LOUT1V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8971_ROUT1V);
+	snd_soc_write(codec, WM8971_ROUT1V, reg | 0x0100);
+
+	reg = snd_soc_read(codec, WM8971_LOUT2V);
+	snd_soc_write(codec, WM8971_LOUT2V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8971_ROUT2V);
+	snd_soc_write(codec, WM8971_ROUT2V, reg | 0x0100);
+
+	reg = snd_soc_read(codec, WM8971_LINVOL);
+	snd_soc_write(codec, WM8971_LINVOL, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8971_RINVOL);
+	snd_soc_write(codec, WM8971_RINVOL, reg | 0x0100);
 
 	snd_soc_add_controls(codec, wm8971_snd_controls,
 				ARRAY_SIZE(wm8971_snd_controls));
@@ -745,7 +712,7 @@ static int wm8971_init(struct snd_soc_device *socdev)
 card_err:
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-pcm_err:
+err:
 	kfree(codec->reg_cache);
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 6f15acd..7d5b807 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -57,50 +57,7 @@ struct wm8988_priv {
 };
 
 
-/*
- * read wm8988 register cache
- */
-static inline unsigned int wm8988_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg > WM8988_NUM_REG)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write wm8988 register cache
- */
-static inline void wm8988_write_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg > WM8988_NUM_REG)
-		return;
-	cache[reg] = value;
-}
-
-static int wm8988_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 WM8753 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8988_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8988_reset(c)	wm8988_write(c, WM8988_RESET, 0)
+#define wm8988_reset(c)	snd_soc_write(c, WM8988_RESET, 0)
 
 /*
  * WM8988 Controls
@@ -226,15 +183,15 @@ static int wm8988_lrc_control(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u16 adctl2 = wm8988_read_reg_cache(codec, WM8988_ADCTL2);
+	u16 adctl2 = snd_soc_read(codec, WM8988_ADCTL2);
 
 	/* Use the DAC to gate LRC if active, otherwise use ADC */
-	if (wm8988_read_reg_cache(codec, WM8988_PWR2) & 0x180)
+	if (snd_soc_read(codec, WM8988_PWR2) & 0x180)
 		adctl2 &= ~0x4;
 	else
 		adctl2 |= 0x4;
 
-	return wm8988_write(codec, WM8988_ADCTL2, adctl2);
+	return snd_soc_write(codec, WM8988_ADCTL2, adctl2);
 }
 
 static const char *wm8988_line_texts[] = {
@@ -619,7 +576,7 @@ static int wm8988_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8988_write(codec, WM8988_IFACE, iface);
+	snd_soc_write(codec, WM8988_IFACE, iface);
 	return 0;
 }
 
@@ -653,8 +610,8 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8988_priv *wm8988 = codec->private_data;
-	u16 iface = wm8988_read_reg_cache(codec, WM8988_IFACE) & 0x1f3;
-	u16 srate = wm8988_read_reg_cache(codec, WM8988_SRATE) & 0x180;
+	u16 iface = snd_soc_read(codec, WM8988_IFACE) & 0x1f3;
+	u16 srate = snd_soc_read(codec, WM8988_SRATE) & 0x180;
 	int coeff;
 
 	coeff = get_coeff(wm8988->sysclk, params_rate(params));
@@ -685,9 +642,9 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	wm8988_write(codec, WM8988_IFACE, iface);
+	snd_soc_write(codec, WM8988_IFACE, iface);
 	if (coeff >= 0)
-		wm8988_write(codec, WM8988_SRATE, srate |
+		snd_soc_write(codec, WM8988_SRATE, srate |
 			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
@@ -696,19 +653,19 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 static int wm8988_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8988_read_reg_cache(codec, WM8988_ADCDAC) & 0xfff7;
+	u16 mute_reg = snd_soc_read(codec, WM8988_ADCDAC) & 0xfff7;
 
 	if (mute)
-		wm8988_write(codec, WM8988_ADCDAC, mute_reg | 0x8);
+		snd_soc_write(codec, WM8988_ADCDAC, mute_reg | 0x8);
 	else
-		wm8988_write(codec, WM8988_ADCDAC, mute_reg);
+		snd_soc_write(codec, WM8988_ADCDAC, mute_reg);
 	return 0;
 }
 
 static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 pwr_reg = wm8988_read_reg_cache(codec, WM8988_PWR1) & ~0x1c1;
+	u16 pwr_reg = snd_soc_read(codec, WM8988_PWR1) & ~0x1c1;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -716,24 +673,24 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VREF, VMID=2x50k, digital enabled */
-		wm8988_write(codec, WM8988_PWR1, pwr_reg | 0x00c0);
+		snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x00c0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* VREF, VMID=2x5k */
-			wm8988_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
+			snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
 
 			/* Charge caps */
 			msleep(100);
 		}
 
 		/* VREF, VMID=2*500k, digital stopped */
-		wm8988_write(codec, WM8988_PWR1, pwr_reg | 0x0141);
+		snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x0141);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		wm8988_write(codec, WM8988_PWR1, 0x0000);
+		snd_soc_write(codec, WM8988_PWR1, 0x0000);
 		break;
 	}
 	codec->bias_level = level;
@@ -887,8 +844,6 @@ static int wm8988_register(struct wm8988_priv *wm8988)
 	codec->private_data = wm8988;
 	codec->name = "WM8988";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8988_read_reg_cache;
-	codec->write = wm8988_write;
 	codec->dai = &wm8988_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = ARRAY_SIZE(wm8988->reg_cache);
@@ -899,6 +854,12 @@ static int wm8988_register(struct wm8988_priv *wm8988)
 	memcpy(codec->reg_cache, wm8988_reg,
 	       sizeof(wm8988_reg));
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	ret = wm8988_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
@@ -906,16 +867,16 @@ static int wm8988_register(struct wm8988_priv *wm8988)
 	}
 
 	/* set the update bits (we always update left then right) */
-	reg = wm8988_read_reg_cache(codec, WM8988_RADC);
-	wm8988_write(codec, WM8988_RADC, reg | 0x100);
-	reg = wm8988_read_reg_cache(codec, WM8988_RDAC);
-	wm8988_write(codec, WM8988_RDAC, reg | 0x0100);
-	reg = wm8988_read_reg_cache(codec, WM8988_ROUT1V);
-	wm8988_write(codec, WM8988_ROUT1V, reg | 0x0100);
-	reg = wm8988_read_reg_cache(codec, WM8988_ROUT2V);
-	wm8988_write(codec, WM8988_ROUT2V, reg | 0x0100);
-	reg = wm8988_read_reg_cache(codec, WM8988_RINVOL);
-	wm8988_write(codec, WM8988_RINVOL, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8988_RADC);
+	snd_soc_write(codec, WM8988_RADC, reg | 0x100);
+	reg = snd_soc_read(codec, WM8988_RDAC);
+	snd_soc_write(codec, WM8988_RDAC, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8988_ROUT1V);
+	snd_soc_write(codec, WM8988_ROUT1V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8988_ROUT2V);
+	snd_soc_write(codec, WM8988_ROUT2V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8988_RINVOL);
+	snd_soc_write(codec, WM8988_RINVOL, reg | 0x0100);
 
 	wm8988_set_bias_level(&wm8988->codec, SND_SOC_BIAS_STANDBY);
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
new file mode 100644
index 0000000..4eb4333
--- /dev/null
+++ b/sound/soc/soc-cache.c
@@ -0,0 +1,105 @@
+/*
+ * soc-cache.c  --  ASoC register cache helpers
+ *
+ * Copyright 2009 Wolfson Microelectronics PLC.
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <sound/soc.h>
+
+static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= codec->reg_cache_size)
+		return -1;
+	return cache[reg];
+}
+
+static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	u8 data[2];
+	int ret;
+
+	BUG_ON(codec->volatile_register);
+
+	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
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
+
+static struct {
+	int addr_bits;
+	int data_bits;
+	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+} io_types[] = {
+	{ 7, 9, snd_soc_7_9_write, snd_soc_7_9_read },
+};
+
+/**
+ * snd_soc_codec_set_cache_io: Set up standard I/O functions.
+ *
+ * @codec: CODEC to configure.
+ * @type: Type of cache.
+ * @addr_bits: Number of bits of register address data.
+ * @data_bits: Number of bits of data per register.
+ *
+ * Register formats are frequently shared between many I2C and SPI
+ * devices.  In order to promote code reuse the ASoC core provides
+ * some standard implementations of CODEC read and write operations
+ * which can be set up using this function.
+ *
+ * The caller is responsible for allocating and initialising the
+ * actual cache.
+ *
+ * Note that at present this code cannot be used by CODECs with
+ * volatile registers.
+ */
+int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
+			       int addr_bits, int data_bits)
+{
+	int i;
+
+	/* We don't support volatile registers yet - refactoring of
+	 * the hw_read operation will be required to do so. */
+	if (codec->volatile_register) {
+		printk(KERN_ERR "Volatile registers not yet supported\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(io_types); i++)
+		if (io_types[i].addr_bits == addr_bits &&
+		    io_types[i].data_bits == data_bits)
+			break;
+	if (i == ARRAY_SIZE(io_types)) {
+		printk(KERN_ERR
+		       "No I/O functions for %d bit address %d bit data\n",
+		       addr_bits, data_bits);
+		return -EINVAL;
+	}
+
+	codec->write = io_types[i].write;
+	codec->read = io_types[i].read;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-- 
1.6.3.3
