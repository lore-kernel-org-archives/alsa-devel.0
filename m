From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/6] ASoC: Intel: common: add translation from
	HID to codec-name
Date: Thu,  3 Mar 2016 21:36:36 -0600
Message-ID: <1457062599-10032-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4372652AC
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 04:36:49 +0100 (CET)
In-Reply-To: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

BIOS vendors sometimes declare multiple devices in the DSDT
table that all refer to the same HID. This is not very smart
but not illegal as long as only one device reports present with
the _STA method. The ACPI subsystem tracks each device with an
extension, e.g. 10EC5640:00 and 10EC5640:01

In the ASoC machine driver, the DAI codec name needs to refer to the
ACPI device that reported present, e.g. "i2c-10EC5640:01". The
extension will vary depending on how the BIOS is written and which
ACPI device is activated.

This patch adds a translation function that provides the codec
name from the ACPI HID to avoid any hard-coded values in the
machine driver.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/sst-acpi.h       |  3 +++
 sound/soc/intel/common/sst-match-acpi.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 3ee3b7a..4dcfb7e 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -14,6 +14,9 @@
 
 #include <linux/acpi.h>
 
+/* translation fron HID to I2C name, needed for DAI codec_name */
+const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN]);
+
 /* acpi match */
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
 
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 7452360..7898433 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -16,6 +16,39 @@
 
 #include "sst-acpi.h"
 
+static acpi_status sst_acpi_find_name(acpi_handle handle, u32 level,
+				      void *context, void **ret)
+{
+	struct acpi_device *adev;
+	const char *name = NULL;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+
+	if (adev->status.present && adev->status.functional) {
+		name = acpi_dev_name(adev);
+		*(const char **)ret = name;
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+const char *sst_acpi_find_name_from_hid(const u8 hid[ACPI_ID_LEN])
+{
+	const char *name = NULL;
+	acpi_status status;
+
+	status = acpi_get_devices(hid, sst_acpi_find_name, NULL,
+				  (void **)&name);
+
+	if (ACPI_FAILURE(status) || name[0] == '\0')
+		return NULL;
+
+	return name;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_find_name_from_hid);
+
 static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
 				       void *context, void **ret)
 {
-- 
1.9.1
