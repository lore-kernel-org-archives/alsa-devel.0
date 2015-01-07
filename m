From: mengdong.lin@intel.com
Subject: [PATCH v2 1/3] ASoC: rt5670: redefine ASRC control
	registers 0x84 and 0x85
Date: Wed,  7 Jan 2015 10:19:06 +0800
Message-ID: <1420597146-4101-1-git-send-email-mengdong.lin@intel.com>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 323E0261557
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 03:11:17 +0100 (CET)
In-Reply-To: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, bardliao@realtek.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

The previous definition of registers 0x84 and 0x85 doesn't match the datasheet.
So this patch removes the wrong definition and writes a new one for the two
registers.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
v2: change subject from "fix definition" to "redefine"

diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 54933f3..7c37b00 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1023,50 +1023,33 @@
 #define RT5670_DMIC_2_M_NOR			(0x0 << 8)
 #define RT5670_DMIC_2_M_ASYN			(0x1 << 8)
 
+/* ASRC clock source selection (0x84, 0x85) */
+#define RT5670_CLK_SEL_SYS			(0x0)
+#define RT5670_CLK_SEL_I2S1_ASRC		(0x1)
+#define RT5670_CLK_SEL_I2S2_ASRC		(0x2)
+#define RT5670_CLK_SEL_I2S3_ASRC		(0x3)
+#define RT5670_CLK_SEL_SYS2			(0x5)
+#define RT5670_CLK_SEL_SYS3			(0x6)
+
 /* ASRC Control 2 (0x84) */
-#define RT5670_MDA_L_M_MASK			(0x1 << 15)
-#define RT5670_MDA_L_M_SFT			15
-#define RT5670_MDA_L_M_NOR			(0x0 << 15)
-#define RT5670_MDA_L_M_ASYN			(0x1 << 15)
-#define RT5670_MDA_R_M_MASK			(0x1 << 14)
-#define RT5670_MDA_R_M_SFT			14
-#define RT5670_MDA_R_M_NOR			(0x0 << 14)
-#define RT5670_MDA_R_M_ASYN			(0x1 << 14)
-#define RT5670_MAD_L_M_MASK			(0x1 << 13)
-#define RT5670_MAD_L_M_SFT			13
-#define RT5670_MAD_L_M_NOR			(0x0 << 13)
-#define RT5670_MAD_L_M_ASYN			(0x1 << 13)
-#define RT5670_MAD_R_M_MASK			(0x1 << 12)
-#define RT5670_MAD_R_M_SFT			12
-#define RT5670_MAD_R_M_NOR			(0x0 << 12)
-#define RT5670_MAD_R_M_ASYN			(0x1 << 12)
-#define RT5670_ADC_M_MASK			(0x1 << 11)
-#define RT5670_ADC_M_SFT			11
-#define RT5670_ADC_M_NOR			(0x0 << 11)
-#define RT5670_ADC_M_ASYN			(0x1 << 11)
-#define RT5670_STO_DAC_M_MASK			(0x1 << 5)
-#define RT5670_STO_DAC_M_SFT			5
-#define RT5670_STO_DAC_M_NOR			(0x0 << 5)
-#define RT5670_STO_DAC_M_ASYN			(0x1 << 5)
-#define RT5670_I2S1_R_D_MASK			(0x1 << 4)
-#define RT5670_I2S1_R_D_SFT			4
-#define RT5670_I2S1_R_D_DIS			(0x0 << 4)
-#define RT5670_I2S1_R_D_EN			(0x1 << 4)
-#define RT5670_I2S2_R_D_MASK			(0x1 << 3)
-#define RT5670_I2S2_R_D_SFT			3
-#define RT5670_I2S2_R_D_DIS			(0x0 << 3)
-#define RT5670_I2S2_R_D_EN			(0x1 << 3)
-#define RT5670_PRE_SCLK_MASK			(0x3)
-#define RT5670_PRE_SCLK_SFT			0
-#define RT5670_PRE_SCLK_512			(0x0)
-#define RT5670_PRE_SCLK_1024			(0x1)
-#define RT5670_PRE_SCLK_2048			(0x2)
+#define RT5670_DA_STO_CLK_SEL_MASK		(0xf << 12)
+#define RT5670_DA_STO_CLK_SEL_SFT		12
+#define RT5670_DA_MONOL_CLK_SEL_MASK		(0xf << 8)
+#define RT5670_DA_MONOL_CLK_SEL_SFT		8
+#define RT5670_DA_MONOR_CLK_SEL_MASK		(0xf << 4)
+#define RT5670_DA_MONOR_CLK_SEL_SFT		4
+#define RT5670_AD_STO1_CLK_SEL_MASK		(0xf << 0)
+#define RT5670_AD_STO1_CLK_SEL_SFT		0
 
 /* ASRC Control 3 (0x85) */
-#define RT5670_I2S1_RATE_MASK			(0xf << 12)
-#define RT5670_I2S1_RATE_SFT			12
-#define RT5670_I2S2_RATE_MASK			(0xf << 8)
-#define RT5670_I2S2_RATE_SFT			8
+#define RT5670_UP_CLK_SEL_MASK			(0xf << 12)
+#define RT5670_UP_CLK_SEL_SFT			12
+#define RT5670_DOWN_CLK_SEL_MASK		(0xf << 8)
+#define RT5670_DOWN_CLK_SEL_SFT			8
+#define RT5670_AD_MONOL_CLK_SEL_MASK		(0xf << 4)
+#define RT5670_AD_MONOL_CLK_SEL_SFT		4
+#define RT5670_AD_MONOR_CLK_SEL_MASK		(0xf << 0)
+#define RT5670_AD_MONOR_CLK_SEL_SFT		0
 
 /* ASRC Control 4 (0x89) */
 #define RT5670_I2S1_PD_MASK			(0x7 << 12)
-- 
1.9.1
