Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB33DC4BA0A
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED3124650
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vc9kOzsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED3124650
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE927166D;
	Wed, 26 Feb 2020 06:44:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE927166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582695910;
	bh=kWI2Z1ZTEatJGsq0Lyj6wU6/YlCL2cP9pZH/4+uJ/bg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vc9kOzsxpmrS4ogrgZvupsj9PYXX9iQEg8AQpQLEJmUkxu9tu936PaXuYAA6dMU4+
	 4pBHBIP5Eo/dqNx2LOjScUMsroe0JVoE0Dse542isy/isekhgoj1XkVFfsJ3viokE2
	 bEmIlSYNzVFkdk7FM4rUle0iEdXQAH1Atc6hsZpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E17F8014D;
	Wed, 26 Feb 2020 06:44:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CA63F8014E; Wed, 26 Feb 2020 06:44:14 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B2E1DF800AD
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 06:44:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2E1DF800AD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1582695851008845091-webhooks-bot@alsa-project.org>
References: <1582695851008845091-webhooks-bot@alsa-project.org>
Subject: Most speakers don't work
Message-Id: <20200226054414.9CA63F8014E@alsa1.perex.cz>
Date: Wed, 26 Feb 2020 06:44:14 +0100 (CET)
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

alsa-project/alsa-lib issue #28 was opened from JonathanReeve:

I have a Lenovo Yoga C-930, which has a Dolby sound bar, and it seems that only one or two out of six speakers work. Is there a way I can make this work? 

Here's my alsa-info: http://alsa-project.org/db/?f=87931920f5a8cbfcaa9a2490b88d8c1ed6337e9f

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/28
Repository URL: https://github.com/alsa-project/alsa-lib
