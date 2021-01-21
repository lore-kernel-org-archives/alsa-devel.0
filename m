Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F8C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 22:30:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E018E239EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 22:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018E239EF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7859E1935;
	Thu, 21 Jan 2021 23:29:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7859E1935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611268199;
	bh=hSnHNHF0zB4fL+VUj9sNimje6CViFigTTw2CuGMeocc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcSjjS7iaAerYy7jkUOYTc8O+rRUnL/vzHxEQTOfdVE9vPHD8WtCnzihstjlu5Izk
	 9i/9ErL4CBDpiiqtzy9szG6xRwDVchli63QUriz6uAr0DJpozAvE3KwFNM0W6MN1eD
	 t/gYnyTE970WTUCfISrldtPjjmcOL7aZOrS8tr54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39B59F80255;
	Thu, 21 Jan 2021 23:29:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDAE5F80257; Thu, 21 Jan 2021 23:28:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 337EFF80162
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 23:28:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 337EFF80162
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1611268128448493958-webhooks-bot@alsa-project.org>
References: <1611268128448493958-webhooks-bot@alsa-project.org>
Subject: [Regression] Game "Rise of the Tomb Raider" crashes at launch
Message-Id: <20210121222857.BDAE5F80257@alsa1.perex.cz>
Date: Thu, 21 Jan 2021 23:28:57 +0100 (CET)
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

alsa-project/alsa-lib issue #116 was opened from Oschowa:

The the native linux version of the game "Rise of the Tomb Raider" crashes at launch when it doesn't detect a working pulseaudio server and it falls back alsa-lib directly. This is a regression, the last working alsa-lib version is v1.2.1.2 and bisection yields 5ee5ef31b5ff3f as the first bad commit. The crash happens when using "real" alsa hardware drivers as well as when running on the pulseaudio-alsa or pipewire-alsa software plug. Happy to provide more info if i can.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/116
Repository URL: https://github.com/alsa-project/alsa-lib
