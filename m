Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB04FC83F1A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:07:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 532D760201;
	Mon, 14 Jul 2025 11:07:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 532D760201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752484065;
	bh=O+KZD/TcrhuaiPFzjl3kpVEvCMkAamGfm2HrfR1Qs1c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rn6wrNnMGg3uuEmOfUwQsUYjm8DoqD5hkDI58p3t3REE3EZZ/t/gv8YPVXkwBGq7Z
	 /05JGds0uh5ktwPTHu2gelY0u1heX17jQIyw/PcvsMpK1r9ic9TzdZErTFV1MrG4bk
	 Ozusc5fN3T16herInmpQCcqGIDyF53eh1ul8SebA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 190EAF805BF; Mon, 14 Jul 2025 11:07:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E232DF805D5;
	Mon, 14 Jul 2025 11:07:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C61E1F804E5; Mon, 14 Jul 2025 11:07:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EC0C4F800F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2025 11:06:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC0C4F800F3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185212ee499e5d00-webhooks-bot@alsa-project.org>
In-Reply-To: <185212ee49955f00-webhooks-bot@alsa-project.org>
References: <185212ee49955f00-webhooks-bot@alsa-project.org>
Subject: Feature request: Add native support for Cirrus Logic CS8409 codec
Date: Mon, 14 Jul 2025 11:07:01 +0200 (CEST)
Message-ID-Hash: 24WDWBD3PYNCJF66CUDWUHLSD2JOCUUD
X-Message-ID-Hash: 24WDWBD3PYNCJF66CUDWUHLSD2JOCUUD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/24WDWBD3PYNCJF66CUDWUHLSD2JOCUUD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #592 was opened from Marek-mahav:

-w

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/592
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
