Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40862C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:39:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6805207DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kgl8vu85";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LWkUCJWm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtKxHcXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6805207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A58C1687;
	Fri, 21 Aug 2020 09:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A58C1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597995595;
	bh=EKIKsc8vlf/RDEl9LA+TfayqGKAGbb//XfIH5hFFcn4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kgl8vu85Lx5fEf7qNEc2fqTXljjdR5orp9kwDIon7XF+S0HURyr3ikahhjmfr73ro
	 F9lJ8wtAr8Ax/fU76oC/KuYhWXZVGb/J+zIEOJg+AvMqifnkTo6Ga0oz3NNvCGsD1C
	 1bD089PS5J6Jg9ERDg5QNOimJoDn0HPys+7z/1jU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69B96F80344;
	Fri, 21 Aug 2020 09:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 847B0F80305; Fri, 21 Aug 2020 09:31:52 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E11F5F802E8
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E11F5F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="LWkUCJWm"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AtKxHcXU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 19203891;
 Fri, 21 Aug 2020 03:31:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 21 Aug 2020 03:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=7fM+qijIwANP7
 giKcnjmRQFWV/rTRfKbQ0qtthdRPyY=; b=LWkUCJWmDxfsEbuegYaTTHKjOST3f
 3wXxuJH3RxbO0TJsEQ5dhm1/dDDLs8P4xPBXeuWg8SU7T4eJLafeYEII/vG/j0jt
 XmJZK/z1xwizq2x74yXbL8WXLH/TSGNjlHkQWze5DnwVq64Ld0Nht4UARKRPgBRq
 zJYz36XJfOD4Q5CCRnJNnHDKqKxyUo52uf4JgbkttHXKyoxAufhSAP9gtLMyMBkg
 1yvzzYq7B9E8Cm4+nIFbL+GxeLXzuGs6gbdhLa2UhimkpR1sk5lHIB8wxaDaEd2y
 I6JGP7Sg/6X271TX/2WuR4/Vw/TU5o5gqBeYFXL1vdXCE1GBvTXkVvNhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=7fM+qijIwANP7giKcnjmRQFWV/rTRfKbQ0qtthdRPyY=; b=AtKxHcXU
 KAEQkEhF8Uwl4z2/AhJH+Sis5RCfvjjv0wqmp/i8xD4muJq8JE8eRwyBNIBViTPu
 vfS+ZP1Xob7WSICC7S3q4UfcyVp/2MEGaErhsPWOakizf8MyAxvb1KvqVNQhHCbM
 +nJDnXGPosGIgTjxoKn1nABkRXSDbVoHWj2QctSARbmF+TPQlRjoMvMdU+Eh4U6l
 p+KHz+mfFk5FQiiaWpO3iaJfhSSRa8ZLYrbdmje1Ny34lx3rpu1iggFxNcGMXtod
 m4aPWQ/b8W1ylkgCopfxyV2Die8oukuJjL4h32C6xVYZJNvPNzbRZREWtBVUL6f+
 dYTciC4amJhE9A==
X-ME-Sender: <xms:WHg_X3Cuw5OdlLOnNxladIYTNF7j3zu08l-Hfzc0L__m2kyfXd1azw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudek
 tddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrg
 hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:WHg_X9gBQPDqlevMcusBfxbOdOvcl9d96BfWF2gBgA59SPk5CTtKxw>
 <xmx:WHg_XykxaccDeyYJeHpeRWKQMKppuM47dol2nxXH8SeRmAeMurdpkQ>
 <xmx:WHg_X5wwpI68uI7VMSzV69XRpQ41ue2yJohFk91BiHvkAzRTQwnHQA>
 <xmx:WHg_X3IzPmNd02medJ30rKS1OqGX3N98-pV9dsqlipHvI5Ww86N60Q>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5AEF230600B4;
 Fri, 21 Aug 2020 03:31:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH 12/25] efw-downloader: subcmd-device: open firewire character
 device by HinawaFwNode
Date: Fri, 21 Aug 2020 16:30:58 +0900
Message-Id: <20200821073111.134857-13-o-takashi@sakamocchi.jp>
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

In device sub command, all of operations require actual communication to
the target device. Linux firewire subsystem allows applications to do it
via call of ioctl to firewire character device.

This commit opens firewire character device, with assist of HinawaFwNode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 efw-downloader/src/subcmd-device.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/efw-downloader/src/subcmd-device.c b/efw-downloader/src/subcmd-device.c
index 739944e..e1be025 100644
--- a/efw-downloader/src/subcmd-device.c
+++ b/efw-downloader/src/subcmd-device.c
@@ -7,6 +7,10 @@
 
 #include "efw-proto.h"
 
+#define report_error(error, msg)                                                    \
+        fprintf(stderr, "Fail to %s: %s %d %s\n",                                   \
+                msg, g_quark_to_string(error->domain), error->code, error->message)
+
 static int print_help()
 {
     printf("Usage\n"
@@ -50,6 +54,7 @@ int subcmd_device(int argc, char **argv)
     GError *error = NULL;
     const char *path;
     const char *op_name;
+    HinawaFwNode *node;
     EfwProto *proto;
     int err;
     int i;
@@ -66,8 +71,22 @@ int subcmd_device(int argc, char **argv)
     if (i == G_N_ELEMENTS(entries))
         return print_help();
 
+    node = hinawa_fw_node_new();
+    hinawa_fw_node_open(node, path, &error);
+    if (error != NULL) {
+        if (g_error_matches(error, G_FILE_ERROR, G_FILE_ERROR_NOENT))
+            fprintf(stderr, "File not found: %s\n", path);
+        else if (g_error_matches(error, G_FILE_ERROR, G_FILE_ERROR_ACCES))
+            fprintf(stderr, "Permission denied: %s\n", path);
+        else
+            report_error(error, "open the node");
+        goto err;
+    }
+
     entry->op(argc, argv, proto, &error);
 
+    g_object_unref(node);
+err:
     if (error != NULL) {
         g_clear_error(&error);
         return EXIT_FAILURE;
-- 
2.25.1

