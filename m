Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226F3C28B30
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Mar 2025 13:06:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C0A6601F9;
	Sun, 23 Mar 2025 14:06:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C0A6601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742735170;
	bh=A2+mtvwbT1q2s+E/Rp2lNi3N7D37Lw7sZ0A+v8mgnA0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qJ/crzPL8UEKSSSwScO9nkEYIHQv4jdmo3qiXj16BIGT7CXj4Nb5v1gJ4I9ajmVBf
	 tJ6vQ4m2+oVbpgkRml2Q7kY4S79spil7a/hnzY7glnwfb/y6RPt0WgqEjhoXe3CHSp
	 tokwfFwoERIxARV1FbnkAI23o5FDH63g92oj51Hc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5ED9F805C7; Sun, 23 Mar 2025 14:05:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86BB3F805B6;
	Sun, 23 Mar 2025 14:05:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6078BF80301; Sun, 23 Mar 2025 14:05:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B0D47F800B6
	for <alsa-devel@alsa-project.org>; Sun, 23 Mar 2025 14:05:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0D47F800B6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182f705da964a500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/29@alsa-project.org>
References: <alsa-project/alsa-tools/pr/29@alsa-project.org>
Subject: envy24control: simplify code by using gtk_widget_show_all
Date: Sun, 23 Mar 2025 14:05:30 +0100 (CET)
Message-ID-Hash: 3Q4MWVONNKTFK5H7PS5E556YBNZ56EEO
X-Message-ID-Hash: 3Q4MWVONNKTFK5H7PS5E556YBNZ56EEO
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3Q4MWVONNKTFK5H7PS5E556YBNZ56EEO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #29 was opened from andreas56:

Remove all gtk_widget_show calls and replace it with just one gtk_widget_show_all. This makes the code shorter and it will also help a future port to GTK 4, where gtk_widget_show is gone.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/29
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/29.patch
Repository URL: https://github.com/alsa-project/alsa-tools
