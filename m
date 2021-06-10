Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA118C47094
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 12:19:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211F2613C1
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 12:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211F2613C1
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E087B178A;
	Thu, 10 Jun 2021 14:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E087B178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623327582;
	bh=aHp4oslbab1zRnJ3Hd2wObQtTqdNPppob3CPqV/dAEw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=POql6hWyGi+RBkrqLH3ajSRql2LleQyWE8ZLR7hHk8AR3nwYY7cRUG9kGnEOKSbzU
	 UYHXz8peL2S93mmqrb4Ib5QZLasi5sdmRQSqgeOSs2d5rzS4/kKAW1Xa8ZYvFLN84c
	 /K+YOiur9TXq0SyVHjWJ7aTRr7meJrtryWFNXN2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67CFFF8020D;
	Thu, 10 Jun 2021 14:18:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EE27F80218; Thu, 10 Jun 2021 14:18:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CC6E2F801EC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 14:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC6E2F801EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623327521455009937-webhooks-bot@alsa-project.org>
References: <1623327521455009937-webhooks-bot@alsa-project.org>
Subject: Logitech C922x microphone intermittently working
Message-Id: <20210610121850.9EE27F80218@alsa1.perex.cz>
Date: Thu, 10 Jun 2021 14:18:50 +0200 (CEST)
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

alsa-project/alsa-lib issue #152 was opened from sambo57u:

I have a Logitech C922X (detected as C922) USB webcam. Running latest updates on Fedora 34. The microphone of this device only works about 1 out of 5 reboots. When not working if I install another microphone, activate that one, the unplug and plug
C922 back and switch to it,  it starts to work. Some kind of a timing issue that is very annoying. Don't have this problem with
Logitech C270. The camera always works fine.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/152
Repository URL: https://github.com/alsa-project/alsa-lib
