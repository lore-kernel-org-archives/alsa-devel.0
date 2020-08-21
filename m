Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:36:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B902078D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lDFEXdqW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="F6lgjzCD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0BHf2EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B902078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 650C21669;
	Fri, 21 Aug 2020 09:35:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 650C21669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597995387;
	bh=fhHD7IMMF9mUTUGiwX2FECTy6+NcrCyDYHMR9+HIuks=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDFEXdqW3R4mG7L/aqrrN4G0Mx8BFA4IaH4uWyUj1TrEpqpURhVGHD8qIzAXm5arx
	 HPv3hTXnvP6H5vMSj4zZpbNJZDWJWWZvVd0KgNwOPa9J2lsBa99IL7S1wA/2+HK+5q
	 hI7PPPIA3++WDXlMKyJMnRlIlcYywsoGU5PhY26M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A545F80306;
	Fri, 21 Aug 2020 09:31:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12F56F802E7; Fri, 21 Aug 2020 09:31:42 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B198DF80218
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B198DF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="F6lgjzCD"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="b0BHf2EX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id D01CC6F0;
 Fri, 21 Aug 2020 03:31:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 21 Aug 2020 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=IHL0xumbb5SCV
 VFEZYwR9Fn70hgzcQxVEDDhjaewpJI=; b=F6lgjzCDDjj/tOAyPFfEnLXHUCrqF
 aYcXb3G1R0BUjI3Sd3p709RF/3qSbyJEH4mmNgkIq/xg32TK0w4bXe0zfTDWQT4t
 Q7oqW3TETIXzM9MsoaYNmIUyA/4+pR2Hdb7w/ByW/8zYvrg1RfJxO8a8ly1FhzZe
 LzzbNmP1Hvin2RyAwBVZL3XcBGuEUdlFp2ZWfGyCiu0bCEWoFBth6ouTOr3YALr5
 dhKODmSuMzH++ZN6KK8hWtTMZornRmo5twYGB2xqv6e4jX8XM4V69sKLnaJkzIGO
 R42se5BoAdq9nFOeDRnaQSq45kwsxF4L82ARor0mBY6a3LAB1ew10HZlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=IHL0xumbb5SCVVFEZYwR9Fn70hgzcQxVEDDhjaewpJI=; b=b0BHf2EX
 AjYtHGfEMYj6i5buerO0zX8m7j35fNzHcQAVC+/Ck6YIMZXMa7VkjUfQUhfDRbaa
 bGCwSc0yxj2LkB7tJlZMaYezfCNxMpiLj/vIXWAPRJhk/mK/oCY8rK3/Zk1YhLSq
 /be5V7/bCT/hoirHANil9ltbvDGyFuM1UUpF1Qd//s6FPwQ5EWi8BAX8wRGEghVv
 sr1fXwNziUIQvtY2q2wIHa6DL12BXasc5fSawxpqc/v/CpIOUQX6phEqoF0iameM
 Awc0/u/k9mm59MnzTickaKaP1gpqn5cU+h0YvatRmtpVj6exdQfaXyVGlMMl2B3E
 lJ1BFB0vuEkQiA==
X-ME-Sender: <xms:R3g_X_gn8CrttFSMoWsfHvfU3T5Fif9-sij0qtbt12nt4Yw8drkHFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudek
 tddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:R3g_X8DwvzxN52ebRJwnVQEcpY5fQKO-qJIb_5aFGe07y65DI2OhEQ>
 <xmx:R3g_X_FZZriyU-aUp8zyQCThj8cVeoIcf2mZ6CmjEBPlu4iKpkbYSQ>
 <xmx:R3g_X8Q9cqXtZQaECfIQ7eEsAnD850H0BZXKOSC1tyEl9Da-gwEreA>
 <xmx:R3g_X5q9wQy2uauDxQ6s70nBcmHLvTyrl1CYACTeqEYkmTRmr-8DHQ>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0BC8B30600B1;
 Fri, 21 Aug 2020 03:31:17 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH 02/25] efw-downloader: efw-proto: define EfwProto as derived
 object of HinawaFwResp
Date: Fri, 21 Aug 2020 16:30:48 +0900
Message-Id: <20200821073111.134857-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821073111.134857-1-o-takashi@sakamocchi.jp>
References: <20200821073111.134857-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
 clemens@ladisch.de
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

Echo Digital Audio corporation designed specific protocol to operate
Fireworks board module. The protocol includes a pair of asynchronous
transactions on IEEE 1394 bus to transfer command frame and receive
response frame.

