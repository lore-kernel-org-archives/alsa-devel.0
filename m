Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6140C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5593222CF7
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S2xQ9p3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593222CF7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86A19826;
	Thu,  6 Aug 2020 13:58:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86A19826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596715155;
	bh=R7ejjtrGpaxqH1wG26aLEOpUT5ij2WdJzbdvUc846NM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S2xQ9p3r/r8WKCk6cTQ8Tp1LCFznqfejt1GY/1F787vUBQOQUUEFJ9ZqpZcygG3mR
	 qtYny684sT9H4TlPplhQV9flJrUDTj4Y2PcrzWEqawP2gaOYv1l8CoJRwYS/F6n8CN
	 z0Oaih4rUWbvaVuGtI4G5JiWXNGy49wE1AqDuJVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3C81F8015C;
	Thu,  6 Aug 2020 13:57:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2078DF8015D; Thu,  6 Aug 2020 13:57:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A1CA2F80086
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 13:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1CA2F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1596715058462852001-webhooks-bot@alsa-project.org>
References: <1596715058462852001-webhooks-bot@alsa-project.org>
Subject: Microphone selection logic not working for max98090
Message-Id: <20200806115741.2078DF8015D@alsa1.perex.cz>
Date: Thu,  6 Aug 2020 13:57:41 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #44 was edited from jacobopantoja:

An incorrect conflicting device is set for internal mic. See PR #43 and commit 73fac5b1 for proposed solution.

Adding this issue for traceability purposes

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/44
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
