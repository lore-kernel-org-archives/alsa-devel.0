From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Conditionalize the enable of WM8994 ADC
	TDM mode
Date: Wed,  6 Jul 2011 00:09:08 -0700
Message-ID: <1309936148-11027-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 856AF1037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 09:09:24 +0200 (CEST)
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

Future devices will not benefit from this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c0d8686..299f6eb 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3114,10 +3114,18 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			    1 << WM8994_AIF2DAC_3D_GAIN_SHIFT,
 			    1 << WM8994_AIF2DAC_3D_GAIN_SHIFT);
 
-	/* Unconditionally enable AIF1 ADC TDM mode; it only affects
-	 * behaviour on idle TDM clock cycles. */
-	snd_soc_update_bits(codec, WM8994_AIF1_CONTROL_1,
-			    WM8994_AIF1ADC_TDM, WM8994_AIF1ADC_TDM);
+	/* Unconditionally enable AIF1 ADC TDM mode on chips which can
+	 * use this; it only affects behaviour on idle TDM clock
+	 * cycles. */
+	switch (control->type) {
+	case WM8994:
+	case WM8958:
+		snd_soc_update_bits(codec, WM8994_AIF1_CONTROL_1,
+				    WM8994_AIF1ADC_TDM, WM8994_AIF1ADC_TDM);
+		break;
+	default:
+		break;
+	}
 
 	wm8994_update_class_w(codec);
 
-- 
1.7.5.4
