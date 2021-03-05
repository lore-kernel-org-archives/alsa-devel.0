Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E77C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ADD650A0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ADD650A0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 896BD1ACF;
	Fri,  5 Mar 2021 21:10:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 896BD1ACF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614975103;
	bh=Q+pt6B8cE/cIztsnMTXf3uFl+4t/2f8WyV2UTpeJxgA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1xG5sQigNg0vlY7SYPROUnmKr9yy3yf90bDcOlNgPSt+OexVcgZRLPZPiGxfC64E
	 csv1TJeY5O2/SZeRBkiw3mDbyvki46RRveZyp1FcPiUWfwmeQy7NxulUrhHD53PNqi
	 zUPlCzbKyYbMLpC79p0Rfj0k90dOi5UWhaTMCBw4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5347EF800ED;
	Fri,  5 Mar 2021 21:10:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5E68F8025E; Fri,  5 Mar 2021 21:10:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8BCA2F80121
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 21:10:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BCA2F80121
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1614975040106086969-webhooks-bot@alsa-project.org>
References: <1614975040106086969-webhooks-bot@alsa-project.org>
Subject: Use HTTPS instead of HTTP
Message-Id: <20210305201048.E5E68F8025E@alsa1.perex.cz>
Date: Fri,  5 Mar 2021 21:10:48 +0100 (CET)
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

alsa-project/alsa-utils pull request #79 was opened from BrunoVernay:



Request URL   : https://github.com/alsa-project/alsa-utils/pull/79
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/79.patch
Repository URL: https://github.com/alsa-project/alsa-utils
