Return-Path: <SRS0=pDBX=BR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422D7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 19:40:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6315204EC
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JcAoHOZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6315204EC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 631C2852;
	Fri,  7 Aug 2020 21:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 631C2852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596829203;
	bh=F1hMBpj93t4Wn6gTsNw/JR8zoiA5l67Vd5INDGUPsiM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JcAoHOZxfXACs4znAjGOiFB9eMChR8VqnacogPARBrJDITnXifD2D6Mv/Oj8+mag2
	 FDvU7NrxOevs1R4REjAABBe7P5nw8j91ZhmnsUe1/bHNOO5bpg0pmVAxhIrJJ8/aZf
	 cQkKt+UYS68JE87A12YG/bPa4xJVIBjdt5xaNBrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC78DF8020B;
	Fri,  7 Aug 2020 21:39:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0E04F80218; Fri,  7 Aug 2020 21:39:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9130DF800B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 21:39:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9130DF800B7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1596829142950151920-webhooks-bot@alsa-project.org>
References: <1596829142950151920-webhooks-bot@alsa-project.org>
Subject: aplay: fix for aborted capture streams
Message-Id: <20200807193908.A0E04F80218@alsa1.perex.cz>
Date: Fri,  7 Aug 2020 21:39:08 +0200 (CEST)
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

alsa-project/alsa-utils pull request #51 was opened from mrajwa:

This patch set fixes the issue with capture streams which were aborted by external signal like ctrl+c. Currently functions pcm_read() and pcm_readv() when aborted (in_aborting flag set) return the amount of requested frames instead of those actually read prior to interrupt. The consequence of this is repetition of recent X frames where X stands for amount of frames in one period. This problem is barely visible or rather *audible* when the period is small like few milliseconds because repetition of 1 [ms] of data is not-noticeable however if we use buffer and period sizes in seconds then the problem becomes apparent. 


Example issue -> https://github.com/thesofproject/sof/issues/3189

Request URL   : https://github.com/alsa-project/alsa-utils/pull/51
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/51.patch
Repository URL: https://github.com/alsa-project/alsa-utils
