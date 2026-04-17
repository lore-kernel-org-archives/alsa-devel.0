Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312EDF436B5
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:57:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAF9260203;
	Fri, 17 Apr 2026 16:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAF9260203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776437854;
	bh=Pn/zg6tjIWcffd7Yit6boLGNjzDo5JUwNBdvIFnfsvE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Lo0sfUGb3MBnlBH9K/nssmFWVzY05gAomXw6vC2Fk45Fl4ybkKCKC9hZxy2c4nBhd
	 Jg9fokvgYK9iCDkVO1FsV8NPjqvQegtEZa/jRDsvHSKxvKgxC0Ma71lsUOd3weWSej
	 kmn018z8BLpSzrh6YeHYDMhAxciP9xZO+3ER70B0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A94E0F805F3; Fri, 17 Apr 2026 16:57:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B761F80212;
	Fri, 17 Apr 2026 16:57:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A244DF80528; Fri, 17 Apr 2026 16:56:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D274BF800E2
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2026 16:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D274BF800E2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a72cc6c1f39a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/748@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/748@alsa-project.org>
Subject: ucm2: sof-soundwire: add separate init and combined
 cs42l43-spk+cs35l56 config
Date: Fri, 17 Apr 2026 16:56:52 +0200 (CEST)
Message-ID-Hash: OTVHJC6YJGNTPMMYDDTZANUVHV2UBECQ
X-Message-ID-Hash: OTVHJC6YJGNTPMMYDDTZANUVHV2UBECQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OTVHJC6YJGNTPMMYDDTZANUVHV2UBECQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #748 was opened from mstrozek:

Following from a problem reported and discussed here: https://github.com/alsa-project/alsa-ucm-conf/pull/747

In some systems cs42l43-spk and cs35l56 can be used simultaneously to
drive seprate speakers (e.g. tweeters and woofers), add a configuration
to support that.
cs42l43-spk+cs35l56 case require its own init.conf file, but can reuse the cs42l43.conf file, so cs42l43-spk+cs35l56.conf is a symlink.

Also including an improvement for UAJ-less handling of separate cs42l43-spk since both these commits change spk_init file loading so they apply cleanly in one go.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/748
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/748.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
