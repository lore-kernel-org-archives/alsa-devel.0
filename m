From: Bill Gatliff <bgat@billgatliff.com>
Subject: [PATCH] Add support for CLKOUT to wm8731 codec driver
Date: Thu, 29 Oct 2009 10:13:22 -0500
Message-ID: <1256829202-2508-2-git-send-email-bgat@billgatliff.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DE46103820
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 16:13:31 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so937389fgg.2
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 08:13:31 -0700 (PDT)
In-Reply-To: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
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
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 sound/soc/codecs/wm8731.c |  165 +++++++++++++++++++++++++-------------------
 sound/soc/codecs/wm8731.h |   20 +++++-
 2 files changed, 113 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 801b626..0e20956 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -29,6 +29,8 @@
 
 #include "wm8731.h"
 
+#define PREFIX "wm8731: "
+
 static struct snd_soc_codec *wm8731_codec;
 struct snd_soc_codec_device soc_codec_dev_wm8731;
 
@@ -50,16 +52,17 @@ static int wm8731_spi_write(struct spi_device *spi, const char *data, int len);
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
 
 /*
  * read wm8731 register cache
  */
-static inline unsigned int wm8731_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
+static inline unsigned int
+wm8731_read_reg_cache(struct snd_soc_codec *codec,
+		      unsigned int reg)
 {
 	u16 *cache = codec->reg_cache;
 	if (reg == WM8731_RESET)
@@ -72,8 +75,9 @@ static inline unsigned int wm8731_read_reg_cache(struct snd_soc_codec *codec,
 /*
  * write wm8731 register cache
  */
-static inline void wm8731_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
+static inline void
+wm8731_write_reg_cache(struct snd_soc_codec *codec,
+		       u16 reg, unsigned int value)
 {
 	u16 *cache = codec->reg_cache;
 	if (reg >= WM8731_CACHEREGNUM)
@@ -84,11 +88,13 @@ static inline void wm8731_write_reg_cache(struct snd_soc_codec *codec,
 /*
  * write to the WM8731 register space
  */
-static int wm8731_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
+static inline int
+wm8731_write(struct snd_soc_codec *codec,
+	     unsigned int reg, unsigned int value)
 {
 	u8 data[2];
 
+
 	/* data is
 	 *   D15..D9 WM8731 register offset
 	 *   D8...D0 register data
@@ -115,52 +121,52 @@ static const struct soc_enum wm8731_enum[] = {
 
 static const struct snd_kcontrol_new wm8731_snd_controls[] = {
 
-SOC_DOUBLE_R("Master Playback Volume", WM8731_LOUT1V, WM8731_ROUT1V,
-	0, 127, 0),
-SOC_DOUBLE_R("Master Playback ZC Switch", WM8731_LOUT1V, WM8731_ROUT1V,
-	7, 1, 0),
+	SOC_DOUBLE_R("Master Playback Volume", WM8731_LOUT1V, WM8731_ROUT1V,
+		     0, 127, 0),
+	SOC_DOUBLE_R("Master Playback ZC Switch", WM8731_LOUT1V, WM8731_ROUT1V,
+		     7, 1, 0),
 
-SOC_DOUBLE_R("Capture Volume", WM8731_LINVOL, WM8731_RINVOL, 0, 31, 0),
-SOC_DOUBLE_R("Line Capture Switch", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
+	SOC_DOUBLE_R("Capture Volume", WM8731_LINVOL, WM8731_RINVOL, 0, 31, 0),
+	SOC_DOUBLE_R("Line Capture Switch", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
 
-SOC_SINGLE("Mic Boost (+20dB)", WM8731_APANA, 0, 1, 0),
-SOC_SINGLE("Capture Mic Switch", WM8731_APANA, 1, 1, 1),
+	SOC_SINGLE("Mic Boost (+20dB)", WM8731_APANA, 0, 1, 0),
+	SOC_SINGLE("Capture Mic Switch", WM8731_APANA, 1, 1, 1),
 
-SOC_SINGLE("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1),
+	SOC_SINGLE("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1),
 
-SOC_SINGLE("ADC High Pass Filter Switch", WM8731_APDIGI, 0, 1, 1),
-SOC_SINGLE("Store DC Offset Switch", WM8731_APDIGI, 4, 1, 0),
+	SOC_SINGLE("ADC High Pass Filter Switch", WM8731_APDIGI, 0, 1, 1),
+	SOC_SINGLE("Store DC Offset Switch", WM8731_APDIGI, 4, 1, 0),
 
-SOC_ENUM("Playback De-emphasis", wm8731_enum[1]),
+	SOC_ENUM("Playback De-emphasis", wm8731_enum[1]),
 };
 
 /* Output Mixer */
 static const struct snd_kcontrol_new wm8731_output_mixer_controls[] = {
-SOC_DAPM_SINGLE("Line Bypass Switch", WM8731_APANA, 3, 1, 0),
-SOC_DAPM_SINGLE("Mic Sidetone Switch", WM8731_APANA, 5, 1, 0),
-SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
+	SOC_DAPM_SINGLE("Line Bypass Switch", WM8731_APANA, WM8731_APANA_BYPASS, 1, 0),
+	SOC_DAPM_SINGLE("Mic Sidetone Switch", WM8731_APANA, WM8731_APANA_SIDETONE, 1, 0),
+	SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, WM8731_APANA_DACSEL, 1, 0),
 };
 
 /* Input mux */
 static const struct snd_kcontrol_new wm8731_input_mux_controls =
-SOC_DAPM_ENUM("Input Select", wm8731_enum[0]);
+	SOC_DAPM_ENUM("Input Select", wm8731_enum[0]);
 
 static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
-SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1,
-	&wm8731_output_mixer_controls[0],
-	ARRAY_SIZE(wm8731_output_mixer_controls)),
-SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8731_PWR, 3, 1),
-SND_SOC_DAPM_OUTPUT("LOUT"),
-SND_SOC_DAPM_OUTPUT("LHPOUT"),
-SND_SOC_DAPM_OUTPUT("ROUT"),
-SND_SOC_DAPM_OUTPUT("RHPOUT"),
-SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8731_PWR, 2, 1),
-SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &wm8731_input_mux_controls),
-SND_SOC_DAPM_PGA("Line Input", WM8731_PWR, 0, 1, NULL, 0),
-SND_SOC_DAPM_MICBIAS("Mic Bias", WM8731_PWR, 1, 1),
-SND_SOC_DAPM_INPUT("MICIN"),
-SND_SOC_DAPM_INPUT("RLINEIN"),
-SND_SOC_DAPM_INPUT("LLINEIN"),
+	SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1,
+			   &wm8731_output_mixer_controls[0],
+			   ARRAY_SIZE(wm8731_output_mixer_controls)),
+	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8731_PWR, 3, 1),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+	SND_SOC_DAPM_OUTPUT("LHPOUT"),
+	SND_SOC_DAPM_OUTPUT("ROUT"),
+	SND_SOC_DAPM_OUTPUT("RHPOUT"),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8731_PWR, 2, 1),
+	SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &wm8731_input_mux_controls),
+	SND_SOC_DAPM_PGA("Line Input", WM8731_PWR, 0, 1, NULL, 0),
+	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8731_PWR, 1, 1),
+	SND_SOC_DAPM_INPUT("MICIN"),
+	SND_SOC_DAPM_INPUT("RLINEIN"),
+	SND_SOC_DAPM_INPUT("LLINEIN"),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -265,8 +271,6 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	u16 srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
 
