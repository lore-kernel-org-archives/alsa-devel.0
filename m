From: jassisinghbrar@gmail.com
Subject: [PATCH] WM8580 DAI: Debugged
Date: Sat, 12 Sep 2009 17:05:37 +0900
Message-ID: <1252742737-21925-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 289EF2464D
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 10:08:25 +0200 (CEST)
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
Cc: kgene.kim@samsung.com, Jassi <jassi.brar@samsung.com>, jsgood.yang@samsung.com, broonie@opensource.wolfsonmicro.com, ilho215.lee@samsung.com, thomas.ab@samsung.com, ki0351.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi <jassi.brar@samsung.com>

Debugged improper definition of 'struct snd_soc_dai wm8580_dai'
Also, implemented various clock sourcing options for WM8580 blocks.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/codecs/wm8580.c |  116 ++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/wm8580.h |   17 ++++---
 2 files changed, 93 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6bded8c..105d452 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -106,9 +106,16 @@
 
 /* CLKSEL (register 8h) */
 #define WM8580_CLKSEL_DAC_CLKSEL_MASK 0x03
+#define WM8580_CLKSEL_DAC_CLKSEL_MCLK 0x00
 #define WM8580_CLKSEL_DAC_CLKSEL_PLLA 0x01
 #define WM8580_CLKSEL_DAC_CLKSEL_PLLB 0x02
 
+#define WM8580_CLKSEL_ADC_CLKSEL_MASK     0x0c
+#define WM8580_CLKSEL_ADC_CLKSEL_ADCMCLK  0x00
+#define WM8580_CLKSEL_ADC_CLKSEL_PLLA     0x04
+#define WM8580_CLKSEL_ADC_CLKSEL_PLLB     0x08
+#define WM8580_CLKSEL_ADC_CLKSEL_MCLK     0x0c
+
 /* AIF control 1 (registers 9h-bh) */
 #define WM8580_AIF_RATE_MASK       0x7
 #define WM8580_AIF_RATE_128        0x0
@@ -121,15 +128,16 @@
 
 #define WM8580_AIF_BCLKSEL_MASK   0x18
 #define WM8580_AIF_BCLKSEL_64     0x00
-#define WM8580_AIF_BCLKSEL_128    0x08
-#define WM8580_AIF_BCLKSEL_256    0x10
+#define WM8580_AIF_BCLKSEL_32    0x08
+#define WM8580_AIF_BCLKSEL_16    0x10
 #define WM8580_AIF_BCLKSEL_SYSCLK 0x18
 
 #define WM8580_AIF_MS             0x20
 
 #define WM8580_AIF_CLKSRC_MASK    0xc0
+#define WM8580_AIF_CLKSRC_ADCMCLK 0x00
 #define WM8580_AIF_CLKSRC_PLLA    0x40
-#define WM8580_AIF_CLKSRC_PLLB    0x40
+#define WM8580_AIF_CLKSRC_PLLB    0x80
 #define WM8580_AIF_CLKSRC_MCLK    0xc0
 
 /* AIF control 2 (registers ch-eh) */
@@ -630,6 +638,7 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 		switch (div) {
 		case WM8580_CLKSRC_MCLK:
+			reg |= WM8580_CLKSEL_DAC_CLKSEL_MCLK;
 			break;
 
 		case WM8580_CLKSRC_PLLA:
@@ -646,6 +655,33 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_CLKSEL, reg);
 		break;
 
