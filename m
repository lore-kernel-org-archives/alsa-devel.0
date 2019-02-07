From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM Playback Switch" to the asoc tree
Date: Thu,  7 Feb 2019 12:15:50 +0000 (GMT)
Message-ID: <20190207121550.2CB761127EF9@debutante.sirena.org.uk>
References: <20190130103945.26692-8-dannym@scratchpost.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130103945.26692-8-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM Playback Switch

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

>From 50d164194879ade8dbb1a473232fed0e77d8bfd1 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:43 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right,
 FM Playback Switch

Add FM Playback Volume for Allwinner A10 and Allwinner A20.
Add FM Left, FM Right, FM Playback Switch for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 87bb16e59da7..2ec7a43975f6 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -64,7 +64,10 @@
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
 #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
+#define SUN4I_CODEC_DAC_ACTL_FMG			(23)
 #define SUN4I_CODEC_DAC_ACTL_MICG			(20)
+#define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
+#define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
 #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
 #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
@@ -683,6 +686,8 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale, -450, 150,
+			    0);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
 			    0);
 static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
@@ -696,6 +701,9 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
+		       sun4i_codec_fmin_loopback_gain_scale),
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
@@ -711,6 +719,9 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
+		       sun4i_codec_fmin_loopback_gain_scale),
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
@@ -732,6 +743,9 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
 	SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_MIC1LS,
 			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
@@ -800,6 +814,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("FM Right"),
+	SND_SOC_DAPM_INPUT("FM Left"),
 	SND_SOC_DAPM_INPUT("Mic1"),
 	SND_SOC_DAPM_INPUT("Mic2"),
 
@@ -820,12 +836,14 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
-- 
2.20.1
