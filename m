From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/21] ASoC: SOF: Intel: Add HDA controller for
	Intel DSP
Date: Tue, 11 Dec 2018 15:30:13 -0600
Message-ID: <20181211213029.28801-6-pierre-louis.bossart@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Support HDA controller operations for DSP and provide space for future
DSP HDA FW integration.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 166 +++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-ctrl.c

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
new file mode 100644
index 000000000000..e8f27012ec11
--- /dev/null
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//	    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
+//	    Rander Wang <rander.wang@intel.com>
+//          Keyon Jie <yang.jie@linux.intel.com>
+//
+
+/*
+ * Hardware interface for generic Intel audio DSP HDA IP
+ */
+
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
+#include "../ops.h"
+#include "hda.h"
+
+/*
+ * HDA Operations.
+ */
+
+int hda_dsp_ctrl_link_reset(struct snd_sof_dev *sdev, bool reset)
+{
+	unsigned long timeout;
+	u32 gctl = 0;
+	u32 val;
+
+	/* 0 to enter reset and 1 to exit reset */
+	val = reset ? 0 : SOF_HDA_GCTL_RESET;
+
+	/* enter/exit HDA controller reset */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_GCTL,
+				SOF_HDA_GCTL_RESET, val);
+
+	/* wait to enter/exit reset */
+	timeout = jiffies + msecs_to_jiffies(HDA_DSP_CTRL_RESET_TIMEOUT);
+	while (time_before(jiffies, timeout)) {
+		gctl = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_GCTL);
+		if ((gctl & SOF_HDA_GCTL_RESET) == val)
+			return 0;
+		usleep_range(500, 1000);
+	}
+
+	/* enter/exit reset failed */
+	dev_err(sdev->dev, "error: failed to %s HDA controller gctl 0x%x\n",
+		reset ? "reset" : "ready", gctl);
+	return -EIO;
+}
+
+int hda_dsp_ctrl_get_caps(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	u32 cap, offset, feature;
+	int count = 0;
+
+	offset = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_LLCH);
+
+	do {
+		cap = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, offset);
+
+		dev_dbg(sdev->dev, "checking for capabilities at offset 0x%x\n",
+			offset & SOF_HDA_CAP_NEXT_MASK);
+
+		feature = (cap & SOF_HDA_CAP_ID_MASK) >> SOF_HDA_CAP_ID_OFF;
+
+		switch (feature) {
+		case SOF_HDA_PP_CAP_ID:
+			dev_dbg(sdev->dev, "found DSP capability at 0x%x\n",
+				offset);
+			bus->ppcap = bus->remap_addr + offset;
+			sdev->bar[HDA_DSP_PP_BAR] = bus->ppcap;
+			break;
+		case SOF_HDA_SPIB_CAP_ID:
+			dev_dbg(sdev->dev, "found SPIB capability at 0x%x\n",
+				offset);
+			bus->spbcap = bus->remap_addr + offset;
+			sdev->bar[HDA_DSP_SPIB_BAR] = bus->spbcap;
+			break;
+		case SOF_HDA_DRSM_CAP_ID:
+			dev_dbg(sdev->dev, "found DRSM capability at 0x%x\n",
+				offset);
+			bus->drsmcap = bus->remap_addr + offset;
+			sdev->bar[HDA_DSP_DRSM_BAR] = bus->drsmcap;
+			break;
+		case SOF_HDA_GTS_CAP_ID:
+			dev_dbg(sdev->dev, "found GTS capability at 0x%x\n",
+				offset);
+			bus->gtscap = bus->remap_addr + offset;
+			break;
+		case SOF_HDA_ML_CAP_ID:
+			dev_dbg(sdev->dev, "found ML capability at 0x%x\n",
+				offset);
+			bus->mlcap = bus->remap_addr + offset;
+			break;
+		default:
+			dev_vdbg(sdev->dev, "found capability %d at 0x%x\n",
+				 feature, offset);
+			break;
+		}
+
+		offset = cap & SOF_HDA_CAP_NEXT_MASK;
+	} while (count++ <= SOF_HDA_MAX_CAPS && offset);
+
+	return 0;
+}
+
+void hda_dsp_ctrl_misc_clock_gating(struct snd_sof_dev *sdev, bool enable)
+{
+	u32 val = enable ? PCI_CGCTL_MISCBDCGE_MASK : 0;
+
+	snd_sof_pci_update_bits(sdev, PCI_CGCTL, PCI_CGCTL_MISCBDCGE_MASK, val);
+}
+
+/*
+ * enable/disable audio dsp clock gating and power gating bits.
+ * This allows the HW to opportunistically power and clock gate
+ * the audio dsp when it is idle
+ */
+int hda_dsp_ctrl_clock_power_gating(struct snd_sof_dev *sdev, bool enable)
+{
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_bus *bus = sof_to_bus(sdev);
+#endif
+	u32 val;
+
+	/* enable/disable audio dsp clock gating */
+	val = enable ? PCI_CGCTL_ADSPDCGE : 0;
+	snd_sof_pci_update_bits(sdev, PCI_CGCTL, PCI_CGCTL_ADSPDCGE, val);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* enable/disable L1 support */
+	val = enable ? SOF_HDA_VS_EM2_L1SEN : 0;
+	snd_hdac_chip_updatel(bus, VS_EM2, SOF_HDA_VS_EM2_L1SEN, val);
+#endif
+
+	/* enable/disable audio dsp power gating */
+	val = enable ? 0 : PCI_PGCTL_ADSPPGD;
+	snd_sof_pci_update_bits(sdev, PCI_PGCTL, PCI_PGCTL_ADSPPGD, val);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+/*
+ * While performing reset, controller may not come back properly and causing
+ * issues, so recommendation is to set CGCTL.MISCBDCGE to 0 then do reset
+ * (init chip) and then again set CGCTL.MISCBDCGE to 1
+ */
+int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	int ret;
+
+	hda_dsp_ctrl_misc_clock_gating(sdev, false);
+	ret = snd_hdac_bus_init_chip(bus, full_reset);
+	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+
+	return ret;
+}
+#endif
+
-- 
2.17.1
