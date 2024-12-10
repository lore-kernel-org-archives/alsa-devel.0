Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDB0E7717F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2024 13:49:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0527FE67;
	Tue, 10 Dec 2024 14:49:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0527FE67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733838561;
	bh=7seMAXkquug7n4wiMAC8y5A1M+8T6VfSxq9vEEFy9+4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DTdn1LBOf73dOTbZDuL9Jm0bSnNrndpGiMXc9eCboPmodLWREM6UUoR+7HqCXm/DS
	 dWpqz9f3zHjd4R9/cK60pii1PvMWtl1a7FRAXkUMp/fz4Q1j1tlBfG2ApLfmhiyrFo
	 M7Par2aSzv6vQb69LXv6l6LU06DfeXdCZ6GBnW7I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C36EF805C6; Tue, 10 Dec 2024 14:48:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3E56F805C0;
	Tue, 10 Dec 2024 14:48:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87D0AF80482; Tue, 10 Dec 2024 14:48:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DC56EF8016C
	for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2024 14:48:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC56EF8016C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733838515743928432-webhooks-bot@alsa-project.org>
References: <1733838515743928432-webhooks-bot@alsa-project.org>
Subject: Support for ASUS ROG STRIX X870E-E GAMING WIFI
Message-Id: <20241210134842.87D0AF80482@alsa1.perex.cz>
Date: Tue, 10 Dec 2024 14:48:42 +0100 (CET)
Message-ID-Hash: BFZXHBK4Y7NMK3Q4Z2QTSHO6CB6FRQOS
X-Message-ID-Hash: BFZXHBK4Y7NMK3Q4Z2QTSHO6CB6FRQOS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BFZXHBK4Y7NMK3Q4Z2QTSHO6CB6FRQOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #486 was opened from aidvu:

Add support for [ASUS ROG STRIX X870E-E GAMING WIFI](https://rog.asus.com/motherboards/rog-strix/rog-strix-x870e-e-gaming-wifi/spec/
).

```Bus 003 Device 004: ID 0b05:1b9b ASUSTek Computer, Inc. USB Audio```

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/486
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/486.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
