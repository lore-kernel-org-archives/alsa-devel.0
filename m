Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F12C0032E
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Oct 2023 12:40:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3CBE86E;
	Sat, 28 Oct 2023 14:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3CBE86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698496809;
	bh=5DFRZ4mkakyrajGVj24Y+ob1tJBbO+a6fJKY8wqF2+8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pq4BYfL472TGcOlDcx3SQOr/+5IJgjI4+2RjunEM6Rj0Mr2MMmf4g2GE8WyNLTnja
	 /VgsBOhJ4cAIhENRHXpng9EcN1O3mMPngzjRGwBeuja6cpZv+Zp6BH4DSVctbJfALz
	 26gWcbPnBb+VU//c7fqF6hJ0hG+Q+TxxmJUxAD9I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 673D5F8020D; Sat, 28 Oct 2023 14:38:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17583F8019B;
	Sat, 28 Oct 2023 14:38:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FE0DF8019B; Sat, 28 Oct 2023 14:38:55 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 67830F80152
	for <alsa-devel@alsa-project.org>; Sat, 28 Oct 2023 14:38:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67830F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698496731242286444-webhooks-bot@alsa-project.org>
References: <1698496731242286444-webhooks-bot@alsa-project.org>
Subject: mixer: simple: Support dB TLVs for CTL_SINGLE controls
Message-Id: <20231028123855.5FE0DF8019B@alsa1.perex.cz>
Date: Sat, 28 Oct 2023 14:38:55 +0200 (CEST)
Message-ID-Hash: YIJOSIN2ZWNOATJWZOO5E267UJC7TXAI
X-Message-ID-Hash: YIJOSIN2ZWNOATJWZOO5E267UJC7TXAI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YIJOSIN2ZWNOATJWZOO5E267UJC7TXAI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #358 was opened from marcan:

dB mappings do not work for controls not named "* Volume", since we do not fall back to CTL_SINGLE in get_selem_ctl. Add that branch to make it work.

Fixes dB ranges for e.g. controls named "* Gain".

Request URL   : https://github.com/alsa-project/alsa-lib/pull/358
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/358.patch
Repository URL: https://github.com/alsa-project/alsa-lib
