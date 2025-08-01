Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C8C87FCB
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:06:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23B7260284;
	Fri,  1 Aug 2025 18:06:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23B7260284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754064407;
	bh=VMjUAVkdYgn0m8wVfRGJfBVsiKUfZ1IdohuADgPyIKI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=b29SUZEFmNQWqJwpOYLyejdlmEGgJIZVf5RCH0w2DWKBItuOpxYDcmwq0+PDdjLW8
	 TSZgMOA6nE4T3MO9lKKOT5qqbm5+0Fy3ND8X7ahQ4grf5lZcp2Pz08Jjw37o9vyblR
	 Op8VdY1PGr4nL5sSCsXZXG0g/ZpeNX1RwRnge2Lc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD42EF805D5; Fri,  1 Aug 2025 18:06:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DD9DDF805C7;
	Fri,  1 Aug 2025 18:06:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AAACF8052D; Fri,  1 Aug 2025 18:05:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 61F63F8012A
	for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2025 18:05:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61F63F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1857b032986cc500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/470@alsa-project.org>
References: <alsa-project/alsa-lib/pr/470@alsa-project.org>
Subject: conf/pistachio: fix syntax
Date: Fri,  1 Aug 2025 18:05:18 +0200 (CEST)
Message-ID-Hash: EWRQT4VJTB3BODBWQKJTFRV6EKSWJ5YS
X-Message-ID-Hash: EWRQT4VJTB3BODBWQKJTFRV6EKSWJ5YS
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EWRQT4VJTB3BODBWQKJTFRV6EKSWJ5YS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #470 was opened from blino:

It was missing closing brackets since its introduction.

Fixes: 4dfa8f08fb83 ("conf/cards: add support for pistachio-card.")

Request URL   : https://github.com/alsa-project/alsa-lib/pull/470
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/470.patch
Repository URL: https://github.com/alsa-project/alsa-lib
