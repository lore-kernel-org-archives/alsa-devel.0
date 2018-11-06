From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add quirk for APL RVP
	boards" to the asoc tree
Date: Tue,  6 Nov 2018 17:54:10 +0000 (GMT)
Message-ID: <20181106175410.04E50112266B@debutante.sirena.org.uk>
References: <20181101213454.18894-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6472B2678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:54:11 +0100 (CET)
In-Reply-To: <20181101213454.18894-8-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add quirk for APL RVP boards

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

>From 935ff8007f5efd24e995d26ebf875ee2c787465e Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 1 Nov 2018 16:34:54 -0500
Subject: [PATCH] ASoC: Intel: common: add quirk for APL RVP boards

For some reason the RVP/LeafHill SSDT exposes an INT34C3 ID which is
used on other boards to point to the TDF8532 amplifier. Yay BIOS.

Add a DMI-quirk to ignore this ID and check for other valid machine
driver descriptors.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-bxt-match.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 2756fa4ab552..61dedc103b19 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -6,9 +6,41 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
+enum {
+	APL_RVP,
+};
+
+static const struct dmi_system_id apl_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BOARD_NAME, "Apollolake RVP1A"),
+		},
+		.driver_data = (void *)(APL_RVP),
+	},
+	{}
+};
+
+static struct snd_soc_acpi_mach *apl_quirk(void *arg)
+{
+	struct snd_soc_acpi_mach *mach = arg;
+	const struct dmi_system_id *dmi_id;
+	unsigned long apl_machine_id;
+
+	dmi_id = dmi_first_match(apl_table);
+	if (dmi_id) {
+		apl_machine_id = (unsigned long)dmi_id->driver_data;
+		if (apl_machine_id == APL_RVP)
+			return NULL;
+	}
+
+	return mach;
+}
+
 static struct snd_soc_acpi_codecs bxt_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
@@ -50,6 +82,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 	{
 		.id = "INT34C3",
 		.drv_name = "bxt_tdf8532",
+		.machine_quirk = apl_quirk,
 		.sof_fw_filename = "intel/sof-apl.ri",
 		.sof_tplg_filename = "intel/sof-apl-tdf8532.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
-- 
2.19.0.rc2
