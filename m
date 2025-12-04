Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099FFD2168E
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:30:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B88B60217;
	Thu,  4 Dec 2025 16:29:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B88B60217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764862202;
	bh=ECfzbFzfISJDuTRIPfxgVusUXKWys9UcLTECyh+NdCo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mdFI/iGY3ngABmNfBpYIEcNrXaeuRnrOZV7IgZzRT7BXymqDdGu5bZR4yYL+1wk8j
	 lerYM6fRo7TtG8GzEbKCrEXygKqRO5++I+ds7p4chyskbJ0FSKwPG6IAjaTMC2nh6N
	 cO0A37jT5kwTp1iTTE0ehsm8rEGbhp8SMPPrJSIE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D426F805D4; Thu,  4 Dec 2025 16:29:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F145AF805D2;
	Thu,  4 Dec 2025 16:29:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF59CF80542; Thu,  4 Dec 2025 16:29:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B818F8016E
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2025 16:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B818F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187e0cc6ff9ba700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/654@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/654@alsa-project.org>
Subject: DRAFT [for alsa-lib 1.2.15] USB-Audio: add support for conf.d
 configurations
Date: Thu,  4 Dec 2025 16:29:16 +0100 (CET)
Message-ID-Hash: CQM72THT67CAPAUL3VIZLO4RUSAJBMVF
X-Message-ID-Hash: CQM72THT67CAPAUL3VIZLO4RUSAJBMVF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQM72THT67CAPAUL3VIZLO4RUSAJBMVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #654 was opened from perexg:

It may be useful to add new or override specific hardware configurations until they are merged to the main USB-Audio.conf file.

BugLink: https://github.com/alsa-project/alsa-ucm-conf/issues/609

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/654
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/654.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
