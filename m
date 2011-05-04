From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 09/19] ASoC: upd9976: add Analog MIC support
Date: Wed, 04 May 2011 21:45:39 +0800
Message-ID: <20110504134539.32443.75221.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B60910394C
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:16 +0200 (CEST)
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
 sound/soc/codecs/upd9976.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index fb3a4fc..8b2fff7 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -81,6 +81,13 @@ static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_right_controls[] = {
 	SOC_DAPM_SINGLE("Audio DAC Right", UPD9976_HPRMIXSEL, 3, 1, 1),
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
@@ -144,6 +151,9 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("PCM2 IN No Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* Mux */
+	SND_SOC_DAPM_MUX("Analog Right", UPD9976_POWERCTRL1, 4, 0,
+			 &upd9976_ar_mux_control),
+
 	SND_SOC_DAPM_MUX("PCM2 Left", SND_SOC_NOPM, 0, 0,
 			 &upd9976_pcm2_left_mux_control),
 	SND_SOC_DAPM_MUX("PCM2 Right", SND_SOC_NOPM, 0, 0,
@@ -162,6 +172,8 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 
 	SND_SOC_DAPM_PGA("DMIC Gain", UPD9976_DMICCTRL1, 7, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("MIC2 In", UPD9976_POWERCTRL1, 2, 0, NULL, 0),
+
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_OUT("PCM2 Out", "Audio Capture", 0, SND_SOC_NOPM, 0,
 			     0),
@@ -186,6 +198,13 @@ static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
 	{"HPOUTL", NULL, "HP Playback Left"},
 	{"HPOUTR", NULL, "HP Playback Right"},
 
+	{"MIC2 In", NULL, "MIC2"},
+
+	{"Analog Right", "MIC", "MIC2 In"},
+	{"Analog Right", "LineIn", "LINEINR"},
+
+	{"AADC", NULL, "Analog Right"},
+
 	{"DMICDAT", NULL, "DMIC Supply"},
 	{"DMIC Gain", NULL, "DMICDAT"},
 
