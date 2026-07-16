Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E25C4450A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:29:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF3F3601F6;
	Thu, 16 Jul 2026 16:28:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF3F3601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784212147;
	bh=C5fApvutXtAgcALOZr8KMyyHkGKS1mpMowc3wWHM5bE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DorwdrTG+9Zh0vhrEVQmOOToboL71Vf5RFlxvLRp0ZFSbz2ecbd4TS9Lu1ti47kSm
	 Hw5V753I15KdrfQNCY877/2GQ8e6KabMzfrcyfVUJ3AWNftEDERXN6XIiPiYrZlA4t
	 RPdv6UfyGaN9V/A70BvofJW1rIqdFMto7tyWTi1I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AE03F805FE; Thu, 16 Jul 2026 16:28:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95050F805FB;
	Thu, 16 Jul 2026 16:28:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECCD8F80527; Thu, 16 Jul 2026 16:28:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784212105;
	b=Y0aw2i/bNxQTxG4x0amZbOWYTVDRvGHrGldsWoy7OZnCkswXdTjMZjCF2LHNuRBovS2+
	 j0KyVuxoR9WoTdVRAm5Kr1G7GGto5hDLskefVXfpBHzavjKLGFGr1PXICLxiaBFK87X9D
	 M4gVnJ0hX1e8YXEFor4OElc1QBLmGjd3dXR1sEWxv10nUq8kgr7X2432aOE00pWgd+YXK
	 qfrf8QZV14mTv1Mg4dj4Zp/cQKQedVilzXfjVGCJu2Hr7ubmWqku1rLDowiOMMcsEV8WI
	 hDk7LX6MpLxxRzPtwqfBjMTsGnL1E421R63lT44vhBciMeROZK12NrzifKtyRixd4cg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784212105;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=C5fApvutXtAgcALOZr8KMyyHkGKS1mpMowc3wWHM5bE=;
	b=oU//XdLubqsVNiG3EkhkTQdQjFoos1PcdDJO5aLmmDT2rYsMA3jt71YUWrz2cH0aHK9Z
	 DXUsfz2FU6w+qie+L/kRQ7Ti0JzFKf/d+sW32kjARlgNrbqIFCxbpNsLyP7DWVIKURMU0
	 FkRE/IvsiCcgfFnolUSrR2Td4MDVyHczYjViaO2hbHl/ae8q6NYRnKD8XK6FhcbU9C59p
	 oZWHZtwGHMz0R/CGTVOdDC7G/GHu1+JL2vE3rDb6eSuK/c1HwMdkdcJccHNEOlg/HeWXK
	 pmaNTdemefs6qWRvGkLEIGjvW2pf91Ig0SDXPmvtpOj5BsQ8B9tuzbNmltJP3wS34gQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A1C4CF804FF
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 16:28:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1C4CF804FF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c2cb745e6c7300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/810@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/810@alsa-project.org>
Subject: Rockchip: Add HDMI UCM config for RK3588 simple-card outputs
Date: Thu, 16 Jul 2026 16:28:26 +0200 (CEST)
Message-ID-Hash: U2EMCAV5OYMFUVIXG6ZQPQIZX5OBKQRM
X-Message-ID-Hash: U2EMCAV5OYMFUVIXG6ZQPQIZX5OBKQRM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U2EMCAV5OYMFUVIXG6ZQPQIZX5OBKQRM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #810 was opened from julianbouzas:

RK3588 boards such as the Rock 5b expose their HDMI audio as generic simple-card sound cards:

0 [rockchiphdmi0]: simple-card - rockchiphdmi0
1 [hdmi1        ]: simple-card - hdmi1

There is no shipped UCM matching these cards, so pipewire only generates a stereo ACP profile as fallback mechanism.

Add a shared HiFi verb, matched by card long name via conf.d symlinks, exposing the single hw:,0 PCM as three mutually exclusive profiles (Stereo, 5.1 and 7.1). They are marked as ConflictingDevices so that they are presented as separate switchable profiles in pipewire.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/810
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/810.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
