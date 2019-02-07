From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Add Mic Playback Volume" to the asoc tree
Date: Thu,  7 Feb 2019 12:16:00 +0000 (GMT)
Message-ID: <20190207121600.EA21A1127EF9@debutante.sirena.org.uk>
References: <20190130103945.26692-3-dannym@scratchpost.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130103945.26692-3-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Add Mic Playback Volume

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

>From b5a656030c7435f37deb5d38b1593fba624b8d6d Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:38 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add Mic Playback Volume

Add a control "Mic Playback Volume" that allows the user to control the
MIC gain stage (common for Mic1 and Mic2) leading to the output mixer.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7b965bc50042..060a40b45ab0 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -681,6 +681,9 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
+		       sun4i_codec_micin_loopback_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-- 
2.20.1
