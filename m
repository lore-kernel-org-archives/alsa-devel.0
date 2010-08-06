From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 4/5] ASoC: wm8580: Add to support Master Mode
	Rates
Date: Fri,  6 Aug 2010 09:32:18 +0900
Message-ID: <1281054738-15387-1-git-send-email-sw.youn@samsung.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 785C6243E9
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:44:35 +0200 (CEST)
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

This patch adds to support Master Mode LRCLK, BCLK rates
setting for wm8580.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/codecs/wm8580.c |   51 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8580.h |    2 +
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index d282eb3..a2bb2a4 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -705,6 +705,57 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_CLKSEL, reg);
 		break;
 
+	case WM8580_LRCLK_RATE:
+		reg = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+		reg &= ~WM8580_AIF_RATE_MASK;
+		switch (div) {
+		case 128:
+			reg |= WM8580_AIF_RATE_128;
+			break;
+		case 192:
+			reg |= WM8580_AIF_RATE_192;
+			break;
+		case 256:
+			reg |= WM8580_AIF_RATE_256;
+			break;
+		case 384:
+			reg |= WM8580_AIF_RATE_384;
+			break;
+		case 512:
+			reg |= WM8580_AIF_RATE_512;
+			break;
+		case 768:
+			reg |= WM8580_AIF_RATE_768;
+			break;
+		case 1152:
+			reg |= WM8580_AIF_RATE_1152;
+			break;
+		default:
+			return -EINVAL;
+		}
+		snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, reg);
+		break;
+
+	case WM8580_BCLK_RATE:
+		reg = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+		reg &= ~WM8580_AIF_BCLKSEL_MASK;
+		switch (div) {
+		case 64:
+			reg |= WM8580_AIF_BCLKSEL_64;
+			break;
+		case 32:
+			reg |= WM8580_AIF_BCLKSEL_32;
+			break;
+		case 16:
+			reg |= WM8580_AIF_BCLKSEL_16;
+			break;
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
index aeb65ef..2272e36 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -22,6 +22,8 @@
 #define WM8580_DAC_CLKSEL 2
 #define WM8580_ADC_CLKSEL 3
 #define WM8580_CLKOUTSRC  4
+#define WM8580_LRCLK_RATE 5
+#define WM8580_BCLK_RATE  6
 
 #define WM8580_CLKSRC_MCLK    1
 #define WM8580_CLKSRC_ADCMCLK 2
-- 
1.6.2.5
