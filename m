Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AEBD1CDC6
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Dec 2025 09:37:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0415160201;
	Sun,  7 Dec 2025 10:37:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0415160201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765100233;
	bh=ZoJcqCDd1DLyp8Veu7+tK+NXwK68fpkjRT+3yKSv540=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cdT0lyK1Ai6gYzvj+KFkSo2S6RaBNhc0DpeNF0Tr5bttku+jLI5q6aNDeCnEdDY4G
	 zL7XxOBLASYuHB3PyoJpcyDGYjlQTIFeSgM49c/ypRH4GK80got7URweJVial5LyEH
	 8iRf4OB4WDOmnVSkIhHOqZyqif1M0q0qt7fjnIac=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53058F805EE; Sun,  7 Dec 2025 10:36:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 267DBF805F1;
	Sun,  7 Dec 2025 10:36:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBE5BF80494; Sun,  7 Dec 2025 10:36:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B488F8003C
	for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2025 10:36:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B488F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187ee54243045b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/554@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/554@alsa-project.org>
Subject: [for alsa-lib 1.2.15] USB-Audio: Steinberg UR22C - fix capture
 channels for older firmware
Date: Sun,  7 Dec 2025 10:36:18 +0100 (CET)
Message-ID-Hash: J3DOFPR6ECRC7RY4VKRWSLNYFT6ZM3VZ
X-Message-ID-Hash: J3DOFPR6ECRC7RY4VKRWSLNYFT6ZM3VZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J3DOFPR6ECRC7RY4VKRWSLNYFT6ZM3VZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #554 was edited from perexg:

It seems that firmware version 3.20 added 4 capture channels while previous firmware has only 2 capture channels.

Fixes: https://github.com/alsa-project/alsa-ucm-conf/issues/547

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/554
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/554.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
