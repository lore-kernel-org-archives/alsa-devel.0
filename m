Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D63CD5BD1
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2026 08:08:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E713760218;
	Sun, 31 May 2026 10:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E713760218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780214884;
	bh=ktz8BKmnHcWlFIkGE7xKXEHS4LmkZqF97da7Ys2HbFk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pfQ9x7nfOcYu5DISDO7d4o8IEY9DUaIDA1VzMCKx5H36I2pBKZuuTnklZKzgeUkq9
	 Go1Q/uNhbrjH8hY6Qn0WNaNmym099yV2VLKiwEGArhxQSSTVID2O1c0ELj010mdhOr
	 Vrex7CzBbY5lXaMmQ/ymJLiC8pYIlbC6l64WymTw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68366F805FE; Sun, 31 May 2026 10:07:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1425CF80610;
	Sun, 31 May 2026 10:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCC30F805F8; Sun, 31 May 2026 10:07:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 78B5DF805F4
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2026 10:07:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78B5DF805F4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b497f66e891100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/330@alsa-project.org>
References: <alsa-project/alsa-utils/pr/330@alsa-project.org>
Subject: Consistent global limits for rate and channels
Date: Sun, 31 May 2026 10:07:18 +0200 (CEST)
Message-ID-Hash: O55HNRUVKR2LH3226J4O2VG7X23PCBFG
X-Message-ID-Hash: O55HNRUVKR2LH3226J4O2VG7X23PCBFG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O55HNRUVKR2LH3226J4O2VG7X23PCBFG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #330 was opened from twonoise:

PR for [#507](https://github.com/alsa-project/alsa-lib/issues/507).

Request URL   : https://github.com/alsa-project/alsa-utils/pull/330
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/330.patch
Repository URL: https://github.com/alsa-project/alsa-utils
