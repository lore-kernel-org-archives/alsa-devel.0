From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Handle LRCLK inversion for
	WM8958 and WM1811A
Date: Fri, 17 May 2013 16:33:10 +0100
Message-ID: <1368804790-25539-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FC9C2610CE
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 17:33:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On WM8958 and WM1811A separate control of the LRCLK inversion bit is
available for the DAC and ADC LRCLKs which for compatibility reasons is
done in a new register bit.

Since writes to each scheme have no effect on parts using the other just
always write to both for simplicity.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ab7ebd9..74238bd 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2573,17 +2573,24 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	struct wm8994 *control = wm8994->wm8994;
 	int ms_reg;
 	int aif1_reg;
+	int dac_reg;
+	int adc_reg;
 	int ms = 0;
 	int aif1 = 0;
+	int lrclk = 0;
 
 	switch (dai->id) {
 	case 1:
 		ms_reg = WM8994_AIF1_MASTER_SLAVE;
 		aif1_reg = WM8994_AIF1_CONTROL_1;
+		dac_reg = WM8994_AIF1DAC_LRCLK;
+		adc_reg = WM8994_AIF1ADC_LRCLK;
 		break;
 	case 2:
 		ms_reg = WM8994_AIF2_MASTER_SLAVE;
 		aif1_reg = WM8994_AIF2_CONTROL_1;
+		dac_reg = WM8994_AIF1DAC_LRCLK;
+		adc_reg = WM8994_AIF1ADC_LRCLK;
 		break;
 	default:
 		return -EINVAL;
@@ -2602,6 +2609,7 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif1 |= WM8994_AIF1_LRCLK_INV;
+		lrclk |= WM8958_AIF1_LRCLK_INV;
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x18;
 		break;
@@ -2640,12 +2648,14 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			break;
 		case SND_SOC_DAIFMT_IB_IF:
 			aif1 |= WM8994_AIF1_BCLK_INV | WM8994_AIF1_LRCLK_INV;
+			lrclk |= WM8958_AIF1_LRCLK_INV;
 			break;
 		case SND_SOC_DAIFMT_IB_NF:
 			aif1 |= WM8994_AIF1_BCLK_INV;
 			break;
 		case SND_SOC_DAIFMT_NB_IF:
 			aif1 |= WM8994_AIF1_LRCLK_INV;
+			lrclk |= WM8958_AIF1_LRCLK_INV;
 			break;
 		default:
 			return -EINVAL;
@@ -2676,6 +2686,10 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			    aif1);
 	snd_soc_update_bits(codec, ms_reg, WM8994_AIF1_MSTR,
 			    ms);
+	snd_soc_update_bits(codec, dac_reg,
+			    WM8958_AIF1_LRCLK_INV, lrclk);
+	snd_soc_update_bits(codec, adc_reg,
+			    WM8958_AIF1_LRCLK_INV, lrclk);
 
 	return 0;
 }
-- 
1.7.10.4
