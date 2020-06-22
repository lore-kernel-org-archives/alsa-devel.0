Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC0FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:05:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C688C206E2
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rpASWuye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C688C206E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 115AF1658;
	Mon, 22 Jun 2020 11:04:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 115AF1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592816749;
	bh=YLkXsTZKKm0cOTPcYXdneVPKEVIQ3XApf21x0dVEkxQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpASWuye7wg4+Zo1/a1odpmKFcDrSnc13ka1z/Aq/FiY+B85CCont5ESRuZzQUWs1
	 BhsddhgpjH0M53XKQVdXfI+Q8B4zZcZ3WBFkyZ7ZGKcfEr8dXKJ4DcPA+Y8miutAJN
	 r7nndhb2t74B/wDYuYImTEUif2UeBlINbjDL2k3k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85E66F8015A;
	Mon, 22 Jun 2020 11:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD7A3F8015B; Mon, 22 Jun 2020 11:04:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 777B4F8010E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 11:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 777B4F8010E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592816694661978960-webhooks-bot@alsa-project.org>
References: <1592816694661978960-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: bump version up to 0.1.0 for official release
Message-Id: <20200622090457.DD7A3F8015B@alsa1.perex.cz>
Date: Mon, 22 Jun 2020 11:04:57 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #46 was opened from takaswie:

This patch is a preparation for official v0.1.0 release. After merged, I'm going to push a tag 'v0.1.0' with release note.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/46
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/46.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
