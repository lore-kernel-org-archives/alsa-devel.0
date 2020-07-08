Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B308C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:19:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DE620720
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KncwR2sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DE620720
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BD8115F2;
	Wed,  8 Jul 2020 16:18:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BD8115F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594217971;
	bh=AS3FRmDoGIuizm1FOEH3cXOCDM4JEmHrbQJ0IUjOdxE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KncwR2sVYJNpjMMrM7vgMEG92MC2RsZKRqftTg+804HarTQZLe11+9D0RAqSG/mkm
	 YsInXJPyjXMSBDonC3ZdAAqLwZqwY1aJWGftdpvO3a0BzmxkDeL5ShZ9TefqWXuXoX
	 nVCzDLW/IBddu1YvWOsRY4ds6b/U1O88LWCXObHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7B6FF80150;
	Wed,  8 Jul 2020 16:18:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3431F80150; Wed,  8 Jul 2020 16:18:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CF914F80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 16:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF914F80115
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594217911145972967-webhooks-bot@alsa-project.org>
References: <1594217911145972967-webhooks-bot@alsa-project.org>
Subject: French translation update
Message-Id: <20200708141838.F3431F80150@alsa1.perex.cz>
Date: Wed,  8 Jul 2020 16:18:38 +0200 (CEST)
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

- fixes spaces
- improvements
- min/MAJ
- update some strings
- new strings translations
- typo fixes

Request URL   : https://github.com/alsa-project/alsa-utils/pull/42
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-utils
