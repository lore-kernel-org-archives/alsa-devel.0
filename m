Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD413C83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:33:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4B320661
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VxhKe+98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4B320661
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5108167D;
	Tue, 28 Apr 2020 15:33:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5108167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588080833;
	bh=2gI11G+s6lGUIdUz/uJjTHlmPB34Q+ElWj7NZT8+KGU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VxhKe+98rV8tPhB33K2+2lfBCRBaAuPgQj0MBXuQ1lFRFRGgKMvwnVNeSNV2OLEoa
	 eoTCH0gbW6OCGUKfYGLTRMk4HPObN1UBXl+lD0jJ4wAOIBqzRTBejzmDtk+ajElDc5
	 wGZLo56TcLgZ7YIvam2cvEtWvQs8nDwTBzy+f20U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3569CF80136;
	Tue, 28 Apr 2020 15:33:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1ED91F801DB; Tue, 28 Apr 2020 15:33:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A3376F8010A
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 15:32:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3376F8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1588080772889811039-webhooks-bot@alsa-project.org>
References: <1588080772889811039-webhooks-bot@alsa-project.org>
Subject: please point wiki to github
Message-Id: <20200428133301.1ED91F801DB@alsa1.perex.cz>
Date: Tue, 28 Apr 2020 15:33:01 +0200 (CEST)
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

alsa-project/alsa-lib issue #43 was opened from archenemies:

Googling "alsa report issue" or "alsa report bug" takes me to the following page:

https://www.alsa-project.org/wiki/Bug_Tracking

This page should have a link to https://github.com/alsa-project/alsa-lib/issues/

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/43
Repository URL: https://github.com/alsa-project/alsa-lib
