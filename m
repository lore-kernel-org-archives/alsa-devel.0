From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5645: Sort the order for register bit
	defines
Date: Sat, 24 Oct 2015 14:55:41 +0800
Message-ID: <1445669741.26836.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A93CA2656FB
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 08:55:46 +0200 (CEST)
Received: by pabrc13 with SMTP id rc13so137166524pab.0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 23:55:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

So we have consistent order for register bit defines.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5645.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 13ac732..093e46d 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -621,14 +621,14 @@
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
@@ -643,14 +643,14 @@
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
@@ -675,12 +675,12 @@
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
2.1.4
