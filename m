From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: Add quirk for Surface 3"
	to the asoc tree
Date: Fri, 08 Jul 2016 14:32:23 +0200
Message-ID: <E1bLUxD-0006un-8F@finisterre>
References: <1467972591-29175-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21EB4265914
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:32:54 +0200 (CEST)
In-Reply-To: <1467972591-29175-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: Add quirk for Surface 3

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

>From 73a33f6f6d44db203d0324b67ffed1d86d4c1c9a Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 8 Jul 2016 15:39:49 +0530
Subject: [PATCH] ASoC: Intel: Atom: Add quirk for Surface 3

Surface 3 is CHT based device which shows up with RT5645 codec. But the
BIOS reports ACPI ID as 5640!

To solve this, add a DMI overide for cht-5640 machine.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index b02f12900b93..5d2949324d0e 100644
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
2.8.1
