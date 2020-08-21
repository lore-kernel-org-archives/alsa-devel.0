Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2A9C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:45:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D693520738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kdaKCCBh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WpThy1DF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fc/TWWok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D693520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 519871694;
	Fri, 21 Aug 2020 09:44:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 519871694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597995919;
	bh=qj6DwRt2l7/77BGTLO1VgFLexfNWHoofqRlwGSONCF8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdaKCCBhPiukuTQpduufVIJe5Ugi9Q/mtpa1AQxEuyOAb0lBMEQpRGXfBEEajPNfq
	 K0GfiG2nxIlbofHYx4hKyTwq4nbacVt5lEpX7SzDEYOe7TSh/sDawg+O49zMllNnvA
	 Ral3KxYQuQ7aMBj5tLOf/sx9H8Is7ZVBtSWU6rvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56385F80390;
	Fri, 21 Aug 2020 09:32:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC0D6F80347; Fri, 21 Aug 2020 09:32:12 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0326F802FE
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:31:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0326F802FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="WpThy1DF"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fc/TWWok"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id CD7F38FA;
 Fri, 21 Aug 2020 03:31:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 21 Aug 2020 03:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=hC3f/5eiwOoMy
 eaSZy0EsvqaQWeJ5FR6+CHhWs3o1zs=; b=WpThy1DFAkTKPqptOzjGzljwoUomR
 Q0FEyn/TMWPyggy5UNePLxoYqyFUQe4Q2nMJLIRrv/KLq3AaYN9nBQxC74D5GnlY
 UG+7UgaSt8AA4EGRhc2DPg36DgnlQsWxiFDTvEcAAGajAfg0pGrynpITKel1Fyxk
 zTmx71jurFIDJcPr8IklqATlisl6rrRu2rLBBtJ5NdzX1Okbetwb0ke7FL93DoLt
 X2TQiBUc5a0FKZS2ie/TK35fOIWi4vgNNirRSgx7sHxhIe1K+axuCH++3cjC9sKK
 HHHEonoVbYnQimzLxopyRdKae9KKb111Gzvu2XU4T1AKdBiPjjMTCvqeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=hC3f/5eiwOoMyeaSZy0EsvqaQWeJ5FR6+CHhWs3o1zs=; b=fc/TWWok
 5LSDaQ9B3XCJXj6jaBmLnyZn0H7MD4j3xESoOkgD+totmQQysq4JWnerIMigvavL
 W4M3Lp7rVn32ywxNdW9QC3U3sXXf41y5KI4IQyMgziXbf27k/k7kFZmrF21v/U5j
 qQKxLw4ycsQH+JNu5Idkwnpl/j4iC3Vxm+3OIzSQICWd5CP1J+96bPahim9MwZhV
 j7kMD4xWqea1wuHEo824ca60nqgSOeywb7x7N0ln/JdmSRm0DRF0SKkGGLrwGZJf
 R4945p8W9m3vA+LzL67gwvo1CyoFQiOYrD2pinvb2sjri70eA8oGUxQaPI3yt13Y
 M0bbXMyvO68mHg==
X-ME-Sender: <xms:ZHg_X9hEq0DrG4H_viuKaxHbHm5Zqmjruz4aEK-m_szOYyeIJFMFkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudek
 tddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgepudeinecurfgrrhgrmhepmh
 grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ZHg_XyB83HeM6o_T3e07Qx5e4JjcoWgo9hrZza_E956qv_W1MaciLw>
 <xmx:ZHg_X9HxRUULIWQZ4217HO9Rk3p83-JDhs-nU4TgA65gkmQV4y2gNA>
 <xmx:ZHg_XyQomcW56PA927bw9tN7A__OdGUh3uItOV-Be6omm3BZsdKs0Q>
 <xmx:ZHg_X_qTN91XRbLps7Gi_2El-3pkfLhkDgZITb_Btp1ZDT2cDxqz_Q>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2120530600A9;
 Fri, 21 Aug 2020 03:31:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH 19/25] efw-downloader: efw-commands: add support for commands
 in flash category
Date: Fri, 21 Aug 2020 16:31:05 +0900
Message-Id: <20200821073111.134857-20-o-takashi@sakamocchi.jp>
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

Fireworks protocol includes command for software to operate on-board flash
memory.

This commit implements the command and adds local helper functions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 efw-downloader/src/efw-commands.c | 213 ++++++++++++++++++++++++++++++
 efw-downloader/src/efw-commands.h |  12 ++
 2 files changed, 225 insertions(+)

