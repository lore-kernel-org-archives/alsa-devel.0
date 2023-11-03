Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD14C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Nov 2023 23:09:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9551829;
	Sat,  4 Nov 2023 00:08:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9551829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699052949;
	bh=2EwYv4tkMbwkO7NgqybtC3PiCsUBewVgN7F8QnxDsMY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gA+ULTnL+L8dwn4QGsScFEnuiUek15M4BcrjDxwSEJWIEofXVWIXAJ1Ro76MWso1c
	 t8rhZ3XW2k6NI2JRPo2HpeqMEdlQw4Wp3woelXcTJhBdDg+WUPFK4E+iURRMjp8Daf
	 IzH1N7GFARNlwnjXSOu811sed4kKKniFvrVyhEoo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51059F8055B; Sat,  4 Nov 2023 00:07:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06BC8F80290;
	Sat,  4 Nov 2023 00:07:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3AB0F80290; Sat,  4 Nov 2023 00:07:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D118F8014B
	for <alsa-devel@alsa-project.org>; Sat,  4 Nov 2023 00:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D118F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1699052855629006624-webhooks-bot@alsa-project.org>
References: <1699052855629006624-webhooks-bot@alsa-project.org>
Subject: No sound in OS when suspending `aplay` process
Message-Id: <20231103230739.D3AB0F80290@alsa1.perex.cz>
Date: Sat,  4 Nov 2023 00:07:39 +0100 (CET)
Message-ID-Hash: TDQJOGJJTPLKOUOJNY6SJSOA2P7VMIW2
X-Message-ID-Hash: TDQJOGJJTPLKOUOJNY6SJSOA2P7VMIW2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TDQJOGJJTPLKOUOJNY6SJSOA2P7VMIW2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #243 was opened from syduki:

I'm using the [flac tool](https://xiph.org/flac/documentation_tools_flac.html) + `aplay` combo to play my lossless audio files, something like following:

`flac -cds filename.flac | aplay`

I usually suspend this process with `ctrl+z` when I need to temporarily switch to another sound-enabled application. That worked until recently when I upgraded my OS (Ubuntu 23.10, aplay-1.2.9, was 1.2.8). Now when suspending that process there is no sound at all in any of applications nor system.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/243
Repository URL: https://github.com/alsa-project/alsa-utils
