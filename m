Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A0CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA1721D90
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rKe+0yVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA1721D90
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 017D984D;
	Tue, 14 Jul 2020 13:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 017D984D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594725233;
	bh=SxAryiBg+CXOYq1HUM7bhSs8Vbi+r3BupTNsYd4Ytvg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKe+0yVE9ZiYrm+Lu1c1wou5kYJa5rU0doncDqQWjYFu+CRoJ63gjFCKYIuT3ZVNe
	 3vs4LObtedsAuct6jh7T1e3QRERWson09QRPFiPVVPGQVxbO4OZGs2qqgOBT1rsHXk
	 TC+agzWaUcBmw/p9SiZ8STsUQ1/khjJZib8l+2QI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E744F8014E;
	Tue, 14 Jul 2020 13:13:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05E85F8019B; Tue, 14 Jul 2020 13:13:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AF944F80113
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 13:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF944F80113
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594725170689719915-webhooks-bot@alsa-project.org>
References: <1594725170689719915-webhooks-bot@alsa-project.org>
Subject: Remove cset value quotation
Message-Id: <20200714111302.05E85F8019B@alsa1.perex.cz>
Date: Tue, 14 Jul 2020 13:13:02 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #40 was opened from libinyang:

This patchset removes the quotation marks of the cset values in the ucm2 config files.
In ucm2 files, the cset values should not use quotation marks. Otherwise, the cset won't work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/40
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/40.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
