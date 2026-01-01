Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F4EEB57E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jan 2026 11:51:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D3CB601EA;
	Thu,  1 Jan 2026 12:51:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D3CB601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767268309;
	bh=0NN0VS2rKFxBmqhiIJKr21N4cOg7OGY76A31uJ3Jvgk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LY5dsD5492oOpuz6AWpJHeBVbbUFfKFXgOV2ecC4JcGdjnzEO6swGjGu/KTcK/1+y
	 NQbjyOS4ud/GC22DrM7ouFn91z0kQBBPRWPQsaVFnyEJ9BYt2cDnOC0NymKzjsDVnb
	 HPHH2zAKUZZmeRPESGwvVFaWDObg/wqBBy8khe9A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02DF4F805D9; Thu,  1 Jan 2026 12:51:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ADA5BF805E5;
	Thu,  1 Jan 2026 12:51:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA64AF80246; Thu,  1 Jan 2026 12:50:49 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 31C11F800FE
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2026 12:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31C11F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1886991b9e121a00-webhooks-bot@alsa-project.org>
In-Reply-To: <1886991b9da90a00-webhooks-bot@alsa-project.org>
References: <1886991b9da90a00-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.15.1 | only stereo fallback mode for Realtek ALC1220
Date: Thu,  1 Jan 2026 12:50:49 +0100 (CET)
Message-ID-Hash: YNRW5IUBUWNRM7RLQ54M7HDZ7BOXDAAQ
X-Message-ID-Hash: YNRW5IUBUWNRM7RLQ54M7HDZ7BOXDAAQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YNRW5IUBUWNRM7RLQ54M7HDZ7BOXDAAQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #492 was opened from Eiseiche:

It's similar to https://github.com/alsa-project/alsa-lib/issues/488. After updating from _alsa-lib 1.2.14-2_ to _alsa-lib 1.2.15.1-1_ , I only got the stereo fallback mode.

[1.2.14-2 _alsa-info.txt](https://github.com/user-attachments/files/24400680/1.2.14-2._alsa-info.txt)

[1.2.15.1-1_alsa-info.txt](https://github.com/user-attachments/files/24400681/1.2.15.1-1_alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/492
Repository URL: https://github.com/alsa-project/alsa-lib
