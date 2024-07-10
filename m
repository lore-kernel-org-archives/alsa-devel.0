Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACFCC3DA42
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:42:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47FE2A4D;
	Wed, 10 Jul 2024 14:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47FE2A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720615322;
	bh=GkGKYxpwecGgWy47ekaxtQbisAFUFDkDhQjB2eRPCfw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dwrp11qW1K5N8dLOp+aipaXip9627ci+wz7/atlRTkRD+1r5b4mre/qr/ui485q/0
	 PIOpjGrC1bnlVBoX+CE/lFK0mSRTP8bg4v3ujPUFO9RuP36ccBQGnvIcYTu74Psmld
	 y7vPdLFgW4gs6ZNd0CNJj6l830YofMlBL0qp/h/g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CB58F805B3; Wed, 10 Jul 2024 14:41:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 587AEF805B4;
	Wed, 10 Jul 2024 14:41:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D392EF801F5; Wed, 10 Jul 2024 14:41:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 69887F8013D
	for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2024 14:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69887F8013D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1720615279026883841-webhooks-bot@alsa-project.org>
References: <1720615279026883841-webhooks-bot@alsa-project.org>
Subject: Fix labeling of BOSS Katana ports
Message-Id: <20240710124125.D392EF801F5@alsa1.perex.cz>
Date: Wed, 10 Jul 2024 14:41:25 +0200 (CEST)
Message-ID-Hash: 6HSPSSP7ELR53QQFWXN3QAQWWS2K4TNF
X-Message-ID-Hash: 6HSPSSP7ELR53QQFWXN3QAQWWS2K4TNF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HSPSSP7ELR53QQFWXN3QAQWWS2K4TNF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #430 was edited from aledomu:

I'd like to rename the MIDI ports as well but I don't know how. If you can point me where I can learn about it, I'll be glad to do so and mark this PR as finished.

I guess this fix works the same for all Katana models from all generations, but I don't have the PID available to enable it, nor the devices for testing.

Edit: Didn't post the [`alsa-info.sh` output](https://gist.github.com/aledomu/ac3b2741ca2426bc6fbc057907ad0dab).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/430
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/430.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
