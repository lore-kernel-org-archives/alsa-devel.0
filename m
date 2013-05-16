From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/2 V3] ALSA: hda - Add power-welll support for
	haswell HDA
Date: Thu, 16 May 2013 15:52:37 +0800
Message-ID: <1368690757-2856-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C6F2619ED
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 09:54:59 +0200 (CEST)
In-Reply-To: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

For Intel Haswell chip, HDA controller and codec have
power well dependency from GPU side. This patch added support
to request/release power well in audio driver. Power save
feature should be enabled to get runtime power saving.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/Kconfig     |   10 ++++++
 sound/pci/hda/Makefile    |    3 ++
 sound/pci/hda/hda_i915.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_i915.h  |   35 +++++++++++++++++++++
 sound/pci/hda/hda_intel.c |   41 +++++++++++++++++++++++--
 5 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 sound/pci/hda/hda_i915.c
 create mode 100644 sound/pci/hda/hda_i915.h

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 80a7d44..c5a872c 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -152,6 +152,16 @@ config SND_HDA_CODEC_HDMI
 	  snd-hda-codec-hdmi.
 	  This module is automatically loaded at probing.
 
+config SND_HDA_I915
+	bool "Build Display HD-audio controller/codec power well support for i915 cards"
+	depends on DRM_I915
+	help
+	  Say Y here to include full HDMI and DisplayPort HD-audio controller/codec
+	  power-well support for Intel Haswell graphics cards based on the i915 driver.
+
+	  Note that this option must be enabled for Intel Haswell C+ stepping machines, otherwise
+	  the GPU audio controller/codecs will not be initialized or damaged when exit from S3 mode.
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
index 0000000..76c13d5
--- /dev/null
+++ b/sound/pci/hda/hda_i915.c
@@ -0,0 +1,75 @@
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
+static void (*get_power)(void);
+static void (*put_power)(void);
+
+void hda_display_power(bool enable)
+{
+	if (!get_power || !put_power)
+		return;
+
+	snd_printdd("HDA display power %s \n",
+			enable ? "Enable" : "Disable");
+	if (enable)
+		get_power();
+	else
+		put_power();
+}
+
+int hda_i915_init(void)
+{
+	int err = 0;
+
+	get_power = symbol_request(i915_request_power_well);
+	if (!get_power) {
+		snd_printk(KERN_WARNING "hda-i915: get_power symbol get fail\n");
+		return -ENODEV;
+	}
+
+	put_power = symbol_request(i915_release_power_well);
+	if (!put_power) {
+		symbol_put(i915_request_power_well);
+		get_power = NULL;
+		return -ENODEV;
+	}
+
+	snd_printd("HDA driver get symbol successfully from i915 module\n");
+
+	return err;
+}
+
+int hda_i915_exit(void)
+{
+	if (get_power) {
+		symbol_put(i915_request_power_well);
+		get_power = NULL;
+	}
+	if (put_power) {
+		symbol_put(i915_release_power_well);
+		put_power = NULL;
+	}
+
+	return 0;
+}
diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h
new file mode 100644
index 0000000..4b89dfc
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
+	return -ENODEV;
+}
+static inline int hda_i915_exit(void)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 418bfc0..bf27693 100644
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
@@ -3144,6 +3154,10 @@ static int azx_free(struct azx *chip)
 	if (chip->fw)
 		release_firmware(chip->fw);
 #endif
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		hda_display_power(false);
+		hda_i915_exit();
+	}
 	kfree(chip);
 
 	return 0;
@@ -3700,6 +3714,19 @@ static int azx_probe(struct pci_dev *pci,
 		chip->disabled = true;
 	}
 
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+#ifdef CONFIG_SND_HDA_I915
+		err = hda_i915_init();
+		if (err < 0) {
+			snd_printk(KERN_ERR SFX "Error request power-well from i915\n");
+			goto out_free;
+		}
+		hda_display_power(true);
+#else
+		snd_printk(KERN_ERR SFX "Haswell must build in CONFIG_SND_HDA_I915\n");
+#endif
+	}
+
 	probe_now = !chip->disabled;
 	if (probe_now) {
 		err = azx_first_init(chip);
@@ -3799,6 +3826,7 @@ out_free:
 static void azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
+	struct azx *chip = card->private_data;
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
@@ -3806,6 +3834,10 @@ static void azx_remove(struct pci_dev *pci)
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		hda_display_power(false);
+		hda_i915_exit();
+	}
 }
 
 /* PCI IDs */
@@ -3835,11 +3867,14 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL },
 	{ PCI_DEVICE(0x8086, 0x0c0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL },
 	{ PCI_DEVICE(0x8086, 0x0d0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
+	  AZX_DCAPS_I915_POWERWELL },
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.7.9.5
