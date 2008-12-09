From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/18] ASoC: TWL4030: DAPM mapping of the
	Carkit outputs
Date: Tue,  9 Dec 2008 14:01:31 +0000
Message-ID: <1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87C80103848
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Adds DAPM muxing, routing for the Carkit outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 86ff5a9..08c33e9 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -253,6 +253,30 @@ static const struct soc_enum twl4030_hsor_enum =
 static const struct snd_kcontrol_new twl4030_dapm_hsor_control =
 SOC_DAPM_ENUM("Route", twl4030_hsor_enum);
 
+/* Carkit Left */
+static const char *twl4030_carkitl_texts[] =
+		{"Off", "DACL1", "DACL2"};
+
+static const struct soc_enum twl4030_carkitl_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PRECKL_CTL, 1,
+			ARRAY_SIZE(twl4030_carkitl_texts),
+			twl4030_carkitl_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_carkitl_control =
+SOC_DAPM_ENUM("Route", twl4030_carkitl_enum);
+
+/* Carkit Right */
+static const char *twl4030_carkitr_texts[] =
+		{"Off", "DACR1", "DACR2"};
+
+static const struct soc_enum twl4030_carkitr_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_PRECKR_CTL, 1,
+			ARRAY_SIZE(twl4030_carkitr_texts),
+			twl4030_carkitr_texts);
+
+static const struct snd_kcontrol_new twl4030_dapm_carkitr_control =
+SOC_DAPM_ENUM("Route", twl4030_carkitr_enum);
+
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -751,6 +775,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		&twl4030_dapm_hsol_control),
 	SND_SOC_DAPM_MUX("HeadsetR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_hsor_control),
+	/* CarkitL/R */
+	SND_SOC_DAPM_MUX("CarkitL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_carkitl_control),
+	SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_carkitr_control),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -781,6 +810,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* HeadsetR */
 	{"HeadsetR Mux", "DACR1", "ARXR1_APGA"},
 	{"HeadsetR Mux", "DACR2", "ARXR2_APGA"},
+	/* CarkitL */
+	{"CarkitL Mux", "DACL1", "ARXL1_APGA"},
+	{"CarkitL Mux", "DACL2", "ARXL2_APGA"},
+	/* CarkitR */
+	{"CarkitR Mux", "DACR1", "ARXR1_APGA"},
+	{"CarkitR Mux", "DACR2", "ARXR2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
@@ -790,6 +825,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"PREDRIVER", NULL, "PredriveR Mux"},
 	{"HSOL", NULL, "HeadsetL Mux"},
 	{"HSOR", NULL, "HeadsetR Mux"},
+	{"CARKITL", NULL, "CarkitL Mux"},
+	{"CARKITR", NULL, "CarkitR Mux"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.5.6.5
