From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 05/10] asoc: codecs - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:07:52 +0100
Message-ID: <1215443272.4882.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAEFF103801
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:07:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


This patch merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai for the codec drivers.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c        |    2 +-
 sound/soc/codecs/ac97.h        |    2 +-
 sound/soc/codecs/ak4535.c      |    8 ++++----
 sound/soc/codecs/ak4535.h      |    2 +-
 sound/soc/codecs/cs4270.c      |    8 ++++----
 sound/soc/codecs/cs4270.h      |    2 +-
 sound/soc/codecs/tlv320aic3x.c |    8 ++++----
 sound/soc/codecs/tlv320aic3x.h |    2 +-
 sound/soc/codecs/uda1380.c     |    6 +++---
 sound/soc/codecs/uda1380.h     |    2 +-
 sound/soc/codecs/wm8510.c      |   10 +++++-----
 sound/soc/codecs/wm8510.h      |    2 +-
 sound/soc/codecs/wm8731.c      |    8 ++++----
 sound/soc/codecs/wm8731.h      |    2 +-
 sound/soc/codecs/wm8750.c      |    8 ++++----
 sound/soc/codecs/wm8750.h      |    2 +-
 sound/soc/codecs/wm8753.c      |   28 ++++++++++++++--------------
 sound/soc/codecs/wm8753.h      |    2 +-
 sound/soc/codecs/wm8990.c      |   12 ++++++------
 sound/soc/codecs/wm8990.h      |    2 +-
 sound/soc/codecs/wm9712.c      |    2 +-
 sound/soc/codecs/wm9712.h      |    2 +-
 sound/soc/codecs/wm9713.c      |   10 +++++-----
 sound/soc/codecs/wm9713.h      |    2 +-
 24 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index e4516f3..61fd96c 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -41,7 +41,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream)
 		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
 		SNDRV_PCM_RATE_48000)
 
