Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2BBC001DC
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Jul 2023 19:44:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 464E5827;
	Sat, 29 Jul 2023 21:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 464E5827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690659852;
	bh=qZhttz150FWvMuUpAIOLsD6rs0C/wbnCPcwMZ84s010=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Db1b9T5z+GzRhVRgnEAd4Qkdcm7Q8bXP9HU2FFr2b839i4xivDpRvI3kY/AwY+Pg6
	 z35+kBlMngMusEdcpzmS1wm6PRpXy2o3sdrH/2/PCVJRcTVJZ0pRjZnXkYUC8kSf61
	 l3rI4MoUKT+pc9CZQRuAGY7MoSDulK6xlp+Nb4+g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE621F8019B; Sat, 29 Jul 2023 21:42:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45035F800C7;
	Sat, 29 Jul 2023 21:42:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B555F8019B; Sat, 29 Jul 2023 21:41:54 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 73ED1F800C7
	for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2023 21:41:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73ED1F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690659704510955572-webhooks-bot@alsa-project.org>
References: <1690659704510955572-webhooks-bot@alsa-project.org>
Subject: ALC3306 beeing registered as ALC287 on Lenovo Yoga
Message-Id: <20230729194154.5B555F8019B@alsa1.perex.cz>
Date: Sat, 29 Jul 2023 21:41:54 +0200 (CEST)
Message-ID-Hash: LRQJ7TOXCUXIXIGNQFKFNIJSJKK2KEH3
X-Message-ID-Hash: LRQJ7TOXCUXIXIGNQFKFNIJSJKK2KEH3
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LRQJ7TOXCUXIXIGNQFKFNIJSJKK2KEH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #339 was opened from InfinityRed-Code:

I have a Lenovo Yoga 7 16IAP7 with Fedora Workstation 38 installed.

Kernel Verion: Linux 6.4.6-200.fc38.x86_64
alsa-lib version: alsa-lib-1.2.9-1.fc38.x86_64

I installed alsa-tools and went into hdajackretask to see what is going on. Then I noticed that my System is telling me that I have an ALC287 installed but actually it is a ALC3306. Sound is horrible and several fixes with ALC 287 for Legion Models did nit work. In the Settings I can see as well, that only 2 of the 4 integrated speakers are getting noticed.

Is there any known fix?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/339
Repository URL: https://github.com/alsa-project/alsa-lib
