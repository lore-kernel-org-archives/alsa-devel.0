From: jassi brar <jassisinghbrar@gmail.com>
Subject: [PATCH] Minor WM8580 enhancements.
Date: Sun, 6 Sep 2009 09:09:41 +0900
Message-ID: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f204.google.com (mail-qy0-f204.google.com
	[209.85.221.204])
	by alsa0.perex.cz (Postfix) with ESMTP id D562E1037F5
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 02:09:42 +0200 (CEST)
Received: by qyk42 with SMTP id 42so1566623qyk.10
	for <alsa-devel@alsa-project.org>; Sat, 05 Sep 2009 17:09:41 -0700 (PDT)
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
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Add more options to select clock source for various blocks
in WM8580.
Also, explicitly set defaults for the sake of consistency.

Signed-off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/codecs/wm8580.c |  133 +++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8580.h |   25 +++++----
 2 files changed, 144 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6bded8c..276bc8e 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -95,6 +95,7 @@

 /* PLLB4 (register 7h) */
 #define WM8580_PLLB4_MCLKOUTSRC_MASK   0x60
+#define WM8580_PLLB4_MCLKOUTSRC_MCLK   0x00
 #define WM8580_PLLB4_MCLKOUTSRC_PLLA   0x20
 #define WM8580_PLLB4_MCLKOUTSRC_PLLB   0x40
 #define WM8580_PLLB4_MCLKOUTSRC_OSC    0x60
@@ -106,9 +107,16 @@

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
@@ -121,15 +129,16 @@

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
@@ -604,12 +613,13 @@ static int wm8580_set_dai_clkdiv(struct
snd_soc_dai *codec_dai,

 		switch (div) {
 		case WM8580_CLKSRC_MCLK:
-			/* Input */
+			reg |= WM8580_PLLB4_MCLKOUTSRC_MCLK;
 			break;

 		case WM8580_CLKSRC_PLLA:
 			reg |= WM8580_PLLB4_MCLKOUTSRC_PLLA;
 			break;
+
 		case WM8580_CLKSRC_PLLB:
 			reg |= WM8580_PLLB4_MCLKOUTSRC_PLLB;
 			break;
@@ -630,6 +640,7 @@ static int wm8580_set_dai_clkdiv(struct
snd_soc_dai *codec_dai,

 		switch (div) {
 		case WM8580_CLKSRC_MCLK:
+			reg |= WM8580_CLKSEL_DAC_CLKSEL_MCLK;
 			break;

 		case WM8580_CLKSRC_PLLA:
@@ -646,6 +657,59 @@ static int wm8580_set_dai_clkdiv(struct
snd_soc_dai *codec_dai,
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
 	case WM8580_CLKOUTSRC:
 		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_CLKOUTSRC_MASK;
@@ -672,6 +736,67 @@ static int wm8580_set_dai_clkdiv(struct
snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;

+	case WM8580_MCLKRATIO:
+		reg = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+		reg &= ~WM8580_AIF_RATE_MASK;
+		switch(div) {
+		case 128:
+			reg |= WM8580_AIF_RATE_128;
+			break;
+
+		case 192:
+			reg |= WM8580_AIF_RATE_192;
+			break;
+
+		case 256:
+			reg |= WM8580_AIF_RATE_256;
+			break;
+
+		case 384:
+			reg |= WM8580_AIF_RATE_384;
+			break;
+
+		case 512:
+			reg |= WM8580_AIF_RATE_512;
+			break;
+
+		case 768:
+			reg |= WM8580_AIF_RATE_768;
+			break;
+
+		case 1152:
+			reg |= WM8580_AIF_RATE_1152;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+		snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, reg);
+		break;
+
+	case WM8580_BCLKRATIO:
+		reg = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+		reg &= ~WM8580_AIF_BCLKSEL_MASK;
+		switch(div) {
+		case 64:
+			reg |= WM8580_AIF_BCLKSEL_64;
+			break;
+
+		case 32:
+			reg |= WM8580_AIF_BCLKSEL_32;
+			break;
+
+		case 16:
+			reg |= WM8580_AIF_BCLKSEL_16;
+			break;
+
+		default:
+			reg |= WM8580_AIF_BCLKSEL_SYSCLK;
+			break;
+		}
+		snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, reg);
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 0dfb5dd..0ecdbfa 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -18,16 +18,21 @@
 #define WM8580_PLLA  1
 #define WM8580_PLLB  2

-#define WM8580_MCLK       1
-#define WM8580_DAC_CLKSEL 2
-#define WM8580_CLKOUTSRC  3
-
-#define WM8580_CLKSRC_MCLK 1
-#define WM8580_CLKSRC_PLLA 2
-#define WM8580_CLKSRC_PLLB 3
-#define WM8580_CLKSRC_OSC  4
-#define WM8580_CLKSRC_NONE 5
-
+#define WM8580_MCLK        1
+#define WM8580_DAC_CLKSEL  2
+#define WM8580_ADC_CLKSEL  3
+#define WM8580_PAIF_CLKSEL 4
+#define WM8580_CLKOUTSRC   5
+#define WM8580_MCLKRATIO   6
+#define WM8580_BCLKRATIO   7
+
+#define WM8580_CLKSRC_ADCMCLK 0
+#define WM8580_CLKSRC_MCLK    1
+#define WM8580_CLKSRC_PLLA    2
+#define WM8580_CLKSRC_PLLB    3
+#define WM8580_CLKSRC_OSC     4
+#define WM8580_CLKSRC_NONE    5
+
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1

-- 
1.6.2.5
