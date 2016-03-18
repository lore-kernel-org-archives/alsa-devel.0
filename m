From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH] ASoC: rt5640: Correct the digital interface
	data select
Date: Fri, 18 Mar 2016 14:54:22 +0800
Message-ID: <1458284062-46472-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 821A2261293
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 07:57:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

this patch corrects the interface adc/dac control register definition
according to datasheet.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/codecs/rt5640.c |  2 +-
 sound/soc/codecs/rt5640.h | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 11d032c..48dbb2f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -359,7 +359,7 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 
 /* Interface data select */
 static const char * const rt5640_data_select[] = {
-	"Normal", "left copy to right", "right copy to left", "Swap"};
+	"Normal", "Swap", "left copy to right", "right copy to left"};
 
 static SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
 			    RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 83a7150..f84231e 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -442,39 +442,39 @@
 #define RT5640_IF1_DAC_SEL_MASK			(0x3 << 14)
 #define RT5640_IF1_DAC_SEL_SFT			14
 #define RT5640_IF1_DAC_SEL_NOR			(0x0 << 14)
-#define RT5640_IF1_DAC_SEL_L2R			(0x1 << 14)
-#define RT5640_IF1_DAC_SEL_R2L			(0x2 << 14)
-#define RT5640_IF1_DAC_SEL_SWAP			(0x3 << 14)
+#define RT5640_IF1_DAC_SEL_SWAP			(0x1 << 14)
+#define RT5640_IF1_DAC_SEL_L2R			(0x2 << 14)
+#define RT5640_IF1_DAC_SEL_R2L			(0x3 << 14)
 #define RT5640_IF1_ADC_SEL_MASK			(0x3 << 12)
 #define RT5640_IF1_ADC_SEL_SFT			12
 #define RT5640_IF1_ADC_SEL_NOR			(0x0 << 12)
-#define RT5640_IF1_ADC_SEL_L2R			(0x1 << 12)
-#define RT5640_IF1_ADC_SEL_R2L			(0x2 << 12)
-#define RT5640_IF1_ADC_SEL_SWAP			(0x3 << 12)
+#define RT5640_IF1_ADC_SEL_SWAP			(0x1 << 12)
+#define RT5640_IF1_ADC_SEL_L2R			(0x2 << 12)
+#define RT5640_IF1_ADC_SEL_R2L			(0x3 << 12)
 #define RT5640_IF2_DAC_SEL_MASK			(0x3 << 10)
 #define RT5640_IF2_DAC_SEL_SFT			10
 #define RT5640_IF2_DAC_SEL_NOR			(0x0 << 10)
-#define RT5640_IF2_DAC_SEL_L2R			(0x1 << 10)
-#define RT5640_IF2_DAC_SEL_R2L			(0x2 << 10)
-#define RT5640_IF2_DAC_SEL_SWAP			(0x3 << 10)
+#define RT5640_IF2_DAC_SEL_SWAP			(0x1 << 10)
+#define RT5640_IF2_DAC_SEL_L2R			(0x2 << 10)
+#define RT5640_IF2_DAC_SEL_R2L			(0x3 << 10)
 #define RT5640_IF2_ADC_SEL_MASK			(0x3 << 8)
 #define RT5640_IF2_ADC_SEL_SFT			8
 #define RT5640_IF2_ADC_SEL_NOR			(0x0 << 8)
-#define RT5640_IF2_ADC_SEL_L2R			(0x1 << 8)
-#define RT5640_IF2_ADC_SEL_R2L			(0x2 << 8)
-#define RT5640_IF2_ADC_SEL_SWAP			(0x3 << 8)
+#define RT5640_IF2_ADC_SEL_SWAP			(0x1 << 8)
+#define RT5640_IF2_ADC_SEL_L2R			(0x2 << 8)
+#define RT5640_IF2_ADC_SEL_R2L			(0x3 << 8)
 #define RT5640_IF3_DAC_SEL_MASK			(0x3 << 6)
 #define RT5640_IF3_DAC_SEL_SFT			6
 #define RT5640_IF3_DAC_SEL_NOR			(0x0 << 6)
-#define RT5640_IF3_DAC_SEL_L2R			(0x1 << 6)
-#define RT5640_IF3_DAC_SEL_R2L			(0x2 << 6)
-#define RT5640_IF3_DAC_SEL_SWAP			(0x3 << 6)
+#define RT5640_IF3_DAC_SEL_SWAP			(0x1 << 6)
+#define RT5640_IF3_DAC_SEL_L2R			(0x2 << 6)
+#define RT5640_IF3_DAC_SEL_R2L			(0x3 << 6)
 #define RT5640_IF3_ADC_SEL_MASK			(0x3 << 4)
 #define RT5640_IF3_ADC_SEL_SFT			4
 #define RT5640_IF3_ADC_SEL_NOR			(0x0 << 4)
-#define RT5640_IF3_ADC_SEL_L2R			(0x1 << 4)
-#define RT5640_IF3_ADC_SEL_R2L			(0x2 << 4)
-#define RT5640_IF3_ADC_SEL_SWAP			(0x3 << 4)
+#define RT5640_IF3_ADC_SEL_SWAP			(0x1 << 4)
+#define RT5640_IF3_ADC_SEL_L2R			(0x2 << 4)
+#define RT5640_IF3_ADC_SEL_R2L			(0x3 << 4)
 
 /* REC Left Mixer Control 1 (0x3b) */
 #define RT5640_G_HP_L_RM_L_MASK			(0x7 << 13)
-- 
1.9.1
