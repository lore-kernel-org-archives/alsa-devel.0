From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 3/4] acpi: add _REV quirk for Dell XPS 13 (2015)
Date: Thu, 14 May 2015 15:31:27 +0200
Message-ID: <1431610288-26737-4-git-send-email-linux@dominikbrodowski.net>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

Based on what ACPI exports as is supported version (_REV), the Dell
XPS 13 (2015) configures its audio device to either work in HDA mode
or in I2S mode. As the latter only works on sufficiently new
userspace, add a quirk and an associated config option to force sound
to HDA mode.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/acpi/Kconfig    | 15 +++++++++++++++
 drivers/acpi/bus.c      |  2 ++
 drivers/acpi/internal.h |  1 +
 drivers/acpi/osl.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 16da185..76e4fa7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -430,4 +430,19 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_REV_OVERRIDE_DELL_XPS_13_2015
+	bool "Dell XPS 13 (2015) quirk to force HDA sound"
+	depends on X86 && SND_HDA
+	default y
+	help
+	  Based on what ACPI exports as is supported version, the Dell XPS 13
+	  (2015) configures its audio device to either work in HDA mode or in
+	  I2S mode. As the latter only works on sufficiently new userspace,
+	  this config option allows to force sound to HDA mode. To switch
+	  between I2S and HDA mode, either toggle this option or pass
+	  acpi.rev=2 (for HDA) / acpi.rev=5 (for I2S) on the kernel command
+	  line, and perform a cold reboot _twice_.
+
+	  If in doubt, say Y.
+
 endif	# ACPI
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c412fdb..99c2e56 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -494,6 +494,8 @@ void __init acpi_early_init(void)
 	 */
 	dmi_check_system(dsdt_dmi_table);
 
+	acpi_os_quirks();
+
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ba4a61e..89566d7 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
 
 #define PREFIX "ACPI: "
 
+void acpi_os_quirks(void);
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index caa52f7..6f41f66 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -44,6 +44,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/dmi.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -571,6 +572,47 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015
+static int acpi_set_supported_rev(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE
+		"%s detected - force ACPI _REV to %lu\n",
+		id->ident, (unsigned long) id->driver_data);
+	acpi_supported_rev = (unsigned long) id->driver_data;
+	return 0;
+}
+
+static struct dmi_system_id acpi_rev_quirk_table[] __initdata = {
+	/*
+	 * DELL XPS 13 (2015) switches sound between HDA and I2S
+	 * depending on the ACPI _REV callback. If userspace supports
+	 * I2S sufficiently (or if you do not care about sound), you
+	 * can safely disable this quirk.
+	 */
+	{
+	 .callback = acpi_set_supported_rev,
+	 .ident = "DELL XPS 13 (2015)",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
+		},
+	 .driver_data = (void *) 5
+	},
+	{}
+};
+#else /* !CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015 */
+static struct dmi_system_id acpi_rev_quirk_table[] __initdata = {
+	{}
+};
+#endif /* CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015 */
+
+void __init acpi_os_quirks(void)
+{
+	dmi_check_system(acpi_rev_quirk_table);
+	return;
+}
+
+
 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
-- 
2.1.4

