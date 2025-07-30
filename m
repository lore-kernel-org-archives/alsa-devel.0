Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E286C87FDA
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Aug 2025 07:22:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 680F460276;
	Mon,  4 Aug 2025 09:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 680F460276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754292119;
	bh=oIzyWmAeFK6YgCfn98Wc23JYDRn4luDgLFkFv001LP8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=gwJ/4p0Hs5BFxjP/6V7YAjOK72Ek5TcKlEGtk226QJkLe1cW2qf3XCefLL5mpXIoB
	 +Wusutjm/iH/Dh7ZOxDLzLd9LFKjJIoYi6wIMp98kCWDuEO/zXLpmYGVLacaP+IYTR
	 44w7CzNK9lM2LvvsvQN5jEv2bfL2s/xxaUflYP0Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CFB1F805D5; Mon,  4 Aug 2025 09:21:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1BF6F805D6;
	Mon,  4 Aug 2025 09:21:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3733F80254; Wed, 30 Jul 2025 14:19:08 +0200 (CEST)
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 809FCF80152
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2025 14:19:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 809FCF80152
From: Jochen Sprickerhof <git@jochen.sprickerhof.de>
To: alsa-devel@alsa-project.org
Cc: Jochen Sprickerhof <git@jochen.sprickerhof.de>
Subject: [PATCH] ucm: use close_range on _GNU_SOURCE
Date: Wed, 30 Jul 2025 14:19:01 +0200
Message-ID: <20250730121901.117101-1-git@jochen.sprickerhof.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: jochen@sprickerhof.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: QBFFSQRYDUWKSXQK6FRA5XZGEC7J4ESC
X-Message-ID-Hash: QBFFSQRYDUWKSXQK6FRA5XZGEC7J4ESC
X-Mailman-Approved-At: Mon, 04 Aug 2025 07:21:04 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QBFFSQRYDUWKSXQK6FRA5XZGEC7J4ESC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

---
 src/ucm/ucm_exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/ucm/ucm_exec.c b/src/ucm/ucm_exec.c
index 276cf592..b79a84ae 100644
--- a/src/ucm/ucm_exec.c
+++ b/src/ucm/ucm_exec.c
@@ -254,8 +254,12 @@ int uc_mgr_exec(const char *prog)
 
 		close(f);
 
+#if defined(_GNU_SOURCE)
+		close_range(3, maxfd, 0);
+#else
 		for (f = 3; f < maxfd; f++)
 			close(f);
+#endif
 
 		/* install default handlers for the forked process */
 		signal(SIGINT, SIG_DFL);
-- 
2.50.0

