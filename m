From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Refector DAPM event handler
Date: Thu, 17 Jul 2008 15:06:50 +0100
Message-ID: <1216303611-5815-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1372310380F
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 16:06:53 +0200 (CEST)
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

The DAPM event callback code has many layers of indentation, taking it
over 80 columns. Refactor the code to give less indentation in order to
avoid checkpatch issues on further changes and exploding indentation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   79 ++++++++++++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c87061..17698ef 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -586,45 +586,48 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			power_change = (w->power == power) ? 0: 1;
 			w->power = power;
 
+			if (!power_change)
+				continue;
+
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
+			if (w->event)
+				pr_debug("power %s event for %s flags %x\n",
+					 w->power ? "on" : "off",
+					 w->name, w->event_flags);
+
+			/* power up pre event */
+			if (power && w->event &&
+			    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
+				if (ret < 0)
+					return ret;
+			}
+
+			/* power down pre event */
+			if (!power && w->event &&
+			    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
+				if (ret < 0)
+					return ret;
+			}
+
+			dapm_update_bits(w);
+
+			/* power up post event */
+			if (power && w->event &&
+			    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_POST_PMU);
+				if (ret < 0)
+					return ret;
+			}
+
+			/* power down post event */
+			if (!power && w->event &&
+			    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
+				ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
+				if (ret < 0)
+					return ret;
 			}
 		}
 	}
-- 
1.5.6.2