-struct snd_soc_codec_dai ac97_dai = {
+struct snd_soc_dai ac97_dai = {
 	.name = "AC97 HiFi",
 	.type = SND_SOC_DAI_AC97,
 	.playback = {
diff --git a/sound/soc/codecs/ac97.h b/sound/soc/codecs/ac97.h
index 2bf6d69..281aa42 100644
--- a/sound/soc/codecs/ac97.h
+++ b/sound/soc/codecs/ac97.h
@@ -14,6 +14,6 @@
 #define __LINUX_SND_SOC_AC97_H
 
 extern struct snd_soc_codec_device soc_codec_dev_ac97;
-extern struct snd_soc_codec_dai ac97_dai;
+extern struct snd_soc_dai ac97_dai;
 
 #endif
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 469266e..b26003c 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -329,7 +329,7 @@ static int ak4535_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int ak4535_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int ak4535_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -369,7 +369,7 @@ static int ak4535_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ak4535_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int ak4535_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -394,7 +394,7 @@ static int ak4535_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int ak4535_mute(struct snd_soc_codec_dai *dai, int mute)
+static int ak4535_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = ak4535_read_reg_cache(codec, AK4535_DAC) & 0xffdf;
@@ -436,7 +436,7 @@ static int ak4535_set_bias_level(struct snd_soc_codec *codec,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 
-struct snd_soc_codec_dai ak4535_dai = {
+struct snd_soc_dai ak4535_dai = {
 	.name = "AK4535",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/ak4535.h b/sound/soc/codecs/ak4535.h
index fc686dd..e9fe30e 100644
--- a/sound/soc/codecs/ak4535.h
+++ b/sound/soc/codecs/ak4535.h
@@ -40,7 +40,7 @@ struct ak4535_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_codec_dai ak4535_dai;
+extern struct snd_soc_dai ak4535_dai;
 extern struct snd_soc_codec_device soc_codec_dev_ak4535;
 
 #endif
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index e73fcfd..9deb8c7 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -201,7 +201,7 @@ static struct {
  * driver what the input settings can be.  This would need to be implemented
  * for stand-alone mode to work.
  */
-static int cs4270_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -251,7 +251,7 @@ static int cs4270_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
  * data for playback only, but ASoC currently does not support different
  * formats for playback vs. record.
  */
-static int cs4270_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -471,7 +471,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
  * board does not have the MUTEA or MUTEB pins connected to such circuitry,
  * then this function will do nothing.
  */
-static int cs4270_mute(struct snd_soc_codec_dai *dai, int mute)
+static int cs4270_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	int reg6;
@@ -667,7 +667,7 @@ error:
 
 #endif /* USE_I2C*/
 
-struct snd_soc_codec_dai cs4270_dai = {
+struct snd_soc_dai cs4270_dai = {
 	.name = "CS4270",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/cs4270.h b/sound/soc/codecs/cs4270.h
index 0ced49b..adc6cd9 100644
--- a/sound/soc/codecs/cs4270.h
+++ b/sound/soc/codecs/cs4270.h
@@ -16,7 +16,7 @@
  * The ASoC codec DAI structure for the CS4270.  Assign this structure to
  * the .codec_dai field of your machine driver's snd_soc_dai_link structure.
  */
-extern struct snd_soc_codec_dai cs4270_dai;
+extern struct snd_soc_dai cs4270_dai;
 
 /*
  * The ASoC codec device structure for the CS4270.  Assign this structure
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 954d39b..b1dce5f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -814,7 +814,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int aic3x_mute(struct snd_soc_codec_dai *dai, int mute)
+static int aic3x_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u8 ldac_reg = aic3x_read_reg_cache(codec, LDAC_VOL) & ~MUTE_ON;
@@ -831,7 +831,7 @@ static int aic3x_mute(struct snd_soc_codec_dai *dai, int mute)
 	return 0;
 }
 
-static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int aic3x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -841,7 +841,7 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int aic3x_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			     unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -990,7 +990,7 @@ EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_codec_dai aic3x_dai = {
+struct snd_soc_dai aic3x_dai = {
 	.name = "aic3x",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index e600946..d76c079 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -228,7 +228,7 @@ struct aic3x_setup_data {
 	unsigned int gpio_func[2];
 };
 
-extern struct snd_soc_codec_dai aic3x_dai;
+extern struct snd_soc_dai aic3x_dai;
 extern struct snd_soc_codec_device soc_codec_dev_aic3x;
 
 #endif /* _AIC3X_H */
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 6d5335b..a52d6d9 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -372,7 +372,7 @@ static int uda1380_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int uda1380_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int uda1380_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -499,7 +499,7 @@ static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream)
 	uda1380_write(codec, UDA1380_CLK, clk);
 }
 
-static int uda1380_mute(struct snd_soc_codec_dai *codec_dai, int mute)
+static int uda1380_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 mute_reg = uda1380_read_reg_cache(codec, UDA1380_DEEMP) & ~R13_MTM;
@@ -542,7 +542,7 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 		       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
 		       SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 
-struct snd_soc_codec_dai uda1380_dai[] = {
+struct snd_soc_dai uda1380_dai[] = {
 {
 	.name = "UDA1380",
 	.playback = {
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index f9d885c..50c603e 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -83,7 +83,7 @@ struct uda1380_setup_data {
 #define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
 #define UDA1380_DAI_CAPTURE	2 /* capture DAI */
 
-extern struct snd_soc_codec_dai uda1380_dai[3];
+extern struct snd_soc_dai uda1380_dai[3];
 extern struct snd_soc_codec_device soc_codec_dev_uda1380;
 
 #endif /* _UDA1380_H */
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index b549f67..67325fd 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -332,7 +332,7 @@ static void pll_factors(unsigned int target, unsigned int source)
 	pll_div.k = K;
 }
 
-static int wm8510_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
+static int wm8510_set_dai_pll(struct snd_soc_dai *codec_dai,
 		int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -368,7 +368,7 @@ static int wm8510_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
 /*
  * Configure WM8510 clock dividers.
  */
-static int wm8510_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
+static int wm8510_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -402,7 +402,7 @@ static int wm8510_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int wm8510_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8510_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -510,7 +510,7 @@ static int wm8510_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8510_mute(struct snd_soc_codec_dai *dai, int mute)
+static int wm8510_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8510_read_reg_cache(codec, WM8510_DAC) & 0xffbf;
@@ -554,7 +554,7 @@ static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 #define WM8510_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_codec_dai wm8510_dai = {
+struct snd_soc_dai wm8510_dai = {
 	.name = "WM8510 HiFi",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/wm8510.h b/sound/soc/codecs/wm8510.h
index c862e7b..f5d2e42 100644
--- a/sound/soc/codecs/wm8510.h
+++ b/sound/soc/codecs/wm8510.h
@@ -97,7 +97,7 @@ struct wm8510_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_codec_dai wm8510_dai;
+extern struct snd_soc_dai wm8510_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8510;
 
 #endif
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 3ff42ad..369d39c 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -318,7 +318,7 @@ static void wm8731_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
-static int wm8731_mute(struct snd_soc_codec_dai *dai, int mute)
+static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8731_read_reg_cache(codec, WM8731_APDIGI) & 0xfff7;
@@ -330,7 +330,7 @@ static int wm8731_mute(struct snd_soc_codec_dai *dai, int mute)
 	return 0;
 }
 
-static int wm8731_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -349,7 +349,7 @@ static int wm8731_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 }
 
 
-static int wm8731_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -443,7 +443,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-struct snd_soc_codec_dai wm8731_dai = {
+struct snd_soc_dai wm8731_dai = {
 	.name = "WM8731",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index 5bcab6a..99f2e3c 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -38,7 +38,7 @@ struct wm8731_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_codec_dai wm8731_dai;
+extern struct snd_soc_dai wm8731_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8731;
 
 #endif
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index eb460c9..e23cb09 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -536,7 +536,7 @@ static inline int get_coeff(int mclk, int rate)
 	return -EINVAL;
 }
 
-static int wm8750_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int wm8750_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -554,7 +554,7 @@ static int wm8750_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 	return -EINVAL;
 }
 
-static int wm8750_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8750_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -647,7 +647,7 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8750_mute(struct snd_soc_codec_dai *dai, int mute)
+static int wm8750_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8750_read_reg_cache(codec, WM8750_ADCDAC) & 0xfff7;
@@ -692,7 +692,7 @@ static int wm8750_set_bias_level(struct snd_soc_codec *codec,
 #define WM8750_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-struct snd_soc_codec_dai wm8750_dai = {
+struct snd_soc_dai wm8750_dai = {
 	.name = "WM8750",
 	.playback = {
 		.stream_name = "Playback",
diff --git a/sound/soc/codecs/wm8750.h b/sound/soc/codecs/wm8750.h
index a97a54a..8ef30e6 100644
--- a/sound/soc/codecs/wm8750.h
+++ b/sound/soc/codecs/wm8750.h
@@ -61,7 +61,7 @@ struct wm8750_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_codec_dai wm8750_dai;
+extern struct snd_soc_dai wm8750_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8750;
 
 #endif
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index be01a73..8604809 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -740,7 +740,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int target,
 	pll_div->k = K;
 }
 
-static int wm8753_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_set_dai_pll(struct snd_soc_dai *codec_dai,
 		int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	u16 reg, enable;
@@ -863,7 +863,7 @@ static int get_coeff(int mclk, int rate)
 /*
  * Clock after PLL and dividers
  */
-static int wm8753_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -890,7 +890,7 @@ static int wm8753_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 /*
  * Set's ADC and Voice DAC format.
  */
-static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -960,7 +960,7 @@ static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
 /*
  * Set's PCM dai fmt and BCLK.
  */
-static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1026,7 +1026,7 @@ static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int wm8753_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1054,7 +1054,7 @@ static int wm8753_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
 /*
  * Set's HiFi DAC format.
  */
-static int wm8753_hdac_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_hdac_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1087,7 +1087,7 @@ static int wm8753_hdac_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 /*
  * Set's I2S DAI format.
  */
-static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1195,7 +1195,7 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8753_mode1v_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_mode1v_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1210,7 +1210,7 @@ static int wm8753_mode1v_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return wm8753_pcm_set_dai_fmt(codec_dai, fmt);
 }
 
-static int wm8753_mode1h_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_mode1h_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	if (wm8753_hdac_set_dai_fmt(codec_dai, fmt) < 0)
@@ -1218,7 +1218,7 @@ static int wm8753_mode1h_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return wm8753_i2s_set_dai_fmt(codec_dai, fmt);
 }
 
-static int wm8753_mode2_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_mode2_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1233,7 +1233,7 @@ static int wm8753_mode2_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return wm8753_i2s_set_dai_fmt(codec_dai, fmt);
 }
 
-static int wm8753_mode3_4_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8753_mode3_4_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1250,7 +1250,7 @@ static int wm8753_mode3_4_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return wm8753_i2s_set_dai_fmt(codec_dai, fmt);
 }
 
-static int wm8753_mute(struct snd_soc_codec_dai *dai, int mute)
+static int wm8753_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8753_read_reg_cache(codec, WM8753_DAC) & 0xfff7;
@@ -1316,7 +1316,7 @@ static int wm8753_set_bias_level(struct snd_soc_codec *codec,
  * 3. Voice disabled - HIFI over HIFI
  * 4. Voice disabled - HIFI over HIFI, uses voice DAI LRC for capture
  */
-static const struct snd_soc_codec_dai wm8753_all_dai[] = {
+static const struct snd_soc_dai wm8753_all_dai[] = {
 /* DAI HiFi mode 1 */
 {	.name = "WM8753 HiFi",
 	.id = 1,
@@ -1456,7 +1456,7 @@ static const struct snd_soc_codec_dai wm8753_all_dai[] = {
 },
 };
 
-struct snd_soc_codec_dai wm8753_dai[2];
+struct snd_soc_dai wm8753_dai[2];
 EXPORT_SYMBOL_GPL(wm8753_dai);
 
 static void wm8753_set_dai_mode(struct snd_soc_codec *codec, unsigned int mode)
diff --git a/sound/soc/codecs/wm8753.h b/sound/soc/codecs/wm8753.h
index 95e2a1f..44f5f1f 100644
--- a/sound/soc/codecs/wm8753.h
+++ b/sound/soc/codecs/wm8753.h
@@ -120,7 +120,7 @@ struct wm8753_setup_data {
 #define WM8753_DAI_HIFI		0
 #define WM8753_DAI_VOICE		1
 
-extern struct snd_soc_codec_dai wm8753_dai[2];
+extern struct snd_soc_dai wm8753_dai[2];
 extern struct snd_soc_codec_device soc_codec_dev_wm8753;
 
 #endif
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index a1371b7..3ecce51 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1029,7 +1029,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int target,
 	pll_div->k = K;
 }
 
-static int wm8990_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
+static int wm8990_set_dai_pll(struct snd_soc_dai *codec_dai,
 		int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	u16 reg;
@@ -1065,7 +1065,7 @@ static int wm8990_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
 /*
  * Clock after PLL and dividers
  */
-static int wm8990_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
+static int wm8990_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1078,7 +1078,7 @@ static int wm8990_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 /*
  * Set's ADC and Voice DAC format.
  */
-static int wm8990_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm8990_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1131,7 +1131,7 @@ static int wm8990_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int wm8990_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
+static int wm8990_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1196,7 +1196,7 @@ static int wm8990_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8990_mute(struct snd_soc_codec_dai *dai, int mute)
+static int wm8990_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 val;
@@ -1329,7 +1329,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
  * 1. ADC/DAC on Primary Interface
  * 2. ADC on Primary Interface/DAC on secondary
  */
-struct snd_soc_codec_dai wm8990_dai = {
+struct snd_soc_dai wm8990_dai = {
 /* ADC/DAC on primary */
 	.name = "WM8990 ADC/DAC Primary",
 	.id = 1,
diff --git a/sound/soc/codecs/wm8990.h b/sound/soc/codecs/wm8990.h
index bf9f882..6bea574 100644
--- a/sound/soc/codecs/wm8990.h
+++ b/sound/soc/codecs/wm8990.h
@@ -825,7 +825,7 @@ struct wm8990_setup_data {
 #define WM8990_ADCCLK_DIV 2
 #define WM8990_BCLK_DIV 3
 
-extern struct snd_soc_codec_dai wm8990_dai;
+extern struct snd_soc_dai wm8990_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8990;
 
 #endif	/* __WM8990REGISTERDEFS_H__ */
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 4739011..9fc8edd 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -532,7 +532,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream)
 		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
 		SNDRV_PCM_RATE_48000)
 
-struct snd_soc_codec_dai wm9712_dai[] = {
+struct snd_soc_dai wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.type = SND_SOC_DAI_AC97_BUS,
diff --git a/sound/soc/codecs/wm9712.h b/sound/soc/codecs/wm9712.h
index 719105d..d29e8a1 100644
--- a/sound/soc/codecs/wm9712.h
+++ b/sound/soc/codecs/wm9712.h
@@ -8,7 +8,7 @@
 #define WM9712_DAI_AC97_HIFI	0
 #define WM9712_DAI_AC97_AUX		1
 
-extern struct snd_soc_codec_dai wm9712_dai[2];
+extern struct snd_soc_dai wm9712_dai[2];
 extern struct snd_soc_codec_device soc_codec_dev_wm9712;
 
 #endif
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index a480618..38d1fe0 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -789,7 +789,7 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm9713_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
+static int wm9713_set_dai_pll(struct snd_soc_dai *codec_dai,
 		int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -800,7 +800,7 @@ static int wm9713_set_dai_pll(struct snd_soc_codec_dai *codec_dai,
  * Tristate the PCM DAI lines, tristate can be disabled by calling
  * wm9713_set_dai_fmt()
  */
-static int wm9713_set_dai_tristate(struct snd_soc_codec_dai *codec_dai,
+static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
 	int tristate)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -816,7 +816,7 @@ static int wm9713_set_dai_tristate(struct snd_soc_codec_dai *codec_dai,
  * Configure WM9713 clock dividers.
  * Voice DAC needs 256 FS
  */
-static int wm9713_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
+static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -858,7 +858,7 @@ static int wm9713_set_dai_clkdiv(struct snd_soc_codec_dai *codec_dai,
 	return 0;
 }
 
-static int wm9713_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1018,7 +1018,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream)
 	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
 	 SNDRV_PCM_FORMAT_S24_LE)
 
-struct snd_soc_codec_dai wm9713_dai[] = {
+struct snd_soc_dai wm9713_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.type = SND_SOC_DAI_AC97_BUS,
diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index d357b6c..63b8d81 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -46,7 +46,7 @@
 #define WM9713_DAI_PCM_VOICE	2
 
 extern struct snd_soc_codec_device soc_codec_dev_wm9713;
-extern struct snd_soc_codec_dai wm9713_dai[3];
+extern struct snd_soc_dai wm9713_dai[3];
 
 int wm9713_reset(struct snd_soc_codec *codec,  int try_warm);
 
-- 
1.5.4.2
