From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add strip extended
	manifest utility" to the asoc tree
Date: Mon, 30 May 2016 18:39:19 +0100
Message-ID: <E1b7R9r-0000oG-9g@debutante>
References: <1464610381-19416-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D02265DF5
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:23 +0200 (CEST)
In-Reply-To: <1464610381-19416-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add strip extended manifest utility

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

>From 6eee87261f69e366bfe9b908ae3b441efb8e28ea Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Mon, 30 May 2016 17:42:55 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add strip extended manifest utility

Some upcoming platforms like broxton etc have extended manifest
in firmware binary. This is not required to be downloaded to DSP.
So driver needs to strip this before downloading.

Add a utility function to check if a header exists, and remove it
in that case

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
