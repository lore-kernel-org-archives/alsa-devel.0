From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: hda - Re-add tracepoints to HD-audio
	core driver
Date: Wed, 18 Mar 2015 16:16:37 +0100
Message-ID: <1426691797-17178-8-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF87265114
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BFA51ADAC
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now let's take the basic tracepoints back to the HD-audio driver.
The three bus tracepoints, hda_send_cmd, hda_get_response and
hda_unsol_event are revived but in a slightly different form.
Since we don't assign the card number there, print the bus device name
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/Makefile        |   3 ++
 sound/hda/hdac_bus.c      |   7 ++-
 sound/hda/trace.c         |   6 +++
 sound/hda/trace.h         |  62 ++++++++++++++++++++++++
 sound/pci/hda/Makefile    |   1 -
 sound/pci/hda/hda_trace.h | 119 ----------------------------------------------
 6 files changed, 77 insertions(+), 121 deletions(-)
 create mode 100644 sound/hda/trace.c
 create mode 100644 sound/hda/trace.h
 delete mode 100644 sound/pci/hda/hda_trace.h

diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index ae8b5128b5c3..eec5da03b41f 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,3 +1,6 @@
 snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o hdac_sysfs.o
 
+snd-hda-core-objs += trace.o
+CFLAGS_trace.o := -I$(src)
+
 obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 364f64c0e4a3..8e262da74f6a 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/export.h>
 #include <sound/hdaudio.h>
+#include "trace.h"
 
 static void process_unsol_events(struct work_struct *work);
 
@@ -82,6 +83,7 @@ int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
 	else if (bus->sync_write)
 		res = &tmp;
 	for (;;) {
+		trace_hda_send_cmd(bus, cmd);
 		err = bus->ops->command(bus, cmd);
 		if (err != -EAGAIN)
 			break;
@@ -90,8 +92,10 @@ int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
 		if (err)
 			break;
 	}
-	if (!err && res)
+	if (!err && res) {
 		err = bus->ops->get_response(bus, addr, res);
+		trace_hda_get_response(bus, addr, *res);
+	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_exec_verb_unlocked);
@@ -113,6 +117,7 @@ void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex)
 	if (!bus)
 		return;
 
+	trace_hda_unsol_event(bus, res, res_ex);
 	wp = (bus->unsol_wp + 1) % HDA_UNSOL_QUEUE_SIZE;
 	bus->unsol_wp = wp;
 
