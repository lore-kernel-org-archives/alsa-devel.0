Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30988C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:44:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6672078D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ox/2t3Xt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DVHrBwQe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SmlxBYD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6672078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17DDA16AF;
	Fri, 21 Aug 2020 09:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17DDA16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597995853;
	bh=lE7AyOUk95e6UffPn8xB2yiAY9ZfrT9O2QbO4Ak+iTw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ox/2t3XtsDtnvjJA8nKgSmW3N9+YraHZlnbEjMvaaNzVCG4mSitrWVy7MeJCyX71P
	 twR+a4za/GWrBQiEuxXqb9038RZM2GMfS6yvmDfmvFVESlLMJabDiqO1g3SsXmkEYC
	 thJ1nRBu/3agoLmLiVa+bTY4S087o/VUZ9KJu3zE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C4A2F8037F;
	Fri, 21 Aug 2020 09:32:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDCA0F8033D; Fri, 21 Aug 2020 09:32:08 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 266FFF802DC
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 266FFF802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="DVHrBwQe"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="SmlxBYD0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 57F19885;
 Fri, 21 Aug 2020 03:31:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 21 Aug 2020 03:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=/ku8qMBURHYag
 jJHbBMdrFe0VzeXd9Y+T4h9H2xVdZI=; b=DVHrBwQe+K/O1Ela+x2jnnfOCZwka
 str73OtOXIVVSuTMT7YalAE/8cUASuPsZht/79gTT16Db/dGcs8XGOLOJ8vzQ/q4
 1U6Sb1IwswCByaPhSfSNxfAbGja4hnJE8ZDnGKL1Z2w0M3YQZlFEw7kxOWxS2FEk
 s4h+Y2+A4ohuAAoXEdZ0dzDb/V+VBsxRrY6+9n1z/gcXbrXTEr+H+vgNpdOUo61W
 YaDpuNEKX1f+J/ixT7NAheTFCeW8WInplYKVEqJLg7GynKKs92LNZZaaRkanRS3C
 UwoSBVyaq+WwR+ltcxI7dzxY6LIDOqRhXFN+kGBaTBF9kfwOIEgDGe6og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=/ku8qMBURHYagjJHbBMdrFe0VzeXd9Y+T4h9H2xVdZI=; b=SmlxBYD0
 Ki1/Erd+1SPBqqFTFgEjkOgjXNrOXGrUivhLbyawbWcIh6wZhEz1q3tQtn4nGiCP
 8zD5Vwt5wRc0qXDdJQHrSy62s2kCZIDgVbktWY238BxS3UamWGrwkJQQcZvK74Ev
 aforb/3oHp+nrJNlEqAdCJcCTvJwzytgVlGkn6XS7YLYFyXMs1SHmt25wc6TxvYu
 SfTLHPyZ1FNBszNkGH4m9QAvpCg6Uu531yXYfWqF8la19HZpa/saIBIOIm3bI9aW
 U8ka12xnngXXMGVrZLR5iigUx3eoaqxw/gS4rUlbtoNhkRb8w7fShqhFnH5bPSIR
 n/FXUfdBOvTzug==
X-ME-Sender: <xms:Yng_X8ytMUgpd1Q27yCwwRjK4nHaQGBWQZVET8Xmt8mratHzUB1Rgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudek
 tddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgepudeinecurfgrrhgrmhepmh
 grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Yng_XwRkUsfD5SHQQmfqO9mkZvg7DpdLO4uKJBqe8l7qkVFchNJ_9A>
 <xmx:Yng_X-WFAIfJUlLyFa-863IAWnKOVN1BaZbNy-G7UF3HX9xeIxKg-Q>
 <xmx:Yng_X6gshD0A3MgL-LzF_Lf0Q539JbRWDYwQmn0g7wx3misGMk-OhA>
 <xmx:Yng_X_4kZe2h2H7aQDtnA_cyTL6iAjaFHCguE01Pi4alucpQ3mkvmQ>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 37B8330600B7;
 Fri, 21 Aug 2020 03:31:44 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH 18/25] efw-downloader: efw-commands: add support for a part of
 hardware command
Date: Fri, 21 Aug 2020 16:31:04 +0900
Message-Id: <20200821073111.134857-19-o-takashi@sakamocchi.jp>
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

Fireworks protocol includes command to retrieve information about
hardware.

