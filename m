From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: Intel: filter ACPI devices based on
	_STA return value
Date: Thu,  3 Mar 2016 21:36:35 -0600
Message-ID: <1457062599-10032-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E5E265152
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

BIOS vendors typically list multiple audio codecs in the DSDT
table and enable the relevant one by changing the return value
of the _STA method.

With the current code, all devices are reported by
acpi_dev_present(), regardless of the _STA return values. This
causes errors on probe with the wrong machine driver being loaded.

This patch essentially reverts 'commit 6f08cbdaac5a
("ASoC: Intel: Use acpi_dev_present()")' and adds code to
force the evaluation of the _STA method.

A better solution might be to make sure the ACPI subsystem only
reports devices with a _STA value of 0xf but apparently it's
problematic so dealing with this in the audio subsystem directly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/sst-match-acpi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 0b8ee04..7452360 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -16,14 +16,30 @@
 
 #include "sst-acpi.h"
 
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	unsigned long long sta;
+	acpi_status status;
+
+	*(bool *)context = true;
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
+		*(bool *)context = false;
+
+	return AE_OK;
+}
+
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
+	bool found = false;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (acpi_dev_present(mach->id))
+		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
+						  sst_acpi_mach_match,
+						  &found, NULL)) && found)
 			return mach;
-
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
-- 
1.9.1
