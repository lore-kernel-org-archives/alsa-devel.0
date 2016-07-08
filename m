From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Atom: Add quirk for Surface 3
Date: Fri,  8 Jul 2016 15:39:49 +0530
Message-ID: <1467972591-29175-2-git-send-email-vinod.koul@intel.com>
References: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9C5265930
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 12:03:08 +0200 (CEST)
In-Reply-To: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
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
Cc: Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, Vinod Koul <vinod.koul@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

Surface 3 is CHT based device which shows up with RT5645 codec. But the
BIOS reports ACPI ID as 5640!

To solve this, add a DMI overide for cht-5640 machine.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 44 ++++++++++++++++++++++++++++++++++++-
 sound/soc/intel/common/sst-acpi.h   |  2 +-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3bc4b63b2f9d..82a374d885a7 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -28,6 +28,7 @@
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
+#include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <asm/platform_sst_audio.h>
 #include <sound/core.h>
@@ -237,6 +238,9 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		dev_err(dev, "No matching machine driver found\n");
 		return -ENODEV;
 	}
+	if (mach->machine_quirk)
+		mach = mach->machine_quirk(mach);
+
 	pdata = mach->pdata;
 
 	ret = kstrtouint(id->id, 16, &dev_id);
@@ -320,6 +324,44 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static unsigned long cht_machine_id;
+
+#define CHT_SURFACE_MACH 1
+
+static int cht_surface_quirk_cb(const struct dmi_system_id *id)
+{
+	cht_machine_id = CHT_SURFACE_MACH;
+	return 1;
+}
+
+
+static const struct dmi_system_id cht_table[] = {
+	{
+		.callback = cht_surface_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+	},
+};
+
+
+static struct sst_acpi_mach cht_surface_mach = {
+	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+								&chv_platform_data };
+
+struct sst_acpi_mach *cht_quirk(void *arg)
+{
+	struct sst_acpi_mach *mach = arg;
+
+	dmi_check_system(cht_table);
+
+	if (cht_machine_id == CHT_SURFACE_MACH)
+		return &cht_surface_mach;
+	else
+		return mach;
+}
+
 static struct sst_acpi_mach sst_acpi_bytcr[] = {
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
@@ -343,7 +385,7 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
-	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
+	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
 
 	{},
diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 8398cb227ba9..504b0e4fedd4 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -40,6 +40,6 @@ struct sst_acpi_mach {
 
 	/* board name */
 	const char *board;
-	void (*machine_quirk)(void);
+	struct sst_acpi_mach * (*machine_quirk)(void *arg);
 	void *pdata;
 };
-- 
1.9.1
