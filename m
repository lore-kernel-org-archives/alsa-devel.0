From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: Add support for HP
	ElitePad 1000 G2" to the asoc tree
Date: Tue, 05 Jan 2016 17:49:11 +0000
Message-ID: <E1aGVjL-000354-Oh@debutante>
References: <1450406156-22246-20-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE05E2625ED
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:26 +0100 (CET)
In-Reply-To: <1450406156-22246-20-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: Add support for HP ElitePad 1000 G2

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

>From 55fc205600ff3b529631cfe03b58645e3844bd92 Mon Sep 17 00:00:00 2001
From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Date: Mon, 4 Jan 2016 17:20:30 -0600
Subject: [PATCH] ASoC: Intel: Atom: Add support for HP ElitePad 1000 G2

The BIOS for the HP ElitePad 1000 G2 uses an unexpected HID,
(INTCCFFD), add it to the white list of knowns HIDs.

Signed-off-by: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c             | 1 +
 sound/soc/intel/atom/sst/sst_acpi.c   | 3 ++-
 sound/soc/intel/boards/bytcr_rt5640.c | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 18f2d3bd3c80..11d032cdc658 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2277,6 +2277,7 @@ static const struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
 	{ "10EC5640", 0 },
 	{ "10EC5642", 0 },
+	{ "INTCCFFD", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 510826f497c4..4fce03fc1870 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -325,9 +325,10 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
+	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
+						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
-
 	{},
 };
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5b0cdad901b6..9a1752df45a9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -141,6 +141,14 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (unsigned long *)(BYT_RT5640_DMIC2_MAP |
 						 BYT_RT5640_DMIC_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
+		},
+		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
+	},
 	{}
 };
 
-- 
2.7.0.rc3
