Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A78C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Nov 2023 16:23:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E54A5EA6;
	Fri,  3 Nov 2023 17:22:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E54A5EA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699028601;
	bh=kjdDsewq7/Uih5g1eAdb2BVmOlhcgA7XLihAWsdtKOY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=q1G1Gf4f8xW4NGwpCMzK5ISGd28DzMRt34UuZk13Z2BIwH/fGB8l1EEC+GzQKURvL
	 Y1N1zx3WHb+K00HNVt0C417xLkSLzCxVQ9vqUOtidr693drz84pL9rkY+SEtSUGfjh
	 XhvKsB8mYue+IW+bpZZRouMnxhXEnC5h712EhSNw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 601C7F8003C; Fri,  3 Nov 2023 17:20:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93EA6F8020D;
	Fri,  3 Nov 2023 17:20:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D777F805AA; Fri,  3 Nov 2023 17:20:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 501DBF8016D
	for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2023 17:20:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 501DBF8016D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1699028405927824736-webhooks-bot@alsa-project.org>
References: <1699028405927824736-webhooks-bot@alsa-project.org>
Subject: Documentation: Add ucm URL
Message-Id: <20231103162019.0D777F805AA@alsa1.perex.cz>
Date: Fri,  3 Nov 2023 17:20:18 +0100 (CET)
Message-ID-Hash: AML5M4Q4WTVPHRAPOSEP2UXVYPATUNXV
X-Message-ID-Hash: AML5M4Q4WTVPHRAPOSEP2UXVYPATUNXV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AML5M4Q4WTVPHRAPOSEP2UXVYPATUNXV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #366 was opened from broukema:

This commit adds the main alsa-ucm-conf documentation URL to PinePhone.conf, and clarifies the relevance of the other three URLs.

While in principle it could be argued that anyone editing ucm2 .conf files should RTFM, in practice everybody's busy and will not always find which documentation is the most useful and up-to-date. This commit aims to help people identify where they can expect to find the most useful+up-to-date info so that they can understand the current roles of the various types of sections of the config files, and file bug reports if behaviour of alsa-lib software differs from what's described in the documentation.

This merge request should hopefully be uncontroversial. :)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/366
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/366.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
