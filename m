From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH] ASoC: twl6040: Convert HF and HS drivers to
 use DAPM OUT_DRV widget
Date: Mon, 20 Dec 2010 10:39:20 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4F6D2E0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 812D3244B1
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 17:39:23 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Make the phoenix HS and HF drivers use the new DAPM driver
widget in order to guarantee power ON/OFF order sequence.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 2f68f59..4bbf1b1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1138,19 +1138,19 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0, &hsr_mux_controls),
 
 	/* Analog playback drivers */
-	SND_SOC_DAPM_PGA_E("Handsfree Left Driver",
+	SND_SOC_DAPM_OUT_DRV_E("Handsfree Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_PGA_E("Handsfree Right Driver",
+	SND_SOC_DAPM_OUT_DRV_E("Handsfree Right Driver",
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_PGA_E("Headset Left Driver",
+	SND_SOC_DAPM_OUT_DRV_E("Headset Left Driver",
 			TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_PGA_E("Headset Right Driver",
+	SND_SOC_DAPM_OUT_DRV_E("Headset Right Driver",
 			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-- 
1.7.0.4
