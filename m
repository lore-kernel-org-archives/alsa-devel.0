Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A518CEB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 17:20:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B5ED82B;
	Fri, 16 Jun 2023 19:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B5ED82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686936002;
	bh=kxwE5wMgl8ci0QpEcfScFOv0ZfFQpvRy1MgitZa/T2s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OSX+boC2J3RnYDFa+i1QaCaTWJ8q+Uoob2suhlh01Q0fPxU6E0qfMuMic1uRFyY2T
	 OP2PMDzvokGulGty9RrNO1IZGtd1/pj714bezWLucj2tNylc+OIonGoqth6HITPZAU
	 gLSI5Qith//U44XDrkCuzjbSvNi3JZH+xu/BrTA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B6FFF80132; Fri, 16 Jun 2023 19:18:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F579F80149;
	Fri, 16 Jun 2023 19:18:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9476EF80149; Fri, 16 Jun 2023 19:18:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A28FAF800BA
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 19:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A28FAF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1686935918952581644-webhooks-bot@alsa-project.org>
References: <1686935918952581644-webhooks-bot@alsa-project.org>
Subject: topology: nhlt: intel: support m/n divider and xtal/cardinal/pll
 clock source
Message-Id: <20230616171841.9476EF80149@alsa1.perex.cz>
Date: Fri, 16 Jun 2023 19:18:41 +0200 (CEST)
Message-ID-Hash: 3AJDDULDOOE7B6QLVSFSGGM6DJFWW2P6
X-Message-ID-Hash: 3AJDDULDOOE7B6QLVSFSGGM6DJFWW2P6
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3AJDDULDOOE7B6QLVSFSGGM6DJFWW2P6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #220 was edited from brentlu:

Current alsatplg supports only cardinal clock source without m/n divider. Code in SOF ssp driver is ported here to implement the divider function.

I tested the code on ADL brya device with following setting:
MCLK: 19.2MHz
BCLK: 3.072Mz (m 24 n 25)

Request URL   : https://github.com/alsa-project/alsa-utils/pull/220
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/220.patch
Repository URL: https://github.com/alsa-project/alsa-utils
