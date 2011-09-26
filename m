From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/10] ASoC: twl6040: Rename pga_event to
	out_drv_event
Date: Mon, 26 Sep 2011 16:26:24 +0300
Message-ID: <1317043593-27202-2-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 49C57243A9
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:46 +0200 (CEST)
Received: by mail-bw0-f47.google.com with SMTP id 11so6162532bke.20
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:44 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
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

This event handler is used with the OUT_DRV widgets.
The name pga_event was misleading.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d5c4bb4..b63ee24 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -72,7 +72,6 @@ struct twl6040_output {
 	u16 right_step;
 	unsigned int step_delay;
 	u16 ramp;
-	u16 mute;
 	struct completion ramp_done;
 };
 
@@ -573,7 +572,7 @@ static void twl6040_pga_hf_work(struct work_struct *work)
 	handsfree->ramp = TWL6040_RAMP_NONE;
 }
 
-static int pga_event(struct snd_soc_dapm_widget *w,
+static int out_drv_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
@@ -1248,19 +1247,19 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	/* Analog playback drivers */
 	SND_SOC_DAPM_OUT_DRV_E("HF Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
-			pga_event,
+			out_drv_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUT_DRV_E("HF Right Driver",
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
-			pga_event,
+			out_drv_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUT_DRV_E("HS Left Driver",
 			TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
-			pga_event,
+			out_drv_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUT_DRV_E("HS Right Driver",
 			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
-			pga_event,
+			out_drv_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUT_DRV_E("Earphone Driver",
 			TWL6040_REG_EARCTL, 0, 0, NULL, 0,
-- 
1.7.6.1
