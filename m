From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/4] acpi: use same type for acpi_predefined_names values as in definition
Date: Thu, 14 May 2015 15:31:25 +0200
Message-ID: <1431610288-26737-2-git-send-email-linux@dominikbrodowski.net>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

In the definition of struct acpi_predefined_names, value is of
type char *. Make the OSL override function also work with type
char * (or, more precisely, with a pointer to it).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/acpi/osl.c      | 2 +-
 include/acpi/acpiosxf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7ccba39..db14a66 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -540,7 +540,7 @@ static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
-			    acpi_string * new_val)
+			    char **new_val)
 {
 	if (!init_val || !new_val)
 		return AE_BAD_PARAMETER;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 0bc78df..d02df0a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -95,7 +95,7 @@ acpi_physical_address acpi_os_get_root_pointer(void);
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
-			    acpi_string * new_val);
+			    char **new_val);
 #endif
 
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
-- 
2.1.4

