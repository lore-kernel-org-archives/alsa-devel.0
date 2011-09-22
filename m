From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/10] ASoC: twl6040: Earphone path
	correction
Date: Thu, 22 Sep 2011 11:05:49 +0300
Message-ID: <1316678754-11935-6-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E45210399F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:27 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so2711324bka.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:26 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix the DAPM routing for the earphone path.
Convert the DAPM_SWITCH_E to DAPM_OUT_DRV_E, so we can have correct
power up, and down sequence for EP.
Introduce mute control (Earphone Playback Switch) for users to
enable/disable the EP path.
Note: the EP does not have it's own dedicated DAC. EP is connected to
HSL DAC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9635466..3450b11 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -61,6 +61,9 @@
 #define TWL6040_REG_SW_SHADOW	0x2F
 #define TWL6040_CACHEREGNUM	(TWL6040_REG_SW_SHADOW + 1)
 
+/* TWL6040_REG_SW_SHADOW (0x2F) fields */
+#define TWL6040_EAR_PATH_ENABLE	0x01
+
 struct twl6040_output {
 	u16 active;
 	u16 left_vol;
@@ -991,8 +994,8 @@ static const struct snd_kcontrol_new hfl_mux_controls =
 static const struct snd_kcontrol_new hfr_mux_controls =
 	SOC_DAPM_ENUM("Route", twl6040_hf_enum[1]);
 
-static const struct snd_kcontrol_new ep_driver_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_EARCTL, 0, 1, 0);
+static const struct snd_kcontrol_new ep_path_enable_control =
+	SOC_DAPM_SINGLE("Switch", TWL6040_REG_SW_SHADOW, 0, 1, 0);
 
 /* Headset power mode */
 static const char *twl6040_power_mode_texts[] = {
@@ -1165,6 +1168,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("HS Right Playback",
 			SND_SOC_NOPM, 0, 0, &hsr_mux_controls),
 
+	SND_SOC_DAPM_SWITCH("Earphone Playback", SND_SOC_NOPM, 0, 0,
+			&ep_path_enable_control),
+
 	/* Analog playback drivers */
 	SND_SOC_DAPM_OUT_DRV_E("Handsfree Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
@@ -1182,8 +1188,8 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_SWITCH_E("Earphone Driver",
-			SND_SOC_NOPM, 0, 0, &ep_driver_switch_controls,
+	SND_SOC_DAPM_OUT_DRV_E("Earphone Driver",
+			TWL6040_REG_EARCTL, 0, 0, NULL, 0,
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
@@ -1228,7 +1234,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSOR", NULL, "Headset Right Driver"},
 
 	/* Earphone playback path */
-	{"Earphone Driver", "Switch", "HSDAC Left"},
+	{"Earphone Playback", "Switch", "HSDAC Left"},
+	{"Earphone Driver", NULL, "Earphone Playback"},
 	{"EP", NULL, "Earphone Driver"},
 
 	{"HF Left Playback", "HF DAC", "HFDAC Left"},
-- 
1.7.6.1
