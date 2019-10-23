Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BAECA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:31:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5DA21A4A
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m1rfyX/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5DA21A4A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFFB915E2;
	Wed, 23 Oct 2019 19:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFFB915E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571851892;
	bh=wWxI0xwO4MaCwQUeXmATFYM+z4chyKBYpWQD9YUY7g8=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1rfyX/ttutlItQS2fbSyLKXQWSYJA3kmghwwUsgE1Nczoo5SWx+mfLIHslaZjruE
	 RB4BEIeXT3Q78yf9qEtaBsavxDO2mTMI985DF0T8PcNFNbuFzwcZNgn35BnBpK2V5u
	 vV3juCzgDfBHVmOAQ+PFkgRmW50cZ4C1dp4XuP0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 267D8F80321;
	Wed, 23 Oct 2019 19:30:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38B8BF80368; Wed, 23 Oct 2019 19:30:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3E46DF802DF
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 19:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E46DF802DF
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1571851836428162098-webhooks-bot@alsa-project.org>
References: <1571851836428162098-webhooks-bot@alsa-project.org>
Message-Id: <20191023173041.38B8BF80368@alsa1.perex.cz>
Date: Wed, 23 Oct 2019 19:30:41 +0200 (CEST)
Subject: [alsa-devel] alsa-info: lots of mostly syntactic changes
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

alsa-project/alsa-utils pull request #29 was opened from E5ten:

- remove all bashisms and change shebang to #!/bin/sh
- replace use of which with command -v for portability
- remove awk dependency
- general cosmetic consistency:
    - indentation
    - always put then or done on the same line as if, for, or while
- quote much more, especially when the variable refers to a file
- replace many uses of >> $FILE with command grouping and single
  redirects of the command groups
- simplify text processing pipelines, mostly by turning them into
  a single sed command

Request URL   : https://github.com/alsa-project/alsa-utils/pull/29
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/29.patch
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
