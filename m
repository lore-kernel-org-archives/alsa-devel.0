From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Use
	dmi_first_match() for DMI quirk handling" to the asoc tree
Date: Thu, 17 May 2018 17:38:57 +0100 (BST)
Message-ID: <20180517163857.B2A3644007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-18-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B85726765C
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:39:01 +0200 (CEST)
In-Reply-To: <20180508153604.23711-18-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Use dmi_first_match() for DMI quirk handling

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

>From 6d1bfcc5e7d196416c2ac2d5aead05c0d7acffb0 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:33 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Use dmi_first_match() for DMI
 quirk handling

Use dmi_first_match() instead of dmi_check_system() + callbacks, this
avoid the need to initialize dmi_system_id.callback for each
byt_rt5640_quirk_table entry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 965721663749..0f80deaf7fce 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -395,16 +395,9 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 	return byt_rt5640_prepare_and_enable_pll1(dai, params_rate(params));
 }
 
-static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
-{
-	byt_rt5640_quirk = (unsigned long)id->driver_data;
-	return 1;
-}
-
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
@@ -415,7 +408,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
@@ -427,7 +419,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
@@ -439,7 +430,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
@@ -447,7 +437,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
@@ -460,7 +449,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
@@ -469,7 +457,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
 			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
@@ -479,7 +466,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1),
 	},
 	{	/* Catch-all for generic Insyde tablets, must be last */
-		.callback = byt_rt5640_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 		},
@@ -894,6 +880,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
@@ -996,7 +983,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	/* check quirks before creating card */
-	dmi_check_system(byt_rt5640_quirk_table);
+	dmi_id = dmi_first_match(byt_rt5640_quirk_table);
+	if (dmi_id)
+		byt_rt5640_quirk = (unsigned long)dmi_id->driver_data;
 	if (quirk_override) {
 		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
-- 
2.17.0
