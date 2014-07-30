From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add macros for SST shim register
	bits.
Date: Wed, 30 Jul 2014 20:08:18 +0800
Message-ID: <1406722098-7983-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4653F260859
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:07:20 +0200 (CEST)
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

Add some register definitions for other shim register bits.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-dsp.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 21a85eb..3165dfa 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -77,6 +77,8 @@
 #define SST_CSR_S0IOCS		(0x1 << 21)
 #define SST_CSR_S1IOCS		(0x1 << 23)
 #define SST_CSR_LPCS		(0x1 << 31)
+#define SST_CSR_24MHZ_LPCS	(SST_CSR_SBCS0 | SST_CSR_SBCS1 | SST_CSR_LPCS)
+#define SST_CSR_24MHZ_NO_LPCS	(SST_CSR_SBCS0 | SST_CSR_SBCS1)
 #define SST_BYT_CSR_RST		(0x1 << 0)
 #define SST_BYT_CSR_VECTOR_SEL	(0x1 << 1)
 #define SST_BYT_CSR_STALL	(0x1 << 2)
@@ -96,6 +98,14 @@
 #define SST_IMRX_DONE		(0x1 << 0)
 #define SST_BYT_IMRX_REQUEST	(0x1 << 1)
 
+/* IMRD / IMD */
+#define SST_IMRD_DONE		(0x1 << 0)
+#define SST_IMRD_BUSY		(0x1 << 1)
+#define SST_IMRD_SSP0		(0x1 << 16)
+#define SST_IMRD_DMAC0		(0x1 << 21)
+#define SST_IMRD_DMAC1		(0x1 << 22)
+#define SST_IMRD_DMAC		(SST_IMRD_DMAC0 | SST_IMRD_DMAC1)
+
 /*  IPCX / IPCC */
 #define	SST_IPCX_DONE		(0x1 << 30)
 #define	SST_IPCX_BUSY		(0x1 << 31)
@@ -125,6 +135,18 @@
 /* HMDC */
 #define SST_HMDC_HDDA0(x)	(x << 0)
 #define SST_HMDC_HDDA1(x)	(x << 7)
+#define SST_HMDC_HDDA_E0_CH0	1
+#define SST_HMDC_HDDA_E0_CH1	2
+#define SST_HMDC_HDDA_E0_CH2	4
+#define SST_HMDC_HDDA_E0_CH3	8
+#define SST_HMDC_HDDA_E1_CH0	SST_HMDC_HDDA1(SST_HMDC_HDDA_E0_CH0)
+#define SST_HMDC_HDDA_E1_CH1	SST_HMDC_HDDA1(SST_HMDC_HDDA_E0_CH1)
+#define SST_HMDC_HDDA_E1_CH2	SST_HMDC_HDDA1(SST_HMDC_HDDA_E0_CH2)
+#define SST_HMDC_HDDA_E1_CH3	SST_HMDC_HDDA1(SST_HMDC_HDDA_E0_CH3)
+#define SST_HMDC_HDDA_E0_ALLCH	(SST_HMDC_HDDA_E0_CH0 | SST_HMDC_HDDA_E0_CH1 | \
+				 SST_HMDC_HDDA_E0_CH2 | SST_HMDC_HDDA_E0_CH3)
+#define SST_HMDC_HDDA_E1_ALLCH	(SST_HMDC_HDDA_E1_CH0 | SST_HMDC_HDDA_E1_CH1 | \
+				 SST_HMDC_HDDA_E1_CH2 | SST_HMDC_HDDA_E1_CH3)
 
 
 /* SST Vendor Defined Registers and bits */
@@ -134,11 +156,16 @@
 #define SST_VDRTCTL3		0xaC
 
 /* VDRTCTL0 */
+#define SST_VDRTCL0_APLLSE_MASK		1
 #define SST_VDRTCL0_DSRAMPGE_SHIFT	16
 #define SST_VDRTCL0_DSRAMPGE_MASK	(0xffff << SST_VDRTCL0_DSRAMPGE_SHIFT)
 #define SST_VDRTCL0_ISRAMPGE_SHIFT	6
 #define SST_VDRTCL0_ISRAMPGE_MASK	(0x3ff << SST_VDRTCL0_ISRAMPGE_SHIFT)
 
+/* PMCS */
+#define SST_PMCS		0x84
+#define SST_PMCS_PS_MASK	0x3
+
 struct sst_dsp;
 
 /*
-- 
1.8.3.2
