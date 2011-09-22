From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/10] ASoC: twl6040: Support for AUX L/R
	output
Date: Thu, 22 Sep 2011 11:05:52 +0300
Message-ID: <1316678754-11935-9-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id ECFD5103B0B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:34 +0200 (CEST)
Received: by mail-bw0-f42.google.com with SMTP id r4so4861248bka.1
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:33 -0700 (PDT)
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

AUX L/R outputs can be driver from the Handsfree PGA output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index fffd7ff..3908b88 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -997,6 +997,12 @@ static const struct snd_kcontrol_new hfr_mux_controls =
 static const struct snd_kcontrol_new ep_path_enable_control =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_SW_SHADOW, 0, 1, 0);
 
+static const struct snd_kcontrol_new auxl_switch_control =
+	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFLCTL, 6, 1, 0);
+
+static const struct snd_kcontrol_new auxr_switch_control =
+	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFRCTL, 6, 1, 0);
+
 /* Headset power mode */
 static const char *twl6040_power_mode_texts[] = {
 	"Low-Power", "High-Perfomance",
@@ -1105,6 +1111,8 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HFL"),
 	SND_SOC_DAPM_OUTPUT("HFR"),
 	SND_SOC_DAPM_OUTPUT("EP"),
+	SND_SOC_DAPM_OUTPUT("AUXL"),
+	SND_SOC_DAPM_OUTPUT("AUXR"),
 
 	/* Analog input muxes for the capture amplifiers */
 	SND_SOC_DAPM_MUX("Analog Left Capture Route",
@@ -1170,6 +1178,10 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SWITCH("Earphone Playback", SND_SOC_NOPM, 0, 0,
 			&ep_path_enable_control),
+	SND_SOC_DAPM_SWITCH("AUXL Playback", SND_SOC_NOPM, 0, 0,
+			&auxl_switch_control),
+	SND_SOC_DAPM_SWITCH("AUXR Playback", SND_SOC_NOPM, 0, 0,
+			&auxr_switch_control),
 
 	/* Analog playback drivers */
 	SND_SOC_DAPM_OUT_DRV_E("HF Left Driver",
@@ -1252,6 +1264,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	{"HFL", NULL, "HF Left Driver"},
 	{"HFR", NULL, "HF Right Driver"},
+
+	{"AUXL Playback", "Switch", "HF Left PGA"},
+	{"AUXR Playback", "Switch", "HF Right PGA"},
+
+	{"AUXL", NULL, "AUXL Playback"},
+	{"AUXR", NULL, "AUXR Playback"},
 };
 
 static int twl6040_add_widgets(struct snd_soc_codec *codec)
-- 
1.7.6.1
