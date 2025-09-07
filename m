Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91CDCA1017
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Sep 2025 08:14:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E90FB6020E;
	Sun,  7 Sep 2025 10:14:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E90FB6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757232853;
	bh=ABlDrCjhVCjFM6msqJwc2UK+yg9cxkthuTT5D3DBE5s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fTEER3lQgkAMr38UQZ/UezCEXWmotqVCiysDK2ObzRNLtqKjVkCxcK43YcBgSrP4v
	 i4XzC14CJahiP2JI5IRR1YlY6XIJdKrc9Lois+JRhmvV0NcpgYT66r5zDyjsKtOAJ4
	 JIlhukheu7fZ6FJ2ERlogR/kWu8/tNVK7heaNENs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C141F805C9; Sun,  7 Sep 2025 10:13:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0216F805BF;
	Sun,  7 Sep 2025 10:13:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64521F8055A; Sun,  7 Sep 2025 10:12:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E92EF80548
	for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2025 10:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E92EF80548
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1862f1e3aabe8400-webhooks-bot@alsa-project.org>
In-Reply-To: <1862f1e3aaafed00-webhooks-bot@alsa-project.org>
References: <1862f1e3aaafed00-webhooks-bot@alsa-project.org>
Subject: Mic from audio jack not work on Dell Precision M4800. Please add mic
 drivers
Date: Sun,  7 Sep 2025 10:12:50 +0200 (CEST)
Message-ID-Hash: KX4TQXJEVI4EAN7475CO7NODBM6NJF73
X-Message-ID-Hash: KX4TQXJEVI4EAN7475CO7NODBM6NJF73
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KX4TQXJEVI4EAN7475CO7NODBM6NJF73/>
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
