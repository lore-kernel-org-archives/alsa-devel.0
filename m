Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEB606A329
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=kxyZ4+Ep
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3D4A60201;
	Sat, 14 Nov 2026 10:38:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3D4A60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794649138;
	bh=xRro672DUjYSA73BvYcD4qEjqZtAM4M+zbmq7u2wJGM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kxyZ4+EpNK5bFCMzKroU7of9JgE8eVM7bQHDrB9FoBXFZsjXH3QPuXG75SIJjDnYW
	 31Pn+7Jr1ffQWGpwjYkLs14SZpcmt36F8q9sEXMDIZMFKGGKUgC50ZUdn11h8ImLCC
	 +psXWlScfDaWdOz3IVVn0E7OIUYiO4wVpytPYU/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F020AF805FF; Sat, 14 Nov 2026 10:38:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 192BCF805FB;
	Sat, 14 Nov 2026 10:38:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38E7EF80580; Sat, 14 Nov 2026 10:38:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794649094;
	b=D3A+EuxQqPxgTI7d1A06QYmAcHb5ru0F3vCInc7zz151/FGx6FRHDNXnfiSMmJaeFw8S
	 mK8AlusO83tumVMZIbdtyRT0rsmW2/wm2UkvY1bfmLH7UjGxdikLtePEFC325HIR9lUQB
	 +3i1IsqjeUINCR+xszMG3BY+nwyACgPRAxQa8RhyXhnJw933XLYzCftfnA4S0BuAT1HDH
	 Rsol+A4Rw7UXYi4VJ7glEHhogdHGVImmDT7ZCN6JX89FG6GjWgAfEOb1c5jZzHJYBk1tB
	 uzJPPnvUWbr33vyahNSZziZinAKLYn1QTQtqB5SYIZfABVnCX9ijb97uAIdswVj6FcQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794649094;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=xRro672DUjYSA73BvYcD4qEjqZtAM4M+zbmq7u2wJGM=;
	b=JfEdHI1Wc3dkpnwNSrC4CLexiLRTaPe9tr2MWMQNDVj0VTVcsA52Y15o/zx6Jd3Q/g4m
	 EuG2NFy84tRK6IHU3JNqgeBlAAqUPbV68QPx2rY6Pas51cv1rk6FV0k/41WA7T4YKTrf6
	 lRlpWCXgvo0J1jHlljUfBjeQimWINDiYU8O7z7bqPtRUuLyibskhuXO617lNmKi8DAhik
	 UOwPgVK3K6LbyNdNGJ+Y3KdSkBLHG1w8Ix6XdHllp+T+FjmjTk2ilBT87p1XrAqwC1NPo
	 zaQJWJcJK++UF/0154u8imiw6I1+yrT21SupebqQhvzomQzQ3zLqRPv7pyKRDpoO7qg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B843F80100
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2026 10:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B843F80100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7dfd76308a700-webhooks-bot@alsa-project.org>
In-Reply-To: <18e7dfd762edd900-webhooks-bot@alsa-project.org>
References: <18e7dfd762edd900-webhooks-bot@alsa-project.org>
Subject: Unfullfilled dependencies when using the rpm on Fedora 45, Nov. 2026
Date: Sat, 14 Nov 2026 10:38:15 +0100 (CET)
Message-ID-Hash: CGCZPEC6UCESGRZW2Z42XUAOC7LQ3I3U
X-Message-ID-Hash: CGCZPEC6UCESGRZW2Z42XUAOC7LQ3I3U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CGCZPEC6UCESGRZW2Z42XUAOC7LQ3I3U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf issue #910 was opened from brandtan:

I donwloaded the rpm for my Fedora 45 and tried to install it using the software Center in Gnome but

Failed to resolve transaction: 
Problem: conflicting requests
  - nothing provides lsb-core-noarch needed by atom-1.60.0-0.1.x86_64 from @commandline

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/910
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
