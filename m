Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC9C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:08:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FBB20720
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="slQW8KLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FBB20720
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ED7B166D;
	Wed, 17 Jun 2020 07:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ED7B166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592370508;
	bh=AfoyPzENKsY+inaQruKfOrwefpWoppg99Y65nT5LrrY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=slQW8KLdS8LJsYReoSUXlNHWf/5FIbtSS3mx8kmSeIuBsJl0i64mYKirNDYIFW95o
	 oyd2K98OnarzzcbCn5NeKad/sbDM+jroCpZoBepUNpHomb/2aqy1dzPycJtX3++mIA
	 q0QUEGzvt2r8psX4QBZLZILBBUCjeni4iCV3P1j8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF51BF80162;
	Wed, 17 Jun 2020 07:07:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3583F80171; Wed, 17 Jun 2020 07:07:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 97AACF800EF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 07:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97AACF800EF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592370450217144966-webhooks-bot@alsa-project.org>
References: <1592370450217144966-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: timer/seq: use const qualifier to self argument for
 getter API
Message-Id: <20200617050735.A3583F80171@alsa1.perex.cz>
Date: Wed, 17 Jun 2020 07:07:35 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #40 was opened from takaswie:

In ALSATimer and ALSASeq, some methods have prototype such that self argument don't have const qualifier even if it's getter method.

This patchset adds const qualifier to the methods.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/40
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/40.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
