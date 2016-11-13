From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add ACPI package
	extraction utility" to the asoc tree
Date: Sun, 13 Nov 2016 09:26:43 +0000
Message-ID: <E1c5r3j-0006cY-70@finisterre>
References: <1478995666-3866-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FAE9266C73
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 10:26:57 +0100 (CET)
In-Reply-To: <1478995666-3866-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add ACPI package extraction utility

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3421894765a345c6919b22cdda606c2ba1aab2eb Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sat, 12 Nov 2016 18:07:44 -0600
Subject: [PATCH] ASoC: Intel: common: add ACPI package extraction utility

Add a new common routine to extract a package exposed by a
device indexed with the HID value. The functionality is
implemented without assumptions on the package type or
structure to allow for reuse. The caller is responsible for
defining the name and allocating structures to store the
results, ACPICA will complain in case of type mismatches
or buffer size issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h       | 17 +++++++++-
 sound/soc/intel/common/sst-match-acpi.c | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 012742299dd5..214e000667ae 100644
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
index 789843307a49..1070f3ad23e5 100644
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
2.10.2
