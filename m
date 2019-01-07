From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: Add quirk for PoV P1006W
	tablet" to the asoc tree
Date: Mon,  7 Jan 2019 19:24:44 +0000 (GMT)
Message-ID: <20190107192444.94F951127491@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE3B26742C
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 20:24:45 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: Add quirk for PoV P1006W tablet

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d3dcc5882ca95c9207b5232395c291d34a511627 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 30 Dec 2018 00:00:19 +0100
Subject: [PATCH] ASoC: Intel: common: Add quirk for PoV P1006W tablet

The Point of View TAB-P1006W-232 (v1.0) tablet uses 10EC5640 as
ACPI HID, but it has a rt5651 codec add a quirk for this.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-byt-match.c   | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 47a90909b956..96f9c553fe6c 100644
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
