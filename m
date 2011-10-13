From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: twl6040: Remove PLL usage
	restrictions
Date: Thu, 13 Oct 2011 15:05:42 +0300
Message-ID: <1318507544-26856-3-git-send-email-peter.ujfalusi@ti.com>
References: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id B70BC10385F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 14:06:49 +0200 (CEST)
Received: by mail-ey0-f171.google.com with SMTP id 6so2655632eyb.30
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 05:06:48 -0700 (PDT)
In-Reply-To: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
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

There is no limitation dictated by outputs or inputs regarding to the
selected PLL (LP/HP).
Remove the checks for this, and allow all path with any PLL configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   40 +++++++++-------------------------------
 1 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d078099..8f033f0 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -87,7 +87,6 @@ struct twl6040_data {
 	int plug_irq;
 	int codec_powered;
 	int pll;
-	int non_lp;
 	int pll_power_mode;
 	int hs_power_mode;
 	int hs_power_mode_locked;
@@ -588,10 +587,6 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 		out->left_step = priv->hf_left_step;
 		out->right_step = priv->hf_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
-		if (SND_SOC_DAPM_EVENT_ON(event))
-			priv->non_lp++;
-		else
-			priv->non_lp--;
 		break;
 	default:
 		return -1;
@@ -686,18 +681,12 @@ static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
 	int ret = 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		priv->non_lp++;
-		if (!strcmp(w->name, "Earphone Driver")) {
-			/* Earphone doesn't support low power mode */
-			priv->hs_power_mode_locked = 1;
-			ret = headset_power_mode(codec, 1);
-		}
+		/* Earphone doesn't support low power mode */
+		priv->hs_power_mode_locked = 1;
+		ret = headset_power_mode(codec, 1);
 	} else {
-		priv->non_lp--;
-		if (!strcmp(w->name, "Earphone Driver")) {
-			priv->hs_power_mode_locked = 0;
-			ret = headset_power_mode(codec, priv->hs_power_mode);
-		}
+		priv->hs_power_mode_locked = 0;
+		ret = headset_power_mode(codec, priv->hs_power_mode);
 	}
 
 	msleep(1);
@@ -1125,14 +1114,10 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	/* DACs */
 	SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC_E("HFDAC Left", "Handsfree Playback",
-			TWL6040_REG_HFLCTL, 0, 0,
-			twl6040_power_mode_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_DAC_E("HFDAC Right", "Handsfree Playback",
-			TWL6040_REG_HFRCTL, 0, 0,
-			twl6040_power_mode_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC("HFDAC Left", "Handsfree Playback",
+			 TWL6040_REG_HFLCTL, 0, 0),
+	SND_SOC_DAPM_DAC("HFDAC Right", "Handsfree Playback",
+			 TWL6040_REG_HFRCTL, 0, 0),
 	/* Virtual DAC for vibra path (DL4 channel) */
 	SND_SOC_DAPM_DAC("VIBRA DAC", "Vibra Playback",
 			SND_SOC_NOPM, 0, 0),
@@ -1383,13 +1368,6 @@ static int twl6040_prepare(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if ((priv->sysclk == 17640000) && priv->non_lp) {
-			dev_err(codec->dev,
-				"some enabled paths aren't supported at %dHz\n",
-				priv->sysclk);
-			return -EPERM;
-	}
-
 	ret = twl6040_set_pll(twl6040, priv->pll, priv->clk_in, priv->sysclk);
 	if (ret) {
 		dev_err(codec->dev, "Can not set PLL (%d)\n", ret);
-- 
1.7.7