This commit implements the command and local helper functions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 efw-downloader/src/efw-commands.c | 30 +++++++++++++++++++++
 efw-downloader/src/efw-commands.h | 45 +++++++++++++++++++++++++++++++
 efw-downloader/src/meson.build    |  2 ++
 3 files changed, 77 insertions(+)
 create mode 100644 efw-downloader/src/efw-commands.c
 create mode 100644 efw-downloader/src/efw-commands.h

diff --git a/efw-downloader/src/efw-commands.c b/efw-downloader/src/efw-commands.c
new file mode 100644
index 0000000..08b0114
--- /dev/null
+++ b/efw-downloader/src/efw-commands.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-3.0-or-later
+// Copyright (c) 2020 Takashi Sakamoto
+#include <stdio.h>
+#include <errno.h>
+#include <time.h>
+
+#include "efw-commands.h"
+
+// Categories in Echo Audio Fireworks protocol.
+#define CATEGORY_HW             0
+
+// Commands in hardware category.
+#define HW_CMD_INFO             0
+
+#define TIMEOUT 200
+
+#define CAP_HAS_DSP     0x00000010
+#define CAP_HAS_FPGA    0x00000020
+
+void efw_hw_info(EfwProto *proto, struct hw_info *info, GError **error)
+{
+    gsize param_count = sizeof(*info) / sizeof(guint32);
+    efw_proto_transaction(proto, CATEGORY_HW, HW_CMD_INFO, NULL, 0,
+                          (guint32 *const *)&info, &param_count, TIMEOUT, error);
+}
+
+void efw_hw_info_has_fpga(struct hw_info *info, gboolean *has_fpga)
+{
+    *has_fpga = !!(info->flags & CAP_HAS_FPGA);
+}
diff --git a/efw-downloader/src/efw-commands.h b/efw-downloader/src/efw-commands.h
new file mode 100644
index 0000000..fd2dbe3
--- /dev/null
+++ b/efw-downloader/src/efw-commands.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-3.0-or-later
+// Copyright (c) 2020 Takashi Sakamoto
+#ifndef __EFW_CMDS_H__
+#define __EFW_CMDS_H__
+
+#include "efw-proto.h"
+
+struct hw_info {
+    guint32 flags;
+    guint32 guid_hi;
+    guint32 guid_lo;
+    guint32 type;
+    guint32 version;
+    guint32 vendor_name[8];
+    guint32 model_name[8];
+    guint32 supported_clocks;
+    guint32 amdtp_rx_pcm_channels;
+    guint32 amdtp_tx_pcm_channels;
+    guint32 phys_out;
+    guint32 phys_in;
+    guint32 phys_out_grp_count;
+    guint32 phys_out_grp[4];
+    guint32 phys_in_grp_count;
+    guint32 phys_in_grp[4];
+    guint32 midi_out_ports;
+    guint32 midi_in_ports;
+    guint32 max_sample_rate;
+    guint32 min_sample_rate;
+    guint32 dsp_version;
+    guint32 arm_version;
+    guint32 mixer_playback_channels;
+    guint32 mixer_capture_channels;
+    guint32 fpga_version;
+    guint32 amdtp_rx_pcm_channels_2x;
+    guint32 amdtp_tx_pcm_channels_2x;
+    guint32 amdtp_rx_pcm_channels_4x;
+    guint32 amdtp_tx_pcm_channels_4x;
+    guint32 reserved[16];
+};
+
+void efw_hw_info(EfwProto *proto, struct hw_info *info, GError **error);
+
+void efw_hw_info_has_fpga(struct hw_info *info, gboolean *has_fpga);
+
+#endif
diff --git a/efw-downloader/src/meson.build b/efw-downloader/src/meson.build
index c43c332..73a0f36 100644
--- a/efw-downloader/src/meson.build
+++ b/efw-downloader/src/meson.build
@@ -16,6 +16,7 @@ sources = [
   'efw-proto.c',
   'config-rom.c',
   'node-dispatcher.c',
+  'efw-commands.c',
   'subcmd-device.c',
 ]
 
@@ -23,6 +24,7 @@ headers = [
   'efw-proto.h',
   'config-rom.h',
   'node-dispatcher.h',
+  'efw-commands.h',
   'subcmds.h',
 ]
 
-- 
2.25.1

