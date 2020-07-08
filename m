Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5637C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D628206E9
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dqpqV6oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D628206E9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BD5C165E;
	Wed,  8 Jul 2020 16:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BD5C165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594218024;
	bh=wHvm1tje2O87Jay0w9rqNUAE4zBeLSCJrXp2pXlBDr4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqpqV6oGU1RydOxnGh9fFXF5op/Fyq1+mEjaHrY/MXjtEJT2e6sK9TG7FOusxfaRP
	 cP/nXPVuf1ggHk4OM0nxLM9wnsGkeazn+0Mpm70taxI6GL58udrsbNLsVYV53TiXGf
	 zVGhom0xrOi5YBeiYEsmlsVQ9DbL5X93dCPn9/iI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5278BF8015D;
	Wed,  8 Jul 2020 16:18:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1D0BF800AE; Wed,  8 Jul 2020 16:18:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2D506F800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 16:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D506F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594217918992643118-webhooks-bot@alsa-project.org>
References: <1594217918992643118-webhooks-bot@alsa-project.org>
Subject: French translation update
Message-Id: <20200708141841.E1D0BF800AE@alsa1.perex.cz>
Date: Wed,  8 Jul 2020 16:18:41 +0200 (CEST)
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

alsa-project/alsa-utils pull request #42 was edited from trebmuh:

- spaces fixes
- improvements
- min/MAJ
- update some strings
- new strings translations
- typo fixes

Request URL   : https://github.com/alsa-project/alsa-utils/pull/42
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-utils
