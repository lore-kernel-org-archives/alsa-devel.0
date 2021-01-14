Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19543C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 08:41:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B1E239FF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 08:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B1E239FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E4861679;
	Thu, 14 Jan 2021 09:40:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E4861679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610613690;
	bh=cJ+p9xpYMdKgMtVn+BqIr9BrFG746Y0KmZJvK9pADbg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ccSxQiAC4SaCJNyYpYfThCTtVh/F2FtioWI+ufZHQtRoNYH6Nc+NFdf/HszqgM33H
	 v2AVsPgji7qpyQbSWU7kZsT1MwIH5JByyppscrjhoqCjaEq1AkROVbl5q8aRDa2g/l
	 uq0JLJ6dbK2KV4UFqR0cpM7ozYO0DWXBCBVo1/tM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D213F80249;
	Thu, 14 Jan 2021 09:40:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AA43F8025E; Thu, 14 Jan 2021 09:40:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B3319F80118
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 09:40:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3319F80118
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1610613630844088078-webhooks-bot@alsa-project.org>
References: <1610613630844088078-webhooks-bot@alsa-project.org>
Subject: Audio over HDMI via USB-C Dock broke recently - module-alsa-card.c:
 Failed to find a working profile
Message-Id: <20210114084037.7AA43F8025E@alsa1.perex.cz>
Date: Thu, 14 Jan 2021 09:40:37 +0100 (CET)
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

alsa-project/alsa-lib issue #112 was opened from asgrim:

Hi folks, not sure if this is related to #104 since I get the same error, but slightly different characteristics. Running Ubuntu 20.04.1 here.

I've got an XPS 17 9700, which is plugged into a Dell WD19TB dock via USB-C. Off that, I have a Dell 34" screen via HDMI, into which my speakers are plugged in. My headphones are plugged directly into the WD19TB dock. I do have a Yeti mic as well, which is plugged via USB into the dock also. I often switch between my speakers/headphones using a Gnome extension (I select either `Headphones (USB Audio)` or HDMI something (can't remember what it was called exactly).  However, I noticed recently (maybe last week or two?) I wasn't able to switch. Looked into it today, it's because the HDMI audio output seems completely missing. Does not show in regular Ubuntu sound settings, nor in `pavucontrol`. Checked /var/log/syslog, and found this `Failed to find a working profile` message.

Some Googling bought me here, hopefully you lovely folks can help!

* `pacmd ls` output is [here](https://gist.github.com/asgrim/1788fcae11cd1d0ced106c5d94199f29#file-pacmd)
* `pulseaudio -vvvvv` output is [here](https://gist.github.com/asgrim/1788fcae11cd1d0ced106c5d94199f29#file-pulse)

Hopefully this is just user error, but this did used to work, and I don't know where to ask for help as I know nothing about Linux audio stuff :D

Side note: I'm aware there's an issue with my XPS 17 "onboard" speakers not working, they've never worked; I believe there's a fix out there, but it looks complicated so I have so far avoided it. I'm ok with this as I've got the external speakers anyway.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/112
Repository URL: https://github.com/alsa-project/alsa-lib