This commit adds EfwProto GObject object. This object inherits
HinawaFwResp to receive the response frame from Linux 1394 OHCI driver,
thus libglib-2.0, libgobject-2.0 and libhinawa 2.1 is added for
build and runtime dependency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 efw-downloader/src/efw-proto.c | 25 +++++++++++++++++++++
 efw-downloader/src/efw-proto.h | 40 ++++++++++++++++++++++++++++++++++
 efw-downloader/src/meson.build | 21 +++++++++++++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 efw-downloader/src/efw-proto.c
 create mode 100644 efw-downloader/src/efw-proto.h

diff --git a/efw-downloader/src/efw-proto.c b/efw-downloader/src/efw-proto.c
new file mode 100644
index 0000000..63fd2c5
--- /dev/null
+++ b/efw-downloader/src/efw-proto.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-3.0-or-later
+// Copyright (c) 2020 Takashi Sakamoto
+#include "efw-proto.h"
+
+/**
+ * SECTION:efw_proto
+ * @Title: EfwProto
+ * @Short_description: Transaction implementation for Fireworks protocol
+ * @include: fw_fcp.h
+ *
+ * Fireworks board module from Echo Digital Audio corporation supports specific protocol based on
+ * a pair of asynchronous transactions in IEEE 1394 bus. The EfwProto class is an implementation
+ * for the protocol.
+ */
+G_DEFINE_TYPE(EfwProto, efw_proto, HINAWA_TYPE_FW_RESP)
+
+static void efw_proto_class_init(EfwProtoClass *klass)
+{
+    return;
+}
+
+static void efw_proto_init(EfwProto *self)
+{
+    return;
+}
diff --git a/efw-downloader/src/efw-proto.h b/efw-downloader/src/efw-proto.h
new file mode 100644
index 0000000..83e52be
--- /dev/null
+++ b/efw-downloader/src/efw-proto.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-3.0-or-later
+// Copyright (c) 2020 Takashi Sakamoto
+#ifndef __EFW_PROTO_H__
+#define __EFW_PROTO_H__
+
+#include <glib.h>
+#include <glib-object.h>
+
+#include <libhinawa/fw_resp.h>
+
+G_BEGIN_DECLS
+
+#define EFW_TYPE_PROTO      (efw_proto_get_type())
+
+#define EFW_PROTO(obj) \
+    (G_TYPE_CHECK_INSTANCE_CAST((obj), EFW_TYPE_PROTO, EfwProto))
+#define EFW_IS_PROTO(obj) \
+    (G_TYPE_CHECK_INSTANCE_TYPE((obj), EFW_TYPE_PROTO))
+
+#define EFW_PROTO_CLASS(klass) \
+    (G_TYPE_CHECK_CLASS_CAST((klass), EFW_TYPE_PROTO, EfwProtoClass))
+#define EFW_IS_PROTO_CLASS(klass) \
+    (G_TYPE_CHECK_CLASS_TYPE((klass), EFW_TYPE_PROTO))
+#define EFW_PROTO_GET_CLASS(obj) \
+    (G_TYPE_INSTANCE_GET_CLASS((obj), EFW_TYPE_PROTO, EfwProtoClass))
+
+typedef struct _EfwProto            EfwProto;
+typedef struct _EfwProtoClass       EfwProtoClass;
+
+struct _EfwProto {
+    HinawaFwResp parent_instance;
+};
+
+struct _EfwProtoClass {
+    HinawaFwRespClass parent_class;
+};
+
+G_END_DECLS
+
+#endif
diff --git a/efw-downloader/src/meson.build b/efw-downloader/src/meson.build
index b837e92..b7992a2 100644
--- a/efw-downloader/src/meson.build
+++ b/efw-downloader/src/meson.build
@@ -1,11 +1,30 @@
 # SPDX-License-Identifier: GPL-3.0-or-later
 # Copyright (c) 2020 Takashi Sakamoto
 
+# Depends on glib-2.0 and gobject-2.0.
+gobject = dependency('gobject-2.0',
+  version: '>=2.34.0',
+)
+
+# Depends on libhinawa v2.1.0 or later.
+hinawa = dependency('hinawa',
+  version: '>=2.1',
+)
+
 sources = [
   'main.c',
+  'efw-proto.c',
+]
+
+headers = [
+  'efw-proto.h',
 ]
 
 executable('efw-downloader',
-  sources: sources,
+  sources: sources + headers,
+  dependencies: [
+    gobject,
+    hinawa,
+  ],
   install: true,
 )
-- 
2.25.1

