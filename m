From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Factor out per-widget DAPM power checks
Date: Tue, 20 Sep 2011 22:23:06 +0100
Message-ID: <1316553786-28810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EAAC103A63
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 23:23:13 +0200 (CEST)
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

The indentation is getting a little deep. Should be straight code motion,
no functional changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |  112 +++++++++++++++++++++++++++-----------------------
 1 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6a1e13e..84d1d79 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1191,6 +1191,65 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	}
 }
 
+static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
+				  struct list_head *up_list,
+				  struct list_head *down_list)
+{
+	struct snd_soc_dapm_context *d;
+	int power;
+
+	switch (w->id) {
+	case snd_soc_dapm_pre:
+		dapm_seq_insert(w, down_list, false);
+		break;
+	case snd_soc_dapm_post:
+		dapm_seq_insert(w, up_list, true);
+		break;
+
+	default:
+		if (!w->power_check)
+			break;
+
+		if (!w->force)
+			power = w->power_check(w);
+		else
+			power = 1;
+
+		if (power) {
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
+		if (w->power == power)
+			break;
+
+		trace_snd_soc_dapm_widget_power(w, power);
+
+		if (power)
+			dapm_seq_insert(w, up_list, true);
+		else
+			dapm_seq_insert(w, down_list, false);
+
+		w->power = power;
+		break;
+	}
+}
+
 /*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
@@ -1209,7 +1268,6 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	LIST_HEAD(down_list);
 	LIST_HEAD(async_domain);
 	enum snd_soc_bias_level bias;
-	int power;
 
 	trace_snd_soc_dapm_start(card);
 
@@ -1228,57 +1286,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	 * lists indicating if they should be powered up or down.
 	 */
 	list_for_each_entry(w, &card->widgets, list) {
-		switch (w->id) {
-		case snd_soc_dapm_pre:
-			dapm_seq_insert(w, &down_list, false);
-			break;
-		case snd_soc_dapm_post:
-			dapm_seq_insert(w, &up_list, true);
-			break;
-
-		default:
-			if (!w->power_check)
-				continue;
-
-			if (!w->force)
-				power = w->power_check(w);
-			else
-				power = 1;
-
-			if (power) {
-				d = w->dapm;
-
-				/* Supplies and micbiases only bring
-				 * the context up to STANDBY as unless
-				 * something else is active and
-				 * passing audio they generally don't
-				 * require full power.
-				 */
-				switch (w->id) {
-				case snd_soc_dapm_supply:
-				case snd_soc_dapm_micbias:
-					if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
-						d->target_bias_level = SND_SOC_BIAS_STANDBY;
-					break;
-				default:
-					d->target_bias_level = SND_SOC_BIAS_ON;
-					break;
-				}
-			}
-
-			if (w->power == power)
-				continue;
-
-			trace_snd_soc_dapm_widget_power(w, power);
-
-			if (power)
-				dapm_seq_insert(w, &up_list, true);
-			else
-				dapm_seq_insert(w, &down_list, false);
-
-			w->power = power;
-			break;
-		}
+		dapm_power_one_widget(w, &up_list, &down_list);
 	}
 
 	/* If there are no DAPM widgets then try to figure out power from the
-- 
1.7.6.3