diff --git a/efw-downloader/src/efw-commands.c b/efw-downloader/src/efw-commands.c
index 08b0114..b0a8320 100644
--- a/efw-downloader/src/efw-commands.c
+++ b/efw-downloader/src/efw-commands.c
@@ -8,10 +8,26 @@
 
 // Categories in Echo Audio Fireworks protocol.
 #define CATEGORY_HW             0
+#define CATEGORY_FLASH          1
 
 // Commands in hardware category.
 #define HW_CMD_INFO             0
 
+// Commands in flash category.
+#define FLASH_CMD_ERASE         0
+#define FLASH_CMD_READ          1
+#define FLASH_CMD_WRITE         2
+#define FLASH_CMD_STATE         3
+#define FLASH_CMD_SESSION_BASE  4
+#define FLASH_CMD_LOCK          5
+
+#define EFW_FLASH_FRAME_MAX_QUADS   64
+
+// Between 0x00000000 - 0x00010000.
+#define EFW_FLASH_BLOCK_SIZE_LOW    0x00002000
+// Between 0x00010000 - 0x00200000.
+#define EFW_FLASH_BLOCK_SIZE_HIGH   0x00010000
+
 #define TIMEOUT 200
 
 #define CAP_HAS_DSP     0x00000010
@@ -28,3 +44,200 @@ void efw_hw_info_has_fpga(struct hw_info *info, gboolean *has_fpga)
 {
     *has_fpga = !!(info->flags & CAP_HAS_FPGA);
 }
