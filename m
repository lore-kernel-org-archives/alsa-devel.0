Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6140CA1016
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Sep 2025 04:35:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2E1A6020D;
	Thu, 11 Sep 2025 06:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2E1A6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757565339;
	bh=9e+rSuEIjRJXhpAo5YKJ9t3XAp+u8BLxrsx9voggygI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cYQAKGudyy2dMqcN7pe3AUmDmJncwGrTiXx/V5vnlqCxmvqkE35ktfALKAFjd0Q5H
	 DD1vO1gM9jlhFtVzV2P5dEDnneH4V/CEGoniJ9LL9FYVgb0sx9Nb7t+YEqHZ2UiSS5
	 PuRfGiRFV5y2+qIPvGyoPp3BzhVxhIlgMCJhrm0o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDA11F805C4; Thu, 11 Sep 2025 06:35:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 081D7F8056F;
	Thu, 11 Sep 2025 06:35:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD5EEF80518; Thu, 11 Sep 2025 06:33:49 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B3F81F800E3
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2025 06:33:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3F81F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1864204315316700-webhooks-bot@alsa-project.org>
In-Reply-To: <18642043152b3e00-webhooks-bot@alsa-project.org>
References: <18642043152b3e00-webhooks-bot@alsa-project.org>
Subject: Internal microphone (Conexant SN6140) detected but shows
 inactive/unplugged on Lenovo IdeaPad Slim 5 16AKP10 83HY after alsa-ucm-conf
 1.2.14
Date: Thu, 11 Sep 2025 06:33:49 +0200 (CEST)
Message-ID-Hash: ZSVSHJ5GMXPVQZPIBFEZHTGNTEBCYTWC
X-Message-ID-Hash: ZSVSHJ5GMXPVQZPIBFEZHTGNTEBCYTWC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSVSHJ5GMXPVQZPIBFEZHTGNTEBCYTWC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #612 was edited from JayJaber:

On a Lenovo IdeaPad Slim 5 16AKP10 83HY with Conexant SN6140 codec, the internal microphone works correctly with alsa-ucm-conf 1.2.13-2, but with 1.2.14 and newer it is not detected and shows up as inactive/unplugged.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/612
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
