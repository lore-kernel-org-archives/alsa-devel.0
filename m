From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 1/7] ASoC: hda: Add skl dsp init and registering
	with SST IPC lib
Date: Sun, 19 Apr 2015 02:27:27 +0530
Message-ID: <1429390653-8194-2-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FB92612D0
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:43 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
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

This will be used by the controller to register/unregister
with the SST IPC lib if processing pipe caps is supported

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h |    3 ++
 sound/soc/hda/Kconfig           |    1 +
 sound/soc/hda/Makefile          |    2 +-
 sound/soc/hda/hda_skl.h         |   16 ++--------
 sound/soc/hda/hda_soc_dsp.c     |   62 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 14 deletions(-)
 create mode 100644 sound/soc/hda/hda_soc_dsp.c

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 9adeb49cf126..a85f95be13c1 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -263,4 +263,7 @@ int ssth_cl_dma_prepare(struct ssth_lib *ctx);
 void ssth_process_cl_dma(struct work_struct *work);
 void ssth_cldma_int_disable(struct ssth_lib *ctx);
 
+int ssth_skl_init(struct device *dev, void __iomem *mmio_base, int irq,
+		struct ssth_dsp_loader_ops dsp_ops, struct ssth_lib **dsp);
+void ssth_skl_cleanup(struct device *dev, struct ssth_lib *ctx);
 #endif /*__HDA_SST_DSP_H__*/
diff --git a/sound/soc/hda/Kconfig b/sound/soc/hda/Kconfig
index 841ea5276fe3..445fa9842127 100644
--- a/sound/soc/hda/Kconfig
+++ b/sound/soc/hda/Kconfig
@@ -29,6 +29,7 @@ config SND_SOC_HDA_SKL
 
 config SND_SOC_I2S_SKL_MACH
         tristate "SOC Machine Audio driver for SKL Onboard I2S"
+	 select SND_HDA_DSP_LOADER
         select SND_SOC_HDA_SKL
         select SND_SOC_RT286
         select SND_SOC_HDMI
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index d318d4acb8a7..2be667dc0724 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,4 +1,4 @@
-snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o
+snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o hda_soc_dsp.o
 
 obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
 
diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
index 0cc2ac69a9ab..914ea05da6aa 100644
--- a/sound/soc/hda/hda_skl.h
+++ b/sound/soc/hda/hda_skl.h
@@ -1,15 +1,3 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the Free
- *  Software Foundation; either version 2 of the License, or (at your option)
- *  any later version.
- *
- *  This program is distributed in the hope that it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- *  more details.
- */
-
 #ifndef __SOUND_SOC_HDA_SKL_H
 #define __SOUND_SOC_HDA_SKL_H
 
@@ -22,13 +10,15 @@
 
 struct hda_soc_bus {
 	struct hdac_bus chip;
+	struct device *dev;
 	struct pci_dev *pci;
 
 	unsigned int init_failed:1; /* delayed init failed */
 	unsigned int msi:1;
+	struct ssth_lib *dsp; /* ssth lib ctx */
 };
 
-/* to pass dai dma data */
+/*to pass dai dma data */
 struct soc_hda_dma_params {
 	u32 format;
 	u8 stream_tag;
diff --git a/sound/soc/hda/hda_soc_dsp.c b/sound/soc/hda/hda_soc_dsp.c
new file mode 100644
index 000000000000..3fa033ecaa90
--- /dev/null
+++ b/sound/soc/hda/hda_soc_dsp.c
@@ -0,0 +1,62 @@
+/*
+ *  hda_soc_dsp.c - HDA DSP interface for FW registration, Pipe and Module
+ *  configurations
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author:Rafal Redzimski <rafal.f.redzimski@intel.com>
+ *	   Jeeja KP <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm.h>
+#include <sound/soc-hda-sst-dsp.h>
+#include <sound/soc-hda-sst-ipc.h>
+#include "hda_skl.h"
+
+int ssth_dsp_register(struct hda_soc_bus *schip)
+{
+	void __iomem *mmio_base;
+	int irq = schip->chip.irq;
+	int ret = 0;
+	struct ssth_dsp_loader_ops loader_ops;
+
+	/*TODO assign dsp loader ops */
+
+	/*TODO enable ppcap interrupt */
+	/*read the BAR of the ADSP MMIO */
+	mmio_base = pci_ioremap_bar(schip->pci, 4);
+	if (mmio_base == NULL) {
+		dev_err(schip->dev, "ioremap error\n");
+		return -ENXIO;
+	}
+
+	ret = ssth_skl_init(schip->dev, mmio_base, irq,
+			loader_ops, &schip->dsp);
+
+	dev_dbg(schip->dev, "dsp registeration status=%d\n", ret);
+	return ret;
+}
+
+void ssth_dsp_unregister(struct hda_soc_bus *schip)
+{
+	/*TODO disbale ppcap interrupt */
+	ssth_skl_cleanup(schip->dev, schip->dsp);
+	if (schip->dsp->mmio_base)
+		iounmap(schip->dsp->mmio_base);
+}
-- 
1.7.9.5
