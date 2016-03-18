From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Correct the digital interface data select" to the asoc tree
Date: Fri, 18 Mar 2016 10:58:03 +0000
Message-ID: <E1ags6V-0004FP-I7@debutante>
References: <1458284062-46472-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1458284062-46472-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Correct the digital interface data select

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 653aa4645244042826f105aab1be3d01b3d493ca Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Fri, 18 Mar 2016 14:54:22 +0800
Subject: [PATCH] ASoC: rt5640: Correct the digital interface data select

this patch corrects the interface adc/dac control register definition
according to datasheet.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5640.c |  2 +-
 sound/soc/codecs/rt5640.h | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e8b5ba04417a..09e8988bbb2d 100644
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
index 1761c3a98b76..58b664b06c16 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -443,39 +443,39 @@
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
2.7.0