+
+int efw_flash_get_block_size(size_t offset, size_t *block_size)
+{
+    if (offset < 0x00010000)
+        *block_size = EFW_FLASH_BLOCK_SIZE_LOW;
+    else if (offset < 0x00200000)
+        *block_size = EFW_FLASH_BLOCK_SIZE_HIGH;
+    else
+        return -ENXIO;
+
+    return 0;
+}
+
+void efw_flash_erase(EfwProto *proto, size_t offset, GError **error)
+{
+    size_t block_size;
+    guint32 args[1] = {0};
+    guint32 *params = (guint32 [1]){0};
+    gsize param_count = 1;
+    int err;
+
+    err = efw_flash_get_block_size(offset, &block_size);
+    if (err < 0) {
+        g_set_error(error, EFW_PROTO_ERROR, -err,
+                    "%s %d: %s", __FILE__, __LINE__, strerror(-err));
+        return;
+    }
+
+    if (offset % block_size > 0) {
+        g_set_error(error, EFW_PROTO_ERROR, EINVAL,
+                    "%s %d: %s", __FILE__, __LINE__, strerror(EINVAL));
+        return;
+    }
+
+    args[0] = offset;
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_ERASE, args, G_N_ELEMENTS(args),
+                          (guint32 *const *)&params, &param_count, TIMEOUT, error);
+}
+
+void efw_flash_erase_and_wait(EfwProto *proto, size_t offset, GError **error)
+{
+    efw_flash_erase(proto, offset, error);
+    if (*error != NULL)
+        return;
+
+    while (TRUE) {
+        gboolean state;
+        struct timespec req = {
+            .tv_sec = 0,
+            .tv_nsec = 500000000,
+        };
+
+        efw_flash_state(proto, &state, error);
+        if (state == TRUE)
+            break;
+
+        if (*error != NULL)
+            g_clear_error(error);
+
+        clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
+    }
+}
+
+void efw_flash_read(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error)
+{
+    guint32 args[2] = {0};
+    guint32 *params = (guint32 [2 + EFW_FLASH_FRAME_MAX_QUADS]){0};
+    gsize param_count = 2 + EFW_FLASH_FRAME_MAX_QUADS;
+
+    if (quads > EFW_FLASH_FRAME_MAX_QUADS) {
+        g_set_error(error, EFW_PROTO_ERROR, EINVAL,
+                    "%s %d: %s", __FILE__, __LINE__, strerror(EINVAL));
+        return;
+    }
+
+    args[0] = offset;
+    args[1] = quads;
+
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_READ, args, G_N_ELEMENTS(args),
+                          (guint32 *const *)&params, &param_count, TIMEOUT, error);
+    if (*error != NULL)
+        return;
+
+    if (params[0] != offset || params[1] != quads) {
+        g_set_error(error, EFW_PROTO_ERROR, EIO,
+                    "%s %d: %s", __FILE__, __LINE__, strerror(EIO));
+        return;
+    }
+
+    memcpy(buf, (const void *)&params[2], quads * sizeof(*buf));
+}
+
+void efw_flash_recursive_read(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error)
+{
+    while (quads > 0) {
+        size_t count = MIN(quads, EFW_FLASH_FRAME_MAX_QUADS);
+
+        efw_flash_read(proto, offset, buf, count, error);
+        if (*error != NULL)
+            return;
+
+        offset += count * 4;
+        quads -= count;
+        buf += count;
+    }
+}
+
+void efw_flash_write(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error)
+{
+    guint32 args[2 + EFW_FLASH_FRAME_MAX_QUADS] = {0};
+    guint32 *params = (guint32 [2]){0};
+    gsize param_count = 2;
+
+    if (quads > EFW_FLASH_FRAME_MAX_QUADS) {
+        g_set_error(error, EFW_PROTO_ERROR, EINVAL,
+                    "%s %d: %s", __FILE__, __LINE__, strerror(EINVAL));
+        return;
+    }
+
+    args[0] = offset;
+    args[1] = quads;
+    memcpy((void *)&args[2], buf, quads * sizeof(*buf));
+
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_WRITE, args, G_N_ELEMENTS(args),
+                          (guint32 *const *)&params, &param_count, TIMEOUT, error);
+}
+
+void efw_flash_recursive_write(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error)
+{
+    while (quads > 0) {
+        size_t count = MIN(quads, EFW_FLASH_FRAME_MAX_QUADS);
+        gboolean state;
+
+        efw_flash_write(proto, offset, buf, count, error);
+        if (*error != NULL)
+            return;
+
+        offset += count * 4;
+        quads -= count;
+        buf += count;
+
+        while (TRUE) {
+            struct timespec req = {
+                .tv_sec = 0,
+                .tv_nsec = 500000000,
+            };
+
+            efw_flash_state(proto, &state, error);
+            if (state == TRUE)
+                break;
+
+            if (*error != NULL)
+                g_clear_error(error);
+
+            clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
+        }
+    }
+}
+
+void efw_flash_state(EfwProto *proto, gboolean *state, GError **error)
+{
+    gsize param_count = 0;
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_STATE, NULL, 0, NULL, &param_count,
+                          TIMEOUT, error);
+    if (*error == NULL) {
+        *state = TRUE;
+    } else if (g_error_matches(*error, EFW_PROTO_ERROR, HINAWA_SND_EFW_STATUS_FLASH_BUSY)) {
+        *state = FALSE;
+        g_clear_error(error);
+    }
+}
+
+void efw_flash_get_session_base(EfwProto *proto, size_t *offset, GError **error)
+{
+    guint32 *params = (guint32 [1]){0};
+    gsize param_count = 1;
+
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_SESSION_BASE, NULL, 0,
+                          (guint32 *const *)&params, &param_count, TIMEOUT, error);
+    if (*error != NULL)
+        return;
+
+    *offset = params[0];
+}
+
+// MEMO: Lock operation is additional to the combination of IceLynx Micro and FPGA.
+void efw_flash_lock(EfwProto *proto, gboolean locked, GError **error)
+{
+    guint32 args[1] = {0};
+    guint32 *params = (guint32 [1]){0};
+    gsize param_count = 1;
+
+    args[0] = locked;
+
+    efw_proto_transaction(proto, CATEGORY_FLASH, FLASH_CMD_LOCK, args, G_N_ELEMENTS(args),
+                          (guint32 *const *)&params, &param_count, TIMEOUT, error);
+}
diff --git a/efw-downloader/src/efw-commands.h b/efw-downloader/src/efw-commands.h
index fd2dbe3..a25781b 100644
--- a/efw-downloader/src/efw-commands.h
+++ b/efw-downloader/src/efw-commands.h
@@ -42,4 +42,16 @@ void efw_hw_info(EfwProto *proto, struct hw_info *info, GError **error);
 
 void efw_hw_info_has_fpga(struct hw_info *info, gboolean *has_fpga);
 
+void efw_flash_erase(EfwProto *proto, size_t offset, GError **error);
+void efw_flash_read(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error);
+void efw_flash_write(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error);
+void efw_flash_state(EfwProto *proto, gboolean *state, GError **error);
+void efw_flash_get_session_base(EfwProto *proto, size_t *offset, GError **error);
+void efw_flash_lock(EfwProto *proto, gboolean locked, GError **error);
+
+int efw_flash_get_block_size(size_t offset, size_t *block_size);
+void efw_flash_erase_and_wait(EfwProto *proto, size_t offset, GError **error);
+void efw_flash_recursive_read(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error);
+void efw_flash_recursive_write(EfwProto *proto, size_t offset, guint32 *buf, size_t quads, GError **error);
+
 #endif
-- 
2.25.1

