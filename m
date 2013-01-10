From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Fix sense of regulator bypass mode
Date: Thu, 10 Jan 2013 19:36:12 +0000
Message-ID: <1357846572-12538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BF2B2616BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 20:36:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Enable bypass when the regulator is idle, not when it is in use. This is
consistent with what the few existing users actually want.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dc18d78..17dba18 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1023,7 +1023,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
-			ret = regulator_allow_bypass(w->regulator, true);
+			ret = regulator_allow_bypass(w->regulator, false);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
 					 "ASoC: Failed to bypass %s: %d\n",
@@ -1033,7 +1033,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 		return regulator_enable(w->regulator);
 	} else {
 		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
-			ret = regulator_allow_bypass(w->regulator, false);
+			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
 					 "ASoC: Failed to unbypass %s: %d\n",
@@ -3039,6 +3039,14 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 				w->name, ret);
 			return NULL;
 		}
+
+		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+			ret = regulator_allow_bypass(w->regulator, true);
+			if (ret != 0)
+				dev_warn(w->dapm->dev,
+					 "ASoC: Failed to unbypass %s: %d\n",
+					 w->name, ret);
+		}
 		break;
 	case snd_soc_dapm_clock_supply:
 #ifdef CONFIG_CLKDEV_LOOKUP
-- 
1.7.10.4
