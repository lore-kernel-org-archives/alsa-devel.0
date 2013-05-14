From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/2] ALSA: hda - Add power-welll support for
	haswell HDA
Date: Tue, 14 May 2013 19:44:19 +0800
Message-ID: <1368531859-1943-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1368531859-1943-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1368531859-1943-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

For Intel Haswell chip, HDA controller and codec have
power well dependency from GPU side. This patch added support
to request/release power well in audio driver. Power save
feature should be enabled to get runtime power saving.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/Kconfig     |    8 ++++
 sound/pci/hda/Makefile    |    3 ++
 sound/pci/hda/hda_i915.c  |   92 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h  |   35 +++++++++++++++++
 sound/pci/hda/hda_intel.c |   33 ++++++++++++++--
 5 files changed, 168 insertions(+), 3 deletions(-)
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 80a7d44..d9e71e4 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -152,6 +152,14 @@ config SND_HDA_CODEC_HDMI
 	  snd-hda-codec-hdmi.
 	  This module is automatically loaded at probing.
 
+config SND_HDA_I915
+	bool "Build Display HD-audio controller/codec power well support for i915 cards"
+	depends on DRM_I915
+	default y
+	help
+	  Say Y here to include full HDMI and DisplayPort HD-audio controller/codec
+	  support for Intel Haswell graphics cards based on the i915 driver.
+
 config SND_HDA_CODEC_CIRRUS
 	bool "Build Cirrus Logic codec support"
 	default y
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 24a2514..4b0a4bc 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -6,6 +6,9 @@ snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 
+# for haswell power well
+snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
+
 # for trace-points
 CFLAGS_hda_codec.o := -I$(src)
 CFLAGS_hda_intel.o := -I$(src)
diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
new file mode 100644
index 0000000..96ca9e7
--- /dev/null
+++ b/sound/pci/hda/hda_i915.c
@@ -0,0 +1,92 @@
+/*
+ *  hda_i915.c - routines for Haswell HDA controller power well support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software Foundation,
+ *  Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <drm/i915_powerwell.h>
+#include "hda_i915.h"
+
+static const char *module_name = "i915";
+static struct module *i915;
+static void (*get_power)(void);
+static void (*put_power)(void);
+
+void hda_display_power(bool enable)
+{
+	if (!get_power || !put_power)
+		return;
+
+	snd_printk(KERN_DEBUG "HDA display power %s \n",
+			enable ? "Enable" : "Disable");
+	if (enable)
+		get_power();
+	else
+		put_power();
+}
+
+/* in case i915 not loaded, try load i915 first */
+static int load_i915(void)
+{
+	int err;
+	mutex_lock(&module_mutex);
+	i915 = find_module(module_name);
+	mutex_unlock(&module_mutex);
+
+	if (!i915) {
+		err = request_module(module_name);
+		if (err < 0)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+int hda_i915_init(void)
+{
+	get_power = symbol_get(i915_request_power_well);
+	if (!get_power) {
+		snd_printk(KERN_WARNING "hda-i915: get symbol fail, try again!\n");
+
+		if (load_i915() < 0)
+			return -ENODEV;
+
+		get_power = symbol_get(i915_request_power_well);
+
+		if (!get_power)
+			return -ENODEV;
+	}
+
+	put_power = symbol_get(i915_release_power_well);
+	if (!put_power)
+		return -ENODEV;
+
+	snd_printk(KERN_INFO "HDA driver get symbol successfully from i915 module\n");
+
+	return 0;
+}
+
+int hda_i915_exit(void)
+{
+	if (get_power)
+		symbol_put(i915_request_power_well);
+	if (put_power)
+		symbol_put(i915_release_power_well);
+
+	return 0;
+}
diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h
new file mode 100644
index 0000000..cad4971
--- /dev/null
+++ b/sound/pci/hda/hda_i915.h
@@ -0,0 +1,35 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along with
+ *  this program; if not, write to the Free Software Foundation, Inc., 59
+ *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#ifndef __SOUND_HDA_I915_H
+#define __SOUND_HDA_I915_H
+
+#ifdef CONFIG_SND_HDA_I915
+void hda_display_power(bool enable);
+int hda_i915_init(void);
+int hda_i915_exit(void);
+#else
+static inline void hda_display_power(bool enable) {}
+static inline int hda_i915_init(void) 
+{
+	return 0;
+}
+static inline int hda_i915_exit(void) 
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 418bfc0..6854a7e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -62,6 +62,7 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
 #include "hda_codec.h"
+#include "hda_i915.h"
 
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
@@ -594,6 +595,7 @@ enum {
 #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)	/* BDLE in 4k boundary */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
+#define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 power well support */
 
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
@@ -2869,6 +2871,8 @@ static int azx_suspend(struct device *dev)
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	pci_set_power_state(pci, PCI_D3hot);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		hda_display_power(false);
 	return 0;
 }
 
@@ -2881,6 +2885,8 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled)
 		return 0;
 
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		hda_display_power(true);
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
@@ -2913,6 +2919,8 @@ static int azx_runtime_suspend(struct device *dev)
 
 	azx_stop_chip(chip);
 	azx_clear_irq_pending(chip);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		hda_display_power(false);
 	return 0;
 }
 
@@ -2921,6 +2929,8 @@ static int azx_runtime_resume(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		hda_display_power(true);
 	azx_init_pci(chip);
 	azx_init_chip(chip, 1);
 	return 0;
@@ -3700,6 +3710,15 @@ static int azx_probe(struct pci_dev *pci,
 		chip->disabled = true;
 	}
 
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		err = hda_i915_init();
+		if (err < 0) {
+			snd_printk(KERN_ERR "Error request power-well from i915\n");
+			goto out_free;
+		}
+		hda_display_power(true);
+	}
+
 	probe_now = !chip->disabled;
 	if (probe_now) {
 		err = azx_first_init(chip);
@@ -3799,6 +3818,7 @@ out_free:
 static void azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
+	struct azx *chip = card->private_data;
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
@@ -3806,6 +3826,10 @@ static void azx_remove(struct pci_dev *pci)
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		hda_display_power(false);
+		hda_i915_exit();
+	}
 }
 
 /* PCI IDs */
@@ -3835,11 +3859,14 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL},
 	{ PCI_DEVICE(0x8086, 0x0c0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL},
 	{ PCI_DEVICE(0x8086, 0x0d0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL},
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.7.9.5
