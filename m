From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add another DAPM stat for neighbour
	checks
Date: Wed, 21 Sep 2011 18:20:02 +0100
Message-ID: <1316625602-30540-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEBA82434F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 19:20:55 +0200 (CEST)
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

The number of times we look at a potentially connected neighbour is just
as important as the number of times we actually recurse into looking at
that neighbour so also collect that statistic.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h    |    1 +
 include/trace/events/asoc.h |    7 +++++--
 sound/soc/soc-dapm.c        |    4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 0e2d017..bb59532 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -540,6 +540,7 @@ struct snd_soc_dapm_widget_list {
 struct snd_soc_dapm_stats {
 	int power_checks;
 	int path_checks;
+	int neighbour_checks;
 };
 
 #endif
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 2e1adf6..ab26f8a 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -226,16 +226,19 @@ TRACE_EVENT(snd_soc_dapm_walk_done,
 		__string(	name,	card->name		)
 		__field(	int,	power_checks		)
 		__field(	int,	path_checks		)
+		__field(	int,	neighbour_checks	)
 	),
 
 	TP_fast_assign(
 		__assign_str(name, card->name);
 		__entry->power_checks = card->dapm_stats.power_checks;
 		__entry->path_checks = card->dapm_stats.path_checks;
+		__entry->neighbour_checks = card->dapm_stats.neighbour_checks;
 	),
 
-	TP_printk("%s: %d power checks, %d path checks", __get_str(name),
-		  (int)__entry->power_checks, (int)__entry->path_checks)
+	TP_printk("%s: checks %d power, %d path, %d neighbour",
+		  __get_str(name), (int)__entry->power_checks,
+		  (int)__entry->path_checks, (int)__entry->neighbour_checks)
 );
 
 TRACE_EVENT(snd_soc_jack_irq,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 84d1d79..6cac045 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -677,6 +677,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
+		DAPM_UPDATE_STAT(widget, neighbour_checks);
+
 		if (path->weak)
 			continue;
 
@@ -732,6 +734,8 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
+		DAPM_UPDATE_STAT(widget, neighbour_checks);
+
 		if (path->weak)
 			continue;
 
-- 
1.7.6.3
