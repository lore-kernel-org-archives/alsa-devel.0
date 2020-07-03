Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747AC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB39207D4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tXSnrQ5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB39207D4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CCF716B3;
	Fri,  3 Jul 2020 02:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CCF716B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593737290;
	bh=4XrwAFyEm3vDB30SlAVDeq/hxWsE5hxdhG8Q2xJznmQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXSnrQ5Lc1Y9+JR4x5XLAJo2gXQ97uhgzEy7TrF2BqvTAgOMAtHeQq4n/CeFyxVMz
	 gKUoU5lz56OJN3JdV0GVNmtTbbwezkLMrZTSBzgj2vP5i9Mtb9+8nQJw6m4DGAz21d
	 BW88fNLZXsXhkAT6MJ8xllBDkfthpfhdeXYfblUs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2ECCF8022B;
	Fri,  3 Jul 2020 02:47:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2466F8022D; Fri,  3 Jul 2020 02:47:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E09B9F800ED
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 02:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E09B9F800ED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1593737229610528946-webhooks-bot@alsa-project.org>
References: <1593737229610528946-webhooks-bot@alsa-project.org>
Subject: alsa-lib: ctl: improve documentation for identifier of control element
Message-Id: <20200703004716.F2466F8022D@alsa1.perex.cz>
Date: Fri,  3 Jul 2020 02:47:16 +0200 (CEST)
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

alsa-project/alsa-lib pull request #66 was opened from takaswie:

In documentation, there are two ways relevant to the identifier of control
element. However, the case of combination has the lack of parameters.

This commit improves documentation in this point.

Fixes: f3c24de8c0df ("ctl: add an overview for design of ALSA control interface")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/66
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/66.patch
Repository URL: https://github.com/alsa-project/alsa-lib
