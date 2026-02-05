Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CB4ECD997
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:36:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36354601DB;
	Thu,  5 Feb 2026 20:36:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36354601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770320197;
	bh=L8JyNKJYuV6dayru7ZO4fUVnw4mVh4u/1REjf53ji3w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=V/XeoeFDvvAQd0m26CMGdb4ZfNj8AnwmjEzT2MnezHIIXuE/6LmdFLryqWESMmmtd
	 6yjAtFSkiFWS7m5bO/jdVK+37qfpaEM5kbnwloMkK5XXjUa3FKrvNdRcnsTRCSRVlw
	 oHka1PzHQZaFwbu2xc45CrVNgRSACdJbbInY3Jkg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5037F805ED; Thu,  5 Feb 2026 20:36:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EC84F805EE;
	Thu,  5 Feb 2026 20:36:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFB0CF8051E; Thu,  5 Feb 2026 20:33:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 77E74F8010B
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2026 20:33:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77E74F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189170a7dcbeae00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/701@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/701@alsa-project.org>
Subject: USB-Audio: Motu: M6-HiFi.conf - m6 has only 4 outputs, not 6
Date: Thu,  5 Feb 2026 20:33:18 +0100 (CET)
Message-ID-Hash: BE4GEBLNWLHWDE6GHVIGVFXYPT4JTWDC
X-Message-ID-Hash: BE4GEBLNWLHWDE6GHVIGVFXYPT4JTWDC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BE4GEBLNWLHWDE6GHVIGVFXYPT4JTWDC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #701 was opened from damex:

hi, here is the fix for https://github.com/alsa-project/alsa-ucm-conf/issues/700

motu m6 has 6 input and 4 outputs. https://motu.com/products/m-series/m6 'The M6 is a 6-in/4-out USB-C audio interface...'

in config it is listed as 6 outputs and that throws ALSA UCM error.

adjusting configuration on working system makes error go away.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/701
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/701.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
