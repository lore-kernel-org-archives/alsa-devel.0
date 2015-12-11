From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/14] ALSA: hdac: Add MISCBDCGE support
Date: Fri, 11 Dec 2015 12:14:18 +0530
Message-ID: <1449816267-11910-6-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 05DAF26589D
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:41:36 +0100 (CET)
In-Reply-To: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
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

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_register.h        |  3 +++
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 28ac1f9a18ac..fa33237f4bd1 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -96,6 +96,9 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 /* PCI space */
 #define AZX_PCIREG_TCSEL		0x44
 
+#define AZX_PCIREG_CGCTL               0x48
+#define AZX_CGCTL_MISCBDCGE_MASK       (1 << 6)
+
 /*
  * other constants
  */
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index f3454950ee0b..65961bbb8ca3 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -152,6 +152,7 @@ void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 				 int stream);
 void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
 				 int stream);
+void snd_hdac_ext_bus_enable_miscbdcge(struct device *dev, bool enable);
 
 /* update register macro */
 #define snd_hdac_updatel(addr, reg, mask, val)		\
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 556267e75591..8f1d292a522c 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
+#include <linux/pci.h>
 
 /*
  * maximum HDAC capablities we should parse to avoid endless looping:
@@ -306,3 +307,25 @@ int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
+
+static void update_pci_dword(struct pci_dev *pci,
+			unsigned int reg, u32 mask, u32 val)
+{
+	u32 data;
+
+	pci_read_config_dword(pci, reg, &data);
+	data &= ~mask;
+	data |= (val & mask);
+	pci_write_config_dword(pci, reg, data);
+}
+
+void snd_hdac_ext_bus_enable_miscbdcge(struct device *dev, bool enable)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	u32 val;
+
+	val = enable ? AZX_CGCTL_MISCBDCGE_MASK : 0;
+
+	update_pci_dword(pci, AZX_PCIREG_CGCTL, AZX_CGCTL_MISCBDCGE_MASK, val);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_enable_miscbdcge);
-- 
1.9.1