+	case WM8580_ADC_CLKSEL:
+		reg = snd_soc_read(codec, WM8580_CLKSEL);
+		reg &= ~WM8580_CLKSEL_ADC_CLKSEL_MASK;
+
+		switch (div) {
+		case WM8580_CLKSRC_ADCMCLK:
+			reg |= WM8580_CLKSEL_ADC_CLKSEL_ADCMCLK;
+			break;
+
+		case WM8580_CLKSRC_MCLK:
+			reg |= WM8580_CLKSEL_ADC_CLKSEL_MCLK;
+			break;
+
+		case WM8580_CLKSRC_PLLA:
+			reg |= WM8580_CLKSEL_ADC_CLKSEL_PLLA;
+			break;
+
+		case WM8580_CLKSRC_PLLB:
+			reg |= WM8580_CLKSEL_ADC_CLKSEL_PLLB;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+		snd_soc_write(codec, WM8580_CLKSEL, reg);
+		break;
+
 	case WM8580_CLKOUTSRC:
 		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_CLKOUTSRC_MASK;
@@ -672,6 +708,32 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;
 
+	case WM8580_PAIF_CLKSEL:
+		reg = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+		reg &= ~WM8580_AIF_CLKSRC_MASK;
+		switch (div) {
+		case WM8580_CLKSRC_ADCMCLK:
+			reg |= WM8580_AIF_CLKSRC_ADCMCLK;
+			break;
+
+		case WM8580_CLKSRC_PLLA:
+			reg |= WM8580_AIF_CLKSRC_PLLA;
+			break;
+
+		case WM8580_CLKSRC_PLLB:
+			reg |= WM8580_AIF_CLKSRC_PLLB;
+			break;
+
+		case WM8580_CLKSRC_MCLK:
+			reg |= WM8580_AIF_CLKSRC_MCLK;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+		snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, reg);
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -731,7 +793,7 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 #define WM8580_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
+static struct snd_soc_dai_ops wm8580_dai_ops = {
 	.hw_params	= wm8580_paif_hw_params,
 	.set_fmt	= wm8580_set_paif_dai_fmt,
 	.set_clkdiv	= wm8580_set_dai_clkdiv,
@@ -739,38 +801,26 @@ static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
 	.digital_mute	= wm8580_digital_mute,
 };
 
-static struct snd_soc_dai_ops wm8580_dai_ops_capture = {
-	.hw_params	= wm8580_paif_hw_params,
-	.set_fmt	= wm8580_set_paif_dai_fmt,
-	.set_clkdiv	= wm8580_set_dai_clkdiv,
-	.set_pll	= wm8580_set_dai_pll,
-};
-
 struct snd_soc_dai wm8580_dai[] = {
-	{
-		.name = "WM8580 PAIFRX",
-		.id = 0,
-		.playback = {
-			.stream_name = "Playback",
-			.channels_min = 1,
-			.channels_max = 6,
-			.rates = SNDRV_PCM_RATE_8000_192000,
-			.formats = WM8580_FORMATS,
-		},
-		.ops = &wm8580_dai_ops_playback,
+   {
+	.name = "WM8580 PAIF",
+	.id = 0,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 6,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = WM8580_FORMATS,
 	},
-	{
-		.name = "WM8580 PAIFTX",
-		.id = 1,
-		.capture = {
-			.stream_name = "Capture",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_192000,
-			.formats = WM8580_FORMATS,
-		},
-		.ops = &wm8580_dai_ops_capture,
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = WM8580_FORMATS,
 	},
+	.ops = &wm8580_dai_ops,
+   },
 };
 EXPORT_SYMBOL_GPL(wm8580_dai);
 
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 0dfb5dd..65f9225 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -20,13 +20,16 @@
 
 #define WM8580_MCLK       1
 #define WM8580_DAC_CLKSEL 2
-#define WM8580_CLKOUTSRC  3
-
-#define WM8580_CLKSRC_MCLK 1
-#define WM8580_CLKSRC_PLLA 2
-#define WM8580_CLKSRC_PLLB 3
-#define WM8580_CLKSRC_OSC  4
-#define WM8580_CLKSRC_NONE 5
+#define WM8580_ADC_CLKSEL 3
+#define WM8580_CLKOUTSRC  4
+#define WM8580_PAIF_CLKSEL 5
+
+#define WM8580_CLKSRC_ADCMCLK 0
+#define WM8580_CLKSRC_MCLK    1
+#define WM8580_CLKSRC_PLLA    2
+#define WM8580_CLKSRC_PLLB    3
+#define WM8580_CLKSRC_OSC     4
+#define WM8580_CLKSRC_NONE    5
 
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1
-- 
1.6.2.5
