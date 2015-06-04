From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 12/23] ASoC: tas2552: Correct and clean up
	data format and BCLK/WCLK direction
Date: Thu, 4 Jun 2015 16:04:24 +0300
Message-ID: <1433423075-14142-13-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 1883026655E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:05:06 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use names from the datasheet for the definitions.
Correct the data format definitions since they were not correct.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 18 +++++++++---------
 sound/soc/codecs/tas2552.h | 17 ++++++++---------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 2f4c2b52a9fa..7615d1bc5f5d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -188,9 +188,9 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#define TAS2552_DAI_FMT_MASK	(TAS2552_BIT_CLK_MASK | \
-				 TAS2552_WORD_CLK_MASK | \
-				 TAS2552_DATA_FORMAT_MASK)
+#define TAS2552_DAI_FMT_MASK	(TAS2552_BCLKDIR | \
+				 TAS2552_WCLKDIR | \
+				 TAS2552_DATAFORMAT_MASK)
 static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -202,13 +202,13 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		serial_format = 0x00;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		serial_format = TAS2552_WORD_CLK_MASK;
+		serial_format = TAS2552_WCLKDIR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		serial_format = TAS2552_BIT_CLK_MASK;
+		serial_format = TAS2552_BCLKDIR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		serial_format = (TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK);
+		serial_format = (TAS2552_BCLKDIR | TAS2552_WCLKDIR);
 		break;
 	default:
 		dev_vdbg(codec->dev, "DAI Format master is not found\n");
@@ -222,13 +222,13 @@ static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
 		delay = 1;
 	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
-		serial_format |= TAS2552_DAIFMT_DSP;
+		serial_format |= TAS2552_DATAFORMAT_DSP;
 		break;
 	case (SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_NB_NF):
-		serial_format |= TAS2552_DAIFMT_RIGHT_J;
+		serial_format |= TAS2552_DATAFORMAT_RIGHT_J;
 		break;
 	case (SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF):
-		serial_format |= TAS2552_DAIFMT_LEFT_J;
+		serial_format |= TAS2552_DATAFORMAT_LEFT_J;
 		break;
 	default:
 		dev_vdbg(codec->dev, "DAI Format is not found\n");
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 0725befb4c41..0a12b511e951 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -62,15 +62,14 @@
 #define TAS2552_LIM_EN			(1 << 2)
 #define TAS2552_IVSENSE_EN		(1 << 1)
 
-/* CFG3 Register Masks */
-#define TAS2552_WORD_CLK_MASK		(1 << 7)
-#define TAS2552_BIT_CLK_MASK		(1 << 6)
-#define TAS2552_DATA_FORMAT_MASK	(0x11 << 2)
-
-#define TAS2552_DAIFMT_I2S_MASK		0xf3
-#define TAS2552_DAIFMT_DSP			(1 << 3)
-#define TAS2552_DAIFMT_RIGHT_J		(1 << 4)
-#define TAS2552_DAIFMT_LEFT_J		(0x11 << 3)
+/* Serial Interface Control Register Masks */
+#define TAS2552_DATAFORMAT_I2S		(0x0 << 2)
+#define TAS2552_DATAFORMAT_DSP		(0x1 << 2)
+#define TAS2552_DATAFORMAT_RIGHT_J	(0x2 << 2)
+#define TAS2552_DATAFORMAT_LEFT_J	(0x3 << 2)
+#define TAS2552_DATAFORMAT_MASK		TAS2552_DATAFORMAT_LEFT_J
+#define TAS2552_BCLKDIR			(1 << 6)
+#define TAS2552_WCLKDIR			(1 << 7)
 
 #define TAS2552_DIN_SRC_SEL_MUTED	0x00
 #define TAS2552_DIN_SRC_SEL_LEFT	(1 << 4)
-- 
2.4.2
