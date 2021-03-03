Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2636C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 21:08:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583FB64EF8
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 21:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583FB64EF8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 015901A93;
	Wed,  3 Mar 2021 22:07:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 015901A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614805683;
	bh=Eg8Fcw8QG8CgLuoj0OrhUyjh5fxlNnT7m68VXU1EPTI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qW5Yvx7sVPikJ/Psj5pREnTxCJXQfxM8ioqa+PGt3Blkh+DpDGP38BGe+c1o7C5SP
	 UbyNAW+BUd0w77yvy/PclwMwMghyqR2eBhaOr+3NWKY4drv1lexB9XjtNizeMfL3Fv
	 K443Olk3mEUM1ee2C/13xQ6xD9Yv+PgDwDqsisaw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6006AF80227;
	Wed,  3 Mar 2021 22:07:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 734A6F8025E; Wed,  3 Mar 2021 22:07:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D7F68F80227
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 22:07:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F68F80227
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1614805616283802032-webhooks-bot@alsa-project.org>
References: <1614805616283802032-webhooks-bot@alsa-project.org>
Subject: conf: Remove non-existent SPDIF output on Dell AE515
Message-Id: <20210303210709.734A6F8025E@alsa1.perex.cz>
Date: Wed,  3 Mar 2021 22:07:09 +0100 (CET)
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

alsa-project/alsa-lib pull request #124 was opened from drjhe:

The Dell Professional Sound Bar AE515 shows up in GNOME Settings with a digital output that doesn't physically exist. Add it to the list to suppress this.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/124
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/124.patch
Repository URL: https://github.com/alsa-project/alsa-lib
