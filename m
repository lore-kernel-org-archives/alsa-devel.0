Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38F6EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 09:39:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC3B174C;
	Wed, 28 Jun 2023 11:38:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC3B174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687945178;
	bh=4bZbBCvN/d1JjfkJNV8ZZp8nXyGHJ4qFIn3ZF2pwl6g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ixDdxSfQ1r6cTWgni8K2FJEnGe7IBWHmmbMQPgKpblY+cYKL1s4WL93Jimm5z5H44
	 TyARcXFvl630p55jONW2WVVFaeLXB7c2cTNZeRoPPacnPy40yDYDZ/pWqaJkQf1rss
	 4p+JnZGj8wl5gwSFHnxQIeC61TaydDErX8Zu88+0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C422F80431; Wed, 28 Jun 2023 11:38:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89DECF80431;
	Wed, 28 Jun 2023 11:38:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA197F8027B; Wed, 28 Jun 2023 11:38:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B00C7F80169
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 11:38:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B00C7F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687945108028671980-webhooks-bot@alsa-project.org>
References: <1687945108028671980-webhooks-bot@alsa-project.org>
Subject: acp62: add initial support for AMD ACP v6.2 RPL
Message-Id: <20230628093842.BA197F8027B@alsa1.perex.cz>
Date: Wed, 28 Jun 2023 11:38:42 +0200 (CEST)
Message-ID-Hash: NENK6XBKUVDMNGLGH2BV6I57IJL3NH27
X-Message-ID-Hash: NENK6XBKUVDMNGLGH2BV6I57IJL3NH27
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NENK6XBKUVDMNGLGH2BV6I57IJL3NH27/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #332 was edited from pseudocc:

See also: [config SND_SOC_AMD_RPL_ACP6x](https://github.com/torvalds/linux/commit/4fb35936a374758d5065b0a015c565436685c378#diff-456b8a7915f68714b35e16be618944ffa6c1daabe3ff20ac21474612b018523dR121)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/332
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/332.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
