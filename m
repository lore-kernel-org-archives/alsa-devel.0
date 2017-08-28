From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 8/9] ASoC: max98927: Modified DAPM widget and map to enable/disable VI sense path
Date: Mon, 28 Aug 2017 16:31:00 -0700
Message-ID: <1503963061-14763-8-git-send-email-ryans.lee@maximintegrated.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 5517251..f944659 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -509,11 +509,6 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN,
 			MAX98927_AMP_EN_MASK, 1);
-		/* enable VMON and IMON */
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN);
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R00FF_GLOBAL_SHDN,
 			MAX98927_GLOBAL_EN_MASK, 1);
@@ -525,10 +520,6 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN,
 			MAX98927_AMP_EN_MASK, 0);
-		/* disable VMON and IMON */
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN, 0);
 		break;
 	default:
 		return 0;
@@ -547,14 +538,24 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 static const struct snd_kcontrol_new max98927_dai_controls =
 	SOC_DAPM_ENUM("DAI Sel", dai_sel_enum);
 
+static const struct snd_kcontrol_new max98927_vi_control =
+	SOC_DAPM_SINGLE("Switch", MAX98927_R003F_MEAS_DSP_CFG, 2, 1, 0);
+
 static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_R003A_AMP_EN,
 		0, 0, max98927_dac_event,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("DAI Sel Mux", SND_SOC_NOPM, 0, 0,
 		&max98927_dai_controls),
 	SND_SOC_DAPM_OUTPUT("BE_OUT"),
+	SND_SOC_DAPM_AIF_OUT("Voltage Sense", "HiFi Capture",  0,
+		MAX98927_R003E_MEAS_EN, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("Current Sense", "HiFi Capture",  0,
+		MAX98927_R003E_MEAS_EN, 1, 0),
+	SND_SOC_DAPM_SWITCH("VI Sense", SND_SOC_NOPM, 0, 0,
+		&max98927_vi_control),
+	SND_SOC_DAPM_SIGGEN("VMON"),
+	SND_SOC_DAPM_SIGGEN("IMON"),
 };
 
 static DECLARE_TLV_DB_SCALE(max98927_spk_tlv, 300, 300, 0);
@@ -656,11 +657,16 @@ static SOC_ENUM_SINGLE_DECL(max98927_env_track_headroom,
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
-	{"Amp Enable", NULL, "DAI_OUT"},
+	/* Plabyack */
 	{"DAI Sel Mux", "Left", "Amp Enable"},
 	{"DAI Sel Mux", "Right", "Amp Enable"},
 	{"DAI Sel Mux", "LeftRight", "Amp Enable"},
 	{"BE_OUT", NULL, "DAI Sel Mux"},
+	/* Capture */
+	{ "VI Sense", "Switch", "VMON" },
+	{ "VI Sense", "Switch", "IMON" },
+	{ "Voltage Sense", NULL, "VI Sense" },
+	{ "Current Sense", NULL, "VI Sense" },
 };
 
 static struct snd_soc_dai_driver max98927_dai[] = {
-- 
1.9.1
