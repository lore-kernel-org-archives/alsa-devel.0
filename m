Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455D5C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 19:54:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F4C61CC3
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 19:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F4C61CC3
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 933AF83A;
	Wed,  7 Jul 2021 21:53:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 933AF83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625687688;
	bh=Hk4VIwOd5lheCSXdMMoSA4H2/SQJFDVSR/IvSksctEs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaqRQOnGiKU4Z5a0yc9uyr3XWQLSWU/0SLrXExKdCzKo3a4wVzlMvHS4+kMw4I77E
	 8vzGO9kXC0vXm/lmEvjJd+YTDG01d92lb3I5KRLvK+Zz0erq6PuX3RaS7kjFmiZDUm
	 NbCgBw/ifY0X+hvZeyLzYFBO6koRAykkfQlnvhU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2986FF8016C;
	Wed,  7 Jul 2021 21:53:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54A48F80224; Wed,  7 Jul 2021 21:53:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 11C0BF8012A
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 21:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11C0BF8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1625687624409924030-webhooks-bot@alsa-project.org>
References: <1625687624409924030-webhooks-bot@alsa-project.org>
Subject: Added configuration information to manual page
Message-Id: <20210707195356.54A48F80224@alsa1.perex.cz>
Date: Wed,  7 Jul 2021 21:53:56 +0200 (CEST)
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

alsa-project/alsa-utils pull request #103 was opened from braph:

Added sections FILES and CONFIGURATION.
Removed section BUGS, because the described terminal issues have been fixed.

Signed-off-by: braph <braph93@gmx.de>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/103
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/103.patch
Repository URL: https://github.com/alsa-project/alsa-utils
