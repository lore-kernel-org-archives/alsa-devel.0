From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 4/5] ASoC: Intel: Add trace support for generic
	SST IPC messages.
Date: Thu, 13 Feb 2014 19:15:29 +0000
Message-ID: <1392318930-8771-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B352651FF
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2014 20:15:53 +0100 (CET)
In-Reply-To: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

Provide a trace mechanism for debugging generic SST IPC messages.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/trace/events/sst.h | 148 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 include/trace/events/sst.h

diff --git a/include/trace/events/sst.h b/include/trace/events/sst.h
new file mode 100644
index 0000000..1a0d6b3
--- /dev/null
+++ b/include/trace/events/sst.h
@@ -0,0 +1,148 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sst
+
+#if !defined(_TRACE_SST_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SST_H
+
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(sst_ipc_msg,
+
+	TP_PROTO(unsigned int val),
+
+	TP_ARGS(val),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	val		)
+	),
+
+	TP_fast_assign(
+		__entry->val = val;
+	),
+
+	TP_printk("0x%8.8x", (unsigned int)__entry->val)
+);
+
+DEFINE_EVENT(sst_ipc_msg, sst_ipc_msg_tx,
+
+	TP_PROTO(unsigned int val),
+
+	TP_ARGS(val)
+
+);
+
+DEFINE_EVENT(sst_ipc_msg, sst_ipc_msg_rx,
+
+	TP_PROTO(unsigned int val),
+
+	TP_ARGS(val)
+
+);
+
+DECLARE_EVENT_CLASS(sst_ipc_mailbox,
+
+	TP_PROTO(unsigned int offset, unsigned int val),
+
+	TP_ARGS(offset, val),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	offset		)
+		__field(	unsigned int,	val		)
+	),
+
+	TP_fast_assign(
+		__entry->offset = offset;
+		__entry->val = val;
+	),
+
+	TP_printk(" 0x%4.4x = 0x%8.8x",
+		(unsigned int)__entry->offset, (unsigned int)__entry->val)
+);
+
+DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_rdata,
+
+	TP_PROTO(unsigned int offset, unsigned int val),
+
+	TP_ARGS(offset, val)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_wdata,
+
+	TP_PROTO(unsigned int offset, unsigned int val),
+
+	TP_ARGS(offset, val)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_outbox_rdata,
+
+	TP_PROTO(unsigned int offset, unsigned int val),
+
+	TP_ARGS(offset, val)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_outbox_wdata,
+
+	TP_PROTO(unsigned int offset, unsigned int val),
+
+	TP_ARGS(offset, val)
+
+);
+
+DECLARE_EVENT_CLASS(sst_ipc_mailbox_info,
+
+	TP_PROTO(unsigned int size),
+
+	TP_ARGS(size),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	size		)
+	),
+
+	TP_fast_assign(
+		__entry->size = size;
+	),
+
+	TP_printk("Mailbox bytes 0x%8.8x", (unsigned int)__entry->size)
+);
+
+DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_inbox_read,
+
+	TP_PROTO(unsigned int size),
+
+	TP_ARGS(size)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_inbox_write,
+
+	TP_PROTO(unsigned int size),
+
+	TP_ARGS(size)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_outbox_read,
+
+	TP_PROTO(unsigned int size),
+
+	TP_ARGS(size)
+
+);
+
+DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_outbox_write,
+
+	TP_PROTO(unsigned int size),
+
+	TP_ARGS(size)
+
+);
+
+#endif /* _TRACE_SST_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.8.3.2
