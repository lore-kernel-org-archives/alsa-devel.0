Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA6C678D4
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Mar 2023 21:44:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93DB01DC;
	Wed,  1 Mar 2023 22:43:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93DB01DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677707063;
	bh=AKnURuJj9VLqt2ym8PrCtCoFWFPGd/j3Rh0tEHi5hHw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nQevkW9gvnDuBbGZ90kByy9GhO3JJLkdsO2UYNWbtSFZcBwHGzQpgiJLoYKaIVi23
	 k+GDbYPuc9n/uaARe97Ve+IkglSq/71Nho27aq5Dmt4z6r/xLgnL0bV7CEhoBfce7O
	 yiVGwP9EEnkybziJ2WTq8JXuAPGtUGStbpH0X3ds=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9272F8049C;
	Wed,  1 Mar 2023 22:43:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2022FF8049C; Wed,  1 Mar 2023 22:43:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DD122F80236
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2023 22:43:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD122F80236
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1677706985255067348-webhooks-bot@alsa-project.org>
References: <1677706985255067348-webhooks-bot@alsa-project.org>
Subject: Question: is it possible to subscribe a port to system announcer ?
Message-Id: <20230301214308.2022FF8049C@alsa1.perex.cz>
Date: Wed,  1 Mar 2023 22:43:08 +0100 (CET)
Message-ID-Hash: WFZAO5A3ICAEYTGE27ZG4OPOPZV2B6N4
X-Message-ID-Hash: WFZAO5A3ICAEYTGE27ZG4OPOPZV2B6N4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WFZAO5A3ICAEYTGE27ZG4OPOPZV2B6N4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python issue #7 was opened from Houston4444:

Hi. I try to add ALSA support to [Patchance](https://github.com/Houston4444/Patchance).

I 'd like to create a port capable to receive events as SEQ_EVENT_PORT_START or SEQ_EVENT_PORT_EXIT in order to get a complete graph.

I see in patchage source code (C++) that it uses 'snd_seq_connect_from' function to enable this events.

Is it possible in python with this lib ?

Thanks.

Issue URL     : https://github.com/alsa-project/alsa-python/issues/7
Repository URL: https://github.com/alsa-project/alsa-python
