From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Correct the naming and setting
	of ADC Boost Volume Control" to the asoc tree
Date: Thu, 01 Oct 2015 11:23:57 +0100
Message-ID: <E1Zhb1p-0007PF-R5@finisterre>
References: <1443682030-18258-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D05B626666D
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 12:24:05 +0200 (CEST)
In-Reply-To: <1443682030-18258-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Correct the naming and setting of ADC Boost Volume Control

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

>From 8c1a9d6323abf0fb1e5dad96cf3f1c783505ea5a Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 1 Oct 2015 14:47:09 +0800
Subject: [PATCH] ASoC: rt5645: Correct the naming and setting of ADC Boost
 Volume Control

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c |  6 +++---
 sound/soc/codecs/rt5645.h | 16 +++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4972bf3..aaf08cd3 100644
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
index 0e4cfc6..8c964cf 100644
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
2.5.0
