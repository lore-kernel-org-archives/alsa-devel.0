From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: ASoC: OMAP4: Add support for Earphone speaker
Date: Tue, 18 May 2010 09:23:56 -0500
Message-ID: <1274192636-1430-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E0B5410387D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 16:36:02 +0200 (CEST)
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add control to enable earphone driver in TWL6040 codec. This driver
is connected to HSDAC Left.

Also enable earphone speaker in sdp4430 machine driver.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   21 ++++++++++++++++++++-
 sound/soc/omap/sdp4430.c   |    5 +++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 2ae442e..af36346 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -432,6 +432,12 @@ static DECLARE_TLV_DB_SCALE(hs_tlv, -3000, 200, 0);
  */
 static DECLARE_TLV_DB_SCALE(hf_tlv, -5200, 200, 0);
 
+/*
+ * EPGAIN volume control:
+ * from -24 to 6 dB in 2 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(ep_tlv, -2400, 200, 0);
+
 /* Left analog microphone selection */
 static const char *twl6040_amicl_texts[] =
 	{"Headset Mic", "Main Mic", "Aux/FM Left", "Off"};
@@ -479,6 +485,9 @@ static const struct snd_kcontrol_new hfl_driver_switch_controls =
 static const struct snd_kcontrol_new hfr_driver_switch_controls =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFRCTL, 4, 1, 0);
 
+static const struct snd_kcontrol_new ep_driver_switch_controls =
+	SOC_DAPM_SINGLE("Switch", TWL6040_REG_EARCTL, 0, 1, 0);
+
 static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	/* Capture gains */
 	SOC_DOUBLE_TLV("Capture Preamplifier Volume",
@@ -491,7 +500,8 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
 	SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
 		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
-
+	SOC_SINGLE_TLV("Earphone Playback Volume",
+		TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
 };
 
 static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
@@ -507,6 +517,7 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HSOR"),
 	SND_SOC_DAPM_OUTPUT("HFL"),
 	SND_SOC_DAPM_OUTPUT("HFR"),
+	SND_SOC_DAPM_OUTPUT("EP"),
 
 	/* Analog input muxes for the capture amplifiers */
 	SND_SOC_DAPM_MUX("Analog Left Capture Route",
@@ -572,6 +583,10 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls,
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SWITCH_E("Earphone Driver",
+			SND_SOC_NOPM, 0, 0, &ep_driver_switch_controls,
+			twl6040_power_mode_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback PGAs */
 	SND_SOC_DAPM_PGA("HFDAC Left PGA",
@@ -607,6 +622,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSOL", NULL, "Headset Left Driver"},
 	{"HSOR", NULL, "Headset Right Driver"},
 
+	/* Earphone playback path */
+	{"Earphone Driver", "Switch", "HSDAC Left"},
+	{"EP", NULL, "Earphone Driver"},
+
 	/* Handsfree playback path */
 	{"HFDAC Left Playback", "Switch", "HFDAC Left"},
 	{"HFDAC Right Playback", "Switch", "HFDAC Right"},
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 83831ee..ab45621 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -101,6 +101,7 @@ static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -120,6 +121,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	/* Headset Stereophone (Headphone): HSOL, HSOR */
 	{"Headset Stereophone", NULL, "HSOL"},
 	{"Headset Stereophone", NULL, "HSOR"},
+
+	/* Earphone speaker */
+	{"Earphone Spk", NULL, "EP"},
+
 };
 
 static int sdp4430_twl6040_init(struct snd_soc_codec *codec)
-- 
1.6.3.3
