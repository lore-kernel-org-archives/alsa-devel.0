Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF874C83F1A
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jul 2025 04:50:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F313601F8;
	Thu, 24 Jul 2025 06:50:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F313601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1753332653;
	bh=ZBJ4+J8VQ5Xb5rkqPTJXFJw2FkGS6kWGNq0yXVeJbgk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TjQBzzG42/5v7AkDv2XpbtOBLGp60rfIQXP0X3CEiZZ3X9WlAvRnAqoOYnLX+bahs
	 hvSTB8kokNp/IFWi4ikMekdoAdaUJvymcvdZb7/HVFHokUc2reUlJ+a1Al/WoIQ6EW
	 FFQaG8Dgn59BgwoV+8PXgcWkhUJmfJ3raysTGToY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB41BF805D2; Thu, 24 Jul 2025 06:50:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 412AEF805D4;
	Thu, 24 Jul 2025 06:50:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BBE6F804E5; Thu, 24 Jul 2025 06:49:43 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E6E3F80134
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2025 06:49:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E6E3F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185516b03b8ad700-webhooks-bot@alsa-project.org>
In-Reply-To: <185516b0380ae500-webhooks-bot@alsa-project.org>
References: <185516b0380ae500-webhooks-bot@alsa-project.org>
Subject: New Card: ESI Juli@ eX
Date: Thu, 24 Jul 2025 06:49:43 +0200 (CEST)
Message-ID-Hash: L4QNTGD3UNTOYVJJ72555AQYRZKNVGR6
X-Message-ID-Hash: L4QNTGD3UNTOYVJJ72555AQYRZKNVGR6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L4QNTGD3UNTOYVJJ72555AQYRZKNVGR6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #462 was reopened from Carlisle96:

I am not sure where to ask or how to report this:

There was a new card released ESI-Audio Juli@ eX
https://www.esi-audio.com/products/juliaex/ 

I am wondering if this is supported or planned to be supported. 
It is not yet listed here: https://www.alsa-project.org/wiki/Matrix:Vendor-ESI

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/462
Repository URL: https://github.com/alsa-project/alsa-lib
