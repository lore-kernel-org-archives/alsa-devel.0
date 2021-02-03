Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245DC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:25:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FF764F84
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FF764F84
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27E94173B;
	Wed,  3 Feb 2021 17:24:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27E94173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612369541;
	bh=qah+Lw9EsCZCTc2g8iuXRg1Q35iwtLMPeIlXwIr1y0c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKBLVTwFhpebIMhwRpIXuj5G6YpxTSRsFyybtAjzLurzuCHym+us2Y3/aBk/QhikM
	 JERNCJyDN20YFZVzwE2UDXdzgeLyN66xgdUxVdSmyylpPgferXCfVeIdJZRx1jIBng
	 ymzzy591ERCoG4bZNmbiQ6uD7m3Sw2rROTuItAV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7C18F80154;
	Wed,  3 Feb 2021 17:24:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34637F8016E; Wed,  3 Feb 2021 17:24:49 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CA77EF80154
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 17:24:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA77EF80154
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1612369482268874884-webhooks-bot@alsa-project.org>
References: <1612369482268874884-webhooks-bot@alsa-project.org>
Subject: ucm2: Separate the configuration lookups (hw based)
Message-Id: <20210203162449.34637F8016E@alsa1.perex.cz>
Date: Wed,  3 Feb 2021 17:24:49 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #79 was opened from perexg:

Introduce ucm2/conf.d/ tree with symlinks to the real hardware configurations.
In this way, we do not rely to create the configuration paths based on
simple driver / device identification, but we can store the configurations
more logically to make the maintenance (code reuse, multiple changes)
more easy.

BugLink: https://github.com/alsa-project/alsa-ucm-conf/pull/70
BugLink: https://github.com/alsa-project/alsa-ucm-conf/pull/76
BugLink: https://github.com/alsa-project/alsa-ucm-conf/pull/78

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/79
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/79.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
