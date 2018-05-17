From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Add quirks for
	various devices" to the asoc tree
Date: Thu, 17 May 2018 17:38:55 +0100 (BST)
Message-ID: <20180517163855.7654C44007E@finisterre.ee.mobilebroadband>
References: <20180511132928.7669-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 87B4026766C
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:38:58 +0200 (CEST)
In-Reply-To: <20180511132928.7669-10-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5640: Add quirks for various devices

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

>From ec8e8418ff7d3c5c295a44dfd7170c3d1e0a441e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:34 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for various devices

Even with our recently tweaked defaults, quite a few bytcr_rt5640 devices
still need quirks to be fully functional. This commits adds quirks where
necessary for the 16 bytcr_rt5640 devices I have access to.

The quirks are added for the following reasons:

1) Devices with only one speaker need the mono quirk to avoid driving an
unused and potentially short-circuited output. 8 of my sample of 16 devs
are mono, 4 of these would work with the defaults if it were not for their
mono speaker.

2) Devices using a different input for the internal mic then the default,
this is the case for 6 of my sample of 16 devices.

3) BYTCR devices without an ACPI channel map, which do not work with the
default of SSP0-AIF2, this is the case for 2 of my sample of 16 devices.

4) Devices which need non-default jack-detect settings, this is the case
for 6 of my sample of 16 devices.

This commit add quirks for the following devices:

Acer Iconia Tab 8 W1-810
Chuwi Vi8
HP Pavilion X2 10-n000nd
HP Stream 7
I.T. Works TW891
Lamina I8270
MSI S100
Pipo W4
PoV-mobii-800w (v2.0)
PoV-mobii-800w (v2.1)
Toshiba Click Mini L9W-B

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 141 ++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0f80deaf7fce..686d00405493 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -397,6 +397,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia Tab 8 W1-810 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Iconia W1-810"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
@@ -429,6 +441,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Chuwi Vi8 (CWI506) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
@@ -456,6 +480,111 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* HP Pavilion x2 10-n000nd */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* HP Stream 7 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 7 Tablet"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* I.T.Works TW891 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "TW891"),
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "TW891"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Lamina I8270 / T701BR.SE */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Lamina"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "T701BR.SE"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* MSI S100 tablet */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "S100"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Pipo W4 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "V8L_WIN32_CHIPHD"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Point of View Mobii TAB-P800W (V2.0) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* The above are too generic, also match BIOS info */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "3BAIR1014"),
+			DMI_EXACT_MATCH(DMI_BIOS_DATE, "10/24/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Point of View Mobii TAB-P800W (V2.1) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* The above are too generic, also match BIOS info */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "3BAIR1013"),
+			DMI_EXACT_MATCH(DMI_BIOS_DATE, "08/22/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
@@ -465,6 +594,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN |
 					BYT_RT5640_SSP0_AIF1),
 	},
+	{	/* Toshiba Satellite Click Mini L9W-B */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Catch-all for generic Insyde tablets, must be last */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-- 
2.17.0
