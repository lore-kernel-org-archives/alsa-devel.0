From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 6/9] ASoC: TWL4030: DAPM mapping of the Headset
	outputs
Date: Tue,  9 Dec 2008 08:45:48 +0200
Message-ID: <1228805151-29385-7-git-send-email-peter.ujfalusi@nokia.com>
References: <1228805151-29385-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-5-git-send-email-peter.ujfalusi@nokia.com>
	<1228805151-29385-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0912E103835
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 07:46:08 +0100 (CET)
In-Reply-To: <1228805151-29385-6-git-send-email-peter.ujfalusi@nokia.com>
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

Adds DAPM muxing, routing for the Headset outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3ecc009..ace1dce 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -229,6 +229,30 @@ static const struct soc_enum twl4030_predriver_enum =
 static const struct snd_kcontrol_new twl4030_dapm_predriver_control =
 SOC_DAPM_ENUM("Route", twl4030_predriver_enum);
 
+/* Headset Left */
+static const char *twl4030_hsol_texts[] =
+		{"Off", "DACL1", "DACL2"};
+
+static const struct soc_enum twl4030_hsol_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 1,
+			ARRAY_SIZE(twl4030_hsol_texts),
+			twl4030_hsol_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_hsol_control =
+SOC_DAPM_ENUM("Route", twl4030_hsol_enum);
+
+/* Headset Right */
+static const char *twl4030_hsor_texts[] =
+		{"Off", "DACR1", "DACR2"};
+
+static const struct soc_enum twl4030_hsor_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 4,
+			ARRAY_SIZE(twl4030_hsor_texts),
+			twl4030_hsor_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_hsor_control =
+SOC_DAPM_ENUM("Route", twl4030_hsor_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -687,6 +711,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
+	SND_SOC_DAPM_OUTPUT("HSOL"),
+	SND_SOC_DAPM_OUTPUT("HSOR"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -720,6 +746,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX_E("PredriveR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_predriver_control, outmixer_event,
 		SND_SOC_DAPM_PRE_REG),
+	/* HeadsetL/R */
+	SND_SOC_DAPM_MUX("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_hsol_control),
+	SND_SOC_DAPM_MUX("HeadsetR Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_hsor_control),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -744,6 +775,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"PredriveR Mux", "DACR1 Switch", "ARXR1_APGA"},
 	{"PredriveR Mux", "DACR2 Switch", "ARXR2_APGA"},
 	{"PredriveR Mux", "DACL2 Switch", "ARXL2_APGA"},
+	/* HeadsetL */
+	{"HeadsetL Mux", "DACL1 Switch", "ARXL1_APGA"},
+	{"HeadsetL Mux", "DACL2 Switch", "ARXL2_APGA"},
+	/* HeadsetR */
+	{"HeadsetR Mux", "DACR1 Switch", "ARXR1_APGA"},
+	{"HeadsetR Mux", "DACR2 Switch", "ARXR2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
@@ -751,6 +788,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"EARPIECE", NULL, "Earpiece Mux"},
 	{"PREDRIVEL", NULL, "PredriveL Mux"},
 	{"PREDRIVER", NULL, "PredriveR Mux"},
+	{"HSOL", NULL, "HeadsetL Mux"},
+	{"HSOR", NULL, "HeadsetR Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
