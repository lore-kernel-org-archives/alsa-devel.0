Return-Path: <SRS0=HN0C=B2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C7C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:46:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456D12065C
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VOyTRdte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456D12065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marcan.st
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA0C41665;
	Sun, 16 Aug 2020 10:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA0C41665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597567578;
	bh=Q3wcZchFNqELRbQ/xtZy0TGCNsLvm0i7RXJTe48IuAQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VOyTRdteTMgcaanNJldk5SpGwqx46+9x4bv7jiG9CeAX/abGrtbDQTdBrjfXMN/wu
	 MceaVW9U+oZ2Was/FRb2fcDJCsM0t7P5XQ7KdH9GI0ch09D1zicCM1HcyBp2i6pWLZ
	 uBEPLgxyztUTwnGwGK+/AItmWH84pQ5YJ8RHhD/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80543F80279;
	Sun, 16 Aug 2020 10:44:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29643F802A1; Sun, 16 Aug 2020 10:44:51 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46C35F800C8
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2020 10:44:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46C35F800C8
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: hector@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 73B5E4261A;
 Sun, 16 Aug 2020 08:44:38 +0000 (UTC)
From: Hector Martin <marcan@marcan.st>
To: alsa-devel@alsa-project.org
Subject: [PATCH] usb-audio: Update documentation comment for MS2109 quirk
Date: Sun, 16 Aug 2020 17:44:31 +0900
Message-Id: <20200816084431.102151-1-marcan@marcan.st>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Hector Martin <marcan@marcan.st>
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

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 sound/usb/quirks-table.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d79e3ddc5690..72cc03e7aed1 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3714,8 +3714,8 @@ ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* Asrock TRX40 Creator */
  * they pretend to be 96kHz mono as a workaround for stereo being broken
  * by that...
  *
- * They also have swapped L-R channels, but that's for userspace to deal
- * with.
+ * They also have an issue with initial stream alignment that causes the
+ * channels to be swapped and out of phase, which is dealt with in quirks.c.
  */
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-- 
2.27.0

