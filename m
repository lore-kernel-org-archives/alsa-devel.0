From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 12/17] ASoC: twl6040: Use consistent names for
	Handsfree path
Date: Thu, 15 Sep 2011 15:39:34 +0300
Message-ID: <1316090379-30760-13-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B1A1103BBB
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:39 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so2354209bkb.9
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:38 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Use "Handsfree XYZ" for user visible controls, while the internal DAPM
widgets can use "HF XYZ".
In this way we can group the Handsfree related controls in UI
(alsamixer for example).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 8b908ab..858bfd4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1154,9 +1154,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_MUX("HF Left Playback",
+	SND_SOC_DAPM_MUX("Handsfree Left Playback",
 			SND_SOC_NOPM, 0, 0, &hfl_mux_controls),
-	SND_SOC_DAPM_MUX("HF Right Playback",
+	SND_SOC_DAPM_MUX("Handsfree Right Playback",
 			SND_SOC_NOPM, 0, 0, &hfr_mux_controls),
 	/* Analog playback Muxes */
 	SND_SOC_DAPM_MUX("HS Left Playback",
@@ -1168,11 +1168,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			&ep_path_enable_control),
 
 	/* Analog playback drivers */
-	SND_SOC_DAPM_OUT_DRV_E("Handsfree Left Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HF Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("Handsfree Right Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HF Right Driver",
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1190,9 +1190,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback PGAs */
-	SND_SOC_DAPM_PGA("HFDAC Left PGA",
+	SND_SOC_DAPM_PGA("HF Left PGA",
 			TWL6040_REG_HFLCTL, 1, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HFDAC Right PGA",
+	SND_SOC_DAPM_PGA("HF Right PGA",
 			TWL6040_REG_HFRCTL, 1, 0, NULL, 0),
 
 };
@@ -1234,20 +1234,20 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earphone Driver", NULL, "Earphone Playback"},
 	{"EP", NULL, "Earphone Driver"},
 
-	{"HF Left Playback", "HF DAC", "HFDAC Left"},
-	{"HF Left Playback", "Line-In amp", "AFMAmpL"},
+	{"Handsfree Left Playback", "HF DAC", "HFDAC Left"},
+	{"Handsfree Left Playback", "Line-In amp", "AFMAmpL"},
 
-	{"HF Right Playback", "HF DAC", "HFDAC Right"},
-	{"HF Right Playback", "Line-In amp", "AFMAmpR"},
+	{"Handsfree Right Playback", "HF DAC", "HFDAC Right"},
+	{"Handsfree Right Playback", "Line-In amp", "AFMAmpR"},
 
-	{"HFDAC Left PGA", NULL, "HF Left Playback"},
-	{"HFDAC Right PGA", NULL, "HF Right Playback"},
+	{"HF Left PGA", NULL, "Handsfree Left Playback"},
+	{"HF Right PGA", NULL, "Handsfree Right Playback"},
 
-	{"Handsfree Left Driver", "Switch", "HFDAC Left PGA"},
-	{"Handsfree Right Driver", "Switch", "HFDAC Right PGA"},
+	{"HF Left Driver", NULL, "HF Left PGA"},
+	{"HF Right Driver", NULL, "HF Right PGA"},
 
-	{"HFL", NULL, "Handsfree Left Driver"},
-	{"HFR", NULL, "Handsfree Right Driver"},
+	{"HFL", NULL, "HF Left Driver"},
+	{"HFR", NULL, "HF Right Driver"},
 };
 
 static int twl6040_add_widgets(struct snd_soc_codec *codec)
-- 
1.7.6.1
