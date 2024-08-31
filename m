Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99756CD13DD
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2024 18:40:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D87AD846;
	Sat, 31 Aug 2024 20:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D87AD846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725129646;
	bh=T+YWD5ZFziiO8V6oXHK+Bn8wMbug699+PDmF6PDUYpM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IXo/KYbSbFEJes/zyj1xevd5TEXcALZWD2Ca7x/kTPpUFAUXtViOG/Qi9pbTaVDp1
	 ves+FXA22G5dacH03PbkKQm93UU07K5Ud+r3/4COdE9/cVG8ZyNOKh/be4GQtqcG/9
	 +X/VK16aJ6p1wuOAUWpCFTbAymifUUIIwaipMt3k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2145F8058C; Sat, 31 Aug 2024 20:40:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13FDDF80087;
	Sat, 31 Aug 2024 20:40:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8F97F80518; Sat, 31 Aug 2024 20:40:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D9B7EF8025E
	for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2024 20:40:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9B7EF8025E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1725129604067554712-webhooks-bot@alsa-project.org>
References: <1725129604067554712-webhooks-bot@alsa-project.org>
Subject: Fix TLV dB parser in case of used container
Message-Id: <20240831184006.A8F97F80518@alsa1.perex.cz>
Date: Sat, 31 Aug 2024 20:40:06 +0200 (CEST)
Message-ID-Hash: IKEWVBL33KDYEN3N25FFVB4P2XLBQILN
X-Message-ID-Hash: IKEWVBL33KDYEN3N25FFVB4P2XLBQILN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKEWVBL33KDYEN3N25FFVB4P2XLBQILN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #409 was opened from arkq:

In case when dB information does not appear as the only TLV type in the stream (it might be wrapped in a container, but the container can not have any other type), the TLV parser fails to get the dB TLV pointer.

This commit fixes it by distinguishing between TLV parse error and dB information not being found in a container, so the parser can iterate over all elements in the container.

Also, it fixes out-of-bounds read in case of malicious TLV record.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/409
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/409.patch
Repository URL: https://github.com/alsa-project/alsa-lib
