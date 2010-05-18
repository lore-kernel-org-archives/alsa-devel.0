From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v2 2/2] ASoC: TWL6040: Enable earphone path in
	codec
Date: Tue, 18 May 2010 12:44:18 -0500
Message-ID: <1274204658-31614-3-git-send-email-jorge.candelaria@ti.com>
References: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
	<1274204658-31614-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id A6741103893
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 19:56:24 +0200 (CEST)
In-Reply-To: <1274204658-31614-2-git-send-email-jorge.candelaria@ti.com>
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

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

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
-- 
1.6.3.3
