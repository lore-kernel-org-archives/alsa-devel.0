Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2594C2D0CD
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 13:53:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A21060193;
	Thu, 15 May 2025 15:53:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A21060193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747317236;
	bh=jpMSxCYkoMrSchWi8/YqHEM5k44Nanf35DSrJGgBoGg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VR6Qi6XRfVyakTLSU35v06ae0HcufcQxunCyeozLeAf2aCdPLgftDAGwkXYTJ/C6K
	 2LNPQQ9MO7dhoU8dr5eqskHP38TKtauroFq+Aslh7TcUc2beX5sunVhCWjlSemqM4q
	 r+1Daeoa0BaqsPHMTqiW6MTFGaRksD4Ykzgdreks=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2526F8012B; Thu, 15 May 2025 15:53:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A8A0AF8025F;
	Thu, 15 May 2025 15:53:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2832F80075; Thu, 15 May 2025 15:53:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EEB75F8003C
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2025 15:53:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEB75F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183fb7bbfd841300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/563@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/563@alsa-project.org>
Subject: Device rename regression fixes
Date: Thu, 15 May 2025 15:53:20 +0200 (CEST)
Message-ID-Hash: PWASEK7V45XAVX4OOSXM64S2VEFNL7QA
X-Message-ID-Hash: PWASEK7V45XAVX4OOSXM64S2VEFNL7QA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PWASEK7V45XAVX4OOSXM64S2VEFNL7QA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #563 was opened from jhovold:

A recent change renaming device sections introduced a name collision which broke the internal microphones on the Lenovo ThinkPad X13s. A number of jack hw mute and conflicting devices properties are now also referring to non-existing devices.

Please consider doing a bug fix release as soon as possible to address the X13s regression in v1.2.14.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/563
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/563.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
