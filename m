From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Sort the order for register bit
	defines" to the asoc tree
Date: Mon, 26 Oct 2015 11:08:42 +0900
Message-ID: <E1ZqXDG-0007YJ-TT@finisterre>
References: <1445669741.26836.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4542260452
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 03:08:57 +0100 (CET)
In-Reply-To: <1445669741.26836.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Sort the order for register bit defines

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

>From bc86e53a0ae9bb26c1af04034e010d8f22b1b0da Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 24 Oct 2015 14:55:41 +0800
Subject: [PATCH] ASoC: rt5645: Sort the order for register bit defines

So we have consistent order for register bit defines.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index d0e0ce5..7cea282 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -619,14 +619,14 @@
 #define RT5645_G_OM_L_SM_L_SFT			6
 #define RT5645_M_BST1_L_SM_L			(0x1 << 5)
 #define RT5645_M_BST1_L_SM_L_SFT		5
+#define RT5645_M_BST3_L_SM_L			(0x1 << 4)
+#define RT5645_M_BST3_L_SM_L_SFT		4
 #define RT5645_M_IN_L_SM_L			(0x1 << 3)
 #define RT5645_M_IN_L_SM_L_SFT			3
-#define RT5645_M_DAC_L1_SM_L			(0x1 << 1)
-#define RT5645_M_DAC_L1_SM_L_SFT		1
 #define RT5645_M_DAC_L2_SM_L			(0x1 << 2)
 #define RT5645_M_DAC_L2_SM_L_SFT		2
-#define RT5645_M_BST3_L_SM_L			(0x1 << 4)
-#define RT5645_M_BST3_L_SM_L_SFT		4
+#define RT5645_M_DAC_L1_SM_L			(0x1 << 1)
+#define RT5645_M_DAC_L1_SM_L_SFT		1
 
 /* SPK Right Mixer Control (0x47) */
 #define RT5645_G_RM_R_SM_R_MASK			(0x3 << 14)
@@ -641,14 +641,14 @@
 #define RT5645_G_OM_R_SM_R_SFT			6
 #define RT5645_M_BST2_R_SM_R			(0x1 << 5)
 #define RT5645_M_BST2_R_SM_R_SFT		5
+#define RT5645_M_BST3_R_SM_R			(0x1 << 4)
+#define RT5645_M_BST3_R_SM_R_SFT		4
 #define RT5645_M_IN_R_SM_R			(0x1 << 3)
 #define RT5645_M_IN_R_SM_R_SFT			3
-#define RT5645_M_DAC_R1_SM_R			(0x1 << 1)
-#define RT5645_M_DAC_R1_SM_R_SFT		1
 #define RT5645_M_DAC_R2_SM_R			(0x1 << 2)
 #define RT5645_M_DAC_R2_SM_R_SFT		2
-#define RT5645_M_BST3_R_SM_R			(0x1 << 4)
-#define RT5645_M_BST3_R_SM_R_SFT		4
+#define RT5645_M_DAC_R1_SM_R			(0x1 << 1)
+#define RT5645_M_DAC_R1_SM_R_SFT		1
 
 /* SPOLMIX Control (0x48) */
 #define RT5645_M_DAC_L1_SPM_L			(0x1 << 15)
@@ -673,12 +673,12 @@
 #define RT5645_SPK_G_CLSD_SFT			0
 
 /* Mono Output Mixer Control (0x4c) */
+#define RT5645_G_MONOMIX_MASK			(0x1 << 10)
+#define RT5645_G_MONOMIX_SFT			10
 #define RT5645_M_OV_L_MM			(0x1 << 9)
 #define RT5645_M_OV_L_MM_SFT			9
 #define RT5645_M_DAC_L2_MA			(0x1 << 8)
 #define RT5645_M_DAC_L2_MA_SFT			8
-#define RT5645_G_MONOMIX_MASK			(0x1 << 10)
-#define RT5645_G_MONOMIX_SFT			10
 #define RT5645_M_BST2_MM			(0x1 << 4)
 #define RT5645_M_BST2_MM_SFT			4
 #define RT5645_M_DAC_R1_MM			(0x1 << 3)
-- 
2.6.1
