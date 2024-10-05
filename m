Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73E4CFB420
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:09:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D2B16C0;
	Sat,  5 Oct 2024 19:09:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D2B16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1728148168;
	bh=HC41WkQt0YpyyCKBwZOGwlkTdX2junADqr4nxUUL+R4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LN5F2oElXbGWEzszmxR8Fw3LffI0D0f2bpYQa+uFouYbGoqTJ/dAuACN3rMfYDIbB
	 y4dvbC4jpIAhhs9Z/t0CJPv/s6SFo8b9ocAbr/2JN+bYdkfyisd7eun4tTdoxouST0
	 YdvKGCwg45wPLgEScI6nS6VV+WiMgq7RO2XRGqJc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 419D1F805BD; Sat,  5 Oct 2024 19:08:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86626F805B5;
	Sat,  5 Oct 2024 19:08:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B46BF80517; Sat,  5 Oct 2024 19:08:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 57AC6F80107
	for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2024 19:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57AC6F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1728148130309349775-webhooks-bot@alsa-project.org>
References: <1728148130309349775-webhooks-bot@alsa-project.org>
Subject: Ubuntu 24.04 microphone is not working  USB-Audio: ALC4080  Z-590p
Message-Id: <20241005170853.2B46BF80517@alsa1.perex.cz>
Date: Sat,  5 Oct 2024 19:08:53 +0200 (CEST)
Message-ID-Hash: MO5Q42JDSTPO7N6U5YA3UXQIFECXQ6NY
X-Message-ID-Hash: MO5Q42JDSTPO7N6U5YA3UXQIFECXQ6NY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MO5Q42JDSTPO7N6U5YA3UXQIFECXQ6NY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #447 was opened from jiutian12:

My rear microphone is not working on Ubuntu 24.04 (nor on Ubuntu 22), but it can be used normally on Windows 10. Can hear sound
After updating the master branch, the microphone still doesn't work, but the response is the same as the sound system
Initial feedback on the issue, the following is my hardware information, I am not sure if it is complete
http://alsa-project.org/db/?f=2558f03ffd8c55e18f8208a806f3e2336d9fa49c
Kernel: k6.8.0-45-generic
USB-Audio: ALC4080 
asus Z-590p

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/447
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
