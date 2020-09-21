Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1305C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:02:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8472151B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JJKU8mVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8472151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C13716C1;
	Mon, 21 Sep 2020 14:01:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C13716C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600689732;
	bh=fGXGtvjCtmO/FFKQnUInZWSReaBY3VIrvSlzXsmPHks=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JJKU8mVEJD5CYKHIWbdBhSgeWJ33PwYPiiOq1Ikv3j/3GrwPFEPh7vsVVJ9M5oTd4
	 4z7JWtVIL18E36Gnek3ID2wXp36qBM7QFFu/eSQKM5X+G9mfzTwwc1Qx9YgdspkfzL
	 mKcfYzEO22Q3YE/U0XmaJnp6+NQSccRKkvUQhcmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD030F80338;
	Mon, 21 Sep 2020 13:56:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CAD6F80308; Mon, 21 Sep 2020 13:56:22 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75A1AF802E9
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 13:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75A1AF802E9
IronPort-SDR: gkZ5ZH2eQ9gFoLp9vHnVO4Wp6tc4dl/BSMTwJFU40uGIZ9Z+Ceao5Aeg2C+5PlBOptofXlT64k
 tgn3pVFyJC3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="159657303"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="159657303"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 04:56:14 -0700
IronPort-SDR: hxAiOe/dGO3H/dPeKCrEwPUQjsPSGTsykj5B/sYSwymzL4kFEBkqkprjZxlkP+5u1A0GsQdZl1
 Nku6rsvJFhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="304486453"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga003.jf.intel.com with ESMTP; 21 Sep 2020 04:56:11 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v7 08/14] ASoC: Intel: catpt: Event tracing
Date: Mon, 21 Sep 2020 13:54:18 +0200
Message-Id: <20200921115424.4105-9-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921115424.4105-1-cezary.rojewski@intel.com>
References: <20200921115424.4105-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@linux.intel.com,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com,
 gregkh@linuxfoundation.org, marcin.barlik@intel.com, zwisler@google.com,
 lgirdwood@gmail.com, tiwai@suse.com, filip.proborszcz@intel.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 krzysztof.hejmowski@intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Define tracing macros for easy catpt debug. These cover all IPC message
types: requests, replies and notifications.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes in v6:
- trace usage now part of this patch instead of being separated from it

Changes in v2:
- trace.h events for updating registers have been removed and usages
  replaced by dev_dbg (SRAMPGE/ LPCS)
- trace.h events for catpt_mbank and catpt_mregion have been removed

 sound/soc/intel/catpt/device.c |  3 ++
 sound/soc/intel/catpt/ipc.c    | 11 +++++
 sound/soc/intel/catpt/trace.h  | 83 ++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 sound/soc/intel/catpt/trace.h

