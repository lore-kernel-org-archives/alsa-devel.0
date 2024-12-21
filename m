Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791D4E77184
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Dec 2024 10:04:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A34E760211;
	Sat, 21 Dec 2024 11:03:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A34E760211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1734775447;
	bh=Vd/gwkyGO+wi5/Z54IYFZmBHk/hh6DtLkMunLXlKH+Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VwwvEfZqmYDS1dMbvGNBUgr33H848tH4xZeu7Jp9DhrBI+rZJ94vxH+w2XvmyxPe6
	 0nFTbUUNu4Fq9COUxhmmDZxGZB2z8kab98pCIt4poJqd6YKc5zBhxCWaj9edsvg3vU
	 nF4wqSNQlaJC8BTvV8rt2l5CAYDUWFd6dssB1p+c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D285FF805C6; Sat, 21 Dec 2024 11:03:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DE01F805C2;
	Sat, 21 Dec 2024 11:03:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EA09F80524; Sat, 21 Dec 2024 11:03:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 466E8F800B0
	for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2024 11:03:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 466E8F800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1734775403716074944-webhooks-bot@alsa-project.org>
References: <1734775403716074944-webhooks-bot@alsa-project.org>
Subject: sun4i-codec: add routing for headphones and internal speaker
Message-Id: <20241221100326.3EA09F80524@alsa1.perex.cz>
Date: Sat, 21 Dec 2024 11:03:26 +0100 (CET)
Message-ID-Hash: Q6V2LJUSJKZPBHHUHU5C5XBR43PY4NCT
X-Message-ID-Hash: Q6V2LJUSJKZPBHHUHU5C5XBR43PY4NCT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q6V2LJUSJKZPBHHUHU5C5XBR43PY4NCT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #491 was opened from tokyovigilante:

The sun4i-codec kernel driver covers a large number of Allwinner SoCs. The H616 codec has a single line-out route, which is used in concert with a Toshiba mux chip to send audio to either an internal speaker or headphone jack on a number of Anbernic handheld gaming devices.

Add a UCM configuration to allow enabling/disabling the speaker amp depending on whether headphones are in use or not.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/491
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/491.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
