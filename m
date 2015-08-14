From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Consolidate path trace events" to
	the asoc tree
Date: Fri, 14 Aug 2015 01:00:47 +0100
Message-ID: <E1ZQ2QR-0003Em-TH@finisterre>
References: <1437930302-2789-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A5F264F38
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:00:56 +0200 (CEST)
In-Reply-To: <1437930302-2789-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Consolidate path trace events

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6e588a0d839b51bae49852b68740a25cacc91978 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 11 Aug 2015 21:38:01 +0200
Subject: [PATCH] ASoC: dapm: Consolidate path trace events

The snd_soc_dapm_input_path and snd_soc_dapm_output_path trace events are
identical except for the direction. Instead of having two events have a
single one that has a field that contains the direction.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/trace/events/asoc.h | 53 +++++++++++++--------------------------------
 sound/soc/soc-dapm.c        |  9 --------
 2 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 88cf39d..317a1ed 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -8,6 +8,7 @@
 #include <linux/tracepoint.h>
 
 #define DAPM_DIRECT "(direct)"
+#define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
 struct snd_soc_jack;
 struct snd_soc_codec;
@@ -152,62 +153,38 @@ TRACE_EVENT(snd_soc_dapm_walk_done,
 		  (int)__entry->path_checks, (int)__entry->neighbour_checks)
 );
 
-TRACE_EVENT(snd_soc_dapm_output_path,
+TRACE_EVENT(snd_soc_dapm_path,
 
 	TP_PROTO(struct snd_soc_dapm_widget *widget,
+		enum snd_soc_dapm_direction dir,
 		struct snd_soc_dapm_path *path),
 
-	TP_ARGS(widget, path),
+	TP_ARGS(widget, dir, path),
 
 	TP_STRUCT__entry(
 		__string(	wname,	widget->name		)
 		__string(	pname,	path->name ? path->name : DAPM_DIRECT)
-		__string(	psname,	path->sink->name	)
-		__field(	int,	path_sink		)
+		__string(	pnname,	path->node[dir]->name	)
+		__field(	int,	path_node		)
 		__field(	int,	path_connect		)
+		__field(	int,	path_dir		)
 	),
 
 	TP_fast_assign(
 		__assign_str(wname, widget->name);
 		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
-		__assign_str(psname, path->sink->name);
+		__assign_str(pnname, path->node[dir]->name);
 		__entry->path_connect = path->connect;
-		__entry->path_sink = (long)path->sink;
+		__entry->path_node = (long)path->node[dir];
+		__entry->path_dir = dir;
 	),
 
-	TP_printk("%c%s -> %s -> %s",
-		(int) __entry->path_sink &&
+	TP_printk("%c%s %s %s %s %s",
+		(int) __entry->path_node &&
 		(int) __entry->path_connect ? '*' : ' ',
-		__get_str(wname), __get_str(pname), __get_str(psname))
-);
-
-TRACE_EVENT(snd_soc_dapm_input_path,
-
-	TP_PROTO(struct snd_soc_dapm_widget *widget,
-		struct snd_soc_dapm_path *path),
-
-	TP_ARGS(widget, path),
-
-	TP_STRUCT__entry(
-		__string(	wname,	widget->name		)
-		__string(	pname,	path->name ? path->name : DAPM_DIRECT)
-		__string(	psname,	path->source->name	)
-		__field(	int,	path_source		)
-		__field(	int,	path_connect		)
-	),
-
-	TP_fast_assign(
-		__assign_str(wname, widget->name);
-		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
-		__assign_str(psname, path->source->name);
-		__entry->path_connect = path->connect;
-		__entry->path_source = (long)path->source;
-	),
-
-	TP_printk("%c%s <- %s <- %s",
-		(int) __entry->path_source &&
-		(int) __entry->path_connect ? '*' : ' ',
-		__get_str(wname), __get_str(pname), __get_str(psname))
+		__get_str(wname), DAPM_ARROW(__entry->path_dir),
+		__get_str(pname), DAPM_ARROW(__entry->path_dir),
+		__get_str(pnname))
 );
 
 TRACE_EVENT(snd_soc_dapm_connected,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 27b7fd9..cf2a069 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1047,15 +1047,6 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	return 0;
 }
 
-static void trace_snd_soc_dapm_path(struct snd_soc_dapm_widget *w,
-	enum snd_soc_dapm_direction dir, struct snd_soc_dapm_path *p)
-{
-	if (dir == SND_SOC_DAPM_DIR_IN)
-		trace_snd_soc_dapm_input_path(w, p);
-	else
-		trace_snd_soc_dapm_output_path(w, p);
-}
-
 /*
  * Common implementation for is_connected_output_ep() and
  * is_connected_input_ep(). The function is inlined since the combined size of
-- 
2.5.0
