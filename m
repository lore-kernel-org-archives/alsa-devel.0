From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix reset controller
	sequencing" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:33 +0000
Message-ID: <E1aIF0z-0008SI-H5@debutante>
References: <1450431729-27259-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 88E732658CB
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:24:47 +0100 (CET)
In-Reply-To: <1450431729-27259-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix reset controller sequencing

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

>From 0c8ba9d28518822d612de23fc9020b2a66a0228c Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Fri, 18 Dec 2015 15:12:03 +0530
Subject: [PATCH] ASoC: Intel: Skylake: fix reset controller sequencing

MISCBDCGE is a new register for Misc Backbone clock gate control
which is useful to control while resetting the link and ensuring
controller is in required state so add API to control it

HW recommends that we reset with CGCTL.MISCBDCGE disabled, so add
that while doing init chip and reset sequence.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index b69649aa7809..dd38f5feb7c0 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -29,6 +29,8 @@
 #include <sound/pcm.h>
 #include "../common/sst-acpi.h"
 #include "skl.h"
+#include "skl-sst-dsp.h"
+#include "skl-sst-ipc.h"
 
 /*
  * initialize the PCI registers
@@ -59,6 +61,49 @@ static void skl_init_pci(struct skl *skl)
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
@@ -145,7 +190,9 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
+	skl_enable_miscbdcge(bus->dev, true);
 
 	return 0;
 }
@@ -156,7 +203,7 @@ static int _skl_resume(struct hdac_ext_bus *ebus)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	return skl_resume_dsp(skl);
 }
@@ -380,7 +427,7 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 				 * back to the sanity state.
 				 */
 				snd_hdac_bus_stop_chip(bus);
-				snd_hdac_bus_init_chip(bus, true);
+				skl_init_chip(bus, true);
 			}
 		}
 	}
@@ -490,7 +537,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	/* codec detection */
 	if (!bus->codec_mask) {
@@ -539,6 +586,8 @@ static int skl_probe(struct pci_dev *pci,
 			dev_dbg(bus->dev, "error failed to register dsp\n");
 			goto out_mach_free;
 		}
+		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
+
 	}
 	if (ebus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 36a1b8c5f6d0..8a08bb727991 100644
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
2.7.0.rc3
