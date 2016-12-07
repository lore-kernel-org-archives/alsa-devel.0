From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v5 1/2] arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
Date: Wed,  7 Dec 2016 17:43:25 +0200
Message-ID: <1481125406-29097-2-git-send-email-irina.tirdea@intel.com>
References: <1481125406-29097-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481125406-29097-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Irina Tirdea <irina.tirdea@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The pmc_atom driver does not contain any architecture specific
code. It only enables the SOC Power Management Controller Driver
for BayTrail and CherryTrail platforms.

Move the pmc_atom driver from arch/x86/platform/atom to
drivers/platform/x86.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 arch/x86/Kconfig                                                     | 4 ----
 arch/x86/platform/atom/Makefile                                      | 1 -
 drivers/acpi/acpi_lpss.c                                             | 2 +-
 drivers/platform/x86/Kconfig                                         | 5 +++++
 drivers/platform/x86/Makefile                                        | 1 +
 {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c          | 3 +--
 {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h | 0
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c (99%)
 rename {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h (100%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bada636..5a009f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2753,10 +2753,6 @@ config X86_DMA_REMAP
 	bool
 	depends on STA2X11
 
-config PMC_ATOM
-	def_bool y
-        depends on PCI
-
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/x86/platform/atom/Makefile b/arch/x86/platform/atom/Makefile
index 40983f5..57be88f 100644
--- a/arch/x86/platform/atom/Makefile
+++ b/arch/x86/platform/atom/Makefile
@@ -1,2 +1 @@
-obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_PUNIT_ATOM_DEBUG)	+= punit_atom_debug.o
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 373657f..3e4c566 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/clk-lpss.h>
+#include <linux/platform_data/x86/pmc_atom.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
@@ -31,7 +32,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
-#include <asm/pmc_atom.h>
 
 #define LPSS_ADDR(desc) ((unsigned long)&desc)
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b8a21d7..7b74c53 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1027,4 +1027,9 @@ config INTEL_TELEMETRY
 	  used to get various SoC events and parameters
 	  directly via debugfs files. Various tools may use
 	  this interface for SoC state monitoring.
+
+config PMC_ATOM
+	def_bool y
+        depends on PCI
+
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2efa86d..8568d74 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
 				   intel_telemetry_pltdrv.o \
 				   intel_telemetry_debugfs.o
 obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
+obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
diff --git a/arch/x86/platform/atom/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
similarity index 99%
rename from arch/x86/platform/atom/pmc_atom.c
rename to drivers/platform/x86/pmc_atom.c
index 964ff4f..b53fbc1 100644
--- a/arch/x86/platform/atom/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -21,8 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
-
-#include <asm/pmc_atom.h>
+#include <linux/platform_data/x86/pmc_atom.h>
 
 struct pmc_bit_map {
 	const char *name;
diff --git a/arch/x86/include/asm/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
similarity index 100%
rename from arch/x86/include/asm/pmc_atom.h
rename to include/linux/platform_data/x86/pmc_atom.h
-- 
1.9.1

