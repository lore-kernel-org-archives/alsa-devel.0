Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 07:34:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0CB64D79
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 07:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0CB64D79
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EF1D167F;
	Fri, 19 Mar 2021 08:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EF1D167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616139287;
	bh=7+gq7h0ombRWm06C4jUsVlpF5GlKvYLiEV817MWj1vE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AbH55YfnhuhiRE/J25dEXMdjbN3fiexShAHzn3aLoq2NLvK6l972ePJZQMGI7PBJE
	 7kLbkVrud/ULV+6T5tPEhqx1L2lPtQMJCsYXc+FTOcGLdgZNQO/tQBLVtPwAd9PKqQ
	 jKO7tjySa8+3uDhERDhv/H3qbLsu8isHrth+sqKE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E48D0F801F7;
	Fri, 19 Mar 2021 08:33:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1E9FF8021C; Fri, 19 Mar 2021 08:33:54 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5EC0EF800E0
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 08:33:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EC0EF800E0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1616139226628271103-webhooks-bot@alsa-project.org>
References: <1616139226628271103-webhooks-bot@alsa-project.org>
Subject: Very unstable and broken after audio device switching, reboots,
 multimedia app usage etc etc etc
Message-Id: <20210319073354.F1E9FF8021C@alsa1.perex.cz>
Date: Fri, 19 Mar 2021 08:33:54 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #127 was edited from oliiix:

To me this seems to be a huge issue for years now. Running Ubuntu 20.10 very latest.
I'm using an Astro A50 and two HDMI Displays for playing audio plus there's two more outputs I'm not really using. But as soon as the computer ran a little long (yes, that's actually enough to cause problems, probably due to certain apps like Unreal engine and games!), came out of sleep or I switch playback devices (which I'm doing very often and that shouldnt be ANY issue), things get seriously mixed up. Suddenly the routing goes all wrong (i select one output device, another plays instead, or just no sound at all). Sometimes "no sound" problem gets fixed by just switching devices about 10-20! times until sound is back (it either works or doesn't but that it starts working again after ten times switching devices is very weird behavior). Reinstalling as well as resetting alsa doesn't do anything to remedy no sound, restarting computer doesn't fix sound problems, only switching devices ten times does! Alsa Mixer doesn't show any controls for my A50, yet it often works even if some pro
 files are to low volume and the one that has good volume there I can't hear audio that comes from behind me (I have the no sound issue also on my HDMI outputs, just saying). Pavucontrol on the other hand lists my A50 but doesn't show one of my HDMI displays. I mean what is going wrong here (for years)??? I mean I found forum posts about these  issues that reach back years in time -.- When will we have proper working audio where audio device switching on linux is possible without any problems and the sound doesn't just "give up" after some time?

maybe someone should create one all including audio software system structure instead of several packages that are unable to work together properly... can't be that two apps (pavucontrol and pulseaudio) that work on top on alsa show different devices and settings to begin with

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/127
Repository URL: https://github.com/alsa-project/alsa-lib
