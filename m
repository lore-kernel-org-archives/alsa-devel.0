From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [alsa-devel][PATCH 2/3] ASoC: TSCS42xx: Remove Playback/Capture in
 names
Date: Mon, 4 Jun 2018 15:46:28 -0500
Message-ID: <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These aren't needed and some userspace apps don't work consistently with
them.

Remove Playback/Capture from control names

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 15505c3c9ed4..c79c075228a6 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -619,19 +619,19 @@ static int bytes_info_ext(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Volumes */
-	SOC_DOUBLE_R_TLV("Headphone Playback Volume", R_HPVOLL, R_HPVOLR,
+	SOC_DOUBLE_R_TLV("Headphone Volume", R_HPVOLL, R_HPVOLR,
 			FB_HPVOLL, 0x7F, 0, hpvol_scale),
-	SOC_DOUBLE_R_TLV("Speaker Playback Volume", R_SPKVOLL, R_SPKVOLR,
+	SOC_DOUBLE_R_TLV("Speaker Volume", R_SPKVOLL, R_SPKVOLR,
 			FB_SPKVOLL, 0x7F, 0, spkvol_scale),
-	SOC_DOUBLE_R_TLV("Master Playback Volume", R_DACVOLL, R_DACVOLR,
+	SOC_DOUBLE_R_TLV("Master Volume", R_DACVOLL, R_DACVOLR,
 			FB_DACVOLL, 0xFF, 0, dacvol_scale),
-	SOC_DOUBLE_R_TLV("PCM Capture Volume", R_ADCVOLL, R_ADCVOLR,
+	SOC_DOUBLE_R_TLV("PCM Volume", R_ADCVOLL, R_ADCVOLR,
 			FB_ADCVOLL, 0xFF, 0, adcvol_scale),
-	SOC_DOUBLE_R_TLV("Master Capture Volume", R_INVOLL, R_INVOLR,
+	SOC_DOUBLE_R_TLV("Input Volume", R_INVOLL, R_INVOLR,
 			FB_INVOLL, 0x3F, 0, invol_scale),
 
 	/* INSEL */
-	SOC_DOUBLE_R_TLV("Mic Boost Capture Volume", R_INSELL, R_INSELR,
+	SOC_DOUBLE_R_TLV("Mic Boost Volume", R_INSELL, R_INSELR,
 			FB_INSELL_MICBSTL, FV_INSELL_MICBSTL_30DB,
 			0, mic_boost_scale),
 
@@ -730,9 +730,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 		R_CLECTL, FB_CLECTL_LIMIT_EN, 1, 0),
 	SOC_SINGLE("Comp Switch",
 		R_CLECTL, FB_CLECTL_COMP_EN, 1, 0),
-	SOC_SINGLE_TLV("CLE Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("CLE Make-Up Gain Volume",
 		R_MUGAIN, FB_MUGAIN_CLEMUG, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("Comp Thresh Volume",
 		R_COMPTH, FB_COMPTH, 0xff, 0, compth_scale),
 	SOC_ENUM("Comp Ratio", compressor_ratio_enum),
 	SND_SOC_BYTES("Comp Atk Time", R_CATKTCL, 2),
@@ -763,9 +763,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC1 Phase Invert Switch",
 		R_DACMBCMUG1, FB_DACMBCMUG1_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Volume",
 		R_DACMBCMUG1, FB_DACMBCMUG1_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Volume",
 		R_DACMBCTHR1, FB_DACMBCTHR1_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC1 Comp Ratio",
 		dac_mbc1_compressor_ratio_enum),
@@ -775,9 +775,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC2 Phase Invert Switch",
 		R_DACMBCMUG2, FB_DACMBCMUG2_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Volume",
 		R_DACMBCMUG2, FB_DACMBCMUG2_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Volume",
 		R_DACMBCTHR2, FB_DACMBCTHR2_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC2 Comp Ratio",
 		dac_mbc2_compressor_ratio_enum),
@@ -787,9 +787,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC3 Phase Invert Switch",
 		R_DACMBCMUG3, FB_DACMBCMUG3_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Volume",
 		R_DACMBCMUG3, FB_DACMBCMUG3_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Volume",
 		R_DACMBCTHR3, FB_DACMBCTHR3_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC3 Comp Ratio",
 		dac_mbc3_compressor_ratio_enum),
-- 
2.17.0
