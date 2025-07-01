Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B5BC83038
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:03:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 294A3601D2;
	Tue,  1 Jul 2025 16:03:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 294A3601D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751378597;
	bh=dvZ8d4+DD8THM9oKGiIGU9lAdmmA5iVCSuZQ0DCD6G8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=D1J5K7XHSkq4p20DM8Z0ftBxNdQi3zpiZ94kFR0YLUcx4a4jfEzvypb6nHnOX9wKN
	 4eWDBPmzOKmERFdqO9g6lByVCrDQFqFqzHPeoKhhp0fIou8t6yhw+kgjDPP8kssnYC
	 Ej8XLlcrmQC/MV5Oooufsfx9ff1Gikj1+9IBz2Dc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A3B2F805D2; Tue,  1 Jul 2025 16:02:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2C3BF805CA;
	Tue,  1 Jul 2025 16:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F895F80269; Tue,  1 Jul 2025 16:02:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8509DF800B0
	for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2025 16:02:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8509DF800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184e2584836d7c00-webhooks-bot@alsa-project.org>
In-Reply-To: <184e258483659300-webhooks-bot@alsa-project.org>
References: <184e258483659300-webhooks-bot@alsa-project.org>
Subject: New Card: ESI Juli@ eX
Date: Tue,  1 Jul 2025 16:02:38 +0200 (CEST)
Message-ID-Hash: HLIHLC52UO3WY3E6UKZ4EW5BTNTQHZHL
X-Message-ID-Hash: HLIHLC52UO3WY3E6UKZ4EW5BTNTQHZHL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HLIHLC52UO3WY3E6UKZ4EW5BTNTQHZHL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #462 was opened from Carlisle96:

I am not sure where to ask or how to report this:

There was a new card released ESI-Audio Juli@ eX
https://www.esi-audio.com/products/juliaex/ 

I am wondering if this is supported or planned to be supported. 
It is not yet listed here: https://www.alsa-project.org/wiki/Matrix:Vendor-ESI

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/462
Repository URL: https://github.com/alsa-project/alsa-lib
