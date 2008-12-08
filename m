From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/8] ASoC: TWL4030: DAPM mapping of the
	Earpiece output
Date: Mon,  8 Dec 2008 10:09:04 +0200
Message-ID: <1228723748-22911-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0652D103854
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 09:09:36 +0100 (CET)
In-Reply-To: <1228723748-22911-4-git-send-email-peter.ujfalusi@nokia.com>
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
index 6e7b5fc..83eaaee 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,6 +190,19 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+/* Earpiece */
+static const char *twl4030_earpiece_texts[] =
+		{"Off", "DACL1 Switch", "DACL2 Switch", "Invalid",
+		"DACR1 Switch"};
+
+static const struct soc_enum twl4030_earpiece_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1,
+			ARRAY_SIZE(twl4030_earpiece_texts),
+			twl4030_earpiece_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_erapiece_controls =
+SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -639,6 +652,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -663,6 +677,12 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXL2_APGA",
 			TWL4030_REG_ARXL2_APGA_CTL, 0, 0x3, 0x3, 0x0),
 
+	/* Output MUX controls */
+	/* Earpiece */
+	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_erapiece_controls, outmixer_event,
+		SND_SOC_DAPM_PRE_REG),
+
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
 };
@@ -673,9 +693,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ARXL2_APGA", NULL, "DACL2"},
 	{"ARXR2_APGA", NULL, "DACR2"},
 
+	/* Internal playback routings */
+	/* Earpiece */
+	{"Earpiece Mux", "DACL1 Switch", "ARXL1_APGA"},
+	{"Earpiece Mux", "DACL2 Switch", "ARXL2_APGA"},
+	{"Earpiece Mux", "DACR1 Switch", "ARXR1_APGA"},
+
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
 	{"OUTR", NULL, "ARXR2_APGA"},
+	{"EARPIECE", NULL, "Earpiece Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
