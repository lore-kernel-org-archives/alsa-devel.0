Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F6C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 19:18:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17CF61C5B
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 19:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17CF61C5B
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4FFB83A;
	Wed,  7 Jul 2021 21:17:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4FFB83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625685499;
	bh=z1eg5tyxGt6MYPEBEBHzxB2ZChjkZzg9nGhT7/eiphE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pPNbphDf6RJGf24tV0QnH3PjXzxF2oJXrLWwl5U/g+tCQQQyTxyZv/K8/8Jjon+br
	 OY2cEjT16F1ZGqdgjbwJGai/yjr1+JpYxmU4d0pHwwogqMf386eqwh+mmIPPVYX093
	 Yi6UcB3lk9KqQWAzblZscICnYw1nrbQ6xqJGB+ZE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 553DFF8016C;
	Wed,  7 Jul 2021 21:17:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39D0FF80224; Wed,  7 Jul 2021 21:17:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C0480F8014E
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 21:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0480F8014E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1625685435820916891-webhooks-bot@alsa-project.org>
References: <1625685435820916891-webhooks-bot@alsa-project.org>
Subject: Add a note about return values of snd_pcm_state()
Message-Id: <20210707191728.39D0FF80224@alsa1.perex.cz>
Date: Wed,  7 Jul 2021 21:17:28 +0200 (CEST)
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

alsa-project/alsa-lib pull request #162 was opened from HEnquist:

This is a suggested improvement to the documentation of `snd_pcm_state()`. There is some confusion, probably caused by old bugs that could made it return a negative error code. This stuff is still floating around the internet and sometimes shows up in searches. This PR adds a comment intended to make it absolutely clear that there is never supposed to be a negative error code.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/162
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/162.patch
Repository URL: https://github.com/alsa-project/alsa-lib
