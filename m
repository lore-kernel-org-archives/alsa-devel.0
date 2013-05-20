From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Handle LRCLK inversion for
	WM8958 and WM1811A
Date: Mon, 20 May 2013 11:16:10 -0500
Message-ID: <1369066570-16282-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B33B261643
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 18:24:09 +0200 (CEST)
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
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Samreen Nilofer <samreen.nilofer@intel.com>
---
 include/linux/mfd/wm8994/registers.h |    8 ++++++++
 sound/soc/codecs/wm8994.c            |   14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 0535489..db8cef3 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -2668,6 +2668,10 @@
 /*
  * R772 (0x304) - AIF1ADC LRCLK
  */
+#define WM8958_AIF1_LRCLK_INV                   0x1000  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_MASK              0x1000  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_SHIFT                 12  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_WIDTH                  1  /* AIF1_LRCLK_INV */
 #define WM8994_AIF1ADC_LRCLK_DIR                0x0800  /* AIF1ADC_LRCLK_DIR */
 #define WM8994_AIF1ADC_LRCLK_DIR_MASK           0x0800  /* AIF1ADC_LRCLK_DIR */
 #define WM8994_AIF1ADC_LRCLK_DIR_SHIFT              11  /* AIF1ADC_LRCLK_DIR */
@@ -2679,6 +2683,10 @@
 /*
  * R773 (0x305) - AIF1DAC LRCLK
  */
+#define WM8958_AIF1_LRCLK_INV                   0x1000  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_MASK              0x1000  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_SHIFT                 12  /* AIF1_LRCLK_INV */
+#define WM8958_AIF1_LRCLK_INV_WIDTH                  1  /* AIF1_LRCLK_INV */
 #define WM8994_AIF1DAC_LRCLK_DIR                0x0800  /* AIF1DAC_LRCLK_DIR */
 #define WM8994_AIF1DAC_LRCLK_DIR_MASK           0x0800  /* AIF1DAC_LRCLK_DIR */
 #define WM8994_AIF1DAC_LRCLK_DIR_SHIFT              11  /* AIF1DAC_LRCLK_DIR */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index cb67603..0bcbd12 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2574,17 +2574,24 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
@@ -2603,6 +2610,7 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif1 |= WM8994_AIF1_LRCLK_INV;
+		lrclk |= WM8958_AIF1_LRCLK_INV;
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x18;
 		break;
@@ -2641,12 +2649,14 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
@@ -2677,6 +2687,10 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
