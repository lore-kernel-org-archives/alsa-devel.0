From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: update Thinkpad 10 quirk"
	to the asoc tree
Date: Tue, 18 Apr 2017 19:00:08 +0100
Message-ID: <E1d0XQ8-0007CN-32@debutante>
References: <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2121F266DD4
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 20:00:22 +0200 (CEST)
In-Reply-To: <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Nicole Faerber <nicole.faerber@dpin.de>, alsa-devel@alsa-project.org, broonie@kernel.org, Viacheslav Ostroukh <v.dev@ostroukh.me>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: update Thinkpad 10 quirk

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

>From beb5989a8c6c6867b4e873cca2a66d31f977368f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 17 Apr 2017 10:04:07 -0500
Subject: [PATCH] ASoC: Intel: Atom: update Thinkpad 10 quirk

There are multiple skews of the same Lenovo audio hardware
based on the Realtek RT5670 codec.

Manufacturer: LENOVO
        Product Name: 20C1CTO1WW
        Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C3001VHH
	Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C10024GE
	Version: ThinkPad Tablet B

Manufacturer: LENOVO
	Product Name: 20359
	Version: Lenovo Miix 2 10

For all these devices, the same quirk is used to force
the machine driver to be based on RT5670 instead of RT5640
as indicated by the BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Tested-by: Nicole Faerber <nicole.faerber@dpin.de>
Tested-by: Viacheslav Ostroukh <v.dev@ostroukh.me>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 18fe46ef6ac7..dd250b8b26f2 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -420,7 +420,21 @@ static const struct dmi_system_id byt_table[] = {
 		.callback = byt_thinkpad10_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
 		},
 	},
 	{ }
-- 
2.11.0