diff --git a/sound/soc/intel/catpt/device.c b/sound/soc/intel/catpt/device.c
index e7dc2fb69ea8..c02d46e5bc81 100644
--- a/sound/soc/intel/catpt/device.c
+++ b/sound/soc/intel/catpt/device.c
@@ -25,6 +25,9 @@
 #include "core.h"
 #include "registers.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 static int __maybe_unused catpt_suspend(struct device *dev)
 {
 	struct catpt_dev *cdev = dev_get_drvdata(dev);
diff --git a/sound/soc/intel/catpt/ipc.c b/sound/soc/intel/catpt/ipc.c
index 9e4e33d99c03..473f43f6b792 100644
--- a/sound/soc/intel/catpt/ipc.c
+++ b/sound/soc/intel/catpt/ipc.c
@@ -9,6 +9,7 @@
 #include "core.h"
 #include "messages.h"
 #include "registers.h"
+#include "trace.h"
 
 #define CATPT_IPC_TIMEOUT_MSECS	300
 
@@ -56,6 +57,9 @@ static void catpt_dsp_send_tx(struct catpt_dev *cdev,
 {
 	u32 header = tx->header | CATPT_IPCC_BUSY;
 
+	trace_catpt_ipc_request(header);
+	trace_catpt_ipc_payload(tx->data, tx->size);
+
 	if (tx->size)
 		memcpy_toio(catpt_outbox_addr(cdev), tx->data, tx->size);
 	catpt_writel_shim(cdev, IPCC, header);
@@ -155,12 +159,14 @@ catpt_dsp_notify_stream(struct catpt_dev *cdev, union catpt_notify_msg msg)
 	switch (msg.notify_reason) {
 	case CATPT_NOTIFY_POSITION_CHANGED:
 		memcpy_fromio(&pos, catpt_inbox_addr(cdev), sizeof(pos));
+		trace_catpt_ipc_payload((u8 *)&pos, sizeof(pos));
 
 		catpt_stream_update_position(cdev, stream, &pos);
 		break;
 
 	case CATPT_NOTIFY_GLITCH_OCCURRED:
 		memcpy_fromio(&glitch, catpt_inbox_addr(cdev), sizeof(glitch));
+		trace_catpt_ipc_payload((u8 *)&glitch, sizeof(glitch));
 
 		dev_warn(cdev->dev, "glitch %d at pos: 0x%08llx, wp: 0x%08x\n",
 			 glitch.type, glitch.presentation_pos,
@@ -182,6 +188,7 @@ static void catpt_dsp_copy_rx(struct catpt_dev *cdev, u32 header)
 	if (ipc->rx.size && ipc->rx.rsp.status == CATPT_REPLY_SUCCESS) {
 		memcpy_fromio(ipc->rx.data, catpt_outbox_addr(cdev),
 			      ipc->rx.size);
+		trace_catpt_ipc_payload(ipc->rx.data, ipc->rx.size);
 	}
 }
 
@@ -196,6 +203,7 @@ static void catpt_dsp_process_response(struct catpt_dev *cdev, u32 header)
 		u32 off = msg.mailbox_address << 3;
 
 		memcpy_fromio(&config, cdev->lpe_ba + off, sizeof(config));
+		trace_catpt_ipc_payload((u8 *)&config, sizeof(config));
 
 		catpt_ipc_arm(ipc, &config);
 		complete(&cdev->fw_ready);
@@ -236,6 +244,7 @@ irqreturn_t catpt_dsp_irq_thread(int irq, void *dev_id)
 	u32 ipcd;
 
 	ipcd = catpt_readl_shim(cdev, IPCD);
+	trace_catpt_ipc_notify(ipcd);
 
 	/* ensure there is delayed reply or notification to process */
 	if (!(ipcd & CATPT_IPCD_BUSY))
@@ -259,6 +268,7 @@ irqreturn_t catpt_dsp_irq_handler(int irq, void *dev_id)
 	u32 isc, ipcc;
 
 	isc = catpt_readl_shim(cdev, ISC);
+	trace_catpt_irq(isc);
 
 	/* immediate reply */
 	if (isc & CATPT_ISC_IPCCD) {
@@ -266,6 +276,7 @@ irqreturn_t catpt_dsp_irq_handler(int irq, void *dev_id)
 		catpt_updatel_shim(cdev, IMC, CATPT_IMC_IPCCD, CATPT_IMC_IPCCD);
 
 		ipcc = catpt_readl_shim(cdev, IPCC);
+		trace_catpt_ipc_reply(ipcc);
 		catpt_dsp_copy_rx(cdev, ipcc);
 		complete(&cdev->ipc.done_completion);
 
diff --git a/sound/soc/intel/catpt/trace.h b/sound/soc/intel/catpt/trace.h
new file mode 100644
index 000000000000..bb3d627dbeaf
--- /dev/null
+++ b/sound/soc/intel/catpt/trace.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2020 Intel Corporation. All rights reserved.
+ *
+ * Author: Cezary Rojewski <cezary.rojewski@intel.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM intel_catpt
+
+#if !defined(__SND_SOC_INTEL_CATPT_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __SND_SOC_INTEL_CATPT_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(catpt_ipc_msg,
+
+	TP_PROTO(u32 header),
+
+	TP_ARGS(header),
+
+	TP_STRUCT__entry(
+		__field(u32, header)
+	),
+
+	TP_fast_assign(
+		__entry->header = header;
+	),
+
+	TP_printk("0x%08x", __entry->header)
+);
+
+DEFINE_EVENT(catpt_ipc_msg, catpt_irq,
+	TP_PROTO(u32 header),
+	TP_ARGS(header)
+);
+
+DEFINE_EVENT(catpt_ipc_msg, catpt_ipc_request,
+	TP_PROTO(u32 header),
+	TP_ARGS(header)
+);
+
+DEFINE_EVENT(catpt_ipc_msg, catpt_ipc_reply,
+	TP_PROTO(u32 header),
+	TP_ARGS(header)
+);
+
+DEFINE_EVENT(catpt_ipc_msg, catpt_ipc_notify,
+	TP_PROTO(u32 header),
+	TP_ARGS(header)
+);
+
+TRACE_EVENT_CONDITION(catpt_ipc_payload,
+
+	TP_PROTO(const u8 *data, size_t size),
+
+	TP_ARGS(data, size),
+
+	TP_CONDITION(data && size),
+
+	TP_STRUCT__entry(
+		__dynamic_array(u8, buf, size)
+	),
+
+	TP_fast_assign(
+		memcpy(__get_dynamic_array(buf), data, size);
+	),
+
+	TP_printk("%u byte(s)%s",
+		  __get_dynamic_array_len(buf),
+		  __print_hex_dump("", DUMP_PREFIX_NONE, 16, 4,
+				   __get_dynamic_array(buf),
+				   __get_dynamic_array_len(buf), false))
+);
+
+#endif /* __SND_SOC_INTEL_CATPT_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.17.1

