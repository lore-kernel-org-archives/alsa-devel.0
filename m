Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C669ECD99A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:51:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9617601F2;
	Thu,  5 Feb 2026 20:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9617601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770321094;
	bh=SuVAF+Q3tHU29LTXtRDIInVYF+tEIniy3dogdLcPRaI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tec2/1TeOWsHFmh9m24odGs8kglKaBI6MHwLyVY9/O0L47mzKCkasz656vO3EVt42
	 sKLJUbunHSHsXkOyE5QmKjbMnzWnUaaa7o5UjopoO7hnv87HlhoTbvEq6dMgVLV8Iz
	 BtiImxXuxPPXKK+muFIwbQtKCiYc2ac4dLtiApYk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7812F805F2; Thu,  5 Feb 2026 20:51:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 004E0F805EC;
	Thu,  5 Feb 2026 20:51:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DB02F8051E; Thu,  5 Feb 2026 20:46:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A9383F8016E
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2026 20:46:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9383F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1891715ff53e2200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/702@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/702@alsa-project.org>
Subject: USB-Audio: MOTU M6 - fix playback channels
Date: Thu,  5 Feb 2026 20:46:42 +0100 (CET)
Message-ID-Hash: D55GYFPJHGUJTXWQQZTIPK2JM3XOCDKW
X-Message-ID-Hash: D55GYFPJHGUJTXWQQZTIPK2JM3XOCDKW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D55GYFPJHGUJTXWQQZTIPK2JM3XOCDKW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #702 was opened from puleglot:

There is only one incorrect instance of playback HWChannels. Fix it.

Closes: #700

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/702
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/702.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
