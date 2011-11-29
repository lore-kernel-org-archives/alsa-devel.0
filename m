From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Put WM8958 and WM1811 MICBIAS into
	bypass mode when no audio
Date: Tue, 29 Nov 2011 18:17:29 +0000
Message-ID: <1322590649-27188-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2A9A243AB
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 19:17:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When we don't have any active audio we can put the microphone biases into
bypass mode to save power at the expense of performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2cb2518..51fefb8 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1980,6 +1980,18 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
+		/* MICBIAS into regulating mode */
+		switch (control->type) {
+		case WM8958:
+		case WM1811:
+			snd_soc_update_bits(codec, WM8958_MICBIAS1,
+					    WM8958_MICB1_MODE, 0);
+			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+					    WM8958_MICB2_MODE, 0);
+			break;
+		default:
+			break;
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -2032,7 +2044,20 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_LINEOUT2_DISCH);
 		}
 
-
+		/* MICBIAS into bypass mode on newer devices */
+		switch (control->type) {
+		case WM8958:
+		case WM1811:
+			snd_soc_update_bits(codec, WM8958_MICBIAS1,
+					    WM8958_MICB1_MODE,
+					    WM8958_MICB1_MODE);
+			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+					    WM8958_MICB2_MODE,
+					    WM8958_MICB2_MODE);
+			break;
+		default:
+			break;
+		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
@@ -3354,6 +3379,19 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
+	/* Put MICBIAS into bypass mode by default on newer devices */
+	switch (control->type) {
+	case WM8958:
+	case WM1811:
+		snd_soc_update_bits(codec, WM8958_MICBIAS1,
+				    WM8958_MICB1_MODE, WM8958_MICB1_MODE);
+		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+				    WM8958_MICB2_MODE, WM8958_MICB2_MODE);
+		break;
+	default:
+		break;
+	}
+
 	wm8994_update_class_w(codec);
 
 	wm8994_handle_pdata(wm8994);
-- 
1.7.7.3
