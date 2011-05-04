From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 08/19] ASoC: upd9976: add DMIC support
Date: Wed, 04 May 2011 21:45:34 +0800
Message-ID: <20110504134534.32443.79243.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id B6B6010395B
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:11 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
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
 sound/soc/codecs/upd9976.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index dc7920c..fb3a4fc 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -81,6 +81,29 @@ static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_right_controls[] = {
 	SOC_DAPM_SINGLE("Audio DAC Right", UPD9976_HPRMIXSEL, 3, 1, 1),
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
@@ -117,12 +140,34 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 			   upd9976_hp_spkr_mixer_right_controls,
 			   ARRAY_SIZE(upd9976_hp_spkr_mixer_right_controls)),
 
+	SND_SOC_DAPM_MIXER("PCM2 IN Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("PCM2 IN No Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Mux */
+	SND_SOC_DAPM_MUX("PCM2 Left", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_left_mux_control),
+	SND_SOC_DAPM_MUX("PCM2 Right", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_right_mux_control),
+	SND_SOC_DAPM_MUX("PCM2 Mux", SND_SOC_NOPM, 0, 0,
+			 &upd9976_pcm2_mux_control),
+
 	/* PGA */
 	SND_SOC_DAPM_PGA("HP Playback Left", UPD9976_DRVPOWERCTRL,
 			 2, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("HP Playback Right", UPD9976_DRVPOWERCTRL,
 			 1, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("AADC Left", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("AADC Right", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("DMIC Gain", UPD9976_DMICCTRL1, 7, 0, NULL, 0),
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_OUT("PCM2 Out", "Audio Capture", 0, SND_SOC_NOPM, 0,
+			     0),
+
+	/* Supply */
+	SND_SOC_DAPM_SUPPLY("DMIC Supply", UPD9976_POWERCTRL2, 1, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
@@ -141,6 +186,28 @@ static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
 	{"HPOUTL", NULL, "HP Playback Left"},
 	{"HPOUTR", NULL, "HP Playback Right"},
 
+	{"DMICDAT", NULL, "DMIC Supply"},
+	{"DMIC Gain", NULL, "DMICDAT"},
+
+	{"AADC Left", NULL, "AADC"},
+	{"AADC Right", NULL, "AADC"},
+
+	{"PCM2 Left", "DMIC", "DMIC Gain"},
+	{"PCM2 Left", "AADC Left", "AADC Left"},
+
+	{"PCM2 Right", "DMIC", "DMIC Gain"},
+	{"PCM2 Right", "AADC Right", "AADC Right"},
+
+	{"PCM2 IN Mix", NULL, "PCM2 Left"},
+	{"PCM2 IN No Mix", NULL, "PCM2 Left"},
+
+	{"PCM2 IN No Mix", NULL, "PCM2 Right"},
+	{"PCM2 IN Mix", NULL, "PCM2 Right"},
+
+	{"PCM2 Mux", "No Mix", "PCM2 IN No Mix"},
+	{"PCM2 Mux", "Mix", "PCM2 IN Mix"},
+
+	{"PCM2 Out", NULL, "PCM2 Mux"},
 };
 
 static int upd9976_audio_digital_mute(struct snd_soc_dai *dai, int mute)
