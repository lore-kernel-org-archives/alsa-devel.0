From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: detect audio routing with CHAN
	package" to the asoc tree
Date: Sun, 13 Nov 2016 09:26:37 +0000
Message-ID: <E1c5r3d-0006bl-Nm@finisterre>
References: <1478995666-3866-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0255A266C4A
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 10:26:52 +0100 (CET)
In-Reply-To: <1478995666-3866-3-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: detect audio routing with CHAN package

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

>From 64e84305cb936024a9862c48f61539fdad649a22 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sat, 12 Nov 2016 18:07:45 -0600
Subject: [PATCH] ASoC: Intel: detect audio routing with CHAN package

Baytrail-CR devices usually expose information in the DSDT
which can be used to auto-detect AIF1/AIF2 connections.
The CHAN package contains two integers, the first one describes
the AIF number (1: AIF1, 2: AIF2) and the second the MCLK
value (ignored in this patch)

For example the following information is found in Lenovo 100s:

Device (RTEK) {
[...]
    Name (CHAN, Package (0x02)
    {
        One,
        0x017D7840
    })

While on Asus T100TAF the package values are:

    Name (CHAN, Package (0x02)
    {
        0x02,
        0x017D7840
    })

This patch relies on the new common routine to extract
a package exposed by a device indexed with the HID value.
The CHAN package contents are queried from the machine driver
and stored in a structure.

If this auto-detection fails (missing or bad package in the
BIOS), the routing falls back to SSP0-AIF2.

Note that quirks may still be needed to support mono speakers
or microphone, but this should reduce the number of issues with
Baytrail significantly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index bff77a1f27fc..32aeffc352ee 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -689,6 +689,10 @@ static bool is_valleyview(void)
 	return true;
 }
 
+struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
+	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
+	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
+};
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
@@ -698,6 +702,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	int i;
 	int dai_index;
 	struct byt_rt5640_private *priv;
+	bool is_bytcr = false;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv)
@@ -734,8 +739,52 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		struct sst_platform_info *p_info = mach->pdata;
 		const struct sst_res_info *res_info = p_info->res_info;
 
-		/* TODO: use CHAN package info from BIOS to detect AIF1/AIF2 */
-		if (res_info->acpi_ipc_irq_index == 0) {
+		if (res_info->acpi_ipc_irq_index == 0)
+			is_bytcr = true;
+	}
+
+	if (is_bytcr) {
+		/*
+		 * Baytrail CR platforms may have CHAN package in BIOS, try
+		 * to find relevant routing quirk based as done on Windows
+		 * platforms. We have to read the information directly from the
+		 * BIOS, at this stage the card is not created and the links
+		 * with the codec driver/pdata are non-existent
+		 */
+
+		struct acpi_chan_package chan_package;
+
+		/* format specified: 2 64-bit integers */
+		struct acpi_buffer format = {sizeof("NN"), "NN"};
+		struct acpi_buffer state = {0, NULL};
+		struct sst_acpi_package_context pkg_ctx;
+		bool pkg_found = false;
+
+		state.length = sizeof(chan_package);
+		state.pointer = &chan_package;
+
+		pkg_ctx.name = "CHAN";
+		pkg_ctx.length = 2;
+		pkg_ctx.format = &format;
+		pkg_ctx.state = &state;
+		pkg_ctx.data_valid = false;
+
+		pkg_found = sst_acpi_find_package_from_hid(mach->id, &pkg_ctx);
+		if (pkg_found) {
+			if (chan_package.aif_value == 1) {
+				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
+				byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF1;
+			} else  if (chan_package.aif_value == 2) {
+				dev_info(&pdev->dev, "BIOS Routing: AIF2 connected\n");
+				byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
+			} else {
+				dev_info(&pdev->dev, "BIOS Routing isn't valid, ignored\n");
+				pkg_found = false;
+			}
+		}
+
+		if (!pkg_found) {
+			/* no BIOS indications, assume SSP0-AIF2 connection */
 			byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
 		}
 	}
-- 
2.10.2
