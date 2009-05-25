From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3 take2] ASoC: TWL4030: HandsfreeL/R mute
	DAPM switch
Date: Mon, 25 May 2009 11:12:13 +0300
Message-ID: <1243239133-18996-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1243239133-18996-1-git-send-email-peter.ujfalusi@nokia.com>
	<1243239133-18996-2-git-send-email-peter.ujfalusi@nokia.com>
	<1243239133-18996-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE90103853
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 10:12:25 +0200 (CEST)
In-Reply-To: <1243239133-18996-3-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add DAPM switch for HeadsetL/R mute. Since all bits are are needed
for the HFL/R pop removal to work the switch is using the SW_SHADOW
no HW register for the HandsfreeL/R mute.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 989446d..63ebd17 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -395,6 +395,10 @@ static const struct soc_enum twl4030_handsfreel_enum =
 static const struct snd_kcontrol_new twl4030_dapm_handsfreel_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);

+/* Handsfree Left virtual mute */
+static const struct snd_kcontrol_new twl4030_dapm_handsfreelmute_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_SW_SHADOW, 0, 1, 0);
+
 /* Handsfree Right */
 static const char *twl4030_handsfreer_texts[] =
 		{"Voice", "AudioR1", "AudioR2", "AudioL2"};
@@ -407,6 +411,10 @@ static const struct soc_enum twl4030_handsfreer_enum =
 static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);

+/* Handsfree Right virtual mute */
+static const struct snd_kcontrol_new twl4030_dapm_handsfreermute_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_SW_SHADOW, 1, 1, 0);
+
 /* Vibra */
 /* Vibra audio path selection */
 static const char *twl4030_vibra_texts[] =
@@ -1231,11 +1239,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	/* HandsfreeL/R */
 	SND_SOC_DAPM_MUX("HandsfreeL Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_handsfreel_control),
+	SND_SOC_DAPM_SWITCH("HandsfreeL Switch", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_handsfreelmute_control),
 	SND_SOC_DAPM_PGA_E("HandsfreeL PGA", SND_SOC_NOPM,
 			0, 0, NULL, 0, handsfreelpga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("HandsfreeR Mux", SND_SOC_NOPM, 5, 0,
 		&twl4030_dapm_handsfreer_control),
+	SND_SOC_DAPM_SWITCH("HandsfreeR Switch", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_handsfreermute_control),
 	SND_SOC_DAPM_PGA_E("HandsfreeR PGA", SND_SOC_NOPM,
 			0, 0, NULL, 0, handsfreerpga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
@@ -1346,13 +1358,15 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HandsfreeL Mux", "AudioL1", "Analog L1 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioL2", "Analog L2 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioR2", "Analog R2 Playback Mixer"},
-	{"HandsfreeL PGA", NULL, "HandsfreeL Mux"},
+	{"HandsfreeL Switch", "Switch", "HandsfreeL Mux"},
+	{"HandsfreeL PGA", NULL, "HandsfreeL Switch"},
 	/* HandsfreeR */
 	{"HandsfreeR Mux", "Voice", "Analog Voice Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR1", "Analog R1 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR2", "Analog R2 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioL2", "Analog L2 Playback Mixer"},
-	{"HandsfreeR PGA", NULL, "HandsfreeR Mux"},
+	{"HandsfreeR Switch", "Switch", "HandsfreeR Mux"},
+	{"HandsfreeR PGA", NULL, "HandsfreeR Switch"},
 	/* Vibra */
 	{"Vibra Mux", "AudioL1", "DAC Left1"},
 	{"Vibra Mux", "AudioR1", "DAC Right1"},
--
1.6.3.1
