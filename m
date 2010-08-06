From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 1/5] ASoC: wm8580: Add to support ADC clock
	source setting
Date: Fri,  6 Aug 2010 09:18:17 +0900
Message-ID: <1281053897-4675-1-git-send-email-sw.youn@samsung.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C09D24399
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:29:38 +0200 (CEST)
In-Reply-To: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch adds to support additional ADC clock source setting
with R8 register for CLKSRC on wm8580.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/codecs/wm8580.c |   33 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8580.h |   16 +++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index c3571ee..e342da5 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -110,6 +110,12 @@
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
@@ -672,6 +678,33 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_PLLB4, reg);
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
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 0dfb5dd..aeb65ef 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -20,13 +20,15 @@
 
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
+
+#define WM8580_CLKSRC_MCLK    1
+#define WM8580_CLKSRC_ADCMCLK 2
+#define WM8580_CLKSRC_PLLA    3
+#define WM8580_CLKSRC_PLLB    4
+#define WM8580_CLKSRC_OSC     5
+#define WM8580_CLKSRC_NONE    6
 
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1
-- 
1.6.2.5
