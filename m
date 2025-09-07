Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84804CA1017
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Sep 2025 08:12:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84FEB6020E;
	Sun,  7 Sep 2025 10:12:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84FEB6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757232751;
	bh=ABlDrCjhVCjFM6msqJwc2UK+yg9cxkthuTT5D3DBE5s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=e+9SC/uRfnw3r9y+9juHIS/FD66NIFhU8z4aQzGfxLRioVthi0tJ4K7bb97F/79UY
	 rqyyoMkwZbUxKNDvTA/3QOe/MbcbRLskebNxltGokjYld7+GczKVtJWDiYz6BMZ3fy
	 sprr9L/P3dN5wfWJ83O2wa/jRvgvO/N2szxSYGtQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEAE5F805D6; Sun,  7 Sep 2025 10:11:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 191E8F805C1;
	Sun,  7 Sep 2025 10:11:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 436C1F80548; Sun,  7 Sep 2025 10:11:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 28D82F80153
	for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2025 10:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28D82F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1862f1d412d61500-webhooks-bot@alsa-project.org>
In-Reply-To: <1862f1d411d0a400-webhooks-bot@alsa-project.org>
References: <1862f1d411d0a400-webhooks-bot@alsa-project.org>
Subject: Mic from audio jack not work on Dell Precision M4800
Date: Sun,  7 Sep 2025 10:11:40 +0200 (CEST)
Message-ID-Hash: RYD4XXKYEEEEZUHKN4UEHLYSOXSVR4WV
X-Message-ID-Hash: RYD4XXKYEEEEZUHKN4UEHLYSOXSVR4WV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RYD4XXKYEEEEZUHKN4UEHLYSOXSVR4WV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #476 was edited from Slavomir9:

Hello,
on my Dell Precision M4800 not work mic on headset Koss CS100 audio jack (non USB) version.
Please add mic drivers.

[Dell Precision M4800 ](https://www.google.com/search?q=%0D%0ADell+Precision+M4800%0D%0A&sca_esv=e618e5e4341fb9f4&)

[Headset Koss CS100](https://www.kaufland.sk/product/5373091/)

I use dual boot. On Windows 11 work mic only after install drivers from Dell website.

Please add mic drivers.
Thanks

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/476
Repository URL: https://github.com/alsa-project/alsa-lib
