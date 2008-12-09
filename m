From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/9] ASoC: TWL4030: DAPM mapping of the
	Earpiece output
Date: Tue,  9 Dec 2008 12:35:47 +0200
Message-ID: <1228818952-31082-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E83103868
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:36:08 +0100 (CET)
In-Reply-To: <1228818952-31082-4-git-send-email-peter.ujfalusi@nokia.com>
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

Adds DAPM muxing, routing for the Earpiece output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 9d10783..1da4617 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,6 +190,19 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+/* Earpiece */
+static const char *twl4030_earpiece_texts[] =
+		{"Off", "DACL1", "DACL2", "Invalid",
+		"DACR1"};
+
+static const struct soc_enum twl4030_earpiece_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1,
+			ARRAY_SIZE(twl4030_earpiece_texts),
+			twl4030_earpiece_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_earpiece_control =
+SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -645,6 +658,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -666,6 +680,12 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("ARXL2_APGA", TWL4030_REG_ARXL2_APGA_CTL,
 			0, 0, NULL, 0),
 
+	/* Output MUX controls */
+	/* Earpiece */
+	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_earpiece_control, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
+
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
 };
@@ -676,9 +696,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ARXL2_APGA", NULL, "DACL2"},
 	{"ARXR2_APGA", NULL, "DACR2"},
 
+	/* Internal playback routings */
+	/* Earpiece */
+	{"Earpiece Mux", "DACL1", "ARXL1_APGA"},
+	{"Earpiece Mux", "DACL2", "ARXL2_APGA"},
+	{"Earpiece Mux", "DACR1", "ARXR1_APGA"},
+
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
 	{"OUTR", NULL, "ARXR2_APGA"},
+	{"EARPIECE", NULL, "Earpiece Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
