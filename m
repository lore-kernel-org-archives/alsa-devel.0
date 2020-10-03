Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B03C41604
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:03:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A4E206CD
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e8acworl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A4E206CD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A18511771;
	Sat,  3 Oct 2020 14:02:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A18511771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601726599;
	bh=nZ9guSz8z4G12XqYa1eLsjb77Z4aHqiE4mXtlmzJuSk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e8acworly14XzB0bfiK79yYPld13p+iQfyszStoE8qsTm6AlxVaXVxasCHIWrID69
	 G812PpRl6emigYIh7QPcx38YtLkPdHc6y1zpvTnDBwzarJUkerWTYYlmb/7Fmxy7EU
	 /aR+noSBBZEXY4BIMxXmIiPupNh/GMYg8alWR5Qc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29535F801DB;
	Sat,  3 Oct 2020 14:02:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B75F4F801F5; Sat,  3 Oct 2020 14:02:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A5663F800BB
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 14:02:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5663F800BB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1601726537291300058-webhooks-bot@alsa-project.org>
References: <1601726537291300058-webhooks-bot@alsa-project.org>
Subject: treewide: fix typos in manual pages
Message-Id: <20201003120228.B75F4F801F5@alsa1.perex.cz>
Date: Sat,  3 Oct 2020 14:02:28 +0200 (CEST)
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

alsa-project/alsa-utils pull request #61 was opened from ferivoz:

Signed-off-by: Samanta Navarro <ferivoz@riseup.net>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/61
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/61.patch
Repository URL: https://github.com/alsa-project/alsa-utils
