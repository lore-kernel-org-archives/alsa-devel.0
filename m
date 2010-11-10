From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add trace events for ASoC register
	read/write
Date: Wed, 10 Nov 2010 16:39:05 +0000
Message-ID: <1289407146-20250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25CDE2455C
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 17:39:08 +0100 (CET)
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

The trace subsystem provides a convenient way of instrumenting the kernel
which can be left on all the time with extremely low impact on the system
unlike prints to the kernel log which can be very spammy. Begin adding
support for instrumenting ASoC via this interface by adding trace for the
register access primitives.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/trace/events/asoc.h |   64 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c        |    5 +++
 2 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 include/trace/events/asoc.h

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
new file mode 100644
index 0000000..93c3371
--- /dev/null
+++ b/include/trace/events/asoc.h
@@ -0,0 +1,64 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM asoc
+
+#if !defined(_TRACE_ASOC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ASOC_H
+
+#include <linux/ktime.h>
+#include <linux/tracepoint.h>
+
+struct snd_soc_codec;
+
+/*
+ * Log register events
+ */
+DECLARE_EVENT_CLASS(snd_soc_reg,
+
+	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(codec, reg, val),
+
+	TP_STRUCT__entry(
+		__string(	name,		codec->name	)
+		__field(	int,		id		)
+		__field(	unsigned int,	reg		)
+		__field(	unsigned int,	val		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, codec->name);
+		__entry->id = codec->id;
+		__entry->reg = reg;
+		__entry->val = val;
+	),
+
+	TP_printk("codec=%s.%d reg=%x val=%x", __get_str(name),
+		  (int)__entry->id, (unsigned int)__entry->reg,
+		  (unsigned int)__entry->val)
+);
+
+DEFINE_EVENT(snd_soc_reg, snd_soc_reg_write,
+
+	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(codec, reg, val)
+
+);
+
+DEFINE_EVENT(snd_soc_reg, snd_soc_reg_read,
+
+	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(codec, reg, val)
+
+);
+
+
+
+#endif /* _TRACE_ASOC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c18ce1d..700a6d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -39,6 +39,9 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/asoc.h>
+
 #define NAME_SIZE	32
 
 static DEFINE_MUTEX(pcm_mutex);
@@ -1914,6 +1917,7 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
 
 	ret = codec->driver->read(codec, reg);
 	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
+	trace_snd_soc_reg_read(codec, reg, ret);
 
 	return ret;
 }
@@ -1923,6 +1927,7 @@ unsigned int snd_soc_write(struct snd_soc_codec *codec,
 			   unsigned int reg, unsigned int val)
 {
 	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
+	trace_snd_soc_reg_write(codec, reg, val);
 	return codec->driver->write(codec, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
-- 
1.7.1
