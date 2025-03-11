Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FF3C282EC
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:47:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03A6B60389;
	Tue, 11 Mar 2025 11:47:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03A6B60389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741690039;
	bh=W5CgWMqnlgGrCctmNkBzZDaHdIwpyOiKACxWnbwQOW4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kJ6flSG6DHaCGUKqrx42KgeCOYxY51kHa9rCS4F95tkx55t7ecgfejkRqhMrycPcY
	 8/ZKFtZVIa4O54Nbir4pEA+F4M+8mBD+VJIJc07mciFNKbPtuqlR2SjJS/sHDss2cq
	 Mb8rGKcbLlgXIowp9tZ8WM6T6ewwJ1a6FQAd1e3E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF9AAF805B5; Tue, 11 Mar 2025 11:46:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C89ACF805B1;
	Tue, 11 Mar 2025 11:46:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EA1FF8013D; Tue, 11 Mar 2025 11:46:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 55DCEF800D0
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2025 11:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55DCEF800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182bb9d343592f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/517@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/517@alsa-project.org>
Subject: Add SetLED macro to hide implementation details for LED handling
Date: Tue, 11 Mar 2025 11:46:40 +0100 (CET)
Message-ID-Hash: NY5NIPD7SO6DMF2Z47EQKNWEO6JZUXWO
X-Message-ID-Hash: NY5NIPD7SO6DMF2Z47EQKNWEO6JZUXWO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NY5NIPD7SO6DMF2Z47EQKNWEO6JZUXWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #517 was opened from perexg:

This change also reduces modprobe calls when settings is split to multiple configuration files.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/517
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/517.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
