Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85825CD5BD0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 16:27:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DFE760261;
	Wed, 27 May 2026 18:26:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DFE760261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779899226;
	bh=l9ZMucj9J1MPysXcdPvv9j/hmxqhE0775mi/vELs8Rk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=J51urYJrKVdUXkbzdW/k3T6ZSE9o1583ssrZsXo1m7UK7VeIhsMeQc2TXSf2D+RS3
	 AtIEuVqvp/o4y33bisprBr+vYP2O9rw0aoVUFA/xMcR5msIJxcFIAYcd4MLfIZwmvz
	 JFsFToomYSW8DlLrDcTziHPdZ2i6aDZ9KDnhaklw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F96BF80087; Wed, 27 May 2026 18:26:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FC61F805EF;
	Wed, 27 May 2026 18:26:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0AF5F804FF; Wed, 27 May 2026 18:26:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 968F9F80087
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 968F9F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b378dfc02fe100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/329@alsa-project.org>
References: <alsa-project/alsa-utils/pr/329@alsa-project.org>
Subject: alsactl: use [Install] instead of .wants/ symlinks for systemd
 integration
Date: Wed, 27 May 2026 18:26:25 +0200 (CEST)
Message-ID-Hash: AEWYF43DBKTIDN5XM7L7FJJGIHO2L7AH
X-Message-ID-Hash: AEWYF43DBKTIDN5XM7L7FJJGIHO2L7AH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AEWYF43DBKTIDN5XM7L7FJJGIHO2L7AH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #329 was opened from craftyguy:

This adds [Install] sections with WantedBy=sound.target to alsa-restore and alsa-state service files, and removes the install-data-hook that manually creates .wants/ symlinks. This lets distributions manage enabling/disabling via a preset policy rather than hardwiring it at install time.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/329
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/329.patch
Repository URL: https://github.com/alsa-project/alsa-utils
