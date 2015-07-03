From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/6] ASoC: Intel: Define SKL ADSP IPC and
	general purpose registers
Date: Fri,  3 Jul 2015 16:04:03 +0530
Message-ID: <1435919647-14049-3-git-send-email-vinod.koul@intel.com>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B2F264EF3
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 12:32:34 +0200 (CEST)
In-Reply-To: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Kp, Jeeja" <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Kp, Jeeja <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl-sst-dsp.h

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
new file mode 100644
index 000000000000..2ac120c18bea
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -0,0 +1,62 @@
+/*
+ * Skylake SST DSP Support
+ *
+ * Copyright (C) 2014-15, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __SKL_SST_DSP_H__
+#define __SKL_SST_DSP_H__
+
+/* Intel HD Audio General DSP Registers */
+#define SKL_ADSP_GEN_BASE		0x0
+#define SKL_ADSP_REG_ADSPCS		(SKL_ADSP_GEN_BASE + 0x04)
+#define SKL_ADSP_REG_ADSPIC		(SKL_ADSP_GEN_BASE + 0x08)
+#define SKL_ADSP_REG_ADSPIS		(SKL_ADSP_GEN_BASE + 0x0C)
+#define SKL_ADSP_REG_ADSPIC2		(SKL_ADSP_GEN_BASE + 0x10)
+#define SKL_ADSP_REG_ADSPIS2		(SKL_ADSP_GEN_BASE + 0x14)
+
+/* Intel HD Audio Inter-Processor Communication Registers */
+#define SKL_ADSP_IPC_BASE		0x40
+#define SKL_ADSP_REG_HIPCT		(SKL_ADSP_IPC_BASE + 0x00)
+#define SKL_ADSP_REG_HIPCTE		(SKL_ADSP_IPC_BASE + 0x04)
+#define SKL_ADSP_REG_HIPCI		(SKL_ADSP_IPC_BASE + 0x08)
+#define SKL_ADSP_REG_HIPCIE		(SKL_ADSP_IPC_BASE + 0x0C)
+#define SKL_ADSP_REG_HIPCCTL		(SKL_ADSP_IPC_BASE + 0x10)
+
+/*  HIPCI */
+#define SKL_ADSP_REG_HIPCI_BUSY		BIT(31)
+
+/* HIPCIE */
+#define SKL_ADSP_REG_HIPCIE_DONE	BIT(30)
+
+/* HIPCCTL */
+#define SKL_ADSP_REG_HIPCCTL_DONE	BIT(1)
+#define SKL_ADSP_REG_HIPCCTL_BUSY	BIT(0)
+
+/* HIPCT */
+#define SKL_ADSP_REG_HIPCT_BUSY		BIT(31)
+
+/* Intel HD Audio SRAM Window 1 */
+#define SKL_ADSP_SRAM1_BASE		0xA000
+
+#define SKL_ADSP_MMIO_LEN		0x10000
+
+#define SKL_ADSP_W0_STAT_SZ		0x800
+
+#define SKL_ADSP_W0_UP_SZ		0x800
+
+#define SKL_ADSP_W1_SZ			0x1000
+
+#define SKL_ADSPIC_IPC			1
+#define SKL_ADSPIS_IPC			1
+
+#endif /*__SKL_SST_DSP_H__*/
-- 
1.9.1
