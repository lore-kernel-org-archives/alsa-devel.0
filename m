From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 14 May 2015 15:31:26 +0200
Message-ID: <1431610288-26737-3-git-send-email-linux@dominikbrodowski.net>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

By using a module parameter named acpi.supported_rev=<value>, the BIOS
may be told a different supported ACPI revision compared to the default
(which currently is 5, but will be modified to 2 when the revert of
b1ef29725865 is reverted).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 Documentation/kernel-parameters.txt | 14 ++++++++++++++
 drivers/acpi/osl.c                  | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 61ab162..75f1f8e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -335,6 +335,20 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
+	acpi.rev= [HW,ACPI]
+			Tell ACPI BIOS the supported ACPI REV
+			Format: <int> in range 0..5
+			Up to and including Linux v4.1, the BIOS was told which
+			ACPI revision the ACPICA subsystem in Linux actually
+			supports (which was 5 at the time); from v4.2 on, this
+			value will be set statically to 2 to match the behavior
+			of other ACPI implementations. As some BIOS may operate
+			differently depending on which value _REV is set to, this
+			parameter offers the capability to specify what to export
+			to the BIOS. Note that such changes in the behavior of
+			the BIOS may only be visible after cold booting the
+			system with this parameter _twice_.
+
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db14a66..caa52f7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -538,6 +538,11 @@ acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
 
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
+/* acpi_supported_rev is 0 in case of no override; overrides are limited to
+ *  values between 1 to 5. To simplify casting, use an unsigned long */
+static unsigned long acpi_supported_rev;
+module_param_named(rev, acpi_supported_rev, ulong, 0);
+
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 			    char **new_val)
@@ -552,6 +557,17 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 		*new_val = acpi_os_name;
 	}
 
+	if (!memcmp(init_val->name, "_REV", 4) && (acpi_supported_rev > 0)) {
+		if (acpi_supported_rev <= 5) {
+			printk(KERN_INFO PREFIX
+				"Overriding _REV definition to %lu\n",
+				acpi_supported_rev);
+			*new_val = (char *) acpi_supported_rev;
+		} else
+			printk(KERN_INFO PREFIX
+				"_REV override must be between 1 to 5");
+	}
+
 	return AE_OK;
 }
 
-- 
2.1.4

