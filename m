Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F81099B56
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Mar 2026 01:22:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CC2A601EE;
	Sat, 21 Mar 2026 02:22:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CC2A601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774056172;
	bh=WcQk7Z2S+SVRFrwHkyr3wS0+PIZnlECfBBX6ZuGqwZQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mzgKT9KdKxwFMWa0x1NTby+IV5i6KDqXjrYY3PE3SzfVwyLhQUtil9sbi/qVAxzJe
	 3YGcNcpFEC8Ik4MZcHLLVqJzSx035hlO0GEh5vjm04+PbQVkz6ZL9Umc4B9otF5IkD
	 4JM4SJgusJdaIt9x3MNHMGDrJR2C/zKMupsgHJms=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39BE2F805F3; Sat, 21 Mar 2026 02:22:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 127EFF805EF;
	Sat, 21 Mar 2026 02:22:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F885F80549; Sat, 21 Mar 2026 02:22:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DF710F802DB
	for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2026 02:22:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF710F802DB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189eb6a5c099e600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
Subject: USB-Audio: Add Audient EVO4
Date: Sat, 21 Mar 2026 02:22:09 +0100 (CET)
Message-ID-Hash: YIDGVAE6S6IN5CPL7JKRKC3IBEOIGAQU
X-Message-ID-Hash: YIDGVAE6S6IN5CPL7JKRKC3IBEOIGAQU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YIDGVAE6S6IN5CPL7JKRKC3IBEOIGAQU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #708 was edited from motolav:

This is a 4in/4out device with 1 analog stereo out and 2 analog mono in. 
The hardware mixed loopback interface takes up the remaining 4 channels. 
Without this UCM the device is configured as 4.0 surround for in and out. 

I copied the way Windows configures the device except for the stereo mic mix as I couldn't get it to work somehow(might have been a wiremix issue).

Needs the PlaybackMixerElem and CaptureMixerElem implemented so software volumes are tied to hardware volumes

Closes: #303

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/708
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/708.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
