From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 4/4] ASoC: MAX9860: add sidetone mixer control
Date: Sat, 14 May 2016 23:09:41 +0200
Message-ID: <1463260181-21344-5-git-send-email-peda@axentia.se>
References: <1463260181-21344-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463260181-21344-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Misbah Ullah Khan <Misbahk@danlawinc.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 2b0dd6a18dad..8d257cc20ef7 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -3,9 +3,6 @@
  *
  * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
  *
- * The driver does not support sidetone since the DVST register field is
- * backwards with the mute near the maximum level instead of the minimum.
- *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
  *
@@ -135,6 +132,10 @@ const struct regmap_config max9860_regmap = {
 static const DECLARE_TLV_DB_SCALE(dva_tlv, -9100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(dvg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -1200, 100, 0);
+/* The dvst field has its mute in the wrong end. Sigh. */
+static const DECLARE_TLV_DB_RANGE(dvst_tlv,
+	0, MAX9860_DVST_MIN - 1,            TLV_DB_SCALE_ITEM(-6000, 200, 0),
+	MAX9860_DVST_MIN, MAX9860_DVST_MIN, TLV_DB_SCALE_ITEM(0, 0, 1));
 static const DECLARE_TLV_DB_RANGE(pam_tlv,
 	0, MAX9860_PAM_MAX - 1,             TLV_DB_SCALE_ITEM(-2000, 2000, 1),
 	MAX9860_PAM_MAX, MAX9860_PAM_MAX,   TLV_DB_SCALE_ITEM(3000, 0, 0));
@@ -214,6 +215,11 @@ SOC_ENUM("ADC Filter", avflt_enum),
 SOC_ENUM("DAC Filter", dvflt_enum),
 };
 
+static const struct snd_kcontrol_new max9860_mixer_controls[] = {
+SOC_DAPM_SINGLE_TLV("Sidetone Volume", MAX9860_DACGAIN,
+		    MAX9860_DVST_SHIFT, MAX9860_DVST_MIN, 1, dvst_tlv),
+};
+
 static const struct snd_soc_dapm_widget max9860_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("MICL"),
 SND_SOC_DAPM_INPUT("MICR"),
@@ -224,6 +230,10 @@ SND_SOC_DAPM_ADC("ADCR", NULL, MAX9860_PWRMAN, MAX9860_ADCREN_SHIFT, 0),
 SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),
 
+SND_SOC_DAPM_MIXER("Mixer", SND_SOC_NOPM, 0, 0,
+		   max9860_mixer_controls,
+		   ARRAY_SIZE(max9860_mixer_controls)),
+
 SND_SOC_DAPM_AIF_IN("AIFINL", "Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIFINR", "Playback", 1, SND_SOC_NOPM, 0, 0),
 
@@ -244,8 +254,10 @@ static const struct snd_soc_dapm_route max9860_dapm_routes[] = {
 	{ "AIFOUTL", NULL, "ADCL" },
 	{ "AIFOUTR", NULL, "ADCR" },
 
-	{ "DAC", NULL, "AIFINL" },
-	{ "DAC", NULL, "AIFINR" },
+	{ "Mixer", NULL, "AIFINL" },
+	{ "Mixer", NULL, "AIFINR" },
+	{ "Mixer", "Sidetone Volume", "ADCL" },
+	{ "DAC", NULL, "Mixer" },
 	{ "OUT", NULL, "DAC" },
 
 	{ "Supply", NULL, "AVDD" },
-- 
2.1.4
