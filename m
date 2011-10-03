From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Move bias level decision into main
	dapm_power_widgets()
Date: Mon,  3 Oct 2011 21:32:15 +0100
Message-ID: <1317673938-11716-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2433410392D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 22:32:23 +0200 (CEST)
In-Reply-To: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Future patches will try to reduce the number of widgets we check on each
DAPM run but we're still going to need to look and see if the devices is
on at all so we can manage the overall device bias. Move these checks out
into the main dapm_power_widgets() function so we don't have to think about
them for now.

Once we're doing more incremental updates it'll probably be worth using
refcounts for each bias level to avoid having to do the sweep over all
widgets but that's not going to be where the big performance wins are.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcbd468..12bd01a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1218,7 +1218,6 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 				  struct list_head *up_list,
 				  struct list_head *down_list)
 {
-	struct snd_soc_dapm_context *d;
 	int power;
 
 	switch (w->id) {
@@ -1238,26 +1237,6 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 		else
 			power = 1;
 
-		if (power) {
-			d = w->dapm;
-
-			/* Supplies and micbiases only bring the
-			 * context up to STANDBY as unless something
-			 * else is active and passing audio they
-			 * generally don't require full power.
-			 */
-			switch (w->id) {
-			case snd_soc_dapm_supply:
-			case snd_soc_dapm_micbias:
-				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
-					d->target_bias_level = SND_SOC_BIAS_STANDBY;
-				break;
-			default:
-				d->target_bias_level = SND_SOC_BIAS_ON;
-				break;
-			}
-		}
-
 		dapm_widget_set_power(w, power, up_list, down_list);
 		break;
 	}
@@ -1302,6 +1281,29 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		dapm_power_one_widget(w, &up_list, &down_list);
 	}
 
+	list_for_each_entry(w, &card->widgets, list) {
+		if (w->power) {
+			d = w->dapm;
+
+			/* Supplies and micbiases only bring the
+			 * context up to STANDBY as unless something
+			 * else is active and passing audio they
+			 * generally don't require full power.
+			 */
+			switch (w->id) {
+			case snd_soc_dapm_supply:
+			case snd_soc_dapm_micbias:
+				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
+					d->target_bias_level = SND_SOC_BIAS_STANDBY;
+				break;
+			default:
+				d->target_bias_level = SND_SOC_BIAS_ON;
+				break;
+			}
+		}
+
+	}
+
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
 	 */
-- 
1.7.6.3
