From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 07/13] ASoC: Intel: Skylake: fix reset
	controller sequencing
Date: Fri, 18 Dec 2015 15:12:03 +0530
Message-ID: <1450431729-27259-8-git-send-email-vinod.koul@intel.com>
References: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C62265D44
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:39:17 +0100 (CET)
In-Reply-To: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

MISCBDCGE is a new register for Misc Backbone clock gate control
which is useful to control while resetting the link and ensuring
controller is in required state so add API to control it

HW recommends that we reset with CGCTL.MISCBDCGE disabled, so add
that while doing init chip and reset sequence.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.h |  5 ++++
 sound/soc/intel/skylake/skl.c         | 55 +++++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h         |  3 ++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 1bbcdb471cf2..d59d1ba62a43 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -55,6 +55,11 @@ struct skl_sst {
 
 	/* IPC messaging */
 	struct sst_generic_ipc ipc;
+
+	/* callback for miscbdge */
+	void (*enable_miscbdcge)(struct device *dev, bool enable);
+	/*Is CGCTL.MISCBDCGE disabled*/
+	bool miscbdcg_disabled;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2c16325d1ce1..85d47cedd125 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -28,6 +28,8 @@
 #include <sound/pcm.h>
 #include "../common/sst-acpi.h"
 #include "skl.h"
+#include "skl-sst-dsp.h"
+#include "skl-sst-ipc.h"
 
 /*
  * initialize the PCI registers
@@ -58,6 +60,49 @@ static void skl_init_pci(struct skl *skl)
 	skl_update_pci_byte(skl->pci, AZX_PCIREG_TCSEL, 0x07, 0);
 }
 
+static void update_pci_dword(struct pci_dev *pci,
+			unsigned int reg, u32 mask, u32 val)
+{
+	u32 data = 0;
+
+	pci_read_config_dword(pci, reg, &data);
+	data &= ~mask;
+	data |= (val & mask);
+	pci_write_config_dword(pci, reg, data);
+}
+
+/*
+ * skl_enable_miscbdcge - enable/dsiable CGCTL.MISCBDCGE bits
+ *
+ * @dev: device pointer
+ * @enable: enable/disable flag
+ */
+static void skl_enable_miscbdcge(struct device *dev, bool enable)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	u32 val;
+
+	val = enable ? AZX_CGCTL_MISCBDCGE_MASK : 0;
+
+	update_pci_dword(pci, AZX_PCIREG_CGCTL, AZX_CGCTL_MISCBDCGE_MASK, val);
+}
+
+/*
+ * While performing reset, controller may not come back properly causing
+ * issues, so recommendation is to set CGCTL.MISCBDCGE to 0 then do reset
+ * (init chip) and then again set CGCTL.MISCBDCGE to 1
+ */
+static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
+{
+	int ret;
+
+	skl_enable_miscbdcge(bus->dev, false);
+	ret = snd_hdac_bus_init_chip(bus, full_reset);
+	skl_enable_miscbdcge(bus->dev, true);
+
+	return ret;
+}
+
 /* called from IRQ */
 static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
 {
@@ -144,7 +189,9 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
+	skl_enable_miscbdcge(bus->dev, true);
 
 	return 0;
 }
@@ -155,7 +202,7 @@ static int _skl_resume(struct hdac_ext_bus *ebus)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	return skl_resume_dsp(skl);
 }
@@ -379,7 +426,7 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 				 * back to the sanity state.
 				 */
 				snd_hdac_bus_stop_chip(bus);
-				snd_hdac_bus_init_chip(bus, true);
+				skl_init_chip(bus, true);
 			}
 		}
 	}
@@ -489,7 +536,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	/* codec detection */
 	if (!bus->codec_mask) {
@@ -538,6 +585,8 @@ static int skl_probe(struct pci_dev *pci,
 			dev_dbg(bus->dev, "error failed to register dsp\n");
 			goto out_mach_free;
 		}
+		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
+
 	}
 	if (ebus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 3d167eed0f59..7610808102f9 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -48,6 +48,9 @@
 #define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
 #define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
 
+#define AZX_PCIREG_CGCTL		0x48
+#define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
+
 struct skl_dsp_resource {
 	u32 max_mcps;
 	u32 max_mem;
-- 
1.9.1
