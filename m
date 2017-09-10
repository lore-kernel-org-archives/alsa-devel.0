From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Workaround for noise bug in ADC" to the asoc tree
Date: Sun, 10 Sep 2017 05:58:43 +0100
Message-ID: <E1dquKR-0005QK-Qz@debutante>
References: <alpine.DEB.2.11.1709061745140.14549@lnxricardw1.se.axis.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1709061745140.14549@lnxricardw1.se.axis.com>
Sender: stable-owner@vger.kernel.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Ricard Wanderlof <ricardw@axis.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau17x1: Workaround for noise bug in ADC

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

>From 1e6f4fc06f6411adf98bbbe7fcd79442cd2b2a75 Mon Sep 17 00:00:00 2001
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Thu, 7 Sep 2017 15:31:38 +0200
Subject: [PATCH] ASoC: adau17x1: Workaround for noise bug in ADC

The ADC in the ADAU1361 (and possibly other Analog Devices codecs)
exhibits a cyclic variation in the noise floor (in our test setup between
-87 and -93 dB), a new value being attained within this range whenever a
new capture stream is started. The cycle repeats after about 10 or 11
restarts.

The workaround recommended by the manufacturer is to toggle the ADOSR bit
in the Converter Control 0 register each time a new capture stream is
started.

I have verified that the patch fixes this problem on the ADAU1361, and
according to the manufacturer toggling the bit in question in this manner
will at least have no detrimental effect on other chips served by this
driver.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/adau17x1.c | 24 +++++++++++++++++++++++-
 sound/soc/codecs/adau17x1.h |  2 ++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2c1bd2763864..6758f789b712 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -90,6 +90,27 @@ static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int adau17x1_adc_fixup(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+
+	/*
+	 * If we are capturing, toggle the ADOSR bit in Converter Control 0 to
+	 * avoid losing SNR (workaround from ADI). This must be done after
+	 * the ADC(s) have been enabled. According to the data sheet, it is
+	 * normally illegal to set this bit when the sampling rate is 96 kHz,
+	 * but according to ADI it is acceptable for this workaround.
+	 */
+	regmap_update_bits(adau->regmap, ADAU17X1_CONVERTER0,
+		ADAU17X1_CONVERTER0_ADOSR, ADAU17X1_CONVERTER0_ADOSR);
+	regmap_update_bits(adau->regmap, ADAU17X1_CONVERTER0,
+		ADAU17X1_CONVERTER0_ADOSR, 0);
+
+	return 0;
+}
+
 static const char * const adau17x1_mono_stereo_text[] = {
 	"Stereo",
 	"Mono Left Channel (L+R)",
@@ -121,7 +142,8 @@ static const struct snd_soc_dapm_widget adau17x1_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Right DAC Mode Mux", SND_SOC_NOPM, 0, 0,
 		&adau17x1_dac_mode_mux),
 
-	SND_SOC_DAPM_ADC("Left Decimator", NULL, ADAU17X1_ADC_CONTROL, 0, 0),
+	SND_SOC_DAPM_ADC_E("Left Decimator", NULL, ADAU17X1_ADC_CONTROL, 0, 0,
+			   adau17x1_adc_fixup, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_ADC("Right Decimator", NULL, ADAU17X1_ADC_CONTROL, 1, 0),
 	SND_SOC_DAPM_DAC("Left DAC", NULL, ADAU17X1_DAC_CONTROL0, 0, 0),
 	SND_SOC_DAPM_DAC("Right DAC", NULL, ADAU17X1_DAC_CONTROL0, 1, 0),
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index bf04b7efee40..db350035fad7 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -129,5 +129,7 @@ bool adau17x1_has_dsp(struct adau *adau);
 
 #define ADAU17X1_CONVERTER0_CONVSR_MASK		0x7
 
+#define ADAU17X1_CONVERTER0_ADOSR		BIT(3)
+
 
 #endif
-- 
2.14.1
