Return-Path: <SRS0=b7Q8=XK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6558C4CECD
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:45:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4CF214AF
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tV5vfonf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4CF214AF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8192A15E4;
	Sun, 15 Sep 2019 21:44:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8192A15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568576703;
	bh=97C9RMZr8KDyOxBbqwXukISMp8ZxUtSPCmhwZE1VjtU=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tV5vfonftAuIAn4hOZSgJMbxYYwA5AYdpVtZ6j6bGkYUVkxXoZNEawySRT+q92kTn
	 qN/eRHNfayuGNgjqT4/dWE6sD6HZM23dZF8Eo9AtwXy3kNW7imC+/8ckH4Y3THjN/r
	 TiulxOLOAzlEDJaETDs+dsFOGRJVFs9NlLT0Jc6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E81B4F80307;
	Sun, 15 Sep 2019 21:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09907F80361; Sun, 15 Sep 2019 21:44:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A4AF2F802DF
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2019 21:44:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4AF2F802DF
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1568576648110091925-webhooks-bot@alsa-project.org>
References: <1568576648110091925-webhooks-bot@alsa-project.org>
Message-Id: <20190915194411.09907F80361@alsa1.perex.cz>
Date: Sun, 15 Sep 2019 21:44:11 +0200 (CEST)
Subject: [alsa-devel] fix memory leak in snd_pcm_set_chmap
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

alsa-project/alsa-lib pull request #10 was opened from conradjones:

asan detects this as a memory leak. 

snd_pcm_get_chmap clearly states that the caller is required to free the returned value, i cannot see it stored anywhere so cannot see how it could be freed.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/10
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/10.patch
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
