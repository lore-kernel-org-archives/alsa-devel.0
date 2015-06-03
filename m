From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 2/2] ALSA: hda - add new HDA registers
Date: Wed,  3 Jun 2015 12:24:32 +0530
Message-ID: <1433314472-24965-3-git-send-email-vinod.koul@intel.com>
References: <1433314472-24965-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 15547260517
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 08:53:24 +0200 (CEST)
In-Reply-To: <1433314472-24965-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch adds new registers as per HD audio Spec like capability registers
for processing pipe, software position based FIFO, Multiple Links and Global
Time Synchronization.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_register.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 0c7536e30fa4..ae995e523ff8 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -28,6 +28,10 @@
 #define AZX_REG_STATESTS		0x0e
 #define AZX_REG_GSTS			0x10
 #define   AZX_GSTS_FSTS		(1 << 1)   /* flush status */
+#define AZX_REG_GCAP2			0x12
+#define AZX_REG_LLCH			0x14
+#define AZX_REG_OUTSTRMPAY		0x18
+#define AZX_REG_INSTRMPAY		0x1A
 #define AZX_REG_INTCTL			0x20
 #define AZX_REG_INTSTS			0x24
 #define AZX_REG_WALLCLK			0x30	/* 24Mhz source */
@@ -81,6 +85,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_SD_FIFOW		0x0e
 #define AZX_REG_SD_FIFOSIZE		0x10
 #define AZX_REG_SD_FORMAT		0x12
+#define AZX_REG_SD_FIFOL		0x14
 #define AZX_REG_SD_BDLPL		0x18
 #define AZX_REG_SD_BDLPU		0x1c
 
@@ -138,6 +143,89 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_MAX_CORB_ENTRIES	256
 #define AZX_MAX_RIRB_ENTRIES	256
 
+/* Capability header  Structure */
+#define AZX_REG_CAP_HDR			0x0
+#define AZX_CAP_HDR_VER_OFF		28
+#define AZX_CAP_HDR_VER_MASK		(0xF << AZX_CAP_HDR_VER_OFF)
+#define AZX_CAP_HDR_ID_OFF		16
+#define AZX_CAP_HDR_ID_MASK		(0xFFF << AZX_CAP_HDR_ID_OFF)
+#define AZX_CAP_HDR_NXT_PTR_MASK	0xFFFF
+
+/* registers of Software Position Based FIFO Capability Structure */
+#define AZX_SPB_CAP_ID			0x4
+#define AZX_REG_SPB_BASE_ADDR		0x700
+#define AZX_REG_SPB_SPBFCH		0x00
+#define AZX_REG_SPB_SPBFCCTL		0x04
+/* Base used to calculate the iterating register offset */
+#define AZX_SPB_BASE			0x08
+/* Interval used to calculate the iterating register offset */
+#define AZX_SPB_INTERVAL		0x08
+
+/* registers of Global Time Synchronization Capability Structure */
+#define AZX_GTS_CAP_ID			0x1
+#define AZX_REG_GTS_GTSCH		0x00
+#define AZX_REG_GTS_GTSCD		0x04
+#define AZX_REG_GTS_GTSCTLAC		0x0C
+#define AZX_GTS_BASE			0x20
+#define AZX_GTS_INTERVAL		0x20
+
+/* registers for Processing Pipe Capability Structure */
+#define AZX_PP_CAP_ID			0x3
+#define AZX_REG_PP_PPCH			0x10
+#define AZX_REG_PP_PPCTL		0x04
+#define AZX_PPCTL_PIE			(1<<31)
+#define AZX_PPCTL_GPROCEN		(1<<30)
+/* _X_ = dma engine # and cannot * exceed 29 (per spec max 30 dma engines) */
+#define AZX_PPCTL_PROCEN(_X_)		(1<<(_X_))
+
+#define AZX_REG_PP_PPSTS		0x08
+
+#define AZX_PPHC_BASE			0x10
+#define AZX_PPHC_INTERVAL		0x10
+
+#define AZX_REG_PPHCLLPL		0x0
+#define AZX_REG_PPHCLLPU		0x4
+#define AZX_REG_PPHCLDPL		0x8
+#define AZX_REG_PPHCLDPU		0xC
+
+#define AZX_PPLC_BASE			0x10
+#define AZX_PPLC_MULTI			0x10
+#define AZX_PPLC_INTERVAL		0x10
+
+#define AZX_REG_PPLCCTL			0x0
+#define AZX_PPLCCTL_STRM_BITS		4
+#define AZX_PPLCCTL_STRM_SHIFT		20
+#define AZX_REG_MASK(bit_num, offset) \
+	(((1 << (bit_num)) - 1) << (offset))
+#define AZX_PPLCCTL_STRM_MASK \
+	AZX_REG_MASK(AZX_PPLCCTL_STRM_BITS, AZX_PPLCCTL_STRM_SHIFT)
+#define AZX_PPLCCTL_RUN			(1<<1)
+#define AZX_PPLCCTL_STRST		(1<<0)
+
+#define AZX_REG_PPLCFMT			0x4
+#define AZX_REG_PPLCLLPL		0x8
+#define AZX_REG_PPLCLLPU		0xC
+
+/* registers for Multiple Links Capability Structure */
+#define AZX_ML_CAP_ID			0x2
+#define AZX_REG_ML_MLCH			0x00
+#define AZX_REG_ML_MLCD			0x04
+#define AZX_ML_BASE			0x40
+#define AZX_ML_INTERVAL			0x40
+
+#define AZX_REG_ML_LCAP			0x00
+#define AZX_REG_ML_LCTL			0x04
+#define AZX_REG_ML_LOSIDV		0x08
+#define AZX_REG_ML_LSDIID		0x0C
+#define AZX_REG_ML_LPSOO		0x10
+#define AZX_REG_ML_LPSIO		0x12
+#define AZX_REG_ML_LWALFC		0x18
+#define AZX_REG_ML_LOUTPAY		0x20
+#define AZX_REG_ML_LINPAY		0x30
+
+#define AZX_MLCTL_SPA			(1<<16)
+#define AZX_MLCTL_CPA			23
+
 /*
  * helpers to read the stream position
  */
-- 
1.9.1
