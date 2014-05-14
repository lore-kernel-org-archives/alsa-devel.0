From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/6] ASoC: ak4642: Implement Microphone in
	pathes
Date: Wed, 14 May 2014 09:37:37 +0200
Message-ID: <1400053058-1115-6-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4C3552619E5
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:37:58 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/ak4642.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 3ba4c0f..6292a6a 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -153,6 +153,81 @@ struct ak4642_priv {
  */
 static const DECLARE_TLV_DB_SCALE(out_tlv, -11550, 50, 1);
 
+static const char * const ak4642_micl_strings[] = { "LIN1", "LIN2", "LIN3", "LIN4" };
+static const char * const ak4642_micr_strings[] = { "RIN1", "RIN2", "RIN3", "RIN4" };
+
+static const struct soc_enum ak4642_micl_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4642_micl_strings),
+			    ak4642_micl_strings);
+
+static const struct soc_enum ak4642_micr_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4642_micr_strings),
+			    ak4642_micr_strings);
+
+static int ak4642_micl_enum_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	u32 val, inl;
+
+	val = snd_soc_read(codec, PW_MGMT3);
+
+	inl = (val >> 1) & 0x1;
+	inl |= (val >> 5) & 0x2;
+
+	ucontrol->value.integer.value[0] = inl;
+
+	return 0;
+}
+
+static int ak4642_micl_enum_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	int val, inl;
+
+	val = ucontrol->value.integer.value[0];
+
+	inl = (val & 0x1) << 1;
+	inl |= (val & 0x2) << 5;
+
+	snd_soc_update_bits(codec, PW_MGMT3, (1 << 1) | (1 << 6), inl);
+
+	return 1;
+}
+
+static int ak4642_micr_enum_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	u32 val, inr;
+
+	val = snd_soc_read(codec, PW_MGMT3);
+
+	inr = (val >> 2) & 0x1;
+	inr |= (val >> 6) & 0x2;
+
+	ucontrol->value.integer.value[0] = inr;
+
+	return 0;
+}
+
+static int ak4642_micr_enum_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	int val, inr;
+
+	val = ucontrol->value.integer.value[0];
+
+	inr = (val & 0x1) << 2;
+	inr |= (val & 0x2) << 6;
+
+	snd_soc_update_bits(codec, PW_MGMT3, (1 << 2) | (1 << 7), inr);
+
+	return 1;
+}
+
 static const struct snd_kcontrol_new ak4642_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", L_DVC, R_DVC,
@@ -168,6 +243,16 @@ static const struct snd_kcontrol_new ak4642_lout_mixer_controls[] = {
 	SOC_DAPM_SINGLE("DACL", SG_SL1, 4, 1, 0),
 };
 
+static const struct snd_kcontrol_new ak4642_micl_controls[] = {
+	SOC_ENUM_EXT("Mic Left Capture Route", ak4642_micl_enum,
+		     ak4642_micl_enum_get,  ak4642_micl_enum_put),
+};
+
+static const struct snd_kcontrol_new ak4642_micr_controls[] = {
+	SOC_ENUM_EXT("Mic Right Capture Route", ak4642_micr_enum,
+		     ak4642_micr_enum_get,  ak4642_micr_enum_put),
+};
+
 static const struct snd_soc_dapm_widget ak4642_dapm_widgets[] = {
 
 	/* Outputs */
@@ -188,6 +273,22 @@ static const struct snd_soc_dapm_widget ak4642_dapm_widgets[] = {
 
 	/* DAC */
 	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", PW_MGMT1, 2, 0),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_MUX("Mic Left Capture Route",
+			SND_SOC_NOPM, 0, 0, ak4642_micl_controls),
+	SND_SOC_DAPM_MUX("Mic Right Capture Route",
+			SND_SOC_NOPM, 0, 0, ak4642_micr_controls),
+
+	SND_SOC_DAPM_INPUT("LIN1"),
+	SND_SOC_DAPM_INPUT("LIN2"),
+	SND_SOC_DAPM_INPUT("LIN3"),
+	SND_SOC_DAPM_INPUT("LIN4"),
+	SND_SOC_DAPM_INPUT("RIN1"),
+	SND_SOC_DAPM_INPUT("RIN2"),
+	SND_SOC_DAPM_INPUT("RIN3"),
+	SND_SOC_DAPM_INPUT("RIN4"),
 };
 
 static const struct snd_soc_dapm_route ak4642_intercon[] = {
@@ -205,6 +306,19 @@ static const struct snd_soc_dapm_route ak4642_intercon[] = {
 	{"DACH", NULL, "DAC"},
 
 	{"LINEOUT Mixer", "DACL", "DAC"},
+
+	{"Mic Left Capture Route", "LIN1", "LIN1"},
+	{"Mic Left Capture Route", NULL, "LIN2"},
+	{"Mic Left Capture Route", NULL, "LIN3"},
+	{"Mic Left Capture Route", NULL, "LIN4"},
+
+	{"Mic Right Capture Route", "RIN1", "RIN1"},
+	{"Mic Right Capture Route", NULL, "RIN2"},
+	{"Mic Right Capture Route", NULL, "RIN3"},
+	{"Mic Right Capture Route", NULL, "RIN4"},
+
+	{"ADC", NULL, "Mic Right Capture Route"},
+	{"ADC", NULL, "Mic Left Capture Route"},
 };
 
 /*
-- 
2.0.0.rc0
