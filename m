Return-Path: <SRS0=b7Q8=XK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD27C4CEC7
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 23:01:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F8720692
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Sep 2019 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VdaKjLPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F8720692
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D63D715E4;
	Mon, 16 Sep 2019 01:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D63D715E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568588482;
	bh=utbUM5luzx0WA/YICofJ7bGIOodm51/DZMHgg05hnt8=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdaKjLPt5JNP2MITh+U8/DyUS4WAwsFZXCpi1IOK4Jf5P9KV43Z44TeUCciW1c/2A
	 Nbvan5yDaXMYiwUCE87IpikJt4AypS0ZG/F5I+GwbdApDsY4bR2R5K6s1RnZMtc1Mq
	 bzzAUYnduehY8k6uIzEMm2zdA8EL30iil1gag0N8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 543BEF802DF;
	Mon, 16 Sep 2019 01:00:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CD91F80361; Mon, 16 Sep 2019 01:00:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C82B4F802DF
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 01:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C82B4F802DF
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1568588425812326908-webhooks-bot@alsa-project.org>
References: <1568588425812326908-webhooks-bot@alsa-project.org>
Message-Id: <20190915230030.0CD91F80361@alsa1.perex.cz>
Date: Mon, 16 Sep 2019 01:00:30 +0200 (CEST)
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

alsa-project/alsa-lib pull request #11 was opened from conradjones:

memory leak in snd_pcm_set_chmap :

memory is allocated in the function pointed at by : pcm->ops->get_chmap 

called in: snd_pcm_chmap_t *snd_pcm_get_chmap(snd_pcm_t *pcm)

Request URL   : https://github.com/alsa-project/alsa-lib/pull/11
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/11.patch
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
