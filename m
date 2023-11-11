Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE818C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Nov 2023 20:57:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58E5D844;
	Sat, 11 Nov 2023 21:57:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58E5D844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699736276;
	bh=tV6RB/QyuJuispZTY60mJprCR2h/6e52nHLgJAjpIxg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fYRIrJV9QNzeeB4gDywIKFmgPW9U9DVIKfTCQ6hVzpB89n16tb4omGpLtAgMl+ZDG
	 2DwDkk3a44fU1ZE03GRefILsHgtygpDPiboZyw0H1UV2rlCJR0yluChF6Fdp+64vPa
	 SsxgRSr7W8EV66k/PiXzkvnUnXRvfCpL/uYTCQq4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9E4BF8055A; Sat, 11 Nov 2023 21:57:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11CFCF80169;
	Sat, 11 Nov 2023 21:57:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05198F80169; Sat, 11 Nov 2023 21:56:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 66342F800ED
	for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2023 21:56:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66342F800ED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1699736195843812704-webhooks-bot@alsa-project.org>
References: <1699736195843812704-webhooks-bot@alsa-project.org>
Subject: Z690 Aorus pro no sound from front panel or opitcal port
Message-Id: <20231111205639.05198F80169@alsa1.perex.cz>
Date: Sat, 11 Nov 2023 21:56:39 +0100 (CET)
Message-ID-Hash: 2NXKO45LIFU6DOXZ2KV5KN22JVEGUDUC
X-Message-ID-Hash: 2NXKO45LIFU6DOXZ2KV5KN22JVEGUDUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2NXKO45LIFU6DOXZ2KV5KN22JVEGUDUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #367 was opened from Gr33nHood:

I'm using POP-OS 6.5.6-76060506-generic.

Thanks for your help.
Best regards, Green Hood.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/367
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
