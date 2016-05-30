From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Skylake: Add strip extended
	manifest utility
Date: Mon, 30 May 2016 17:42:55 +0530
Message-ID: <1464610381-19416-2-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B0F2607F7
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:46 +0200 (CEST)
In-Reply-To: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

Some upcoming platforms like broxton etc have extended manifest
in firmware binary. This is not required to be downloaded to DSP.
So driver needs to strip this before downloading.

Add a utility function to check if a header exists, and remove it
in that case

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/Makefile        |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  2 ++
 sound/soc/intel/skylake/skl-sst-utils.c | 54 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-sst-utils.c

diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index c28f5d0e1d99..60fbc9bbe473 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
 snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o skl-sst-cldma.o \
-		skl-sst.o bxt-sst.o
+		skl-sst.o bxt-sst.o skl-sst-utils.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index deabe7308d3b..94878fac2269 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -175,4 +175,6 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
+int skl_dsp_strip_extended_manifest(struct firmware *fw);
+
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
new file mode 100644
index 000000000000..c00567dad989
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -0,0 +1,54 @@
+/*
+ *  skl-sst-utils.c - SKL sst utils functions
+ *
+ *  Copyright (C) 2016 Intel Corp
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
+#include <linux/firmware.h>
+#include "skl-sst-dsp.h"
+
+/* FW Extended Manifest Header id = $AE1 */
+#define SKL_EXT_MANIFEST_HEADER_MAGIC   0x31454124
+
+struct skl_ext_manifest_hdr {
+	u32 id;
+	u32 len;
+	u16 version_major;
+	u16 version_minor;
+	u32 entries;
+};
+
+/*
+ * some firmware binary contains some extended manifest. This needs
+ * to be stripped in that case before we load and use that image.
+ *
+ * So check for magic header, if found strip the header
+ */
+int skl_dsp_strip_extended_manifest(struct firmware *fw)
+{
+	struct skl_ext_manifest_hdr *hdr;
+
+	/* check if fw file is greater than header we are looking */
+	if (fw->size < sizeof(hdr)) {
+		pr_err("%s: Firmware file small, no hdr\n", __func__);
+		return -EINVAL;
+	}
+
+	hdr = (struct skl_ext_manifest_hdr *)fw->data;
+
+	if (hdr->id == SKL_EXT_MANIFEST_HEADER_MAGIC) {
+		fw->size -= hdr->len;
+		fw->data += hdr->len;
+	}
+
+	return 0;
+}
-- 
1.9.1