-	wm8731_write(codec, WM8731_SRATE, srate);
-
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -277,8 +281,13 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		iface |= 0x0008;
 		break;
+	default:
+		pr_err("%s: unrecognized format %x\n",
+		       __func__, params_format(params));
+		return -EINVAL;
 	}
 
+	wm8731_write(codec, WM8731_SRATE, srate);
 	wm8731_write(codec, WM8731_IFACE, iface);
 	return 0;
 }
@@ -323,10 +332,13 @@ static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 }
 
 static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-		int clk_id, unsigned int freq, int dir)
+				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8731_priv *wm8731 = codec->private_data;
+	u16 reg;
+
+	pr_debug(PREFIX "%s\n", __func__);
 
 	switch (freq) {
 	case 11289600:
@@ -335,18 +347,35 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	case 16934400:
 	case 18432000:
 		wm8731->sysclk = freq;
-		return 0;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
+	if (dir == SND_SOC_CLOCK_OUT) {
+		dev_dbg(codec->dev, PREFIX "%s turning on CLKOUT\n", __func__);
+		reg = wm8731_read_reg_cache(codec, WM8731_PWR);
+		reg &= ~(1 << WM8731_PWR_CLKOUTPD);
+		wm8731_write(codec, WM8731_PWR, reg);
+	}
+	else {
+		dev_dbg(codec->dev, PREFIX "%s turning off CLKOUT\n", __func__);
+		reg = wm8731_read_reg_cache(codec, WM8731_PWR);
+		reg |= (1 << WM8731_PWR_CLKOUTPD);
+		wm8731_write(codec, WM8731_PWR, reg);
+	}
+	return 0;
 }
 
 
 static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
