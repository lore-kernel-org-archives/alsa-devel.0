From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add DAPM trace events
Date: Wed, 10 Nov 2010 16:39:06 +0000
Message-ID: <1289407146-20250-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1289407146-20250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53FFA103894
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 17:39:11 +0100 (CET)
In-Reply-To: <1289407146-20250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Trace events for DAPM allow us to monitor the performance and behaviour
of DAPM with logging which can be built into the kernel permanantly, is
more suited to automated analysis and display and less likely to suffer
interference from other logging activity.

Currently trace events are generated for:

- Start and stop of DAPM processing
- Start and stop of bias level changes
- Power decisions for widgets
- Widget event execution start and stop

giving some view as to what is happening and where latencies occur.

Actual changes in widget power can be seen via the register write trace in
soc-core.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/trace/events/asoc.h |  112 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c        |   14 +++++
 2 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 93c3371..9978856 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -8,6 +8,8 @@
 #include <linux/tracepoint.h>
 
 struct snd_soc_codec;
+struct snd_soc_card;
+struct snd_soc_dapm_widget;
 
 /*
  * Log register events
@@ -56,7 +58,117 @@ DEFINE_EVENT(snd_soc_reg, snd_soc_reg_read,
 
 );
 
+DECLARE_EVENT_CLASS(snd_soc_card,
 
+	TP_PROTO(struct snd_soc_card *card, int val),
+
+	TP_ARGS(card, val),
+
+	TP_STRUCT__entry(
+		__string(	name,		card->name	)
+		__field(	int,		val		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, card->name);
+		__entry->val = val;
+	),
+
+	TP_printk("card=%s val=%d", __get_str(name), (int)__entry->val)
+);
+
+DEFINE_EVENT(snd_soc_card, snd_soc_bias_level_start,
+
+	TP_PROTO(struct snd_soc_card *card, int val),
+
+	TP_ARGS(card, val)
+
+);
+
+DEFINE_EVENT(snd_soc_card, snd_soc_bias_level_done,
+
+	TP_PROTO(struct snd_soc_card *card, int val),
+
+	TP_ARGS(card, val)
+
+);
+
+DECLARE_EVENT_CLASS(snd_soc_dapm_basic,
+
+	TP_PROTO(struct snd_soc_card *card),
+
+	TP_ARGS(card),
+
+	TP_STRUCT__entry(
+		__string(	name,	card->name	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, card->name);
+	),
+
+	TP_printk("card=%s", __get_str(name))
+);
+
+DEFINE_EVENT(snd_soc_dapm_basic, snd_soc_dapm_start,
+
+	TP_PROTO(struct snd_soc_card *card),
+
+	TP_ARGS(card)
+
+);
+
+DEFINE_EVENT(snd_soc_dapm_basic, snd_soc_dapm_done,
+
+	TP_PROTO(struct snd_soc_card *card),
+
+	TP_ARGS(card)
+
+);
+
+DECLARE_EVENT_CLASS(snd_soc_dapm_widget,
+
+	TP_PROTO(struct snd_soc_dapm_widget *w, int val),
+
+	TP_ARGS(w, val),
+
+	TP_STRUCT__entry(
+		__string(	name,	w->name		)
+		__field(	int,	val		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, w->name);
+		__entry->val = val;
+	),
+
+	TP_printk("widget=%s val=%d", __get_str(name),
+		  (int)__entry->val)
+);
+
+DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_power,
+
+	TP_PROTO(struct snd_soc_dapm_widget *w, int val),
+
+	TP_ARGS(w, val)
+
+);
+
+DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_event_start,
+
+	TP_PROTO(struct snd_soc_dapm_widget *w, int val),
+
+	TP_ARGS(w, val)
+
+);
+
+DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_event_done,
+
+	TP_PROTO(struct snd_soc_dapm_widget *w, int val),
+
+	TP_ARGS(w, val)
+
+);
 
 #endif /* _TRACE_ASOC_H */
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a5db3f..8352430 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -46,6 +46,8 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
+#include <trace/events/asoc.h>
+
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
@@ -151,6 +153,8 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
+	trace_snd_soc_bias_level_start(card, level);
+
 	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, level);
 	if (ret == 0) {
@@ -160,6 +164,8 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
 			dapm->bias_level = level;
 	}
 
+	trace_snd_soc_bias_level_done(card, level);
+
 	return ret;
 }
 
@@ -761,7 +767,9 @@ static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
 	if (w->event && (w->event_flags & event)) {
 		pop_dbg(dapm->dev, card->pop_time, "pop test : %s %s\n",
 			w->name, ev_name);
+		trace_snd_soc_dapm_widget_event_start(w, event);
 		ret = w->event(w, NULL, event);
+		trace_snd_soc_dapm_widget_event_done(w, event);
 		if (ret < 0)
 			pr_err("%s: %s event failed: %d\n",
 			       ev_name, w->name, ret);
@@ -921,6 +929,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	int power;
 	int sys_power = 0;
 
+	trace_snd_soc_dapm_start(card);
+
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
@@ -947,6 +957,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			if (w->power == power)
 				continue;
 
+			trace_snd_soc_dapm_widget_power(w, power);
+
 			if (power)
 				dapm_seq_insert(w, &up_list, dapm_up_seq);
 			else
@@ -1037,6 +1049,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
 
+	trace_snd_soc_dapm_done(card);
+
 	return 0;
 }
 
-- 
1.7.1
