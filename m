From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support non-crystal master clocks for
	WM8731
Date: Wed, 18 Aug 2010 16:19:53 +0100
Message-ID: <1282144793-32137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4144A2453A
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 17:19:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Instead of unconditionally enabling the crystal oscillator on the WM8731
only enable it when explicitly selected via set_sysclk(), allowing machine
drivers to specify that they drive a clock into MCLK alone. This avoids
any conflicts between the oscillator and the external MCLK source and saves
power for systems which do not need the oscillator.

This should also deliver a small power saving on systems using the crystal
since the oscillator will only be enabled when the ADC or DAC is active.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 sound/soc/au1x/db1200.c          |    2 +-
 sound/soc/codecs/wm8731.c        |   31 +++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8731.h        |    4 +++-
 sound/soc/pxa/corgi.c            |    2 +-
 sound/soc/pxa/poodle.c           |    2 +-
 6 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 66a6f18..8399ac4 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -146,7 +146,7 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 			"at91sam9g20ek_wm8731 "
 			": at91sam9g20ek_wm8731_init() called\n");
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
 		MCLK_RATE, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to set WM8731 SYSCLK: %d\n", ret);
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 8780c90..d8dc822 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -49,7 +49,7 @@ static int db1200_i2s_startup(struct snd_pcm_substream *substream)
 	int ret;
 
 	/* WM8731 has its own 12MHz crystal */
-	snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+	snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
 				12000000, SND_SOC_CLOCK_IN);
 
 	/* codec is bitclock and lrclk master */
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 19844fc..56f5408 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -46,6 +46,7 @@ struct wm8731_priv {
 	struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
 	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
+	int sysclk_type;
 };
 
 
@@ -110,6 +111,7 @@ static const struct snd_kcontrol_new wm8731_input_mux_controls =
 SOC_DAPM_ENUM("Input Select", wm8731_enum[0]);
 
 static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("OSC", WM8731_PWR, 5, 1, NULL, 0),
 SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1,
 	&wm8731_output_mixer_controls[0],
 	ARRAY_SIZE(wm8731_output_mixer_controls)),
@@ -127,7 +129,18 @@ SND_SOC_DAPM_INPUT("RLINEIN"),
 SND_SOC_DAPM_INPUT("LLINEIN"),
 };
 
+static int wm8731_check_osc(struct snd_soc_dapm_widget *source,
+			    struct snd_soc_dapm_widget *sink)
+{
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(source->codec);
+
+	return wm8731->sysclk_type == WM8731_SYSCLK_MCLK;
+}
+
 static const struct snd_soc_dapm_route intercon[] = {
+	{"DAC", NULL, "OSC", wm8731_check_osc},
+	{"ADC", NULL, "OSC", wm8731_check_osc},
+
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
@@ -285,6 +298,15 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 
+	switch (clk_id) {
+	case WM8731_SYSCLK_XTAL:
+	case WM8731_SYSCLK_MCLK:
+		wm8731->sysclk_type = clk_id;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	switch (freq) {
 	case 11289600:
 	case 12000000:
@@ -292,9 +314,14 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
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
+	snd_soc_dapm_sync(codec);
+
+	return 0;
 }
 
 
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index 73a70e2..e9c0c76 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -31,7 +31,9 @@
 
 #define WM8731_CACHEREGNUM 	10
 
-#define WM8731_SYSCLK	0
+#define WM8731_SYSCLK_XTAL 1
+#define WM8731_SYSCLK_MCLK 2
+
 #define WM8731_DAI		0
 
 #endif
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 11c6a49..7325b66 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -150,7 +150,7 @@ static int corgi_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 3ba5a96..9e63745 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -128,7 +128,7 @@ static int poodle_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
-- 
1.7.1
