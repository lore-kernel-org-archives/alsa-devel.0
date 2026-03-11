Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF800FD0651
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:20:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9A7601FA;
	Wed, 11 Mar 2026 15:20:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9A7601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773238847;
	bh=ZyElC8fbqvZKemGs82Py2IDuUdYHSwvid8KYR8XNWPg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jR6eKTtn53GybARd7r7ybe5Q48wFECvjwYLgXhK0lqlkYHdY6UfS4aygx21N55neb
	 ZANDIRNbUv9wbSUqGNF36WG2K2DKgYGYMheRXWdAbYnaE3SdlVep9jhQOMxg8vPN5t
	 5+5JVrqgQVDyQduvHHcLVW7XCmqZqxpm1t1z9xCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E710F805F4; Wed, 11 Mar 2026 15:20:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFE92F80589;
	Wed, 11 Mar 2026 15:20:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9715F80552; Wed, 11 Mar 2026 15:20:02 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D2D9F800C1
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2026 15:20:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D2D9F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189bcf4b506b8a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/33@alsa-project.org>
References: <alsa-project/tinycompress/pr/33@alsa-project.org>
Subject: fcplay: Fix gapless playback sequencing and add new continuouos
 playback strategy (restart mode)
Date: Wed, 11 Mar 2026 15:20:02 +0100 (CET)
Message-ID-Hash: DFLNVUQRPND7BMY7COBSDGK2ZA77CE6B
X-Message-ID-Hash: DFLNVUQRPND7BMY7COBSDGK2ZA77CE6B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DFLNVUQRPND7BMY7COBSDGK2ZA77CE6B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #33 was edited from ujfalusi:

The gapless mode sequence must start with set_metadata then the next_track as the former needs the metadata to beforehand in kernel.

Rework the play_samples() function to allow easier integration of new continuous playback strategies and add new mode to drain, close, open, configure and start for each file in list.

Request URL   : https://github.com/alsa-project/tinycompress/pull/33
Patch URL     : https://github.com/alsa-project/tinycompress/pull/33.patch
Repository URL: https://github.com/alsa-project/tinycompress
