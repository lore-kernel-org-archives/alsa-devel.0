Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1AAC25B67
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Oct 2023 08:31:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8AEFDEB;
	Fri, 27 Oct 2023 10:30:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8AEFDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698395470;
	bh=gwZFto1iq4csw6mgqin5Pbd6C7ndOCpcDoQBhjZSYNg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kmQka7UkZMr2xNkr6UMpVoaNvKfKWyK/Cenb2fwfgN+fGj23oM9OIwa0a6Sghyi3I
	 4zj+MZy2kzG1CQ9dHuR23CktOtyaQp2yPO1JFX+THbfPo44JL+7upvfFusHGETltMk
	 xmYfKIT6eecauvOXzCTJGQ/hHsZZ4cCVWllhlW1E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 451BFF8010B; Fri, 27 Oct 2023 10:29:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95563F8010B;
	Fri, 27 Oct 2023 10:29:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8559BF8019B; Fri, 27 Oct 2023 10:29:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id C66D0F8014B
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 10:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C66D0F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698395380749572515-webhooks-bot@alsa-project.org>
References: <1698395380749572515-webhooks-bot@alsa-project.org>
Subject: ucm2: soundwire: add rt713 SDCA device
Message-Id: <20231027082946.8559BF8019B@alsa1.perex.cz>
Date: Fri, 27 Oct 2023 10:29:46 +0200 (CEST)
Message-ID-Hash: CPWMAOYT55AONJTCANKEDQPVEGEH5BWB
X-Message-ID-Hash: CPWMAOYT55AONJTCANKEDQPVEGEH5BWB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPWMAOYT55AONJTCANKEDQPVEGEH5BWB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #363 was opened from shumingfan:

ucm2: soundwire: add rt713 SDCA device

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/363
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/363.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
