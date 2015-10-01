From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: Correct the naming and
	setting of ADC Boost Volume Control
Date: Thu, 1 Oct 2015 14:47:09 +0800
Message-ID: <1443682030-18258-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B41526066D
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 08:47:20 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c |  6 +++---
 sound/soc/codecs/rt5645.h | 16 +++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3eb184c..080cc1c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -519,11 +519,11 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 		RT5645_L_VOL_SFT + 1, RT5645_R_VOL_SFT + 1, 63, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
-	SOC_DOUBLE_TLV("STO1 ADC Boost Gain", RT5645_ADC_BST_VOL1,
+	SOC_DOUBLE_TLV("ADC Boost Capture Volume", RT5645_ADC_BST_VOL1,
 		RT5645_STO1_ADC_L_BST_SFT, RT5645_STO1_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
-	SOC_DOUBLE_TLV("STO2 ADC Boost Gain", RT5645_ADC_BST_VOL1,
-		RT5645_STO2_ADC_L_BST_SFT, RT5645_STO2_ADC_R_BST_SFT, 3, 0,
+	SOC_DOUBLE_TLV("Mono ADC Boost Capture Volume", RT5645_ADC_BST_VOL2,
+		RT5645_MONO_ADC_L_BST_SFT, RT5645_MONO_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
 
 	/* I2S2 function select */
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index f45861c..61bc8ab 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -39,8 +39,8 @@
 #define RT5645_STO1_ADC_DIG_VOL			0x1c
 #define RT5645_MONO_ADC_DIG_VOL			0x1d
 #define RT5645_ADC_BST_VOL1			0x1e
-/* Mixer - D-D */
 #define RT5645_ADC_BST_VOL2			0x20
+/* Mixer - D-D */
 #define RT5645_STO1_ADC_MIXER			0x27
 #define RT5645_MONO_ADC_MIXER			0x28
 #define RT5645_AD_DA_MIXER			0x29
@@ -315,12 +315,14 @@
 #define RT5645_STO1_ADC_R_BST_SFT		12
 #define RT5645_STO1_ADC_COMP_MASK		(0x3 << 10)
 #define RT5645_STO1_ADC_COMP_SFT		10
-#define RT5645_STO2_ADC_L_BST_MASK		(0x3 << 8)
-#define RT5645_STO2_ADC_L_BST_SFT		8
-#define RT5645_STO2_ADC_R_BST_MASK		(0x3 << 6)
-#define RT5645_STO2_ADC_R_BST_SFT		6
-#define RT5645_STO2_ADC_COMP_MASK		(0x3 << 4)
-#define RT5645_STO2_ADC_COMP_SFT		4
+
+/* ADC Boost Volume Control (0x20) */
+#define RT5645_MONO_ADC_L_BST_MASK		(0x3 << 14)
+#define RT5645_MONO_ADC_L_BST_SFT		14
+#define RT5645_MONO_ADC_R_BST_MASK		(0x3 << 12)
+#define RT5645_MONO_ADC_R_BST_SFT		12
+#define RT5645_MONO_ADC_COMP_MASK		(0x3 << 10)
+#define RT5645_MONO_ADC_COMP_SFT		10
 
 /* Stereo2 ADC Mixer Control (0x26) */
 #define RT5645_STO2_ADC_SRC_MASK		(0x1 << 15)
-- 
1.8.1.1.439.g50a6b54
