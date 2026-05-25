Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2846CD5BB1
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 19:11:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65E93601F8;
	Mon, 25 May 2026 21:11:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65E93601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779736272;
	bh=9I+WczcvaLcSbni5LFk8L2S+pcLlLpG6KFeng5TBg3k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uj0XDRRKBkKKg3tw//EdkjCuAXcSsKxhkMxUyG8n4A5uxVQv9XyNqLpM3DdKyIZZU
	 T1nfjm/awnzhv0P22yv+9i9HeykXTW5ofH3Dmr4AOfnL15/ywFt0NGTvCE9twnSf+u
	 bM/63aBGWySmkVy5TF8wC1oeX/ZKqTCpVv61YNec=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C49EDF805E9; Mon, 25 May 2026 21:10:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A61BF805EC;
	Mon, 25 May 2026 21:10:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B578F80557; Mon, 25 May 2026 21:10:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BF678F8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 21:10:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF678F8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b2e4ab670f8200-webhooks-bot@alsa-project.org>
In-Reply-To: <18b2e4ab6704ea00-webhooks-bot@alsa-project.org>
References: <18b2e4ab6704ea00-webhooks-bot@alsa-project.org>
Subject: [patch] Consistent global limits for rate and channels
Date: Mon, 25 May 2026 21:10:30 +0200 (CEST)
Message-ID-Hash: SOV3D757746ZGZGP6TVQXPYOKUV7EXIA
X-Message-ID-Hash: SOV3D757746ZGZGP6TVQXPYOKUV7EXIA
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SOV3D757746ZGZGP6TVQXPYOKUV7EXIA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #507 was opened from twonoise:

Hello.

I've noticed that `pcm_plugin.h` provides `SND_PCM_PLUGIN_RATE_MIN` and `...MAX`, but these values are not used always. Rather, various local limits used, include a bit unusual ones like `786000` (this one is probably just a typo). In order to make limits consistent across `alsa-lib` (and `-utils`), i've make these small patches. Also two more globals introduced for max channels. As well as some minor things fixed.

Are there chances that it can be merged?

I'll share via mailing list if need.

Thanks!

[alsa-lib.patch](https://github.com/user-attachments/files/28232363/alsa-lib.patch)

[alsa-utils.patch](https://github.com/user-attachments/files/28232368/alsa-utils.patch)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/507
Repository URL: https://github.com/alsa-project/alsa-lib
