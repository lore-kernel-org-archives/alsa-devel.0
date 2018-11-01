From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/7] ASoC: Intel: common: add quirk for APL RVP
	boards
Date: Wed, 31 Oct 2018 20:07:18 -0500
Message-ID: <20181101010718.2878-8-pierre-louis.bossart@linux.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AD362678A5
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 02:07:27 +0100 (CET)
In-Reply-To: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

For some reason the RVP/LeafHill SSDT exposes an INT34C3 ID which is
used on other boards to point to the TDF8532 amplifier. Yay BIOS.

Add a DMI-quirk to ignore this ID and check for other valid machine
driver descriptors.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-bxt-match.c   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 2756fa4ab552..752a1bbff7f7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -6,9 +6,43 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
+static unsigned long apl_machine_id;
+
+#define APL_RVP  1
+
+static int apl_rvp_quirk_cb(const struct dmi_system_id *id)
+{
+	apl_machine_id = APL_RVP;
+	return 1;
+}
+
+static const struct dmi_system_id apl_table[] = {
+	{
+		.callback = apl_rvp_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BOARD_NAME, "Apollolake RVP1A"),
+		},
+	},
+	{},
+};
+
+static struct snd_soc_acpi_mach *apl_quirk(void *arg)
+{
+	struct snd_soc_acpi_mach *mach = arg;
+
+	dmi_check_system(apl_table);
+
+	if (apl_machine_id == APL_RVP)
+		return NULL;
+	else
+		return mach;
+}
+
 static struct snd_soc_acpi_codecs bxt_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
@@ -50,6 +84,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 	{
 		.id = "INT34C3",
 		.drv_name = "bxt_tdf8532",
+		.machine_quirk = apl_quirk,
 		.sof_fw_filename = "intel/sof-apl.ri",
 		.sof_tplg_filename = "intel/sof-apl-tdf8532.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
-- 
2.17.1
