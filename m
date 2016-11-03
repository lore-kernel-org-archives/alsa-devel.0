From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/9] ASoC: Intel: Skylake: Add support for
	programming D0i3C
Date: Thu,  3 Nov 2016 17:07:16 +0530
Message-ID: <1478173042-9458-4-git-send-email-vinod.koul@intel.com>
References: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A49A260083
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 12:28:24 +0100 (CET)
In-Reply-To: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

To set the controller in D0i3 mode, the driver needs to set D0i3C
register after DSP is quiesced. Since the D0iX entry/exit is done by IPC,
add this as callback so that it can be invoked from IPC module.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c     |  1 +
 sound/soc/intel/skylake/skl-sst-ipc.h |  3 +++
 sound/soc/intel/skylake/skl.c         | 47 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h         |  5 ++++
 4 files changed, 56 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index c966b40da180..b69e05ec6844 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1211,6 +1211,7 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 			return ret;
 		}
 		skl_populate_modules(skl);
+		skl->skl_sst->update_d0i3c = skl_update_d0i3c;
 	}
 	pm_runtime_mark_last_busy(platform->dev);
 	pm_runtime_put_autosuspend(platform->dev);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 1ae265d8ee08..ef2182d21934 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -83,6 +83,9 @@ struct skl_sst {
 
 	/* tplg manifest */
 	struct skl_dfw_manifest manifest;
+
+	/* Callback to update D0i3C register */
+	void (*update_d0i3c)(struct device *dev, bool enable);
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06fa5e85dd0e..02c273137703 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
+#include <linux/delay.h>
 #include <sound/pcm.h>
 #include "../common/sst-acpi.h"
 #include <sound/hda_register.h>
@@ -109,6 +110,52 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 	return ret;
 }
 
+void skl_update_d0i3c(struct device *dev, bool enable)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	u8 reg;
+	int timeout = 50;
+
+	reg = snd_hdac_chip_readb(bus, VS_D0I3C);
+	/* Do not write to D0I3C until command in progress bit is cleared */
+	while ((reg & AZX_REG_VS_D0I3C_CIP) && --timeout) {
+		udelay(10);
+		reg = snd_hdac_chip_readb(bus, VS_D0I3C);
+	}
+
+	/* Highly unlikely. But if it happens, flag error explicitly */
+	if (!timeout) {
+		dev_err(bus->dev, "Before D0I3C update: D0I3C CIP timeout\n");
+		return;
+	}
+
+	if (enable)
+		reg = reg | AZX_REG_VS_D0I3C_I3;
+	else
+		reg = reg & (~AZX_REG_VS_D0I3C_I3);
+
+	snd_hdac_chip_writeb(bus, VS_D0I3C, reg);
+
+	timeout = 50;
+	/* Wait for cmd in progress to be cleared before exiting the function */
+	reg = snd_hdac_chip_readb(bus, VS_D0I3C);
+	while ((reg & AZX_REG_VS_D0I3C_CIP) && --timeout) {
+		udelay(10);
+		reg = snd_hdac_chip_readb(bus, VS_D0I3C);
+	}
+
+	/* Highly unlikely. But if it happens, flag error explicitly */
+	if (!timeout) {
+		dev_err(bus->dev, "After D0I3C update: D0I3C CIP timeout\n");
+		return;
+	}
+
+	dev_dbg(bus->dev, "D0I3C register = 0x%x\n",
+			snd_hdac_chip_readb(bus, VS_D0I3C));
+}
+
 /* called from IRQ */
 static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
 {
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 5d4fbb094c48..88ba54ba5f72 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -52,6 +52,9 @@
 #define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
 #define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
+/* D0I3C Register fields */
+#define AZX_REG_VS_D0I3C_CIP      0x1 /* Command in progress */
+#define AZX_REG_VS_D0I3C_I3       0x4 /* D0i3 enable */
 
 struct skl_dsp_resource {
 	u32 max_mcps;
@@ -125,4 +128,6 @@ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 int skl_resume_dsp(struct skl *skl);
 void skl_cleanup_resources(struct skl *skl);
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id);
+void skl_update_d0i3c(struct device *dev, bool enable);
+
 #endif /* __SOUND_SOC_SKL_H */
-- 
1.9.1
