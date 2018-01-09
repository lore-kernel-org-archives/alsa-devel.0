From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: Fix control names" to the asoc tree
Date: Tue, 09 Jan 2018 17:43:45 +0000
Message-ID: <E1eYxw9-0006cJ-Dv@debutante>
References: <20180108164745.zzjb4jzqpafyprda@localhost.localdomain>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108164745.zzjb4jzqpafyprda@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgalsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: Fix control names

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

>From 599522ea10c55c9f6823e3041ce4ddc666965468 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 8 Jan 2018 09:47:54 -0700
Subject: [PATCH] ASoC: TSCS42xx: Fix control names

The tscs42xx CODEC driver can confuse userspace with non-standard
control names.

Remove "Switch" from enum control type names.
Add "Switch" to on/off control type names.

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index eedd600875e5..4a5b32a717f2 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -631,7 +631,7 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 			0, mic_boost_scale),
 
 	/* Input Channel Map */
-	SOC_ENUM("Input Channel Map Switch", ch_map_select_enum),
+	SOC_ENUM("Input Channel Map", ch_map_select_enum),
 
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
@@ -708,13 +708,13 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* EQ */
 	SOC_SINGLE("EQ1 Switch", R_CONFIG1, FB_CONFIG1_EQ1_EN, 1, 0),
 	SOC_SINGLE("EQ2 Switch", R_CONFIG1, FB_CONFIG1_EQ2_EN, 1, 0),
-	SOC_ENUM("EQ1 Band Enable Switch", eq1_band_enable_enum),
-	SOC_ENUM("EQ2 Band Enable Switch", eq2_band_enable_enum),
+	SOC_ENUM("EQ1 Band Enable", eq1_band_enable_enum),
+	SOC_ENUM("EQ2 Band Enable", eq2_band_enable_enum),
 
 	/* CLE */
-	SOC_ENUM("CLE Level Detect Switch",
+	SOC_ENUM("CLE Level Detect",
 		cle_level_detection_enum),
-	SOC_ENUM("CLE Level Detect Win Switch",
+	SOC_ENUM("CLE Level Detect Win",
 		cle_level_detection_window_enum),
 	SOC_SINGLE("Expander Switch",
 		R_CLECTL, FB_CLECTL_EXP_EN, 1, 0),
@@ -726,7 +726,7 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 		R_MUGAIN, FB_MUGAIN_CLEMUG, 0x1f, 0, mugain_scale),
 	SOC_SINGLE_TLV("Comp Thresh Playback Volume",
 		R_COMPTH, FB_COMPTH, 0xff, 0, compth_scale),
-	SOC_ENUM("Comp Ratio Switch", compressor_ratio_enum),
+	SOC_ENUM("Comp Ratio", compressor_ratio_enum),
 	SND_SOC_BYTES("Comp Atk Time", R_CATKTCL, 2),
 
 	/* Effects */
@@ -740,50 +740,50 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	SOC_SINGLE("MBC Band1 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN1, 1, 0),
 	SOC_SINGLE("MBC Band2 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN2, 1, 0),
 	SOC_SINGLE("MBC Band3 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN3, 1, 0),
-	SOC_ENUM("MBC Band1 Level Detect Switch",
+	SOC_ENUM("MBC Band1 Level Detect",
 		mbc_level_detection_enums[0]),
-	SOC_ENUM("MBC Band2 Level Detect Switch",
+	SOC_ENUM("MBC Band2 Level Detect",
 		mbc_level_detection_enums[1]),
-	SOC_ENUM("MBC Band3 Level Detect Switch",
+	SOC_ENUM("MBC Band3 Level Detect",
 		mbc_level_detection_enums[2]),
-	SOC_ENUM("MBC Band1 Level Detect Win Switch",
+	SOC_ENUM("MBC Band1 Level Detect Win",
 		mbc_level_detection_window_enums[0]),
-	SOC_ENUM("MBC Band2 Level Detect Win Switch",
+	SOC_ENUM("MBC Band2 Level Detect Win",
 		mbc_level_detection_window_enums[1]),
-	SOC_ENUM("MBC Band3 Level Detect Win Switch",
+	SOC_ENUM("MBC Band3 Level Detect Win",
 		mbc_level_detection_window_enums[2]),
 
-	SOC_SINGLE("MBC1 Phase Invert", R_DACMBCMUG1, FB_DACMBCMUG1_PHASE,
-		1, 0),
+	SOC_SINGLE("MBC1 Phase Invert Switch",
+		R_DACMBCMUG1, FB_DACMBCMUG1_PHASE, 1, 0),
 	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Playback Volume",
 		R_DACMBCMUG1, FB_DACMBCMUG1_MUGAIN, 0x1f, 0, mugain_scale),
 	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Playback Volume",
 		R_DACMBCTHR1, FB_DACMBCTHR1_THRESH, 0xff, 0, compth_scale),
-	SOC_ENUM("DAC MBC1 Comp Ratio Switch",
+	SOC_ENUM("DAC MBC1 Comp Ratio",
 		dac_mbc1_compressor_ratio_enum),
 	SND_SOC_BYTES("DAC MBC1 Comp Atk Time", R_DACMBCATK1L, 2),
 	SND_SOC_BYTES("DAC MBC1 Comp Rel Time Const",
 		R_DACMBCREL1L, 2),
 
-	SOC_SINGLE("MBC2 Phase Invert", R_DACMBCMUG2, FB_DACMBCMUG2_PHASE,
-		1, 0),
+	SOC_SINGLE("MBC2 Phase Invert Switch",
+		R_DACMBCMUG2, FB_DACMBCMUG2_PHASE, 1, 0),
 	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Playback Volume",
 		R_DACMBCMUG2, FB_DACMBCMUG2_MUGAIN, 0x1f, 0, mugain_scale),
 	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Playback Volume",
 		R_DACMBCTHR2, FB_DACMBCTHR2_THRESH, 0xff, 0, compth_scale),
-	SOC_ENUM("DAC MBC2 Comp Ratio Switch",
+	SOC_ENUM("DAC MBC2 Comp Ratio",
 		dac_mbc2_compressor_ratio_enum),
 	SND_SOC_BYTES("DAC MBC2 Comp Atk Time", R_DACMBCATK2L, 2),
 	SND_SOC_BYTES("DAC MBC2 Comp Rel Time Const",
 		R_DACMBCREL2L, 2),
 
-	SOC_SINGLE("MBC3 Phase Invert", R_DACMBCMUG3, FB_DACMBCMUG3_PHASE,
-		1, 0),
+	SOC_SINGLE("MBC3 Phase Invert Switch",
+		R_DACMBCMUG3, FB_DACMBCMUG3_PHASE, 1, 0),
 	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Playback Volume",
 		R_DACMBCMUG3, FB_DACMBCMUG3_MUGAIN, 0x1f, 0, mugain_scale),
 	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Playback Volume",
 		R_DACMBCTHR3, FB_DACMBCTHR3_THRESH, 0xff, 0, compth_scale),
-	SOC_ENUM("DAC MBC3 Comp Ratio Switch",
+	SOC_ENUM("DAC MBC3 Comp Ratio",
 		dac_mbc3_compressor_ratio_enum),
 	SND_SOC_BYTES("DAC MBC3 Comp Atk Time", R_DACMBCATK3L, 2),
 	SND_SOC_BYTES("DAC MBC3 Comp Rel Time Const",
-- 
2.15.1
