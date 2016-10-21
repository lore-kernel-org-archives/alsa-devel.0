From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 11/14] SoundWire: Add tracing for Slave register read/write
Date: Fri, 21 Oct 2016 18:11:09 +0530
Message-ID: <1477053673-16021-12-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sdw_bus.h    |    7 ++
 include/trace/events/sdw.h |  209 ++++++++++++++++++++++++++++++++++++++++++++
 sound/sdw/sdw.c            |   37 ++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 include/trace/events/sdw.h

diff --git a/include/sound/sdw_bus.h b/include/sound/sdw_bus.h
index 3ea0c71..ad3586e 100644
--- a/include/sound/sdw_bus.h
+++ b/include/sound/sdw_bus.h
@@ -894,5 +894,12 @@ int snd_sdw_config_ports(struct sdw_master *mstr, struct sdw_slave *slave,
  */
 int snd_sdw_slave_transfer(struct sdw_master *master, struct sdw_msg *msg,
 						unsigned int num);
+
+/* Function to enable tracing */
+void sdw_transfer_trace_reg(void);
+
+/* Function to disable tracing */
+void sdw_transfer_trace_unreg(void);
+
 #endif /*  _LINUX_SDW_BUS_H */
 
diff --git a/include/trace/events/sdw.h b/include/trace/events/sdw.h
new file mode 100644
index 0000000..447b86e
--- /dev/null
+++ b/include/trace/events/sdw.h
@@ -0,0 +1,209 @@
+/*
+ * sdw.h - SDW message transfer tracepoints.
+ *
+ * Author: Hardik Shah <hardik.t.shah@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sdw
+
+#if !defined(_TRACE_SDW_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SDW_H
+
+#include <linux/mod_devicetable.h>
+#include <sound/sdw_bus.h>
+#include <linux/tracepoint.h>
+
+/*
+ * __sdw_transfer() write request
+ */
+TRACE_EVENT_FN(sdw_write,
+	       TP_PROTO(const struct sdw_master *mstr,
+			const struct sdw_msg *msg,
+			int num),
+	       TP_ARGS(mstr, msg, num),
+	       TP_STRUCT__entry(
+		       __field(int,	master_nr)
+		       __field(__u16,	msg_nr)
+		       __field(__u8,	addr_page1)
+		       __field(__u8,	addr_page2)
+		       __field(__u16,	addr)
+		       __field(__u16,	flag)
+		       __field(__u16,	len)
+		       __dynamic_array(__u8, buf, msg->len)),
+	       TP_fast_assign(
+		       __entry->master_nr = mstr->nr;
+		       __entry->msg_nr = num;
+		       __entry->addr = msg->addr;
+		       __entry->flag = msg->r_w_flag;
+		       __entry->len = msg->len;
+		       __entry->addr_page1 = msg->addr_page1;
+		       __entry->addr_page2 = msg->addr_page2;
+		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
+			      ),
+	       TP_printk("sdw-%d #%u a=%03x addr_page1=%04x addr_page2=%04x f=%04x l=%u [%*phD]",
+			 __entry->master_nr,
+			 __entry->msg_nr,
+			 __entry->addr,
+			 __entry->addr_page1,
+			 __entry->addr_page2,
+			 __entry->flag,
+			 __entry->len,
+			 __entry->len, __get_dynamic_array(buf)
+			 ),
+	       sdw_transfer_trace_reg,
+	       sdw_transfer_trace_unreg);
+
+/*
+ * __sdw_transfer() read request
+ */
+TRACE_EVENT_FN(sdw_read,
+	       TP_PROTO(const struct sdw_master *mstr, const struct sdw_msg *msg,
+			int num),
+	       TP_ARGS(mstr, msg, num),
+	       TP_STRUCT__entry(
+		       __field(int,	master_nr)
+		       __field(__u16,	msg_nr)
+		       __field(__u8,	addr_page1)
+		       __field(__u8,	addr_page2)
+		       __field(__u16,	addr)
+		       __field(__u16,	flag)
+		       __field(__u16,	len)
+		       __dynamic_array(__u8, buf, msg->len)),
+	       TP_fast_assign(
+		       __entry->master_nr = mstr->nr;
+		       __entry->msg_nr = num;
+		       __entry->addr = msg->addr;
+		       __entry->flag = msg->r_w_flag;
+		       __entry->len = msg->len;
+		       __entry->addr_page1 = msg->addr_page1;
+		       __entry->addr_page2 = msg->addr_page2;
+		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
+			      ),
+	       TP_printk("sdw-%d #%u a=%03x addr_page1=%04x addr_page2=%04x f=%04x l=%u [%*phD]",
+			 __entry->master_nr,
+			 __entry->msg_nr,
+			 __entry->addr,
+			 __entry->addr_page1,
+			 __entry->addr_page2,
+			 __entry->flag,
+			 __entry->len,
+			 __entry->len, __get_dynamic_array(buf)
+			 ),
+	       sdw_transfer_trace_reg,
+	sdw_transfer_trace_unreg);
+
+/*
+ * __sdw_transfer() read reply
+ */
+TRACE_EVENT_FN(sdw_reply,
+	       TP_PROTO(const struct sdw_master *mstr,
+			const struct sdw_msg *msg,
+			int num),
+	       TP_ARGS(mstr, msg, num),
+	       TP_STRUCT__entry(
+		       __field(int,	master_nr)
+		       __field(__u16,	msg_nr)
+		       __field(__u16,	addr)
+		       __field(__u16,	flag)
+		       __field(__u16,	len)
+		       __dynamic_array(__u8, buf, msg->len)),
+	       TP_fast_assign(
+		       __entry->master_nr = mstr->nr;
+		       __entry->msg_nr = num;
+		       __entry->addr = msg->addr;
+		       __entry->flag = msg->r_w_flag;
+		       __entry->len = msg->len;
+		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
+			      ),
+	       TP_printk("sdw-%d #%u a=%03x f=%04x l=%u [%*phD]",
+			 __entry->master_nr,
+			 __entry->msg_nr,
+			 __entry->addr,
+			 __entry->flag,
+			 __entry->len,
+			 __entry->len, __get_dynamic_array(buf)
+			 ),
+	       sdw_transfer_trace_reg,
+	       sdw_transfer_trace_unreg);
+
+/*
+ * __sdw_transfer() result
+ */
+TRACE_EVENT_FN(sdw_result,
+	       TP_PROTO(const struct sdw_master *mstr, int num, int ret),
+	       TP_ARGS(mstr, num, ret),
+	       TP_STRUCT__entry(
+		       __field(int,	master_nr)
+		       __field(__u16,	nr_msgs)
+		       __field(__s16,	ret)
+				),
+	       TP_fast_assign(
+		       __entry->master_nr = mstr->nr;
+		       __entry->nr_msgs = num;
+		       __entry->ret = ret;
+			      ),
+	       TP_printk("sdw-%d n=%u ret=%d",
+			 __entry->master_nr,
+			 __entry->nr_msgs,
+			 __entry->ret
+			 ),
+	       sdw_transfer_trace_reg,
+	       sdw_transfer_trace_unreg);
+
+#endif /* _TRACE_SDW_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/sound/sdw/sdw.c b/sound/sdw/sdw.c
index 449060e..71d2550 100644
--- a/sound/sdw/sdw.c
+++ b/sound/sdw/sdw.c
@@ -70,6 +70,8 @@
 
 #include "sdw_priv.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/sdw.h>
 /*
  * Global SoundWire core instance contains list of Masters registered, core
  *	lock and SoundWire stream tags.
@@ -335,6 +337,17 @@ static int sdw_match(struct device *dev, struct device_driver *driver)
 	.match		= sdw_match,
 	.pm		= &soundwire_pm,
 };
+static struct static_key sdw_trace_msg = STATIC_KEY_INIT_FALSE;
+
+void sdw_transfer_trace_reg(void)
+{
+	static_key_slow_inc(&sdw_trace_msg);
+}
+
+void sdw_transfer_trace_unreg(void)
+{
+	static_key_slow_dec(&sdw_trace_msg);
+}
 
 static int sdw_find_free_dev_num(struct sdw_master *mstr,
 				struct sdw_msg *msg)
@@ -601,6 +614,21 @@ static int sdw_transfer(struct sdw_master *mstr, struct sdw_msg *msg, int num,
 	u8 prev_adr_pg1 = 0;
 	u8 prev_adr_pg2 = 0;
 
+	/*
+	 * sdw_trace_msg gets enabled when trace point sdw_slave_transfer gets
+	 * enabled.  This is an efficient way of keeping the for-loop from
+	 * being executed when not needed.
+	 */
+	if (static_key_false(&sdw_trace_msg)) {
+		int j;
+
+		for (j = 0; j < num; j++)
+			if (msg[j].r_w_flag & SDW_MSG_FLAG_READ)
+				trace_sdw_read(mstr, &msg[j], j);
+			else
+				trace_sdw_write(mstr, &msg[j], j);
+	}
+
 	for (i = 0; i < num; i++) {
 
 		/* Reset timeout for every message */
@@ -665,6 +693,15 @@ static int sdw_transfer(struct sdw_master *mstr, struct sdw_msg *msg, int num,
 		}
 	}
 
+	if (static_key_false(&sdw_trace_msg)) {
+		int j;
+
+		for (j = 0; j < msg->len; j++)
+			if (msg[j].r_w_flag & SDW_MSG_FLAG_READ)
+				trace_sdw_reply(mstr, &msg[j], j);
+		trace_sdw_result(mstr, j, ret);
+	}
+
 	if (!ret)
 		return i + 1;
 
-- 
1.7.9.5
