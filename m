From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 4/4] acpi: fix kernel-parameters ordering in Documentation
Date: Thu, 14 May 2015 15:31:28 +0200
Message-ID: <1431610288-26737-5-git-send-email-linux@dominikbrodowski.net>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 Documentation/kernel-parameters.txt | 62 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 75f1f8e..d6db165 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -179,11 +179,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 			See also Documentation/power/runtime_pm.txt, pci=noacpi
 
-	acpi_rsdp=	[ACPI,EFI,KEXEC]
-			Pass the RSDP address to the kernel, mostly used
-			on machines running EFI runtime service to boot the
-			second kernel for kdump.
-
 	acpi_apic_instance=	[ACPI, IOAPIC]
 			Format: <int>
 			2: use 2nd APIC table, if available
@@ -197,6 +192,14 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			(e.g. thinkpad_acpi, sony_acpi, etc.) instead
 			of the ACPI video.ko driver.
 
+	acpica_no_return_repair [HW, ACPI]
+			Disable AML predefined validation mechanism
+			This mechanism can repair the evaluation result to make
+			the return objects more ACPI specification compliant.
+			This option is useful for developers to identify the
+			root cause of an AML interpreter issue when the issue
+			has something to do with the repair mechanism.
+
 	acpi.debug_layer=	[HW,ACPI,ACPI_DEBUG]
 	acpi.debug_level=	[HW,ACPI,ACPI_DEBUG]
 			Format: <int>
@@ -225,6 +228,22 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
 
+	acpi_enforce_resources=	[ACPI]
+			{ strict | lax | no }
+			Check for resource conflicts between native drivers
+			and ACPI OperationRegions (SystemIO and SystemMemory
+			only). IO ports and memory declared in ACPI might be
+			used by the ACPI subsystem in arbitrary AML code and
+			can interfere with legacy drivers.
+			strict (default): access to resources claimed by ACPI
+			is denied; legacy drivers trying to access reserved
+			resources will fail to bind to device using them.
+			lax: access to resources claimed by ACPI is allowed;
+			legacy drivers trying to access reserved resources
+			will bind successfully but a warning message is logged.
+			no: ACPI OperationRegions are not marked as reserved,
+			no further checks are performed.
+
 	acpi_force_table_verification	[HW,ACPI]
 			Enable table checksum verification during early stage.
 			By default, this is disabled due to x86 early mapping
@@ -253,6 +272,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			This feature is enabled by default.
 			This option allows to turn off the feature.
 
+	acpi_no_memhotplug [ACPI] Disable memory hotplug.  Useful for kdump
+			   kernels.
+
 	acpi_no_static_ssdt	[HW,ACPI]
 			Disable installation of static SSDTs at early boot time
 			By default, SSDTs contained in the RSDT/XSDT will be
@@ -263,13 +285,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			dynamic table installation which will install SSDT
 			tables to /sys/firmware/acpi/tables/dynamic.
 
-	acpica_no_return_repair [HW, ACPI]
-			Disable AML predefined validation mechanism
-			This mechanism can repair the evaluation result to make
-			the return objects more ACPI specification compliant.
-			This option is useful for developers to identify the
-			root cause of an AML interpreter issue when the issue
-			has something to do with the repair mechanism.
+	acpi_rsdp=	[ACPI,EFI,KEXEC]
+			Pass the RSDP address to the kernel, mostly used
+			on machines running EFI runtime service to boot the
+			second kernel for kdump.
 
 	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
 			Format: To spoof as Windows 98: ="Microsoft Windows"
@@ -379,25 +398,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have HPET
 
-	acpi_enforce_resources=	[ACPI]
-			{ strict | lax | no }
-			Check for resource conflicts between native drivers
-			and ACPI OperationRegions (SystemIO and SystemMemory
-			only). IO ports and memory declared in ACPI might be
-			used by the ACPI subsystem in arbitrary AML code and
-			can interfere with legacy drivers.
-			strict (default): access to resources claimed by ACPI
-			is denied; legacy drivers trying to access reserved
-			resources will fail to bind to device using them.
-			lax: access to resources claimed by ACPI is allowed;
-			legacy drivers trying to access reserved resources
-			will bind successfully but a warning message is logged.
-			no: ACPI OperationRegions are not marked as reserved,
-			no further checks are performed.
-
-	acpi_no_memhotplug [ACPI] Disable memory hotplug.  Useful for kdump
-			   kernels.
-
 	add_efi_memmap	[EFI; X86] Include EFI memory map in
 			kernel's map of available physical RAM.
 
-- 
2.1.4

