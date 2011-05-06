From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 05/10] ASoC: upd9976: add DMIC support
Date: Fri, 06 May 2011 13:46:24 +0800
Message-ID: <20110506054624.26312.30651.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A83EA103839
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:44:56 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/upd9976.c |   76 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 5b8d047..a668b47 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -71,6 +71,12 @@ static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
  * Audio DAC Volume: From -84 dB to 10.5 dB in 0.75 steps.
  */
 static DECLARE_TLV_DB_SCALE(adac_tlv, -8400, 75, 0);
+
+/*
+ * DMIC Volume: from -63 dB to 1 dB in 1 db steps.
+ */
+static DECLARE_TLV_DB_SCALE(dmic_tlv, -6300, 100, 1);
+
 static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Volume",
 			 UPD9976_AUDIOLVOL, UPD9976_AUDIORVOL,
@@ -78,6 +84,9 @@ static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("PCM Volume",
 			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
 			 0, 0x1f, 1, mixer_tlv),
+	SOC_SINGLE("Internal Mic Switch", UPD9976_DMICCTRL1, 6, 1, 0),
+	SOC_SINGLE_TLV("Internal Mic Capture Volume",
+		       UPD9976_DMICCTRL1, 0, 0x3f, 1, dmic_tlv),
 };
 
 static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
@@ -90,6 +99,29 @@ static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_right_controls[] = {
 	SOC_DAPM_SINGLE("Audio DAC Right Switch", UPD9976_HPRMIXSEL, 3, 1, 1),
 };
 
+/* PCM2 Left Mux */
+static const char *upd9976_pcm2_left_mux_texts[] = {"AADC Left", "DMIC"};
+static const struct soc_enum upd9976_pcm2_left_mux_enum =
+	SOC_ENUM_SINGLE(UPD9976_ADCSAMPLERATE, 5, 2,
+			upd9976_pcm2_left_mux_texts);
+static const struct snd_kcontrol_new upd9976_pcm2_left_mux_control =
+	SOC_DAPM_ENUM("PCM2 Left Mux", upd9976_pcm2_left_mux_enum);
+
+/* PCM2 Right Mux */
+static const char *upd9976_pcm2_right_mux_texts[] = {"AADC Right", "DMIC"};
+static const struct soc_enum upd9976_pcm2_right_mux_enum =
+	SOC_ENUM_SINGLE(UPD9976_ADCSAMPLERATE, 4, 2,
+			upd9976_pcm2_right_mux_texts);
+static const struct snd_kcontrol_new upd9976_pcm2_right_mux_control =
+	SOC_DAPM_ENUM("PCM2 Right Mux", upd9976_pcm2_right_mux_enum);
+
+/* PCM2 Mux */
+static const char *upd9976_pcm2_mux_texts[] = {"No Mix", "Mix"};
+static const struct soc_enum upd9976_pcm2_mux_enum =
+	SOC_ENUM_SINGLE(UPD9976_ADCSAMPLERATE, 3, 2, upd9976_pcm2_mux_texts);
+static const struct snd_kcontrol_new upd9976_pcm2_mux_control =
+	SOC_DAPM_ENUM("PCM2 Mux", upd9976_pcm2_mux_enum);
+
 static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 	/* Input */
 	SND_SOC_DAPM_INPUT("LINEINL"),
@@ -130,12 +162,34 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 	SND_SOC_DAPM_MICBIAS("MIC1 Bias", UPD9976_MICCTRL, 6, 0),
 	SND_SOC_DAPM_MICBIAS("MIC2 Bias", UPD9976_MICCTRL, 4, 0),
 
+	SND_SOC_DAPM_MIXER("PCM2 In Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("PCM2 In No Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Mux */
+	SND_SOC_DAPM_MUX("PCM2 Left Mux", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_left_mux_control),
+	SND_SOC_DAPM_MUX("PCM2 Right Mux", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_right_mux_control),
+	SND_SOC_DAPM_MUX("PCM2 Mux", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_mux_control),
+
 	/* PGA */
 	SND_SOC_DAPM_PGA("HP Playback Left PGA", UPD9976_DRVPOWERCTRL,
 			 2, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("HP Playback Right PGA", UPD9976_DRVPOWERCTRL,
 			 1, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("AADC Left PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("AADC Right PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("DMIC Gain PGA", UPD9976_DMICCTRL1, 7, 0, NULL, 0),
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_OUT("PCM2 Out", "Audio Capture", 0, SND_SOC_NOPM, 0,
+			     0),
+
+	/* Supply */
+	SND_SOC_DAPM_SUPPLY("DMIC Supply", UPD9976_POWERCTRL2, 1, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
@@ -154,6 +208,28 @@ static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
 	{"HPOUTL", NULL, "HP Playback Left PGA"},
 	{"HPOUTR", NULL, "HP Playback Right PGA"},
 
+	{"DMICDAT", NULL, "DMIC Supply"},
+	{"DMIC Gain PGA", NULL, "DMICDAT"},
+
+	{"AADC Left PGA", NULL, "AADC"},
+	{"AADC Right PGA", NULL, "AADC"},
+
+	{"PCM2 Left Mux", "DMIC", "DMIC Gain PGA"},
+	{"PCM2 Left Mux", "AADC Left", "AADC Left PGA"},
+
+	{"PCM2 Right Mux", "DMIC", "DMIC Gain PGA"},
+	{"PCM2 Right Mux", "AADC Right", "AADC Right PGA"},
+
+	{"PCM2 In Mixer", NULL, "PCM2 Left Mux"},
+	{"PCM2 In No Mixer", NULL, "PCM2 Left Mux"},
+
+	{"PCM2 In Mixer", NULL, "PCM2 Right Mux"},
+	{"PCM2 In No Mixer", NULL, "PCM2 Right Mux"},
+
+	{"PCM2 Mux", "Mix", "PCM2 In Mixer"},
+	{"PCM2 Mux", "No Mix", "PCM2 In No Mixer"},
+
+	{"PCM2 Out", NULL, "PCM2 Mux"},
 };
 
 static int upd9976_audio_digital_mute(struct snd_soc_dai *dai, int mute)
