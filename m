Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4787CF2588
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Nov 2025 06:49:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26F136020D;
	Wed, 19 Nov 2025 07:49:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26F136020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763534961;
	bh=YAXFJN9AHwXYWUAyEGR6o9I4OFT23hzPwTdUod/dEvE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=utBhcCh0cWw+97qwVBLjqlmCLMRBERh2qtm/UhzSISNwoy2BIcK8qba0qAlvcgbzB
	 sg9XncDPnY7YxWoaphQxXH6oyzCHaTkvfdEaQ3xJEX2XhPePryYoYtNs+FETQYb4rj
	 O17vm7rQ1rPJNHt0iP46C5W0ajiv1cV9aE3fqiqk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D52F7F805C7; Wed, 19 Nov 2025 07:48:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE7CDF805D6;
	Wed, 19 Nov 2025 07:48:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D36CCF80171; Wed, 19 Nov 2025 07:48:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C986F800B5
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2025 07:48:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C986F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187955a7f3aaf600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/483@alsa-project.org>
References: <alsa-project/alsa-lib/pr/483@alsa-project.org>
Subject: fix typo in error.h to avoid compile error when gcc <= 2.95
Date: Wed, 19 Nov 2025 07:48:33 +0100 (CET)
Message-ID-Hash: 2NQKA7AI6A3NG7W3WGQUWIECH6A6J255
X-Message-ID-Hash: 2NQKA7AI6A3NG7W3WGQUWIECH6A6J255
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2NQKA7AI6A3NG7W3WGQUWIECH6A6J255/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #483 was opened from versaloon:

a typo in include/error.h

Request URL   : https://github.com/alsa-project/alsa-lib/pull/483
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/483.patch
Repository URL: https://github.com/alsa-project/alsa-lib
