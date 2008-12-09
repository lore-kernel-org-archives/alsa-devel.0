From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/18] ASoC: TWL4030: DAPM mapping of the
	Handsfree outputs
Date: Tue,  9 Dec 2008 14:01:32 +0000
Message-ID: <1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B87A103851
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:47 +0100 (CET)
In-Reply-To: <1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Adds DAPM muxing, routing for the Handsfree outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 08c33e9..d0612a4 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -277,6 +277,30 @@ static const struct soc_enum twl4030_carkitr_enum =
 static const struct snd_kcontrol_new twl4030_dapm_carkitr_control =
 SOC_DAPM_ENUM("Route", twl4030_carkitr_enum);
 
+/* Handsfree Left */
+static const char *twl4030_handsfreel_texts[] =
+		{"Voice", "DACL1", "DACL2", "DACR2"};
+
+static const struct soc_enum twl4030_handsfreel_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0,
+			ARRAY_SIZE(twl4030_handsfreel_texts),
+			twl4030_handsfreel_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_handsfreel_control =
+SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
+
+/* Handsfree Right */
+static const char *twl4030_handsfreer_texts[] =
+		{"Voice", "DACR1", "DACR2", "DACL2"};
+
+static const struct soc_enum twl4030_handsfreer_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0,
+			ARRAY_SIZE(twl4030_handsfreer_texts),
+			twl4030_handsfreer_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
+SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -737,6 +761,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 	SND_SOC_DAPM_OUTPUT("HSOL"),
 	SND_SOC_DAPM_OUTPUT("HSOR"),
+	SND_SOC_DAPM_OUTPUT("HFL"),
+	SND_SOC_DAPM_OUTPUT("HFR"),
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
@@ -780,6 +806,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		&twl4030_dapm_carkitl_control),
 	SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_carkitr_control),
+	/* HandsfreeL/R */
+	SND_SOC_DAPM_MUX("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
+		&twl4030_dapm_handsfreel_control),
+	SND_SOC_DAPM_MUX("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
+		&twl4030_dapm_handsfreer_control),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -816,6 +847,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* CarkitR */
 	{"CarkitR Mux", "DACR1", "ARXR1_APGA"},
 	{"CarkitR Mux", "DACR2", "ARXR2_APGA"},
+	/* HandsfreeL */
+	{"HandsfreeL Mux", "DACL1", "ARXL1_APGA"},
+	{"HandsfreeL Mux", "DACL2", "ARXL2_APGA"},
+	{"HandsfreeL Mux", "DACR2", "ARXR2_APGA"},
+	/* HandsfreeR */
+	{"HandsfreeR Mux", "DACR1", "ARXR1_APGA"},
+	{"HandsfreeR Mux", "DACR2", "ARXR2_APGA"},
+	{"HandsfreeR Mux", "DACL2", "ARXL2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
@@ -827,6 +866,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSOR", NULL, "HeadsetR Mux"},
 	{"CARKITL", NULL, "CarkitL Mux"},
 	{"CARKITR", NULL, "CarkitR Mux"},
+	{"HFL", NULL, "HandsfreeL Mux"},
+	{"HFR", NULL, "HandsfreeR Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.5.6.5
