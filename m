Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A191C48BDF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:44:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A2461002
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A2461002
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CB331677;
	Tue, 15 Jun 2021 17:44:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CB331677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623771895;
	bh=BuhlqQstT4rS2KUOaPFkw68loy3tyMtQNldCjJy0sLE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/bj6tRbBmfAZmy2ebNQ/o6SvmhJ7rs4/Tyr2gxOl3/Dg7RAwo908c17UezKDB83T
	 WnuJNfHCBfuRCY66m7Q5AF4ndo3NFDz/K3konKXpFRyfDJALLYbwoE2QtYX+uvUpfq
	 t3aEJonrIPzgq2RHNb4EKNW6FLlN8msdczRtE6Vc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 261B6F8016D;
	Tue, 15 Jun 2021 17:44:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D0B0F80113; Tue, 15 Jun 2021 17:44:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9DAC1F80113
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 17:43:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DAC1F80113
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623771834847848892-webhooks-bot@alsa-project.org>
References: <1623771834847848892-webhooks-bot@alsa-project.org>
Subject: Undefined symbol in static library
Message-Id: <20210615154403.8D0B0F80113@alsa1.perex.cz>
Date: Tue, 15 Jun 2021 17:44:03 +0200 (CEST)
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

alsa-project/alsa-lib issue #157 was opened from jpalus:

There is a mismatch between declaration:
https://github.com/alsa-project/alsa-lib/blob/f4c061f349188c548497607efd4622c6e6a43270/src/control/control_symbols.c#L24
and actual definition:
https://github.com/alsa-project/alsa-lib/blob/f4c061f349188c548497607efd4622c6e6a43270/src/control/control_empty.c#L33
resulting in undefined symbol in static library. Judging by convention used in other files I suppose the latter should be renamed to match declaration.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/157
Repository URL: https://github.com/alsa-project/alsa-lib
