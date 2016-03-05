From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add translation from HID
	to codec-name" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:03 +0900
Message-ID: <E1acBGZ-0003Jy-Og@finisterre>
References: <1457062599-10032-5-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61395265821
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:07 +0100 (CET)
In-Reply-To: <1457062599-10032-5-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add translation from HID to codec-name

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

>From 1fdb7c14a24689e9c7ec51aa16a3970a7ec0fdde Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 3 Mar 2016 21:36:36 -0600
Subject: [PATCH] ASoC: Intel: common: add translation from HID to codec-name

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-acpi.h       |  3 +++
 sound/soc/intel/common/sst-match-acpi.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 3ee3b7ab5d03..4dcfb7e5ed70 100644
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
index cf2c27cd8651..2c0e7fca97db 100644
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
2.7.0
