From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/8] ASoC: TWL4030: DAPM mapping of the PreDriv
	outputs
Date: Mon,  8 Dec 2008 10:09:05 +0200
Message-ID: <1228723748-22911-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 80DB710385A
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 09:09:40 +0100 (CET)
In-Reply-To: <1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
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

Adds DAPM muxing, routing for the PreDrive outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 83eaaee..c31f328 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -203,6 +203,32 @@ static const struct soc_enum twl4030_earpiece_enum =
 static const struct snd_kcontrol_new twl4030_dapm_erapiece_controls =
 SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
 
+/* PreDrive Left */
+static const char *twl4030_predrivel_texts[] =
+		{"Off", "DACL1 Switch", "DACL2 Switch", "Invalid",
+		"DACR2 Switch"};
+
+static const struct soc_enum twl4030_predrivel_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1,
+			ARRAY_SIZE(twl4030_predrivel_texts),
+			twl4030_predrivel_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_predrivel_controls =
+SOC_DAPM_ENUM("Route", twl4030_predrivel_enum);
+
+/* PreDrive Right */
+static const char *twl4030_predriver_texts[] =
+		{"Off", "DACR1 Switch", "DACR2 Switch", "Invalid",
+		"DACL2 Switch"};
+
+static const struct soc_enum twl4030_predriver_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1,
+			ARRAY_SIZE(twl4030_predriver_texts),
+			twl4030_predriver_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_predriver_controls =
+SOC_DAPM_ENUM("Route", twl4030_predriver_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -653,6 +679,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
+	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
+	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -682,6 +710,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_erapiece_controls, outmixer_event,
 		SND_SOC_DAPM_PRE_REG),
+	/* PreDrivL/R */
+	SND_SOC_DAPM_MUX_E("PredriveL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predrivel_controls, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_MUX_E("PredriveR Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predriver_controls, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -698,11 +733,21 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earpiece Mux", "DACL1 Switch", "ARXL1_APGA"},
 	{"Earpiece Mux", "DACL2 Switch", "ARXL2_APGA"},
 	{"Earpiece Mux", "DACR1 Switch", "ARXR1_APGA"},
+	/* PreDrivL */
+	{"PredriveL Mux", "DACL1 Switch", "ARXL1_APGA"},
+	{"PredriveL Mux", "DACL2 Switch", "ARXL2_APGA"},
+	{"PredriveL Mux", "DACR2 Switch", "ARXR2_APGA"},
+	/* PreDrivR */
+	{"PredriveR Mux", "DACR1 Switch", "ARXR1_APGA"},
+	{"PredriveR Mux", "DACR2 Switch", "ARXR2_APGA"},
+	{"PredriveR Mux", "DACL2 Switch", "ARXL2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
 	{"OUTR", NULL, "ARXR2_APGA"},
 	{"EARPIECE", NULL, "Earpiece Mux"},
+	{"PREDRIVEL", NULL, "PredriveL Mux"},
+	{"PREDRIVER", NULL, "PredriveR Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
