Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EBC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:03:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D66206E2
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xrst3tMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D66206E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 455691673;
	Tue,  7 Jul 2020 17:02:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 455691673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594134186;
	bh=VqGOPJ+g5A1pSx0HQmhlClPNi9+K1AkIuI/ubl15mHI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xrst3tMjU45uFYKbzkQz06/acx1dQJ4zwc/6HoqP0SmZ3pl50AdErgiMt1n/sk7h2
	 rsAAdy8W7gootNIgia93+9e2SXXcyoesLkL7sGgTBPKC8gjvSUP3pPJ7o3eXDMBAlQ
	 IxObU2dY5h54U9FL1jw4B+LYjGP5P0jM7+nd7xi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D54D6F8011F;
	Tue,  7 Jul 2020 17:02:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BD8DF80216; Tue,  7 Jul 2020 17:02:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7A934F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 17:02:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A934F8011F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594134127026408911-webhooks-bot@alsa-project.org>
References: <1594134127026408911-webhooks-bot@alsa-project.org>
Subject: Localization
Message-Id: <20200707150214.7BD8DF80216@alsa1.perex.cz>
Date: Tue,  7 Jul 2020 17:02:14 +0200 (CEST)
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

alsa-project/alsa-tools issue #1 was opened from yasarciv:

Will there be translations to other languages?

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/1
Repository URL: https://github.com/alsa-project/alsa-tools
