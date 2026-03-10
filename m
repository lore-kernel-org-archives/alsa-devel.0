Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C51EB1060
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:44:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECA1960172;
	Tue, 10 Mar 2026 15:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECA1960172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773153844;
	bh=PZ4pTpLCvp1+zFbZ2s96F3BSKPw6S2avYGxBwCoWgNc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ERw1vg94OAVqX0nvJi0kRG9J0LQUGmLnT/Zf0tnbcWXW2x5izfSUVGpXYYCYaUJDh
	 qdFa4OxN2VVSvzgPvhXDpWA+6NGZQT9ZTZIN+tNyZ9bOV3BHigQ74/1oHNphFh0XMk
	 8R3SiGR0M9XRurDKzuSUiz11y7LL6k2f9+LKTYdE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FE62F805EB; Tue, 10 Mar 2026 15:43:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5B6FF805EC;
	Tue, 10 Mar 2026 15:43:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42331F8053B; Tue, 10 Mar 2026 15:43:24 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E6AFF800C1
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2026 15:43:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E6AFF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189b81fd0ee3d100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/719@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/719@alsa-project.org>
Subject: Remove .gitignore from ucm2/conf.virt.d
Date: Tue, 10 Mar 2026 15:43:24 +0100 (CET)
Message-ID-Hash: XCN7U6OVFESV6HVKGONJQ7SFIYOXPO3W
X-Message-ID-Hash: XCN7U6OVFESV6HVKGONJQ7SFIYOXPO3W
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XCN7U6OVFESV6HVKGONJQ7SFIYOXPO3W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #719 was opened from nguyen140320:

Reason: 
This file is available when I fetching the source code with yocto project. This is empty now, so I think this is unnecessary. 
I belive we should remove this in upstream

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/719
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/719.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
