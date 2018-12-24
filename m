From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/7] ASoC: Intel: common: Add quirk for PoV
	P1006W tablet
Date: Mon, 24 Dec 2018 16:00:31 +0100
Message-ID: <20181224150037.20275-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 87A2B267A65
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 16:00:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Point of View TAB-P1006W-232 (v1.0) tablet uses 10EC5640 as
ACPI HID, but it has a rt5651 codec add a quirk for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../intel/common/soc-acpi-intel-byt-match.c   | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 097dc06377ba..027dc27262b7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -21,6 +21,7 @@
 static unsigned long byt_machine_id;
 
 #define BYT_THINKPAD_10  1
+#define BYT_POV_P1006W   2
 
 static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
 {
@@ -28,6 +29,11 @@ static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int byt_pov_p1006w_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_machine_id = BYT_POV_P1006W;
+	return 1;
+}
 
 static const struct dmi_system_id byt_table[] = {
 	{
@@ -58,6 +64,17 @@ static const struct dmi_system_id byt_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
 		},
 	},
+	{
+		/* Point of View mobii wintab p1006w (v1.0) */
+		.callback = byt_pov_p1006w_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Note 105b is Foxcon's USB/PCI vendor id */
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
+		},
+	},
 	{ }
 };
 
@@ -71,16 +88,30 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
+static struct snd_soc_acpi_mach byt_pov_p1006w = {
+	.id = "10EC5640",
+	.drv_name = "bytcr_rt5651",
+	.fw_filename = "intel/fw_sst_0f28.bin",
+	.board = "bytcr_rt5651",
+	.sof_fw_filename = "intel/sof-byt.ri",
+	.sof_tplg_filename = "intel/sof-byt-rt5651.tplg",
+	.asoc_plat_name = "sst-mfld-platform",
+};
+
 static struct snd_soc_acpi_mach *byt_quirk(void *arg)
 {
 	struct snd_soc_acpi_mach *mach = arg;
 
 	dmi_check_system(byt_table);
 
-	if (byt_machine_id == BYT_THINKPAD_10)
+	switch (byt_machine_id) {
+	case BYT_THINKPAD_10:
 		return &byt_thinkpad_10;
-	else
+	case BYT_POV_P1006W:
+		return &byt_pov_p1006w;
+	default:
 		return mach;
+	}
 }
 
 struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[] = {
-- 
2.20.1
