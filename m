From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 07/13] ASoC: Intel: Skylake: fix reset
	controller sequencing
Date: Sat, 12 Dec 2015 17:36:27 +0530
Message-ID: <1449921993-21101-8-git-send-email-vinod.koul@intel.com>
References: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8287826583C
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 13:04:04 +0100 (CET)
In-Reply-To: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
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
 sound/soc/intel/skylake/skl.c | 45 ++++++++++++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl.h |  5 +++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2c16325d1ce1..0f437f715216 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -58,6 +58,43 @@ static void skl_init_pci(struct skl *skl)
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
+void skl_enable_miscbdcge(struct device *dev, bool enable)
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
@@ -144,7 +181,9 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
+	skl_enable_miscbdcge(bus->dev, true);
 
 	return 0;
 }
@@ -155,7 +194,7 @@ static int _skl_resume(struct hdac_ext_bus *ebus)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	return skl_resume_dsp(skl);
 }
@@ -379,7 +418,7 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 				 * back to the sanity state.
 				 */
 				snd_hdac_bus_stop_chip(bus);
-				snd_hdac_bus_init_chip(bus, true);
+				skl_init_chip(bus, true);
 			}
 		}
 	}
@@ -489,7 +528,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	/* codec detection */
 	if (!bus->codec_mask) {
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 3d167eed0f59..f2370f5d66c6 100644
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
@@ -96,4 +99,6 @@ int skl_init_dsp(struct skl *skl);
 void skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
+
+void skl_enable_miscbdcge(struct device *dev, bool enable);
 #endif /* __SOUND_SOC_SKL_H */
-- 
1.9.1