diff --git a/sound/hda/trace.c b/sound/hda/trace.c
new file mode 100644
index 000000000000..ca2d6bd94518
--- /dev/null
+++ b/sound/hda/trace.c
@@ -0,0 +1,6 @@
+/*
+ * tracepoint definitions for HD-audio core drivers
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/sound/hda/trace.h b/sound/hda/trace.h
new file mode 100644
index 000000000000..33a7eb5573d4
--- /dev/null
+++ b/sound/hda/trace.h
@@ -0,0 +1,62 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hda
+
+#if !defined(__HDAC_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HDAC_TRACE_H
+
+#include <linux/tracepoint.h>
+#include <linux/device.h>
+#include <sound/hdaudio.h>
+
+#ifndef HDAC_MSG_MAX
+#define HDAC_MSG_MAX	500
+#endif
+
+struct hdac_bus;
+struct hdac_codec;
+
+TRACE_EVENT(hda_send_cmd,
+	TP_PROTO(struct hdac_bus *bus, unsigned int cmd),
+	TP_ARGS(bus, cmd),
+	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_fast_assign(
+		snprintf(__get_str(msg), HDAC_MSG_MAX,
+			 "[%s:%d] val=0x%08x",
+			 dev_name((bus)->dev), (cmd) >> 28, cmd);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+TRACE_EVENT(hda_get_response,
+	TP_PROTO(struct hdac_bus *bus, unsigned int addr, unsigned int res),
+	TP_ARGS(bus, addr, res),
+	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_fast_assign(
+		snprintf(__get_str(msg), HDAC_MSG_MAX,
+			 "[%s:%d] val=0x%08x",
+			 dev_name((bus)->dev), addr, res);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+TRACE_EVENT(hda_unsol_event,
+	TP_PROTO(struct hdac_bus *bus, u32 res, u32 res_ex),
+	TP_ARGS(bus, res, res_ex),
+	TP_STRUCT__entry(__dynamic_array(char, msg, HDAC_MSG_MAX)),
+	TP_fast_assign(
+		snprintf(__get_str(msg), HDAC_MSG_MAX,
+			 "[%s:%d] res=0x%08x, res_ex=0x%08x",
+			 dev_name((bus)->dev), res_ex & 0x0f, res, res_ex);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+#endif /* __HDAC_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 96caaebfc19d..af78fb33a4fd 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -10,7 +10,6 @@ snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 
 # for trace-points
-CFLAGS_hda_codec.o := -I$(src)
 CFLAGS_hda_controller.o := -I$(src)
 
 snd-hda-codec-generic-objs :=	hda_generic.o
diff --git a/sound/pci/hda/hda_trace.h b/sound/pci/hda/hda_trace.h
deleted file mode 100644
index 7fedfa862419..000000000000
--- a/sound/pci/hda/hda_trace.h
+++ /dev/null
@@ -1,119 +0,0 @@
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM hda
-#define TRACE_INCLUDE_FILE hda_trace
-
-#if !defined(_TRACE_HDA_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_HDA_H
-
-#include <linux/tracepoint.h>
-
-struct hda_bus;
-struct hda_codec;
-
-DECLARE_EVENT_CLASS(hda_cmd,
-
-	TP_PROTO(struct hda_codec *codec, unsigned int val),
-
-	TP_ARGS(codec, val),
-
-	TP_STRUCT__entry(
-		__field( unsigned int, card )
-		__field( unsigned int, addr )
-		__field( unsigned int, val )
-	),
-
-	TP_fast_assign(
-		__entry->card = (codec)->card->number;
-		__entry->addr = (codec)->addr;
-		__entry->val = (val);
-	),
-
-	TP_printk("[%d:%d] val=%x", __entry->card, __entry->addr, __entry->val)
-);
-
-DEFINE_EVENT(hda_cmd, hda_send_cmd,
-	TP_PROTO(struct hda_codec *codec, unsigned int val),
-	TP_ARGS(codec, val)
-);
-
-DEFINE_EVENT(hda_cmd, hda_get_response,
-	TP_PROTO(struct hda_codec *codec, unsigned int val),
-	TP_ARGS(codec, val)
-);
-
-TRACE_EVENT(hda_bus_reset,
-
-	TP_PROTO(struct hda_bus *bus),
-
-	TP_ARGS(bus),
-
-	TP_STRUCT__entry(
-		__field( unsigned int, card )
-	),
-
-	TP_fast_assign(
-		__entry->card = (bus)->card->number;
-	),
-
-	TP_printk("[%d]", __entry->card)
-);
-
-#ifdef CONFIG_PM
-DECLARE_EVENT_CLASS(hda_power,
-
-	TP_PROTO(struct hda_codec *codec),
-
-	TP_ARGS(codec),
-
-	TP_STRUCT__entry(
-		__field( unsigned int, card )
-		__field( unsigned int, addr )
-	),
-
-	TP_fast_assign(
-		__entry->card = (codec)->card->number;
-		__entry->addr = (codec)->addr;
-	),
-
-	TP_printk("[%d:%d]", __entry->card, __entry->addr)
-);
-
-DEFINE_EVENT(hda_power, hda_power_down,
-	TP_PROTO(struct hda_codec *codec),
-	TP_ARGS(codec)
-);
-
-DEFINE_EVENT(hda_power, hda_power_up,
-	TP_PROTO(struct hda_codec *codec),
-	TP_ARGS(codec)
-);
-#endif /* CONFIG_PM */
-
-TRACE_EVENT(hda_unsol_event,
-
-	TP_PROTO(struct hda_bus *bus, u32 res, u32 res_ex),
-
-	TP_ARGS(bus, res, res_ex),
-
-	TP_STRUCT__entry(
-		__field( unsigned int, card )
-		__field( u32, res )
-		__field( u32, res_ex )
-	),
-
-	TP_fast_assign(
-		__entry->card = (bus)->card->number;
-		__entry->res = res;
-		__entry->res_ex = res_ex;
-	),
-
-	TP_printk("[%d] res=%x, res_ex=%x", __entry->card,
-		  __entry->res, __entry->res_ex)
-);
-
-#endif /* _TRACE_HDA_H */
-
-/* This part must be outside protection */
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-#include <trace/define_trace.h>
-- 
2.3.3
