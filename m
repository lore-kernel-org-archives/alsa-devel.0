From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Refector DAPM event handler
Date: Thu, 17 Jul 2008 11:59:35 +0100
Message-ID: <1216292376-2583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2D8D10381B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 12:59:37 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DAPM event callback code has many layers of indentation. Refector
the code to give less indentation in order to facilitiate further
refactoring.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   76 +++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c87061..9307b10 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -587,44 +587,44 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			w->power = power;
 
 			/* call any power change event handlers */
-			if (power_change) {
-				if (w->event) {
-					pr_debug("power %s event for %s flags %x\n",
-						 w->power ? "on" : "off", w->name, w->event_flags);
-					if (power) {
-						/* power up event */
-						if (w->event_flags & SND_SOC_DAPM_PRE_PMU) {
-							ret = w->event(w,
-								NULL, SND_SOC_DAPM_PRE_PMU);
-							if (ret < 0)
-								return ret;
-						}
-						dapm_update_bits(w);
-						if (w->event_flags & SND_SOC_DAPM_POST_PMU){
-							ret = w->event(w,
-								NULL, SND_SOC_DAPM_POST_PMU);
-							if (ret < 0)
-								return ret;
-						}
-					} else {
-						/* power down event */
-						if (w->event_flags & SND_SOC_DAPM_PRE_PMD) {
-							ret = w->event(w,
-								NULL, SND_SOC_DAPM_PRE_PMD);
-							if (ret < 0)
-								return ret;
-						}
-						dapm_update_bits(w);
-						if (w->event_flags & SND_SOC_DAPM_POST_PMD) {
-							ret = w->event(w,
-								NULL, SND_SOC_DAPM_POST_PMD);
-							if (ret < 0)
-								return ret;
-						}
-					}
-				} else
-					/* no event handler */
-					dapm_update_bits(w);
+			if (power_change && w->event)
+				pr_debug("power %s event for %s flags %x\n",
+					 w->power ? "on" : "off",
+					 w->name, w->event_flags);
+
+			/* power up pre event */
+			if (power_change && power && w->event &&
+			    w->event_flags & SND_SOC_DAPM_PRE_PMU) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
+				if (ret < 0)
+					return ret;
+			}
+
+			/* power down pre event */
+			if (power_change && !power && w->event &&
+			    w->event_flags & SND_SOC_DAPM_PRE_PMD) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
+				if (ret < 0)
+					return ret;
+			}
+
+			dapm_update_bits(w);
+
+			/* power up post event */
+			if (power_change && power && w->event &&
+			    w->event_flags & SND_SOC_DAPM_POST_PMU){
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_POST_PMU);
+				if (ret < 0)
+					return ret;
+			}
+
+			/* power down post event */
+			if (power_change && !power && w->event &&
+			    w->event_flags & SND_SOC_DAPM_POST_PMD) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
+				if (ret < 0)
+					return ret;
 			}
 		}
 	}
-- 
1.5.6.2
