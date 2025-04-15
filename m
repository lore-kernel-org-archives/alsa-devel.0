Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE1C369AB
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:17:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED3C362234;
	Tue, 15 Apr 2025 19:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED3C362234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1744737470;
	bh=0qDlE3+LsJJFo1AW0yKMwHSfK3aZJrWDDdYI60LJm/M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WAHNp5/Yfx49SYONOTwZomQwU8Hy6f3C35ToCdgtxV0yKehIjwuEhI6uqOBuoWAkC
	 xpy+4sMOpRZwIV+OBOEtkwkuqOf0m20jjmXNpHRZHKnibpNTA1yNVxZlLeOhO1cC46
	 TtNZr+k2MZiI4rmBdctqPkGqvEXtsVQ+Lf84pZh0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BA97F805D3; Tue, 15 Apr 2025 19:16:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CD21F805CB;
	Tue, 15 Apr 2025 19:16:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 710C2F8021D; Tue, 15 Apr 2025 19:16:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AC076F800B0
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2025 19:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC076F800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18368d6d49dfe300-webhooks-bot@alsa-project.org>
In-Reply-To: <18368d6d49bd4300-webhooks-bot@alsa-project.org>
References: <18368d6d49bd4300-webhooks-bot@alsa-project.org>
Subject: Steinberg UR22C: Version 1.2.14 introduced "[ALSA UCM error]"
Date: Tue, 15 Apr 2025 19:16:48 +0200 (CEST)
Message-ID-Hash: NHOEKANJC46FKLXDVLSUMQPXUFEBYM7Y
X-Message-ID-Hash: NHOEKANJC46FKLXDVLSUMQPXUFEBYM7Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NHOEKANJC46FKLXDVLSUMQPXUFEBYM7Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #547 was opened from NoXPhasma:

Since version 1.2.14 the `node.description` of the Steinberg UR22C shows  `[ALSA UCM error]`:

```
node.description = "Steinberg UR22C [ALSA UCM error] Direct Steinberg UR22C"
```

Reverting to version 1.2.13 fixes this issue.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/547
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
