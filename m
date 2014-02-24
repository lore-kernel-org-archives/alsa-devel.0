From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Add Baytrail SST ID and
	Baytrail specific register bits
Date: Mon, 24 Feb 2014 17:26:56 +0200
Message-ID: <1393255622-31365-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A14261A22
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:27:11 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

While the SHIM register addresses in Baytrail are the same than Haswell and
Broadwell their register size is 64-bit and some bits are different.

This patch adds the SST device ID for Baytrail and Baytrail specific
SHIM bit definitions.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-dsp.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 608418c1181a..74052b59485c 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -24,6 +24,7 @@
 /* SST Device IDs  */
 #define SST_DEV_ID_LYNX_POINT		0x33C8
 #define SST_DEV_ID_WILDCAT_POINT	0x3438
+#define SST_DEV_ID_BYT			0x0F28
 
 /* Supported SST DMA Devices */
 #define SST_DMA_TYPE_DW		1
@@ -72,10 +73,15 @@
 #define SST_CSR_S0IOCS		(0x1 << 21)
 #define SST_CSR_S1IOCS		(0x1 << 23)
 #define SST_CSR_LPCS		(0x1 << 31)
+#define SST_BYT_CSR_RST		(0x1 << 0)
+#define SST_BYT_CSR_VECTOR_SEL	(0x1 << 1)
+#define SST_BYT_CSR_STALL	(0x1 << 2)
+#define SST_BYT_CSR_PWAITMODE	(0x1 << 3)
 
 /*  ISRX / ISC */
 #define SST_ISRX_BUSY		(0x1 << 1)
 #define SST_ISRX_DONE		(0x1 << 0)
+#define SST_BYT_ISRX_REQUEST	(0x1 << 1)
 
 /*  ISRD / ISD */
 #define SST_ISRD_BUSY		(0x1 << 1)
@@ -84,14 +90,19 @@
 /* IMRX / IMC */
 #define SST_IMRX_BUSY		(0x1 << 1)
 #define SST_IMRX_DONE		(0x1 << 0)
+#define SST_BYT_IMRX_REQUEST	(0x1 << 1)
 
 /*  IPCX / IPCC */
 #define	SST_IPCX_DONE		(0x1 << 30)
 #define	SST_IPCX_BUSY		(0x1 << 31)
+#define SST_BYT_IPCX_DONE	((u64)0x1 << 62)
+#define SST_BYT_IPCX_BUSY	((u64)0x1 << 63)
 
 /*  IPCD */
 #define	SST_IPCD_DONE		(0x1 << 30)
 #define	SST_IPCD_BUSY		(0x1 << 31)
+#define SST_BYT_IPCD_DONE	((u64)0x1 << 62)
+#define SST_BYT_IPCD_BUSY	((u64)0x1 << 63)
 
 /* CLKCTL */
 #define SST_CLKCTL_SMOS(x)	(x << 24)
-- 
1.8.5.3
