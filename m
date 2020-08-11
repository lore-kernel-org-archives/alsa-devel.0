Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D0BC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:12:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20452076B
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jRdPLXID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20452076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 451841663;
	Tue, 11 Aug 2020 18:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 451841663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597162334;
	bh=iJPhLvKheZwvVUyqvU/hflgQlhuR1S6KLIFIqDDgcT4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRdPLXIDSrt2LEovrKlN6sCkKG8TTZJnZ5m9VMZP10D382GBRRa0VRj/d96GfejUt
	 0rC5BwbyFtLzN3HN7HK3L3PI/zoxCDURl5hAFReWI0Cp7H3D5FfdWgVeTIvpATIJte
	 4GC3CuW6iGLm7uHyNMk7v6ztaz41HAl6+494iCRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F8D6F80316;
	Tue, 11 Aug 2020 18:07:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91E02F80161; Tue, 11 Aug 2020 18:07:05 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E006AF8014C
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 18:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E006AF8014C
IronPort-SDR: 7hfX10UJgxCK3SBGvz/jsToOK+BFV7TpGKkhOjG5eowlIvHYLZs8wtbTtEXtOYzGfswkmyExA7
 ZZ4vUR8hZGUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153734021"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; d="scan'208";a="153734021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 09:07:02 -0700
IronPort-SDR: IJS1dxANh6ua58amBTND3nFT+fGRuN+b+LgytPql5G9yHtA+QLyyWjzb9NLYjN/unvLOf6aUnn
 F6jDDAD/xPmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; d="scan'208";a="317777755"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 09:06:59 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 07/13] ASoC: Intel: catpt: Event tracing
Date: Tue, 11 Aug 2020 18:06:04 +0200
Message-Id: <20200811160610.32735-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811160610.32735-1-cezary.rojewski@intel.com>
References: <20200811160610.32735-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@intel.com,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, marcin.barlik@intel.com,
 zwisler@google.com, lgirdwood@gmail.com, tiwai@suse.com,
 filip.proborszcz@intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, michal.wasko@intel.com,
 cujomalainey@chromium.org, krzysztof.hejmowski@intel.com,
 ppapierkowski@habana.ai, vamshi.krishna.gopal@intel.com
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
 sound/soc/intel/catpt/trace.h | 83 +++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 sound/soc/intel/catpt/trace.h

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

