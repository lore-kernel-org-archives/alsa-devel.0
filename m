From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/17] ASoC: Intel: Baytrail: add quirk for
	Lenovo Thinkpad 10
Date: Thu, 26 Jan 2017 14:09:35 -0600
Message-ID: <1485461385-14544-8-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0501C267774
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:24 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

the BIOS reports this codec as RT5640 but it's a rt5670. Use the
quirk mechanism to use the cht_bsw_rt5672 machine driver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0699ce5..4cf95e7 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -400,6 +400,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 static unsigned long cht_machine_id;
 
 #define CHT_SURFACE_MACH 1
+#define BYT_THINKPAD_10  2
 
 static int cht_surface_quirk_cb(const struct dmi_system_id *id)
 {
@@ -407,6 +408,23 @@ static int cht_surface_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
+{
+	cht_machine_id = BYT_THINKPAD_10;
+	return 1;
+}
+
+
+static const struct dmi_system_id byt_table[] = {
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
+		},
+	},
+	{ }
+};
 
 static const struct dmi_system_id cht_table[] = {
 	{
@@ -424,6 +442,10 @@ static struct sst_acpi_mach cht_surface_mach = {
 	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 								&chv_platform_data };
 
+static struct sst_acpi_mach byt_thinkpad_10 = {
+	"10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+	                                                        &byt_rvp_platform_data };
+
 static struct sst_acpi_mach *cht_quirk(void *arg)
 {
 	struct sst_acpi_mach *mach = arg;
@@ -436,8 +458,21 @@ static struct sst_acpi_mach *cht_quirk(void *arg)
 		return mach;
 }
 
+static struct sst_acpi_mach *byt_quirk(void *arg)
+{
+	struct sst_acpi_mach *mach = arg;
+
+	dmi_check_system(byt_table);
+
+	if (cht_machine_id == BYT_THINKPAD_10)
+		return &byt_thinkpad_10;
+	else
+		return mach;
+}
+
+
 static struct sst_acpi_mach sst_acpi_bytcr[] = {
-	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
+	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", byt_quirk,
 						&byt_rvp_platform_data },
 	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
-- 
2.7.4
