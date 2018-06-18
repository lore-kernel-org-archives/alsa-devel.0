From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: Remove Playback/Capture in
	names" to the asoc tree
Date: Mon, 18 Jun 2018 12:59:54 +0100
Message-ID: <E1fUsp8-0008S8-CN@debutante>
References: <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A0BF4267614
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:59:57 +0200 (CEST)
In-Reply-To: <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: Remove Playback/Capture in names

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

>From 19d996cc3ad698379bcd8482dabe78abe3dc8d96 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 4 Jun 2018 15:46:28 -0500
Subject: [PATCH] ASoC: TSCS42xx: Remove Playback/Capture in names

These aren't needed and some userspace apps don't work consistently with
them.

Remove Playback/Capture from control names

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 743194052fc4..5d596e4dab0c 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -625,19 +625,19 @@ static int bytes_info_ext(struct snd_kcontrol *kcontrol,
 
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
 
@@ -736,9 +736,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
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
@@ -769,9 +769,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
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
@@ -781,9 +781,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
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
@@ -793,9 +793,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
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
2.17.1
