From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v2 2/6] ASoC: Intel: Create a helper to search
	for matching machine
Date: Thu, 11 May 2017 18:02:20 +0530
Message-ID: <1494505944-31378-3-git-send-email-naveen.m@intel.com>
References: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FEC3266CAF
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 14:32:28 +0200 (CEST)
In-Reply-To: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, naveen.m@intel.com, Harsha Priya <harshapriya.n@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Create a helper function to search for a matching machine
based on HID. No functional change

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/common/sst-acpi.h       |  3 +++
 sound/soc/intel/common/sst-match-acpi.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 214e000..3649d3b 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -43,6 +43,9 @@ static inline bool sst_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
 /* acpi match */
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
 
+/* acpi check hid */
+bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN]);
+
 /* Descriptor for SST ASoC machine driver */
 struct sst_acpi_mach {
 	/* ACPI ID for the matching machine driver. Audio codec for instance */
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index 1070f3a..f4af3d1 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -63,15 +63,26 @@ static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
+bool sst_acpi_check_hid(const u8 hid[ACPI_ID_LEN])
+{
+	acpi_status status;
+	bool found = false;
+
+	status = acpi_get_devices(hid, sst_acpi_mach_match, &found, NULL);
+
+	if (ACPI_FAILURE(status))
+		return false;
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_check_hid);
+
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
-	bool found = false;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (sst_acpi_check_hid(mach->id) == true)
 			return mach;
 	return NULL;
 }
-- 
1.9.1
