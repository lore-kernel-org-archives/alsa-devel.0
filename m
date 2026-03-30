Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5361061B15
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:51:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCDB8601FC;
	Mon, 30 Mar 2026 18:51:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCDB8601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774889517;
	bh=+QOumF08WcnamMhxuoCp4BKXi6k5+eqJ+DqZnQH60WE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=laIvJhDR+CP0OMDdNgSzccYNMQEsWWsGnYWNneCMbi8l8aSvOnsSM6YQHTLA945W6
	 yNUs/fpM8YthIH5RKJVZEn9KZh0mLJVIuPIHaIPfdllcA3KfTPmgyBokvuZ/SBz9Jb
	 quaWGMF+lV18QiOft7GoZQxVz+9d8ahq8Btx5WHs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D179EF805B3; Mon, 30 Mar 2026 18:51:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC1F9F805E4;
	Mon, 30 Mar 2026 18:51:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20701F8052D; Mon, 30 Mar 2026 18:51:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 36AE5F80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 18:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36AE5F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a1ac921f874400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
Subject: USB-Audio: Add Audient EVO4
Date: Mon, 30 Mar 2026 18:51:14 +0200 (CEST)
Message-ID-Hash: XB2XZWNA7GOJHBQRW2A5GZTJEMOVB4SF
X-Message-ID-Hash: XB2XZWNA7GOJHBQRW2A5GZTJEMOVB4SF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XB2XZWNA7GOJHBQRW2A5GZTJEMOVB4SF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #708 was reopened from motolav:

This is a 4in/4out device with 1 analog stereo out and 2 analog mono in. 
The hardware mixed loopback interface takes up the remaining 4 channels. 
Without this UCM the device is configured as 4.0 surround for in and out. 

I copied the way Windows configures the device except for the stereo mic mix as I couldn't get it to work somehow(might have been a wiremix issue).

Needs the PlaybackMixerElem and CaptureMixerElem implemented so software volumes are tied to hardware volumes

Closes: #303

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/708
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/708.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
