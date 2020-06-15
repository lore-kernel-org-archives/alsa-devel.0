Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E74C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:01:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E00206B7
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DfNm2y7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E00206B7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B05715E5;
	Mon, 15 Jun 2020 13:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B05715E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592218871;
	bh=qGRE0Z9IRt1rCv8+WQEaLPsva3a96XgukU67pBYxQ2o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DfNm2y7NjlpiVRFaBMMVARCgqTS2e7z4XQtdsqyw9+RWAkw/xFplgDApuN0p5Tq8G
	 iPElDpeBzum5m5jWYX8es0L0+o3NUnav8l+iNc9g8vYi4nVFeXuEL9ORWfoZ2L9RJt
	 59oCkVGWi9dlnGexk7+6B29CWqb2q1mIwtm996Qg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B287EF80162;
	Mon, 15 Jun 2020 13:00:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7429DF80171; Mon, 15 Jun 2020 13:00:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B5D0DF8013E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 13:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5D0DF8013E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592218814897614002-webhooks-bot@alsa-project.org>
References: <1592218814897614002-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq/timer: add constructure for status object
Message-Id: <20200615110019.7429DF80171@alsa1.perex.cz>
Date: Mon, 15 Jun 2020 13:00:19 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #39 was opened from takaswie:

In patchset at #38, I forgot to add constructors for issued status object because no function call returns the instance of object. This patchset adds the constructors.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/39
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/39.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
