Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B4C4829B
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Feb 2024 11:25:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FDF4850;
	Mon, 12 Feb 2024 12:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FDF4850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707737114;
	bh=cAk5RPNtr3SsUGGuja6Sw/mzISkeHIu6NbxDFFbkr8E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OxP9oO8//J/JsNpnCJyCueqfeAdzzi4F7aYsFfz6n7t7yGPNNnVsH0SEyXr8mh9yu
	 E4aTguQKhJEGyrzz3e4HKK4Keg8M58b7tpEerxD0lxoEQY9tBSZGVgg63pKeXNyURp
	 k1NAnT4XOVuAlNBuThcOzZX0LwyfFba8oSO58eCE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED2E3F8057E; Mon, 12 Feb 2024 12:24:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6911BF805A8;
	Mon, 12 Feb 2024 12:24:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02BE8F80238; Mon, 12 Feb 2024 12:24:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 41E15F800EE
	for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2024 12:24:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41E15F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1707737072576266766-webhooks-bot@alsa-project.org>
References: <1707737072576266766-webhooks-bot@alsa-project.org>
Subject: MAG Z790 TOMAHAWK WIFI DDR4 no Sound Front Audio Realtek 4080
Message-Id: <20240212112436.02BE8F80238@alsa1.perex.cz>
Date: Mon, 12 Feb 2024 12:24:36 +0100 (CET)
Message-ID-Hash: 4ZBHHMXTZXUZCXEQKVPX2PTKCLNIU6LB
X-Message-ID-Hash: 4ZBHHMXTZXUZCXEQKVPX2PTKCLNIU6LB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ZBHHMXTZXUZCXEQKVPX2PTKCLNIU6LB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #395 was opened from Acer6920:

Greetings,

back audio is working the sound card is recognized as Generic USB Audio
3 [Audio ]: USB-Audio - USB Audio Generic USB Audio at usb-0000:00:14.0-11, high speed

alsa information:
http://alsa-project.org/db/?f=655312de1f9b11ddc33de5fa41c6cad87bcbab9d

if i missed something excuse it please i use zorin os/linux since yesterday and need some advice if you need more information.

thanks a lot.

ace

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/395
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
