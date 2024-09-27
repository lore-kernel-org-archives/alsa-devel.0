Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC92CF6483
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:37:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D9F3E68;
	Fri, 27 Sep 2024 23:36:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D9F3E68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727473019;
	bh=5xqgEfm9H1HE+QGR5POorwiRGEAHqSdUuTHo126n9LA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Jsxtz8B4SmFP2YCFvt448iSSGWkr7/2lszyv0clHC9od6dQEtv+AyKeKft7B7S671
	 hu2pjuwatKNi99mAEtxO2qiMBuTs71TARBCj73P5KJH7t8AzSG6v0JHynMLNmyNsz7
	 ZfXzaU22YmbUaEBbvV7+DVgJTSzF38ij3kZ8Xwm8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 430F3F80518; Fri, 27 Sep 2024 23:36:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE3AEF8047C;
	Fri, 27 Sep 2024 23:36:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96C87F802DB; Fri, 27 Sep 2024 23:36:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B9105F8010B
	for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2024 23:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9105F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1727472977031108379-webhooks-bot@alsa-project.org>
References: <1727472977031108379-webhooks-bot@alsa-project.org>
Subject: No sound from XonarDX
Message-Id: <20240927213619.96C87F802DB@alsa1.perex.cz>
Date: Fri, 27 Sep 2024 23:36:19 +0200 (CEST)
Message-ID-Hash: NYKUYSAVEP7BJKYS2BXKQ7KNSRWNEUPJ
X-Message-ID-Hash: NYKUYSAVEP7BJKYS2BXKQ7KNSRWNEUPJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NYKUYSAVEP7BJKYS2BXKQ7KNSRWNEUPJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #408 was reopened from 3bitbrain:

No matter what wiki or advice I try, no sound at all from a known good Xonar DX card.
Distro : Gentoo, fresh install.
Always un-muted everything in the console alsamixer.

alsa-lib version 1.2.11

[alsa.txt](https://github.com/user-attachments/files/16697602/alsa.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/408
Repository URL: https://github.com/alsa-project/alsa-lib
