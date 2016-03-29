From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: intel: add function stub when ACPI is not enabled
Date: Tue, 29 Mar 2016 09:45:00 -0700
Message-ID: <56FAB10C.502@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Add function stub for "sst_acpi_find_name_from_hid()"
when CONFIG_ACPI is not enabled so that the driver will build
successfully. This fixes the following build errors:

(loadable module)
ERROR: "sst_acpi_find_name_from_hid" [sound/soc/intel/boards/snd-soc-sst-bytcr-rt5640.ko] undefined!
(or built-in)
bytcr_rt5640.c:(.text+0x26fc52): undefined reference to `sst_acpi_find_name_from_hid'

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc:	Jie Yang <yang.jie@linux.intel.com>
Cc:	alsa-devel@alsa-project.org
---
 sound/soc/intel/common/sst-acpi.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-next-20160308.orig/sound/soc/intel/common/sst-acpi.h
+++ linux-next-20160308/sound/soc/intel/common/sst-acpi.h
@@ -12,10 +12,19 @@
  *
  */
 
+#include <linux/kconfig.h>
+#include <linux/stddef.h>
 #include <linux/acpi.h>
 
 /* translation fron HID to I2C name, needed for DAI codec_name */
+#if IS_ENABLED(CONFIG_ACPI)
 const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
+#else
+inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+{
+	return NULL;
+}
+#endif
 
 /* acpi match */
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
