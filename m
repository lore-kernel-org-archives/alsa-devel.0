From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoC: adau17x1: Workaround for noise bug in ADC
Date: Thu, 7 Sep 2017 15:31:38 +0200
Message-ID: <alpine.DEB.2.11.1709061745140.14549@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 23BC92669F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:31:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


The ADC in the ADAU1361 (and possibly other Analog Devices codecs) =

exhibits a cyclic variation in the noise floor (in our test setup between =

-87 and -93 dB), a new value being attained within this range whenever a =

new capture stream is started. The cycle repeats after about 10 or 11 =

restarts.

The workaround recommended by the manufacturer is to toggle the ADOSR bit =

in the Converter Control 0 register each time a new capture stream is =

started.

I have verified that the patch fixes this problem on the ADAU1361, and =

according to the manufacturer toggling the bit in question in this manner =

will at least have no detrimental effect on other chips served by this =

driver.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2c1bd27..6758f78 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -90,6 +90,27 @@ static int adau17x1_pll_event(struct snd_soc_dapm_widget=
 *w,
 	return 0;
 }
 =

+static int adau17x1_adc_fixup(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec =3D snd_soc_dapm_to_codec(w->dapm);
+	struct adau *adau =3D snd_soc_codec_get_drvdata(codec);
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
 static const char * const adau17x1_mono_stereo_text[] =3D {
 	"Stereo",
 	"Mono Left Channel (L+R)",
@@ -121,7 +142,8 @@ static const struct snd_soc_dapm_widget adau17x1_dapm_w=
idgets[] =3D {
 	SND_SOC_DAPM_MUX("Right DAC Mode Mux", SND_SOC_NOPM, 0, 0,
 		&adau17x1_dac_mode_mux),
 =

-	SND_SOC_DAPM_ADC("Left Decimator", NULL, ADAU17X1_ADC_CONTROL, 0, 0),
+	SND_SOC_DAPM_ADC_E("Left Decimator", NULL, ADAU17X1_ADC_CONTROL, 0, 0,
+			   adau17x1_adc_fixup, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_ADC("Right Decimator", NULL, ADAU17X1_ADC_CONTROL, 1, 0),
 	SND_SOC_DAPM_DAC("Left DAC", NULL, ADAU17X1_DAC_CONTROL0, 0, 0),
 	SND_SOC_DAPM_DAC("Right DAC", NULL, ADAU17X1_DAC_CONTROL0, 1, 0),
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index bf04b7ef..db35003 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -129,5 +129,7 @@ bool adau17x1_has_dsp(struct adau *adau);
 =

 #define ADAU17X1_CONVERTER0_CONVSR_MASK		0x7
 =

+#define ADAU17X1_CONVERTER0_ADOSR		BIT(3)
+
 =

 #endif

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
