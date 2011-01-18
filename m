From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Explicitly say if we're powering up
	or down
Date: Tue, 18 Jan 2011 16:20:12 +0000
Message-ID: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FF0524747
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 17:20:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Rather than passing the sequence to use for DAPM widgets around by reference
explicitly say if we're powering up or down until the point where we need
the sequence itself. This should make no practical difference in itself but
supports future refactoring.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 499730a..57e1c9f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -726,8 +726,15 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 
 static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 			    struct snd_soc_dapm_widget *b,
-			    int sort[])
+			    bool power_up)
 {
+	int *sort;
+
+	if (power_up)
+		sort = dapm_up_seq;
+	else
+		sort = dapm_down_seq;
+
 	if (sort[a->id] != sort[b->id])
 		return sort[a->id] - sort[b->id];
 	if (a->reg != b->reg)
@@ -741,12 +748,12 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 /* Insert a widget in order into a DAPM power sequence. */
 static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 			    struct list_head *list,
-			    int sort[])
+			    bool power_up)
 {
 	struct snd_soc_dapm_widget *w;
 
 	list_for_each_entry(w, list, power_list)
-		if (dapm_seq_compare(new_widget, w, sort) < 0) {
+		if (dapm_seq_compare(new_widget, w, power_up) < 0) {
 			list_add_tail(&new_widget->power_list, &w->power_list);
 			return;
 		}
@@ -857,7 +864,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
  * handled.
  */
 static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
-			 struct list_head *list, int event, int sort[])
+			 struct list_head *list, int event, bool power_up)
 {
 	struct snd_soc_dapm_widget *w, *n;
 	LIST_HEAD(pending);
@@ -865,6 +872,12 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	int cur_reg = SND_SOC_NOPM;
 	struct snd_soc_dapm_context *cur_dapm = NULL;
 	int ret;
+	int *sort;
+
+	if (power_up)
+		sort = dapm_up_seq;
+	else
+		sort = dapm_down_seq;
 
 	list_for_each_entry_safe(w, n, list, power_list) {
 		ret = 0;
@@ -1002,10 +1015,10 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	list_for_each_entry(w, &card->widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
-			dapm_seq_insert(w, &down_list, dapm_down_seq);
+			dapm_seq_insert(w, &down_list, false);
 			break;
 		case snd_soc_dapm_post:
-			dapm_seq_insert(w, &up_list, dapm_up_seq);
+			dapm_seq_insert(w, &up_list, true);
 			break;
 
 		default:
@@ -1025,9 +1038,9 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			trace_snd_soc_dapm_widget_power(w, power);
 
 			if (power)
-				dapm_seq_insert(w, &up_list, dapm_up_seq);
+				dapm_seq_insert(w, &up_list, true);
 			else
-				dapm_seq_insert(w, &down_list, dapm_down_seq);
+				dapm_seq_insert(w, &down_list, false);
 
 			w->power = power;
 			break;
@@ -1086,12 +1099,12 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(dapm, &down_list, event, dapm_down_seq);
+	dapm_seq_run(dapm, &down_list, event, false);
 
 	dapm_widget_update(dapm);
 
 	/* Now power up. */
-	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
+	dapm_seq_run(dapm, &up_list, event, true);
 
 	list_for_each_entry(d, &dapm->card->dapm_list, list) {
 		/* If we just powered the last thing off drop to standby bias */
@@ -2372,7 +2385,7 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 		if (w->dapm != dapm)
 			continue;
 		if (w->power) {
-			dapm_seq_insert(w, &down_list, dapm_down_seq);
+			dapm_seq_insert(w, &down_list, false);
 			w->power = 0;
 			powerdown = 1;
 		}
@@ -2383,7 +2396,7 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 	 */
 	if (powerdown) {
 		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_PREPARE);
-		dapm_seq_run(dapm, &down_list, 0, dapm_down_seq);
+		dapm_seq_run(dapm, &down_list, 0, false);
 		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_STANDBY);
 	}
 }
-- 
1.7.2.3
