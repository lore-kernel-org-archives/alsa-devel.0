From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 3/5] arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
Date: Tue, 17 Jan 2017 15:57:48 -0600
Message-ID: <1484690270-28425-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Irina Tirdea <irina.tirdea@intel.com>

The pmc_atom driver does not contain any architecture specific
code. It only enables the SoC Power Management Controller driver
for BayTrail and CherryTrail platforms.

Move the pmc_atom driver from arch/x86/platform/atom to
drivers/platform/x86. Also clean-up and reorder include files by
alphabetical order in pmc_atom.h

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 arch/x86/Kconfig                                                 | 4 ----
 arch/x86/platform/atom/Makefile                                  | 1 -
 drivers/acpi/acpi_lpss.c                                         | 2 +-
 drivers/platform/x86/Kconfig                                     | 4 ++++
 drivers/platform/x86/Makefile                                    | 1 +
 {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c      | 9 ++++-----
 .../include/asm => include/linux/platform_data/x86}/pmc_atom.h   | 0
 7 files changed, 10 insertions(+), 11 deletions(-)
 rename {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c (99%)
 rename {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h (100%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e487493..7b4f178 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2789,10 +2789,6 @@ config X86_DMA_REMAP
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
index 8ea836c..90d112a 100644
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
@@ -31,7 +32,6 @@ ACPI_MODULE_NAME("acpi_lpss");
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
-#include <asm/pmc_atom.h>
 
 #define LPSS_ADDR(desc) ((unsigned long)&desc)
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 59aa8e3..8b1988a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1077,3 +1077,7 @@ config MLX_CPLD_PLATFORM
 	  cables and fans on the wide range Mellanox IB and Ethernet systems.
 
 endif # X86_PLATFORM_DEVICES
+
+config PMC_ATOM
+       def_bool y
+       depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index d4111f0..49ee7ef 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -74,5 +74,6 @@ obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
 				   intel_telemetry_pltdrv.o \
 				   intel_telemetry_debugfs.o
 obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
+obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_MLX_CPLD_PLATFORM)	+= mlxcpld-hotplug.o
diff --git a/arch/x86/platform/atom/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
similarity index 99%
rename from arch/x86/platform/atom/pmc_atom.c
rename to drivers/platform/x86/pmc_atom.c
index 964ff4f..e1dfb1b 100644
--- a/arch/x86/platform/atom/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -15,14 +15,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_data/x86/pmc_atom.h>
 #include <linux/pci.h>
-#include <linux/device.h>
-#include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/io.h>
-
-#include <asm/pmc_atom.h>
 
 struct pmc_bit_map {
 	const char *name;
diff --git a/arch/x86/include/asm/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
similarity index 100%
rename from arch/x86/include/asm/pmc_atom.h
rename to include/linux/platform_data/x86/pmc_atom.h
-- 
2.7.4
