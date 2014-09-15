From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: Revise the wrong name in the
	header file
Date: Mon, 15 Sep 2014 19:58:44 +0800
Message-ID: <1410782325-10541-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 52ECF261AA0
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 13:59:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch revises the wrong name in the header file.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.h | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 8791ab9..a334eb6 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1287,16 +1287,16 @@
 #define RT5677_PLL1_PD_SFT			8
 #define RT5677_PLL1_PD_1			(0x0 << 8)
 #define RT5677_PLL1_PD_2			(0x1 << 8)
-#define RT5671_DAC_OSR_MASK			(0x3 << 6)
-#define RT5671_DAC_OSR_SFT			6
-#define RT5671_DAC_OSR_128			(0x0 << 6)
-#define RT5671_DAC_OSR_64			(0x1 << 6)
-#define RT5671_DAC_OSR_32			(0x2 << 6)
-#define RT5671_ADC_OSR_MASK			(0x3 << 4)
-#define RT5671_ADC_OSR_SFT			4
-#define RT5671_ADC_OSR_128			(0x0 << 4)
-#define RT5671_ADC_OSR_64			(0x1 << 4)
-#define RT5671_ADC_OSR_32			(0x2 << 4)
+#define RT5677_DAC_OSR_MASK			(0x3 << 6)
+#define RT5677_DAC_OSR_SFT			6
+#define RT5677_DAC_OSR_128			(0x0 << 6)
+#define RT5677_DAC_OSR_64			(0x1 << 6)
+#define RT5677_DAC_OSR_32			(0x2 << 6)
+#define RT5677_ADC_OSR_MASK			(0x3 << 4)
+#define RT5677_ADC_OSR_SFT			4
+#define RT5677_ADC_OSR_128			(0x0 << 4)
+#define RT5677_ADC_OSR_64			(0x1 << 4)
+#define RT5677_ADC_OSR_32			(0x2 << 4)
 
 /* Global Clock Control 2 (0x81) */
 #define RT5677_PLL2_PR_SRC_MASK			(0x1 << 15)
@@ -1312,18 +1312,18 @@
 #define RT5677_PLL2_SRC_BCLK4			(0x4 << 12)
 #define RT5677_PLL2_SRC_RCCLK			(0x5 << 12)
 #define RT5677_PLL2_SRC_SLIM			(0x6 << 12)
-#define RT5671_DSP_ASRC_O_SRC			(0x3 << 10)
-#define RT5671_DSP_ASRC_O_SRC_SFT		10
-#define RT5671_DSP_ASRC_O_MCLK			(0x0 << 10)
-#define RT5671_DSP_ASRC_O_PLL1			(0x1 << 10)
-#define RT5671_DSP_ASRC_O_SLIM			(0x2 << 10)
-#define RT5671_DSP_ASRC_O_RCCLK			(0x3 << 10)
-#define RT5671_DSP_ASRC_I_SRC			(0x3 << 8)
-#define RT5671_DSP_ASRC_I_SRC_SFT		8
-#define RT5671_DSP_ASRC_I_MCLK			(0x0 << 8)
-#define RT5671_DSP_ASRC_I_PLL1			(0x1 << 8)
-#define RT5671_DSP_ASRC_I_SLIM			(0x2 << 8)
-#define RT5671_DSP_ASRC_I_RCCLK			(0x3 << 8)
+#define RT5677_DSP_ASRC_O_SRC			(0x3 << 10)
+#define RT5677_DSP_ASRC_O_SRC_SFT		10
+#define RT5677_DSP_ASRC_O_MCLK			(0x0 << 10)
+#define RT5677_DSP_ASRC_O_PLL1			(0x1 << 10)
+#define RT5677_DSP_ASRC_O_SLIM			(0x2 << 10)
+#define RT5677_DSP_ASRC_O_RCCLK			(0x3 << 10)
+#define RT5677_DSP_ASRC_I_SRC			(0x3 << 8)
+#define RT5677_DSP_ASRC_I_SRC_SFT		8
+#define RT5677_DSP_ASRC_I_MCLK			(0x0 << 8)
+#define RT5677_DSP_ASRC_I_PLL1			(0x1 << 8)
+#define RT5677_DSP_ASRC_I_SLIM			(0x2 << 8)
+#define RT5677_DSP_ASRC_I_RCCLK			(0x3 << 8)
 #define RT5677_DSP_CLK_SRC_MASK			(0x1 << 7)
 #define RT5677_DSP_CLK_SRC_SFT			7
 #define RT5677_DSP_CLK_SRC_PLL2			(0x0 << 7)
-- 
1.8.1.1.439.g50a6b54
