Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690DBC3DA6E
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jan 2024 10:19:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B37A2E8C;
	Fri,  5 Jan 2024 11:19:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B37A2E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704449988;
	bh=M8TXMKnjoaWExf6f5RDGAHF/QD3BEE3lXcbYTcPu4Lk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vcF98N4cR/YbV/Og10RRHSDCouZHG0KzIOR3AxiDyARRt6/SfD/ky2qmvwgZAtwic
	 H9XSzLcFQb8MYOg25a3xsM0F4MU3j7PDtXvs1ZjY7g8S9KJXE/7CYzrXzGzgl4FMFA
	 I5LMlYeLhkcS3b91WxAGf+P/DiLAw1PVIOkzscEs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34CB5F80548; Fri,  5 Jan 2024 11:19:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03310F80588;
	Fri,  5 Jan 2024 11:19:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4659DF80238; Fri,  5 Jan 2024 11:07:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 20C72F80238
	for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2024 11:01:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20C72F80238
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1704448884950618029-webhooks-bot@alsa-project.org>
References: <1704448884950618029-webhooks-bot@alsa-project.org>
Subject: SplitPCM devices missing profiles since 1.2.10
Message-Id: <20240105100730.4659DF80238@alsa1.perex.cz>
Date: Fri,  5 Jan 2024 11:07:29 +0100 (CET)
Message-ID-Hash: V5XPDBB6WALNYR33D4PSMPKWYND62HXS
X-Message-ID-Hash: V5XPDBB6WALNYR33D4PSMPKWYND62HXS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V5XPDBB6WALNYR33D4PSMPKWYND62HXS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #346 was edited from freswa:

When updating t 1.2.10 the profile `Analog Stereo Output + Inputs` is gone. Instead I get a `Surround ...` profile, which doesn't work at all.

Downgrading alsa, alsa-ucm-conf and alsa-lib from 1.2.10 to 1.2.9 fixes the issue.

I'm on Kernel 6.5.1 with Pipewire backend.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/346
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
