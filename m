From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] ASoC: clean up wm8974 and wm8978 clock
	divider handling
Date: Fri, 29 Jan 2010 15:31:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001291526000.4613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 355D610391A
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:30:57 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

wm8974 and wm8978 codec drivers control DAC and ADC oversampling rates in their
.set_clkdiv() methods, which is wrong, because these are simple boolean
switches and not clock dividers. Move these bits to sound controls. Also remove
manual configuration of the MCLK divider in wm8978, since it is configured
automatically.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. Added " Switch" to wm8974 and wm8978 DAC/ADC oversampling controls

 sound/soc/codecs/wm8974.c |   12 ++++--------
 sound/soc/codecs/wm8974.h |   12 +-----------
 sound/soc/codecs/wm8978.c |   19 ++++---------------
 sound/soc/codecs/wm8978.h |    3 ---
 sound/soc/sh/migor.c      |    4 ----
 5 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 8812751..ee637af 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -170,6 +170,10 @@ SOC_ENUM("Aux Mode", wm8974_auxmode),
 
 SOC_SINGLE("Capture Boost(+20dB)", WM8974_ADCBOOST,  8, 1, 0),
 SOC_SINGLE("Mono Playback Switch", WM8974_MONOMIX, 6, 1, 1),
+
+/* DAC / ADC oversampling */
+SOC_SINGLE("DAC 128x Oversampling Switch", WM8974_DAC, 8, 1, 0),
+SOC_SINGLE("ADC 128x Oversampling Switch", WM8974_ADC, 8, 1, 0),
 };
 
 /* Speaker Output Mixer */
@@ -381,14 +385,6 @@ static int wm8974_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		reg = snd_soc_read(codec, WM8974_CLOCK) & 0x11f;
 		snd_soc_write(codec, WM8974_CLOCK, reg | div);
 		break;
-	case WM8974_ADCCLK:
-		reg = snd_soc_read(codec, WM8974_ADC) & 0x1f7;
-		snd_soc_write(codec, WM8974_ADC, reg | div);
-		break;
-	case WM8974_DACCLK:
-		reg = snd_soc_read(codec, WM8974_DAC) & 0x1f7;
-		snd_soc_write(codec, WM8974_DAC, reg | div);
-		break;
 	case WM8974_BCLKDIV:
 		reg = snd_soc_read(codec, WM8974_CLOCK) & 0x1e3;
 		snd_soc_write(codec, WM8974_CLOCK, reg | div);
diff --git a/sound/soc/codecs/wm8974.h b/sound/soc/codecs/wm8974.h
index 98de956..896a7f0 100644
--- a/sound/soc/codecs/wm8974.h
+++ b/sound/soc/codecs/wm8974.h
@@ -57,17 +57,7 @@
 /* Clock divider Id's */
 #define WM8974_OPCLKDIV		0
 #define WM8974_MCLKDIV		1
-#define WM8974_ADCCLK		2
-#define WM8974_DACCLK		3
-#define WM8974_BCLKDIV		4
-
-/* DAC clock dividers */
-#define WM8974_DACCLK_F2	(1 << 3)
-#define WM8974_DACCLK_F4	(0 << 3)
-
-/* ADC clock dividers */
-#define WM8974_ADCCLK_F2	(1 << 3)
-#define WM8974_ADCCLK_F4	(0 << 3)
+#define WM8974_BCLKDIV		2
 
 /* PLL Out dividers */
 #define WM8974_OPCLKDIV_1	(0 << 4)
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8dcebaa..ec2624b 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -210,6 +210,10 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 	/* Speaker */
 	SOC_DOUBLE_R("Speaker Switch",
 		WM8978_LOUT2_SPK_CONTROL, WM8978_ROUT2_SPK_CONTROL, 6, 1, 1),
+
+	/* DAC / ADC oversampling */
+	SOC_SINGLE("DAC 128x Oversampling Switch", WM8978_DAC_CONTROL, 8, 1, 0),
+	SOC_SINGLE("ADC 128x Oversampling Switch", WM8978_ADC_CONTROL, 8, 1, 0),
 };
 
 /* Mixer #1: Output (OUT1, OUT2) Mixer: mix AUX, Input mixer output and DAC */
@@ -513,21 +517,6 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		if (wm8978->f_mclk)
 			ret = wm8978_configure_pll(codec);
 		break;
-	case WM8978_MCLKDIV:
-		if (div & ~0xe0)
-			return -EINVAL;
-		snd_soc_update_bits(codec, WM8978_CLOCKING, 0xe0, div);
-		break;
-	case WM8978_ADCCLK:
-		if (div & ~8)
-			return -EINVAL;
-		snd_soc_update_bits(codec, WM8978_ADC_CONTROL, 8, div);
-		break;
-	case WM8978_DACCLK:
-		if (div & ~8)
-			return -EINVAL;
-		snd_soc_update_bits(codec, WM8978_DAC_CONTROL, 8, div);
-		break;
 	case WM8978_BCLKDIV:
 		if (div & ~0x1c)
 			return -EINVAL;
diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
index b58f0bf..56ec832 100644
--- a/sound/soc/codecs/wm8978.h
+++ b/sound/soc/codecs/wm8978.h
@@ -72,9 +72,6 @@
 /* Clock divider Id's */
 enum wm8978_clk_id {
 	WM8978_OPCLKRATE,
-	WM8978_MCLKDIV,
-	WM8978_ADCCLK,
-	WM8978_DACCLK,
 	WM8978_BCLKDIV,
 };
 
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 3ccd9b3..b823a5c 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -59,10 +59,6 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_DACCLK, 8);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_OPCLKRATE, rate * 512);
 	if (ret < 0)
 		return ret;
-- 
1.6.2.4
