From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 06/10] ASoC: upd9976: add Analog MIC support
Date: Fri, 06 May 2011 13:46:29 +0800
Message-ID: <20110506054629.26312.4509.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C257C103A5E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:45:02 +0200 (CEST)
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
 sound/soc/codecs/upd9976.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index a668b47..cbcfbb2 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -77,6 +77,11 @@ static DECLARE_TLV_DB_SCALE(adac_tlv, -8400, 75, 0);
  */
 static DECLARE_TLV_DB_SCALE(dmic_tlv, -6300, 100, 1);
 
+/*
+ * Analog Volume: from -25 dB to 6 dB in 1 dB steps.
+ */
+static DECLARE_TLV_DB_SCALE(analog_tlv, -2500, 100, 0);
+
 static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Volume",
 			 UPD9976_AUDIOLVOL, UPD9976_AUDIORVOL,
@@ -87,6 +92,11 @@ static const struct snd_kcontrol_new upd9976_snd_controls[] = {
 	SOC_SINGLE("Internal Mic Switch", UPD9976_DMICCTRL1, 6, 1, 0),
 	SOC_SINGLE_TLV("Internal Mic Capture Volume",
 		       UPD9976_DMICCTRL1, 0, 0x3f, 1, dmic_tlv),
+	SOC_DOUBLE_R("Analog Mic Switch", UPD9976_LILSEL, UPD9976_LIRSEL,
+		     6, 1, 0),
+	SOC_DOUBLE_R_TLV("Analog Capture Volume",
+			 UPD9976_LILSEL, UPD9976_LILSEL,
+			 0, 0x1f, 1, analog_tlv),
 };
 
 static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
@@ -99,6 +109,13 @@ static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_right_controls[] = {
 	SOC_DAPM_SINGLE("Audio DAC Right Switch", UPD9976_HPRMIXSEL, 3, 1, 1),
 };
 
+/* Analog Right Mux */
+static const char *upd9976_analog_mux_texts[] = {"MIC", "LineIn"};
+static const struct soc_enum upd9976_ar_mux_enum =
+	SOC_ENUM_SINGLE(UPD9976_LIRSEL, 7, 2, upd9976_analog_mux_texts);
+static const struct snd_kcontrol_new upd9976_ar_mux_control =
+	SOC_DAPM_ENUM("Route", upd9976_ar_mux_enum);
+
 /* PCM2 Left Mux */
 static const char *upd9976_pcm2_left_mux_texts[] = {"AADC Left", "DMIC"};
 static const struct soc_enum upd9976_pcm2_left_mux_enum =
@@ -166,6 +183,9 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("PCM2 In No Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* Mux */
+	SND_SOC_DAPM_MUX("Analog Right Mux", UPD9976_POWERCTRL1, 4, 0,
+			 &upd9976_ar_mux_control),
+
 	SND_SOC_DAPM_MUX("PCM2 Left Mux", SND_SOC_NOPM, 0, 0,
 			 &upd9976_pcm2_left_mux_control),
 	SND_SOC_DAPM_MUX("PCM2 Right Mux", SND_SOC_NOPM, 0, 0,
@@ -184,6 +204,8 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 
 	SND_SOC_DAPM_PGA("DMIC Gain PGA", UPD9976_DMICCTRL1, 7, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("MIC2 In PGA", UPD9976_POWERCTRL1, 2, 0, NULL, 0),
+
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_OUT("PCM2 Out", "Audio Capture", 0, SND_SOC_NOPM, 0,
 			     0),
@@ -208,6 +230,13 @@ static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
 	{"HPOUTL", NULL, "HP Playback Left PGA"},
 	{"HPOUTR", NULL, "HP Playback Right PGA"},
 
+	{"MIC2 In PGA", NULL, "MIC2"},
+
+	{"Analog Right Mux", "MIC", "MIC2 In PGA"},
+	{"Analog Right Mux", "LineIn", "LINEINR"},
+
+	{"AADC", NULL, "Analog Right Mux"},
+
 	{"DMICDAT", NULL, "DMIC Supply"},
 	{"DMIC Gain PGA", NULL, "DMICDAT"},
 
