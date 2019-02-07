From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Add sun7i_codec_controls,
	sun7i_codec_codec" to the asoc tree
Date: Thu,  7 Feb 2019 12:15:58 +0000 (GMT)
Message-ID: <20190207121558.9E0071127EF9@debutante.sirena.org.uk>
References: <20190130103945.26692-4-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B2CE126797D
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 13:16:00 +0100 (CET)
In-Reply-To: <20190130103945.26692-4-dannym@scratchpost.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec

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

>From b71a7eb56c958ffb8c90cef74f3dff6f87e6b554 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:39 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add sun7i_codec_controls,
 sun7i_codec_codec

Introduce sun7i_codec_controls because some of the controls are different
on Allwinner A20 compared to Allwinner A10.

Also introduce sun7i_codec_codec in order to use sun7i_codec_controls and
make sun7i_codec_quirks use sun7i_codec_codec.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 060a40b45ab0..52453c46b409 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -686,6 +686,15 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 		       sun4i_codec_micin_loopback_gain_scale),
 };
 
+static const struct snd_kcontrol_new sun7i_codec_controls[] = {
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
+		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
+		       sun4i_codec_micin_loopback_gain_scale),
+};
+
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
@@ -820,6 +829,19 @@ static const struct snd_soc_component_driver sun4i_codec_codec = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver sun7i_codec_codec = {
+	.controls		= sun7i_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun7i_codec_controls),
+	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun4i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 /*** sun6i Codec ***/
 
 /* mixer controls */
@@ -1500,7 +1522,7 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.regmap_config	= &sun7i_codec_regmap_config,
-	.codec		= &sun4i_codec_codec,
+	.codec		= &sun7i_codec_codec,
 	.create_card	= sun4i_codec_create_card,
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
-- 
2.20.1
