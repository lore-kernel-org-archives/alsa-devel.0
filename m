Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47505C10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 00:27:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79E9222C3
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 00:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dVI6pntn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E9222C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41299828;
	Wed, 11 Mar 2020 01:26:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41299828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583886435;
	bh=9hkpiENi2fmLYQD7qgRSLsZ13kxlChnihz6mA03rdVw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dVI6pntn2qazCUASlUHn+LNMExClbYu7ov6KmLg//IykT4tZS0bnCQhpn7DHvTmDp
	 3+Omuob2h1RlRiM0xxi4nLOA3K+wAo298WuGrXdtduGrXgKqYpWe7VTYw3K2afH8T5
	 PxMZpaJcFad3W5RpcEa5t81FAEYPhDKrhCGOPmqs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A1E3F8020C;
	Wed, 11 Mar 2020 01:26:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 924DBF80217; Wed, 11 Mar 2020 01:26:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 99690F800DA
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 01:26:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99690F800DA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583886376963728905-webhooks-bot@alsa-project.org>
References: <1583886376963728905-webhooks-bot@alsa-project.org>
Subject: Sample project request...
Message-Id: <20200311002621.924DBF80217@alsa1.perex.cz>
Date: Wed, 11 Mar 2020 01:26:21 +0100 (CET)
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #35 was opened from mnini:

Can you make sample of alsa processor that is have input and output in the code?

I know only syntax of C and I want to program DSP for linux output sound.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/35
Repository URL: https://github.com/alsa-project/alsa-lib
