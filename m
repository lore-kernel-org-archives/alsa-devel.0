Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB67C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:53:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9456AE69;
	Mon,  1 Jul 2024 19:53:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9456AE69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719856391;
	bh=airLazxY8ndDpbGbtFXGC/q2u7G9cqXQr++ewNjQW9o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tsWOd3/CisXP1eXLxOhL2AP0cDKPXpbiW2tWujQ7Kz13JrDwWyDYv4ios252Geed7
	 u51SiE2gsunjANGXeJ6aaNYmT/meTjBtwvTMIJufgMzhCg6gBP+PrLKKrXWz0YxLFY
	 Uo9wd8cRlYbpzfwDCPcDZA/R+42Vc0G5ZibY1htg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4D40F805AD; Mon,  1 Jul 2024 19:52:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 598B1F80588;
	Mon,  1 Jul 2024 19:52:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54831F80238; Mon,  1 Jul 2024 19:52:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 96C11F800E4
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 19:52:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96C11F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1719856349844297886-webhooks-bot@alsa-project.org>
References: <1719856349844297886-webhooks-bot@alsa-project.org>
Subject: ucm2/conf.d: add symlink for Qualcomm DB820c
Message-Id: <20240701175234.54831F80238@alsa1.perex.cz>
Date: Mon,  1 Jul 2024 19:52:34 +0200 (CEST)
Message-ID-Hash: KTTHFCWJGAHW7COVFOGE3F4IDRUYXZXD
X-Message-ID-Hash: KTTHFCWJGAHW7COVFOGE3F4IDRUYXZXD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KTTHFCWJGAHW7COVFOGE3F4IDRUYXZXD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #428 was opened from lumag:

Since the release 6.3 Linux kernel uses driver name apq8096 for Qualcomm Dragonboard 820c. This makes alsaucm look for conf.d/apq8096/DB820c.conf and then for conf.d/apq8096/apq8096.conf, while alsa-ucm-conf has historical conf.d/DB820c/DB820c.conf symlink. Add symlink to provide correct configuration for the device.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/428
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/428.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
