From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Move SKL+ vendor specific
	register definitions to hda_register.h
Date: Fri, 31 Mar 2017 10:49:29 +0200
Message-ID: <20170331084930.813-3-tiwai@suse.de>
References: <20170331084930.813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB8A2671EA
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 10:49:32 +0200 (CEST)
In-Reply-To: <20170331084930.813-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

They may be used by both legacy and ASoC drivers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_register.h  | 22 ++++++++++++++++++++--
 sound/pci/hda/hda_intel.c     |  4 ++--
 sound/soc/intel/skylake/skl.h | 21 ---------------------
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 0013063db7f2..1251ff41c9d3 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -106,8 +106,26 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_HSW_EM4			0x100c
 #define AZX_REG_HSW_EM5			0x1010
 
-/* Skylake/Broxton display HD-A controller Extended Mode registers */
-#define AZX_REG_SKL_EM4L		0x1040
+/* Skylake/Broxton vendor-specific registers */
+#define AZX_REG_VS_EM1			0x1000
+#define AZX_REG_VS_INRC			0x1004
+#define AZX_REG_VS_OUTRC		0x1008
+#define AZX_REG_VS_FIFOTRK		0x100C
+#define AZX_REG_VS_FIFOTRK2		0x1010
+#define AZX_REG_VS_EM2			0x1030
+#define AZX_REG_VS_EM3L			0x1038
+#define AZX_REG_VS_EM3U			0x103C
+#define AZX_REG_VS_EM4L			0x1040
+#define AZX_REG_VS_EM4U			0x1044
+#define AZX_REG_VS_LTRC			0x1048
+#define AZX_REG_VS_D0I3C		0x104A
+#define AZX_REG_VS_PCE			0x104B
+#define AZX_REG_VS_L2MAGC		0x1050
+#define AZX_REG_VS_L2LAHPT		0x1054
+#define AZX_REG_VS_SDXDPIB_XBASE	0x1084
+#define AZX_REG_VS_SDXDPIB_XINTERVAL	0x20
+#define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
+#define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
 
 /* PCI space */
 #define AZX_PCIREG_TCSEL		0x44
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c8256a89375a..a48330f4a1a9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -534,9 +534,9 @@ static void bxt_reduce_dma_latency(struct azx *chip)
 {
 	u32 val;
 
-	val = azx_readl(chip, SKL_EM4L);
+	val = azx_readl(chip, VS_EM4L);
 	val &= (0x3 << 20);
-	azx_writel(chip, SKL_EM4L, val);
+	azx_writel(chip, VS_EM4L, val);
 }
 
 static void hda_intel_init_chip(struct azx *chip, bool full_reset)
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index bbef77d2b917..8e2878012d53 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -27,27 +27,6 @@
 
 #define SKL_SUSPEND_DELAY 2000
 
-/* Vendor Specific Registers */
-#define AZX_REG_VS_EM1			0x1000
-#define AZX_REG_VS_INRC			0x1004
-#define AZX_REG_VS_OUTRC		0x1008
-#define AZX_REG_VS_FIFOTRK		0x100C
-#define AZX_REG_VS_FIFOTRK2		0x1010
-#define AZX_REG_VS_EM2			0x1030
-#define AZX_REG_VS_EM3L			0x1038
-#define AZX_REG_VS_EM3U			0x103C
-#define AZX_REG_VS_EM4L			0x1040
-#define AZX_REG_VS_EM4U			0x1044
-#define AZX_REG_VS_LTRC			0x1048
-#define AZX_REG_VS_D0I3C		0x104A
-#define AZX_REG_VS_PCE			0x104B
-#define AZX_REG_VS_L2MAGC		0x1050
-#define AZX_REG_VS_L2LAHPT		0x1054
-#define AZX_REG_VS_SDXDPIB_XBASE	0x1084
-#define AZX_REG_VS_SDXDPIB_XINTERVAL	0x20
-#define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
-#define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
-
 #define AZX_PCIREG_PGCTL		0x44
 #define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
-- 
2.11.1
