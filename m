Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E6C54754
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 08:07:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F55461C71;
	Thu, 15 May 2025 10:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F55461C71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747296170;
	bh=rn234ZM7sXQ05Sa+4BN7aL0VKP6jVOT0x5iNJqH84xg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AuZZ3aQvTpoB+wBDHKDYLy6+xfPb5RYer3Ewt07VOGUhc9rm/qn+TFHIurFNfEvKH
	 pFrI5RCVP//DbYvNcyRTVPs4d3K4lnHSEyV6qdRRIfTs7kbISN2U0HATtGYlgJXAF3
	 u5574Fry2zlSdYshO0eP3i/Jp46AGJYKrg6JYMRU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1DB18F8074D; Sun, 11 May 2025 11:19:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1123DF8071D;
	Sun, 11 May 2025 11:19:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C572F80683; Sun, 11 May 2025 11:19:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B4386F8067E
	for <alsa-devel@alsa-project.org>; Sun, 11 May 2025 11:19:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4386F8067E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183e6e7c5cd98000-webhooks-bot@alsa-project.org>
In-Reply-To: <183e6e7c5cd01500-webhooks-bot@alsa-project.org>
References: <183e6e7c5cd01500-webhooks-bot@alsa-project.org>
Subject: ALSA UCM error for Scarlett 18i20 Gen2 with new profile introduced in
 1.2.14
Date: Sun, 11 May 2025 11:19:48 +0200 (CEST)
Message-ID-Hash: UDPC74PSRA6KZULXUVNJNRH27MY5VOOO
X-Message-ID-Hash: UDPC74PSRA6KZULXUVNJNRH27MY5VOOO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UDPC74PSRA6KZULXUVNJNRH27MY5VOOO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #559 was opened from chw90:

I run the Focusrite 18i20 Gen2 on Arch Linux and the recent update of alsa-ucm-conf from 1.2.13-2 to 1.2.14-2 broke the audio output of my device.

`May 11 10:33:55 chw90 wireplumber[1636]: spa.alsa: Error in ALSA UCM profile for _ucm0009.hw:USB,0 (HiFi: Direct 2: source): CaptureChannels=20 > avail 18`

Reverting to 1.2.13-2 fixes the problem.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/559
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
