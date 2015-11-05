From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: use consistent names for
	PA controls" to the asoc tree
Date: Thu, 05 Nov 2015 14:15:37 +0000
Message-ID: <E1ZuLKD-0007ms-3y@finisterre>
References: <1445979645-1664-1-git-send-email-ats@offog.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4583943380396111544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C651265FC8
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 15:15:53 +0100 (CET)
In-Reply-To: <1445979645-1664-1-git-send-email-ats@offog.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Sampson <ats@offog.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4583943380396111544==
Content-Type: text/plain

The patch

   ASoC: sun4i-codec: use consistent names for PA controls

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

>From 474d147ad1ecc98e50a65c9f350fadfcc37a8bb4 Mon Sep 17 00:00:00 2001
From: Adam Sampson <ats@offog.org>
Date: Tue, 27 Oct 2015 21:00:45 +0000
Subject: [PATCH] ASoC: sun4i-codec: use consistent names for PA controls

The power amplifier for the headphone output is called "the PA" and "the
headphone amplifier" in Allwinner's documentation for the A10 and A20.
sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
isn't really accurate) in others, leading to user-visible controls with
different names referring to the same device.

When this driver implements audio input, it'll also need to expose
controls for the line and mic input preamps, so just referring to "the
Pre-Amplifier" will be ambiguous.

Change it to use "Power Amplifier" consistently for the power
amplifier's controls.

Signed-off-by: Adam Sampson <ats@offog.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da..1bb896d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -2,6 +2,7 @@
  * Copyright 2014 Emilio López <emilio@elopez.com.ar>
  * Copyright 2014 Jon Smirl <jonsmirl@gmail.com>
  * Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
+ * Copyright 2015 Adam Sampson <ats@offog.org>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -404,7 +405,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
 static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
-	SOC_SINGLE_TLV("PA Volume", SUN4I_CODEC_DAC_ACTL,
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
 };
@@ -452,12 +453,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
 			    SUN4I_CODEC_DAC_ACTL_MIXEN, 0, NULL, 0),
 
-	/* Pre-Amplifier */
-	SND_SOC_DAPM_MIXER("Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+	/* Power Amplifier */
+	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
 			   sun4i_codec_pa_mixer_controls,
 			   ARRAY_SIZE(sun4i_codec_pa_mixer_controls)),
-	SND_SOC_DAPM_SWITCH("Pre-Amplifier Mute", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
 	SND_SOC_DAPM_OUTPUT("HP Right"),
@@ -480,16 +481,16 @@ static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
 
-	/* Pre-Amplifier Mixer Routes */
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Left Mixer" },
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Right Mixer" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Left DAC" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Right DAC" },
+	/* Power Amplifier Routes */
+	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
+	{ "Power Amplifier", "Mixer Playback Switch", "Right Mixer" },
+	{ "Power Amplifier", "DAC Playback Switch", "Left DAC" },
+	{ "Power Amplifier", "DAC Playback Switch", "Right DAC" },
 
-	/* PA -> HP path */
-	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
-	{ "HP Right", NULL, "Pre-Amplifier Mute" },
-	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+	/* Headphone Output Routes */
+	{ "Power Amplifier Mute", "Switch", "Power Amplifier" },
+	{ "HP Right", NULL, "Power Amplifier Mute" },
+	{ "HP Left", NULL, "Power Amplifier Mute" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
-- 
2.6.1


--===============4583943380396111544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4583943380396111544==--