-		unsigned int fmt)
+			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 iface = 0;
 
+	pr_debug(PREFIX "%s\n", __func__);
+
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -405,25 +434,20 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 {
 	u16 reg;
 
+	pr_debug(PREFIX "%s\n", __func__);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-#warning "TODO: figure out how to turn on/off CLKOUT properly"
-		wm8731_write(codec, WM8731_PWR, 0);
-		break;
 	case SND_SOC_BIAS_PREPARE:
-#if 1
-#warning "TODO: figure out how to turn on/off CLKOUT properly"
-	  /* probably has to do with SND_SOC_CLOCK_OUT
-	     and whether we're master or slave ... */
-		wm8731_write(codec, WM8731_PWR, 0);
-#endif
-		break;
 	case SND_SOC_BIAS_STANDBY:
-#if 1
-		/* Clear PWROFF, gate CLKOUT, everything else as-is */
+		/* power up the part, but leave other power settings alone */
 		reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
-		wm8731_write(codec, WM8731_PWR, reg | 0x0040);
-#endif
+
+		/* turn off CLKOUT in STANDBY */
+		if (level == SND_SOC_BIAS_STANDBY)
+			reg |= (1 << WM8731_PWR_CLKOUTPD);
+
+		wm8731_write(codec, WM8731_PWR, reg);
 		break;
 	case SND_SOC_BIAS_OFF:
 		wm8731_write(codec, WM8731_ACTIVE, 0x0);
@@ -434,14 +458,14 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
-		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
-		SNDRV_PCM_RATE_96000)
+#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
+		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
+		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |	\
+		      SNDRV_PCM_RATE_96000)
 
-#define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-	SNDRV_PCM_FMTBIT_S24_LE)
+#define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_ops wm8731_dai_ops = {
 	.prepare	= wm8731_pcm_prepare,
@@ -608,8 +632,7 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 
 	/* Disable bypass path by default */
 	reg = wm8731_read_reg_cache(codec, WM8731_APANA);
-	wm8731_write(codec, WM8731_APANA, reg & ~0x4);
-
+	wm8731_write(codec, WM8731_APANA, reg & ~(1 << WM8731_APANA_BYPASS));
 	wm8731_codec = codec;
 
 	ret = snd_soc_register_codec(codec);
@@ -753,14 +776,14 @@ static int __init wm8731_modinit(void)
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8731_i2c_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8731 I2C driver: %d\n",
+		pr_err("Failed to register WM8731 I2C driver: %d\n",
 		       ret);
 	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8731_spi_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8731 SPI driver: %d\n",
+		pr_err("Failed to register WM8731 SPI driver: %d\n",
 		       ret);
 	}
 #endif
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index cd7b806..2e77393 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -31,9 +31,27 @@
 
 #define WM8731_CACHEREGNUM 	10
 
-#define WM8731_SYSCLK	0
+#define WM8731_SYSCLK		0
 #define WM8731_DAI		0
 
+#define WM8731_APANA_MICBOOST	0
+#define WM8731_APANA_MUTEMIC	1
+#define WM8731_APANA_INSEL	2
+#define WM8731_APANA_BYPASS	3
+#define WM8731_APANA_DACSEL	4
+#define WM8731_APANA_SIDETONE	5
+
+#define WM8731_PWR_LINEINPD	0
+#define WM8731_PWR_MICPD	1
+#define WM8731_PWR_ADCPD	2
+#define WM8731_PWR_DACPD	3
+#define WM8731_PWR_OUTPD	4
+#define WM8731_PWR_OSCPD	5
+#define WM8731_PWR_CLKOUTPD	6
+#define WM8731_PWR_POWEROFF	7
+
+
+
 extern struct snd_soc_dai wm8731_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8731;
 
-- 
1.5.6.5
