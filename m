From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Baytrail: add quirk for Lenovo
	Thinkpad 10" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:45 +0000
Message-ID: <E1cYfo9-00012U-45@debutante>
References: <1485461385-14544-8-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0584F267404
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:53 +0100 (CET)
In-Reply-To: <1485461385-14544-8-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: Baytrail: add quirk for Lenovo Thinkpad 10

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

>From fd0138dc5d17c636477b371d99265c406437c583 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:35 -0600
Subject: [PATCH] ASoC: Intel: Baytrail: add quirk for Lenovo Thinkpad 10

the BIOS reports this codec as RT5640 but it's a rt5670. Use the
quirk mechanism to use the cht_bsw_rt5672 machine driver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 4c0b89ec42e0..8cc30dfbf87d 100644
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
2.11.0
