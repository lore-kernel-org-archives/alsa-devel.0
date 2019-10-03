Return-Path: <SRS0=AoKC=X4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FFEC10F14
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:14:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D24207FF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eFii5V71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D24207FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1011672;
	Thu,  3 Oct 2019 21:13:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1011672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570130037;
	bh=47KG08xw3Lq+0NEVFDLXOv1TPnkPphXKqkAKvc+J7SE=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eFii5V71Am5G+TX+Tb1Z4ipzUJ2mpW/bLRL5ikJYIZ7Yz+bAK4H5oN6qxGaq1IcCA
	 T175NP/tWgDu1ufD7fWftxocyWBV6qsWmqjc0z5t+my1wpPr4aJV64CdPc9u4iE0si
	 DbAw6B7MudK8N6vA2fintWxRRqJdeygiPxm6AZZE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65DB4F804FF;
	Thu,  3 Oct 2019 21:13:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7DD1F80506; Thu,  3 Oct 2019 21:13:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E2B83F80137
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2019 21:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2B83F80137
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1570129978986185074-webhooks-bot@alsa-project.org>
References: <1570129978986185074-webhooks-bot@alsa-project.org>
Message-Id: <20191003191303.A7DD1F80506@alsa1.perex.cz>
Date: Thu,  3 Oct 2019 21:13:03 +0200 (CEST)
Subject: [alsa-devel] Making alsamixer configurable,
	adding mouse support + minor fixes ...
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

alsa-project/alsa-utils pull request #28 was opened from braph:

... continued from PR #26 ...

Request URL   : https://github.com/alsa-project/alsa-utils/pull/28
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/28.patch
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
