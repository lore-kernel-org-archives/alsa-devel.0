Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA4C369AB
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:55:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D8046BD6B;
	Tue, 15 Apr 2025 23:55:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D8046BD6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1744754124;
	bh=5ySA7NW4dJU6oElR2DtLk5XaHSYZ9MzzEAI6shNtC3U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RJKL8edPA2xx38XvDsGmv01QvkRy41vHi0o+Q7Y1BI8ck/Djt/9OolCmNxit1kIC6
	 rSS8nnXXiXhoitKvrZIGLD65228A758dl1r29wG/YOo1ckGqJaahXuxJppuJY7GVbG
	 sM2sUTb7KeUywpj1dWx6CRkpVZYtmfvnyuPpXMVo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15796F805D7; Tue, 15 Apr 2025 23:54:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC07F805D3;
	Tue, 15 Apr 2025 23:54:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 585AEF8021D; Tue, 15 Apr 2025 23:54:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AF352F80075
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2025 23:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF352F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18369c98733d8100-webhooks-bot@alsa-project.org>
In-Reply-To: <18369c987334e500-webhooks-bot@alsa-project.org>
References: <18369c987334e500-webhooks-bot@alsa-project.org>
Subject: No audio on Lenovo Yoga Slim 7 14ILL1
Date: Tue, 15 Apr 2025 23:54:46 +0200 (CEST)
Message-ID-Hash: LED6ZSIXHJCH46GFNWJLZ3G3VEO3ETRS
X-Message-ID-Hash: LED6ZSIXHJCH46GFNWJLZ3G3VEO3ETRS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LED6ZSIXHJCH46GFNWJLZ3G3VEO3ETRS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #548 was edited from miguel1117:

Only "Dummy Output" is available as an output device on the Lenovo Yoga Slim 7 14ILL1. I'm not absolutely sure if this is the right place to report this so apologies if it's not.

[ALSA information](https://alsa-project.org/db/?f=71342ec47d52681c81335d75d2947d89691f3c77)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/548
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
