From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II" to the asoc tree
Date: Mon,  8 Apr 2019 14:24:31 +0700 (+07)
Message-ID: <20190408072431.38023441D3B@finisterre.ee.mobilebroadband>
References: <20190329215045.6254-3-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329215045.6254-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II

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

>From a8d218f4fe8116395e4c4a13b63029ecf00d4035 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 29 Mar 2019 22:50:45 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II

The Teclast X98+ II is a Cherrytrail tablet, which require two quirks:
- it has stereo speakers,
- its jack detection mechanism is inverted.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index ccf552e92d53..38975827e276 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -441,11 +442,25 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 	{ },
 };
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
+	{	/* Teclast X98 Plus II */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
+		},
+		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN1_MAP
+					| BYT_CHT_ES8316_JD_INVERTED),
+	},
+	{}
+};
+
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	static const char * const mic_name[] = { "in1", "in2" };
 	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
@@ -488,7 +503,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Check for BYTCR or other platform and setup quirks */
-	if (x86_match_cpu(baytrail_cpu_ids) &&
+	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
+	if (dmi_id) {
+		quirk = (int)dmi_id->driver_data;
+	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
 		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP |
-- 
2.20.1
