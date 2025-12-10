Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C261D2CE17
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Dec 2025 10:17:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A183601FC;
	Wed, 10 Dec 2025 11:17:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A183601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765361835;
	bh=HJIQ8Hay2nNLe+mxbdBLcnFO/wxuMyAUokp0oDaIhMo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WqtcB2ttwoEaUC+iGkBoCtSPc8RfFHPT/1VDpyTtd1sPRTGAKWv0yywC/AJAghFxN
	 +qr2WEGmZtqFe03XpnPKjU7b3HuZfAfZbucRPBRt6C1cZOjJA+sE53O8ATfWXf9bRP
	 WSNYWFqVFv6oGZF1MzpOK2DVWLC6S4fBvezFl7vE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DB32F805E2; Wed, 10 Dec 2025 11:16:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D6ECF805CB;
	Wed, 10 Dec 2025 11:16:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F9AEF804F2; Wed, 10 Dec 2025 11:14:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5543EF80095
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2025 11:14:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5543EF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187fd313063e6700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/659@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/659@alsa-project.org>
Subject: USB-Audio: Antelope Audio Zen Go: add UCM2 configuration files
Date: Wed, 10 Dec 2025 11:14:31 +0100 (CET)
Message-ID-Hash: 2KVOQKUJLEDGG22VNJJ2HJB4GSEXXAEU
X-Message-ID-Hash: 2KVOQKUJLEDGG22VNJJ2HJB4GSEXXAEU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2KVOQKUJLEDGG22VNJJ2HJB4GSEXXAEU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #659 was opened from ryodeushii:

Add support for Antelope Audio Zen Go SC


[alsa-info.txt](https://github.com/user-attachments/files/24074814/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/659
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/659.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
