From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Mon, 23 Nov 2015 15:34:55 +0100
Message-ID: <d66501819cfa8f3d3b07708d3f20e3e20d07e4f8.1448282995.git.lukas@wunner.de>
References: <cover.1448282995.git.lukas@wunner.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448282995.git.lukas@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org
Cc: platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

There are 7 drivers which call acpi_get_devices to check for the
presence of a particular ACPI HID, each defining its own copy of
a mostly identical callback.

Add acpi_dev_present, the ACPI equivalent to pci_dev_present,
allowing us to deduplicate all that boilerplate in the drivers.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/acpica/nsxfeval.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |  7 +++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 6ee1e52..19293fa 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -828,6 +828,52 @@ ACPI_EXPORT_SYMBOL(acpi_get_devices)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ns_dev_present_callback
+ *
+ * PARAMETERS:  Callback from acpi_get_devices
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Minimal callback to be passed to acpi_get_devices which
+ *              performs no further filtering and terminates the search
+ *              immediately.
+ *
+ ******************************************************************************/
+static acpi_status acpi_ns_dev_present_callback(acpi_handle handle, u32 level,
+						void *context, void **retval)
+{
+	*(bool *)context = true;
+	return AE_CTRL_TERMINATE;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_dev_present
+ *
+ * PARAMETERS:  HID                 - HID to search for.
+ *
+ * RETURNS      True if a matching object of type Device was found.
+ *
+ * DESCRIPTION: Performs a walk of the namespace tree. When a matching object
+ *              of type Device is found, the search is terminated immediately.
+ *
+ ******************************************************************************/
+
+bool
+acpi_dev_present(const char *HID)
+{
+	acpi_status status;
+	bool found = false;
+
+	status = acpi_get_devices(HID, acpi_ns_dev_present_callback, &found,
+				  NULL);
+	return ACPI_SUCCESS(status) && found;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_dev_present)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_attach_data
  *
  * PARAMETERS:  obj_handle          - Namespace node
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3aaaa86..f299347 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -115,6 +115,11 @@
 	prototype;
 #endif
 
+#ifndef ACPI_EXTERNAL_RETURN_BOOL
+#define ACPI_EXTERNAL_RETURN_BOOL(prototype) \
+	prototype;
+#endif
+
 /*****************************************************************************
  *
  * Public globals and runtime configuration options
@@ -483,6 +488,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					      acpi_walk_callback user_function,
 					      void *context,
 					      void **return_value))
+ACPI_EXTERNAL_RETURN_BOOL(bool
+			     acpi_dev_present(const char *HID))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_name(acpi_handle object, u32 name_type,
 					   struct acpi_buffer *ret_path_ptr))
-- 
1.8.5.2 (Apple Git-48)
