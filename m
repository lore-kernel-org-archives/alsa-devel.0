Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECBDC432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:22:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9F9214DA
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WmblPNNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F9214DA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FA7216AB;
	Tue, 24 Sep 2019 22:21:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FA7216AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569356522;
	bh=oEdL8lC1wKfdX/YH4nBfKthp8XoS/4aquBgwtpJn2p0=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmblPNNYyiii6j8vCdKE/zE7g2I4mxN3ayqegxGznQ27u/X3pRUEb1MeXcTnDI0w9
	 pAk0Let1zriHg5MdHSqPEgK0bf5fZH5yNiGeE5m04LW5Iyj0RvfQT3KBwpaCBt0bKz
	 Y6/CvolKibZC7+DRyUry/23CpPkE1anOkF0wQzSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2CD8F800B4;
	Tue, 24 Sep 2019 22:21:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06891F8045F; Tue, 24 Sep 2019 22:21:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AEDECF800B4
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 22:21:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEDECF800B4
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1569356467848001957-webhooks-bot@alsa-project.org>
References: <1569356467848001957-webhooks-bot@alsa-project.org>
Message-Id: <20190924202111.06891F8045F@alsa1.perex.cz>
Date: Tue, 24 Sep 2019 22:21:11 +0200 (CEST)
Subject: [alsa-devel] Making alsamixer configurable,
	adding mouse support + minor fixes
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils pull request #26 was opened from braph:

Hello,

I'm using the alsamixer, but I am missing mouse support and the ability to configure it.
I implemented those things for myself now, maybe it would also be useful for others.

There are some commits that would even fit in the original alsamixer code without my rather heavy modifications, these are:

6eb0bc8f0848567f302e94ea5ee3a6d7c6966e65: _alsamixer: remove redundant sprintf() calls_
bef5b723a43f310ba73bcaa52f3da74ef5e08dde: _alsamixer: use mvwhline/mvwvline for drawing lines_
ae0604c93aa4bacbb678eb8ec832ad9e17c8b56a: _alsamixer: device_name.c: recognize DEL (ASCII 127) as backspace_
And maybe
485f3b0da1ffead2f88cffd9f2203516000415b5: _alsamixer: fix window_size_changed()_

Regards,

Benjamin

Request URL   : https://github.com/alsa-project/alsa-utils/pull/26
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/26.patch
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
