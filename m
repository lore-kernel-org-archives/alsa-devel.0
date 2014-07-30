From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Fix naming of HMDC register
	macros.
Date: Wed, 30 Jul 2014 20:05:44 +0800
Message-ID: <1406721944-7652-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B8C05260859
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:05:08 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

HMDC is the correct naming for this register.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-dsp.h         | 8 ++++----
 sound/soc/intel/sst-haswell-dsp.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 967fb32..21a85eb 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -52,7 +52,7 @@
 #define SST_CLKCTL		0x78
 #define SST_CSR2		0x80
 #define SST_LTRC		0xE0
-#define SST_HDMC		0xE8
+#define SST_HMDC		0xE8
 
 #define SST_SHIM_BEGIN		SST_CSR
 #define SST_SHIM_END		SST_HDMC
@@ -122,9 +122,9 @@
 /* LTRC */
 #define SST_LTRC_VAL(x)		(x << 0)
 
-/* HDMC */
-#define SST_HDMC_HDDA0(x)	(x << 0)
-#define SST_HDMC_HDDA1(x)	(x << 7)
+/* HMDC */
+#define SST_HMDC_HDDA0(x)	(x << 0)
+#define SST_HMDC_HDDA1(x)	(x << 7)
 
 
 /* SST Vendor Defined Registers and bits */
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 03ea282..4b6c163 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -269,9 +269,9 @@ static void hsw_boot(struct sst_dsp *sst)
 		SST_CSR2_SDFD_SSP1);
 
 	/* enable DMA engine 0,1 all channels to access host memory */
-	sst_dsp_shim_update_bits_unlocked(sst, SST_HDMC,
-		SST_HDMC_HDDA1(0xff)  | SST_HDMC_HDDA0(0xff),
-		SST_HDMC_HDDA1(0xff) | SST_HDMC_HDDA0(0xff));
+	sst_dsp_shim_update_bits_unlocked(sst, SST_HMDC,
+		SST_HMDC_HDDA1(0xff) | SST_HMDC_HDDA0(0xff),
+		SST_HMDC_HDDA1(0xff) | SST_HMDC_HDDA0(0xff));
 
 	/* disable all clock gating */
 	writel(0x0, sst->addr.pci_cfg + SST_VDRTCTL2);
-- 
1.8.3.2
