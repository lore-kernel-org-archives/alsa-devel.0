From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: common: add ACPI package
	extraction utility
Date: Sat, 12 Nov 2016 18:07:44 -0600
Message-ID: <1478995666-3866-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1478995666-3866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C08A266703
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 01:07:53 +0100 (CET)
In-Reply-To: <1478995666-3866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add a new common routine to extract a package exposed by a
device indexed with the HID value. The functionality is
implemented without assumptions on the package type or
structure to allow for reuse. The caller is responsible for
defining the name and allocating structures to store the
results, ACPICA will complain in case of type mismatches
or buffer size issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/sst-acpi.h       | 17 +++++++++-
 sound/soc/intel/common/sst-match-acpi.c | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 0127422..214e000 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -15,14 +15,29 @@
 #include <linux/stddef.h>
 #include <linux/acpi.h>
 
-/* translation fron HID to I2C name, needed for DAI codec_name */
+struct sst_acpi_package_context {
+	char *name;           /* package name */
+	int length;           /* number of elements */
+	struct acpi_buffer *format;
+	struct acpi_buffer *state;
+	bool data_valid;
+};
+
 #if IS_ENABLED(CONFIG_ACPI)
+/* translation fron HID to I2C name, needed for DAI codec_name */
 const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
+bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+				    struct sst_acpi_package_context *ctx);
 #else
 static inline const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
 {
 	return NULL;
 }
+static inline bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+					   struct sst_acpi_package_context *ctx)
+{
+	return false;
+}
 #endif
 
 /* acpi match */
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 7898433..1070f3a 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -77,5 +77,62 @@ struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 }
 EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
 
+static acpi_status sst_acpi_find_package(acpi_handle handle, u32 level,
+					void *context, void **ret)
+{
+	struct acpi_device *adev;
+	acpi_status status = AE_OK;
+	struct sst_acpi_package_context *pkg_ctx = context;
+
+	pkg_ctx->data_valid = false;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+
+	if (adev->status.present && adev->status.functional) {
+		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+		union acpi_object  *myobj = NULL;
+
+		status = acpi_evaluate_object_typed(handle, pkg_ctx->name,
+						NULL, &buffer,
+						ACPI_TYPE_PACKAGE);
+		if (ACPI_FAILURE(status))
+			return AE_OK;
+
+		myobj = buffer.pointer;
+		if (!myobj || myobj->package.count != pkg_ctx->length) {
+			kfree(buffer.pointer);
+			return AE_OK;
+		}
+
+		status = acpi_extract_package(myobj,
+					pkg_ctx->format, pkg_ctx->state);
+		if (ACPI_FAILURE(status)) {
+			kfree(buffer.pointer);
+			return AE_OK;
+		}
+
+		kfree(buffer.pointer);
+		pkg_ctx->data_valid = true;
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
+				struct sst_acpi_package_context *ctx)
+{
+	acpi_status status;
+
+	status = acpi_get_devices(hid, sst_acpi_find_package, ctx, NULL);
+
+	if (ACPI_FAILURE(status) || !ctx->data_valid)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_find_package_from_hid);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.7.4
