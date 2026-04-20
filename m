Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E8F55807
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:19:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4FB360203;
	Mon, 20 Apr 2026 12:19:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4FB360203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776680373;
	bh=6/bAWvtbBNXNEtF8myBlyHWTo+Xek+v2YxuUztHqT/E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZbMXvPv9GUZUj4EsJ2U3R+fLBTHg46/32ydVfKkoJJ3mYgVUeFnS79k/VghPj+VSa
	 cFaJI9tlW+++v0yrSPuJB4YYtGXAqlWquUHYSnBoxkDcUGGBvlUQUNJhglfzOIl3iy
	 0hillt+49TifkKzzKQQwHh8zOPh/dZRrGjhqqP9w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C4D6F805F3; Mon, 20 Apr 2026 12:18:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4ADAF805F1;
	Mon, 20 Apr 2026 12:18:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A981F80524; Mon, 20 Apr 2026 12:18:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D1952F800B5
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2026 12:18:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1952F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a80958db6ffc00-webhooks-bot@alsa-project.org>
In-Reply-To: <18a80958db4d6000-webhooks-bot@alsa-project.org>
References: <18a80958db4d6000-webhooks-bot@alsa-project.org>
Subject: SSL2 Debian13, Kernel 6.18.21, lates alsa-ucm sound issues
Date: Mon, 20 Apr 2026 12:18:52 +0200 (CEST)
Message-ID-Hash: Y2SBPIMSKRV6BY6P4J3PKM25YIUUEJVA
X-Message-ID-Hash: Y2SBPIMSKRV6BY6P4J3PKM25YIUUEJVA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y2SBPIMSKRV6BY6P4J3PKM25YIUUEJVA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #749 was opened from brandtan:

Hi Team,

everytime I start discord my other peep can her himself.

What can be done against it.

Latest kernel, latest alsa-ucm, latestes everything. I tried nothing since I do not know what to do.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/749
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
