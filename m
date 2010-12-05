From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add trace events for jack detection
Date: Sun,  5 Dec 2010 12:28:24 +0000
Message-ID: <1291552104-22230-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66BA32453A
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2010 13:28:16 +0100 (CET)
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

As jack detection can trigger DAPM and the latency in debouncing can create
confusing windows in operation provide some trace events which will hopefully
help in diagnostics. The soc-jack core traces all reports that it gets and
the resulting notifications to upper layers. An event for jack IRQs is also
provided for instrumentation of debounce, and used in the GPIO jack code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/trace/events/asoc.h |   58 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-jack.c        |    7 +++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 9978856..4a7ab26 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -170,6 +170,64 @@ DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_event_done,
 
 );
 
+TRACE_EVENT(snd_soc_jack_irq,
+
+	TP_PROTO(const char *name),
+
+	TP_ARGS(name),
+
+	TP_STRUCT__entry(
+		__string(	name,	name		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, w->name);
+	),
+
+	TP_printk("%s", __get_str(name))
+);
+
+TRACE_EVENT(snd_soc_jack_report,
+
+	TP_PROTO(struct snd_soc_jack *jack, int mask, int val),
+
+	TP_ARGS(jack, mask, val),
+
+	TP_STRUCT__entry(
+		__string(	name,		jack->jack->name	)
+		__field(	int,		mask			)
+		__field(	int,		val			)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, jack->jack->name);
+		__entry->mask = mask;
+		__entry->val = val;
+	),
+
+	TP_printk("jack=%s %x/%x", __get_str(name), (int)__entry->val,
+		  (int)__entry->mask)
+);
+
+TRACE_EVENT(snd_soc_jack_notify,
+
+	TP_PROTO(struct snd_soc_jack *jack, int val),
+
+	TP_ARGS(jack, val),
+
+	TP_STRUCT__entry(
+		__string(	name,		jack->jack->name	)
+		__field(	int,		val			)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, jack->jack->name);
+		__entry->val = val;
+	),
+
+	TP_printk("jack=%s %x", __get_str(name), (int)__entry->val)
+);
+
 #endif /* _TRACE_ASOC_H */
 
 /* This part must be outside protection */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0e9b071..ac5a5bc 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
+#include <trace/events/asoc.h>
 
 /**
  * snd_soc_jack_new - Create a new jack
@@ -64,6 +65,8 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	int enable;
 	int oldstatus;
 
+	trace_snd_soc_jack_report(jack, mask, status);
+
 	if (!jack)
 		return;
 
@@ -82,6 +85,8 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	if (mask && (jack->status == oldstatus))
 		goto out;
 
+	trace_snd_soc_jack_notify(jack, status);
+
 	list_for_each_entry(pin, &jack->pins, list) {
 		enable = pin->mask & jack->status;
 
@@ -210,6 +215,8 @@ static irqreturn_t gpio_handler(int irq, void *data)
 	struct snd_soc_jack_gpio *gpio = data;
 	struct device *dev = gpio->jack->codec->card->dev;
 
+	trace_snd_soc_jack_irq(gpio->name);
+
 	if (device_may_wakeup(dev))
 		pm_wakeup_event(dev, gpio->debounce_time + 50);
 
-- 
1.7.2.3
