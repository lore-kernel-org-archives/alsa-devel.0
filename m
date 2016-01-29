From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - disable dynamic clock gating on
	Broxton before reset
Date: Fri, 29 Jan 2016 20:39:09 +0800
Message-ID: <1454071149-15712-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A33F626047B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 13:42:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

On Broxton, to make sure the reset controller works properly,
MISCBDCGE bit (bit 6) in CGCTL (0x48) of PCI configuration space
need be cleared before reset and set back to 1 after reset.
Otherwise, it may prevent the CORB/RIRB logic from being reset.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index aeaa9a5..12c5442 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -90,6 +90,8 @@ enum {
 #define NVIDIA_HDA_ENABLE_COHBIT      0x01
 
 /* Defines for Intel SCH HDA snoop control */
+#define INTEL_HDA_CGCTL	 0x48
+#define INTEL_HDA_CGCTL_MISCBDCGE        (0x1 << 6)
 #define INTEL_SCH_HDA_DEVC      0x78
 #define INTEL_SCH_HDA_DEVC_NOSNOOP       (0x1<<11)
 
@@ -536,10 +538,21 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 {
 	struct hdac_bus *bus = azx_bus(chip);
 	struct pci_dev *pci = chip->pci;
+	u32 val;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		snd_hdac_set_codec_wakeup(bus, true);
+	if (IS_BROXTON(pci)) {
+		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
+		val = val & (~(INTEL_HDA_CGCTL_MISCBDCGE));
+		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
+	}
 	azx_init_chip(chip, full_reset);
+	if (IS_BROXTON(pci)) {
+		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
+		val = val | INTEL_HDA_CGCTL_MISCBDCGE;
+		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
+	}
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		snd_hdac_set_codec_wakeup(bus, false);
 
-- 
1.9.1
