Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58460106FD7D
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:00:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ABE560204;
	Fri, 13 Mar 2026 06:59:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ABE560204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773381607;
	bh=R0xOay7aCDHwnNOTO2c/kn/wvMxA6Jpstovl3JsIqiw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=s7o0CCwDBLUec8cPM+L6OrL1jhdKKgjav2t8pgeo0yzXHi6K1nzJggIb6a2eiPXzQ
	 h2PE3yFO6PV4NuUYQMqjW9p5iHkFWpFx1mhBqcIwQIOv5vKcXZnP9g0m5tURkooXGE
	 v8LqPJTnsGzZak/jD783H+e/Bx5UnIDpLdGf46jg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1237F805E7; Fri, 13 Mar 2026 06:59:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3417F805F3;
	Fri, 13 Mar 2026 06:59:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0653AF804B4; Fri, 13 Mar 2026 06:59:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4904EF800E2
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2026 06:59:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4904EF800E2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189c5122e8edb400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/722@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/722@alsa-project.org>
Subject: sof-soundwire: rt1320: add playback control switch
Date: Fri, 13 Mar 2026 06:59:26 +0100 (CET)
Message-ID-Hash: DNITEFX65H7MV3MEWPTZTFUZIH4G3TAN
X-Message-ID-Hash: DNITEFX65H7MV3MEWPTZTFUZIH4G3TAN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DNITEFX65H7MV3MEWPTZTFUZIH4G3TAN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #722 was opened from oortcomet:

This patch defines 'rt1320 OT23' as PlaybackMixerElem and a remapped one 'rt1320 OT23 Playback Switch' when using one or two amps.

And also attach rt1320 OT23 controls to speaker LED.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/722
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/722.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
