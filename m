From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 8/8] ASoC: TWL4030: DAPM mapping of the
	Handsfree outputs
Date: Mon,  8 Dec 2008 10:09:08 +0200
Message-ID: <1228723748-22911-9-git-send-email-peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-7-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-8-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F258103854
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 09:09:37 +0100 (CET)
In-Reply-To: <1228723748-22911-8-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Adds DAPM muxing, routing for the Handsfree outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4fb16ec..334f625 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -277,6 +277,30 @@ static const struct soc_enum twl4030_carkitr_enum =
 static const struct snd_kcontrol_new twl4030_dapm_carkitr_controls =
 SOC_DAPM_ENUM("Route", twl4030_carkitr_enum);
 
+/* Handsfree Left */
+static const char *twl4030_handsfreel_texts[] =
+		{"Voice", "DACL1 Switch", "DACL2 Switch", "DACR2 Switch"};
+
+static const struct soc_enum twl4030_handsfreel_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0,
+			ARRAY_SIZE(twl4030_handsfreel_texts),
+			twl4030_handsfreel_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_handsfreel_controls =
+SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
+
+/* Handsfree Right */
+static const char *twl4030_handsfreer_texts[] =
+		{"Voice", "DACR1 Switch", "DACR2 Switch", "DACL2 Switch"};
+
+static const struct soc_enum twl4030_handsfreer_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0,
+			ARRAY_SIZE(twl4030_handsfreer_texts),
+			twl4030_handsfreer_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_handsfreer_controls =
+SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -731,6 +755,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 	SND_SOC_DAPM_OUTPUT("HSOL"),
 	SND_SOC_DAPM_OUTPUT("HSOR"),
+	SND_SOC_DAPM_OUTPUT("HFL"),
+	SND_SOC_DAPM_OUTPUT("HFR"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -777,6 +803,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		&twl4030_dapm_carkitl_controls),
 	SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_carkitr_controls),
+	/* HandsfreeL/R */
+	SND_SOC_DAPM_MUX("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
+		&twl4030_dapm_handsfreel_controls),
+	SND_SOC_DAPM_MUX("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
+		&twl4030_dapm_handsfreer_controls),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -813,6 +844,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* CarkitR */
 	{"CarkitR Mux", "DACR1 Switch", "ARXR1_APGA"},
 	{"CarkitR Mux", "DACR2 Switch", "ARXR2_APGA"},
+	/* HandsfreeL */
+	{"HandsfreeL Mux", "DACL1 Switch", "ARXL1_APGA"},
+	{"HandsfreeL Mux", "DACL2 Switch", "ARXL2_APGA"},
+	{"HandsfreeL Mux", "DACR2 Switch", "ARXR2_APGA"},
+	/* HandsfreeR */
+	{"HandsfreeR Mux", "DACR1 Switch", "ARXR1_APGA"},
+	{"HandsfreeR Mux", "DACR2 Switch", "ARXR2_APGA"},
+	{"HandsfreeR Mux", "DACL2 Switch", "ARXL2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
@@ -824,6 +863,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSOR", NULL, "HeadsetR Mux"},
 	{"CARKITL", NULL, "CarkitL Mux"},
 	{"CARKITR", NULL, "CarkitR Mux"},
+	{"HFL", NULL, "HandsfreeL Mux"},
+	{"HFR", NULL, "HandsfreeR Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
