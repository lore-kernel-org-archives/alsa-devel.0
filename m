From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/23] ASoC: tas2552: Add support for pll
	and pdm source clock selection
Date: Thu, 4 Jun 2015 16:04:22 +0300
Message-ID: <1433423075-14142-11-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD33266536
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:05:03 +0200 (CEST)
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

Instead of hard wiring the PLL_CLKIN and PDM_CLK to be sourced from BCLK add
proper clock configuration via the set_dai_sysclk callback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index e29b29b279d9..34495241c674 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -34,6 +34,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/tas2552-plat.h>
+#include <dt-bindings/sound/tas2552.h>
 
 #include "tas2552.h"
 
@@ -76,6 +77,7 @@ struct tas2552_data {
 	struct gpio_desc *enable_gpio;
 	unsigned char regs[TAS2552_VBAT_DATA];
 	unsigned int pll_clkin;
+	unsigned int pdm_clk;
 };
 
 /* Input mux controls */
@@ -244,8 +246,33 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
+	u8 reg, mask, val;
+
+	switch (clk_id) {
+	case TAS2552_PLL_CLKIN_MCLK:
+	case TAS2552_PLL_CLKIN_BCLK:
+	case TAS2552_PLL_CLKIN_IVCLKIN:
+	case TAS2552_PLL_CLKIN_1_8_FIXED:
+		mask = TAS2552_PLL_SRC_MASK;
+		val = (clk_id << 3) & mask; /* bit 4:5 in the register */
+		reg = TAS2552_CFG_1;
+		tas2552->pll_clkin = freq;
+		break;
+	case TAS2552_PDM_CLK_PLL:
+	case TAS2552_PDM_CLK_IVCLKIN:
+	case TAS2552_PDM_CLK_BCLK:
+	case TAS2552_PDM_CLK_MCLK:
+		mask = TAS2552_PDM_CLK_SEL_MASK;
+		val = (clk_id >> 1) & mask; /* bit 0:1 in the register */
+		reg = TAS2552_PDM_CFG;
+		tas2552->pdm_clk = freq;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid clk id: %d\n", clk_id);
+		return -EINVAL;
+	}
 
-	tas2552->pll_clkin = freq;
+	snd_soc_update_bits(codec, reg, mask, val);
 
 	return 0;
 }
@@ -366,13 +393,11 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 		goto probe_fail;
 	}
 
-	snd_soc_write(codec, TAS2552_CFG_1, TAS2552_MUTE |
-				TAS2552_PLL_SRC_BCLK);
+	snd_soc_write(codec, TAS2552_CFG_1, TAS2552_MUTE);
 	snd_soc_write(codec, TAS2552_CFG_3, TAS2552_I2S_OUT_SEL |
 				TAS2552_DIN_SRC_SEL_AVG_L_R | TAS2552_88_96KHZ);
 	snd_soc_write(codec, TAS2552_DOUT, TAS2552_PDM_DATA_I);
 	snd_soc_write(codec, TAS2552_OUTPUT_DATA, TAS2552_PDM_DATA_V_I | 0x8);
-	snd_soc_write(codec, TAS2552_PDM_CFG, TAS2552_PDM_CLK_SEL_PLL);
 	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
 				TAS2552_APT_THRESH_2_1_7);
 
-- 
2.4.2
