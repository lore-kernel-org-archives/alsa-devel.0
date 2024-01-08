Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5460CC3DA6E
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jan 2024 11:48:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9F6F82C;
	Mon,  8 Jan 2024 12:48:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9F6F82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704714511;
	bh=ue3KemxopgbpK0UrnO1p7dHwtDCXGJ2Cj4brYtlgNtw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ol8+v3RISrLBrhhnM/Qf/ed9t7LEXxpbkFGncfaCNukKlhK5CnR8XENaY6pB8xu5m
	 G3zb8d+kr1Gy/BK0vdhSEwodxU1dIEoBxrg0Iig/QUzIMYN7+Wgp/EmZemGuatzUsj
	 HVuMVAel7yKYS9u4cSm4IZLe4OLeQ+QWElp7CLik=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 160AAF80589; Mon,  8 Jan 2024 12:47:57 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FB21F80563;
	Mon,  8 Jan 2024 12:47:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25D70F80254; Mon,  8 Jan 2024 12:47:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id F0533F80086
	for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2024 12:47:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0533F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1704714465273882389-webhooks-bot@alsa-project.org>
References: <1704714465273882389-webhooks-bot@alsa-project.org>
Subject: Update USB-Audio.conf
Message-Id: <20240108114752.25D70F80254@alsa1.perex.cz>
Date: Mon,  8 Jan 2024 12:47:52 +0100 (CET)
Message-ID-Hash: P6K7SRWKLCSBMMHNMEZPZK7FFH2KOND4
X-Message-ID-Hash: P6K7SRWKLCSBMMHNMEZPZK7FFH2KOND4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P6K7SRWKLCSBMMHNMEZPZK7FFH2KOND4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #376 was opened from MiroslavGubenko:

add MPG Z590M GAMING EDGE WIFI

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/376
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/376.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
