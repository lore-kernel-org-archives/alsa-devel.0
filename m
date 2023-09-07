Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6162EEC875E
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Sep 2023 21:16:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72762852;
	Thu,  7 Sep 2023 23:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72762852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694121375;
	bh=ZSCrVTvHHb+4mfQHpL35oAqtu4nAoecpFq8Tby3s2vw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ilemDsdTU9qdY/tyMuCeiyaJAch+LfdGQT66iPhQJG4ljd1mERacRzUfikWhbmvF0
	 PrLCXarH59xKBWPb30cJGRSJIY3gV0K4Dpvt8tUBsPnb0VW6ZT+uexOo6Zelg6yjQD
	 5+M9WTHLZe8M3totTtAmovztZTUGS+2oIZv98rIE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E9B3F800AA; Thu,  7 Sep 2023 23:14:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1CD3F80494;
	Thu,  7 Sep 2023 23:14:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9329FF80494; Thu,  7 Sep 2023 23:14:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 895B5F80431
	for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2023 23:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 895B5F80431
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694121289943583727-webhooks-bot@alsa-project.org>
References: <1694121289943583727-webhooks-bot@alsa-project.org>
Subject: pcm: fix signed overflow in pcm_softvol
Message-Id: <20230907211452.9329FF80494@alsa1.perex.cz>
Date: Thu,  7 Sep 2023 23:14:52 +0200 (CEST)
Message-ID-Hash: VMD47AOL2D5X46XZNU4OGKLIGKOQ3R2H
X-Message-ID-Hash: VMD47AOL2D5X46XZNU4OGKLIGKOQ3R2H
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VMD47AOL2D5X46XZNU4OGKLIGKOQ3R2H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #351 was opened from q66:

This fixes functionality on specific setups with UBSan.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/351
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/351.patch
Repository URL: https://github.com/alsa-project/alsa-lib
