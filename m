From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: Remove word "Switch" from Handsfree
	switch name
Date: Thu, 25 Jun 2009 12:36:14 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E35607E71@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B4A342435C
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 19:36:25 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

SoC dapm adds the suffix "Switch" to SND_SOC_DAPM_SWITCH controls,
removing word "Switch" from HandsfreeL/HandsfreeR widget name
for avoiding to duplicate it.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index df42fa2..49ceb62 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1258,14 +1258,14 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	/* HandsfreeL/R */
 	SND_SOC_DAPM_MUX("HandsfreeL Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_handsfreel_control),
-	SND_SOC_DAPM_SWITCH("HandsfreeL Switch", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("HandsfreeL", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_handsfreelmute_control),
 	SND_SOC_DAPM_PGA_E("HandsfreeL PGA", SND_SOC_NOPM,
 			0, 0, NULL, 0, handsfreelpga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("HandsfreeR Mux", SND_SOC_NOPM, 5, 0,
 		&twl4030_dapm_handsfreer_control),
-	SND_SOC_DAPM_SWITCH("HandsfreeR Switch", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("HandsfreeR", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_handsfreermute_control),
 	SND_SOC_DAPM_PGA_E("HandsfreeR PGA", SND_SOC_NOPM,
 			0, 0, NULL, 0, handsfreerpga_event,
@@ -1377,15 +1377,15 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HandsfreeL Mux", "AudioL1", "Analog L1 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioL2", "Analog L2 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioR2", "Analog R2 Playback Mixer"},
-	{"HandsfreeL Switch", "Switch", "HandsfreeL Mux"},
-	{"HandsfreeL PGA", NULL, "HandsfreeL Switch"},
+	{"HandsfreeL", "Switch", "HandsfreeL Mux"},
+	{"HandsfreeL PGA", NULL, "HandsfreeL"},
 	/* HandsfreeR */
 	{"HandsfreeR Mux", "Voice", "Analog Voice Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR1", "Analog R1 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR2", "Analog R2 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioL2", "Analog L2 Playback Mixer"},
-	{"HandsfreeR Switch", "Switch", "HandsfreeR Mux"},
-	{"HandsfreeR PGA", NULL, "HandsfreeR Switch"},
+	{"HandsfreeR", "Switch", "HandsfreeR Mux"},
+	{"HandsfreeR PGA", NULL, "HandsfreeR"},
 	/* Vibra */
 	{"Vibra Mux", "AudioL1", "DAC Left1"},
 	{"Vibra Mux", "AudioR1", "DAC Right1"},
-- 
1.5.4.3
