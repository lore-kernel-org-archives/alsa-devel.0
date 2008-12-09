From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/9] ASoC: TWL4030: DAPM mapping of the PreDriv
	outputs
Date: Tue,  9 Dec 2008 12:35:48 +0200
Message-ID: <1228818952-31082-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 11405103858
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:36:06 +0100 (CET)
In-Reply-To: <1228818952-31082-5-git-send-email-peter.ujfalusi@nokia.com>
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
index 1da4617..c508344 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -203,6 +203,32 @@ static const struct soc_enum twl4030_earpiece_enum =
 static const struct snd_kcontrol_new twl4030_dapm_earpiece_control =
 SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
 
+/* PreDrive Left */
+static const char *twl4030_predrivel_texts[] =
+		{"Off", "DACL1", "DACL2", "Invalid",
+		"DACR2"};
+
+static const struct soc_enum twl4030_predrivel_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1,
+			ARRAY_SIZE(twl4030_predrivel_texts),
+			twl4030_predrivel_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_predrivel_control =
+SOC_DAPM_ENUM("Route", twl4030_predrivel_enum);
+
+/* PreDrive Right */
+static const char *twl4030_predriver_texts[] =
+		{"Off", "DACR1", "DACR2", "Invalid",
+		"DACL2"};
+
+static const struct soc_enum twl4030_predriver_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1,
+			ARRAY_SIZE(twl4030_predriver_texts),
+			twl4030_predriver_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_predriver_control =
+SOC_DAPM_ENUM("Route", twl4030_predriver_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -659,6 +685,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
+	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
+	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -685,6 +713,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_earpiece_control, outmixer_event,
 		SND_SOC_DAPM_PRE_REG),
+	/* PreDrivL/R */
+	SND_SOC_DAPM_MUX_E("PredriveL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predrivel_control, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_MUX_E("PredriveR Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predriver_control, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -701,11 +736,21 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earpiece Mux", "DACL1", "ARXL1_APGA"},
 	{"Earpiece Mux", "DACL2", "ARXL2_APGA"},
 	{"Earpiece Mux", "DACR1", "ARXR1_APGA"},
+	/* PreDrivL */
+	{"PredriveL Mux", "DACL1", "ARXL1_APGA"},
+	{"PredriveL Mux", "DACL2", "ARXL2_APGA"},
+	{"PredriveL Mux", "DACR2", "ARXR2_APGA"},
+	/* PreDrivR */
+	{"PredriveR Mux", "DACR1", "ARXR1_APGA"},
+	{"PredriveR Mux", "DACR2", "ARXR2_APGA"},
+	{"PredriveR Mux", "DACL2", "ARXL2_APGA"},
 
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
