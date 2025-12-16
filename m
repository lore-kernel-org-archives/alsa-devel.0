Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59935D5E15A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:03:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B24AC6017E;
	Tue, 16 Dec 2025 15:03:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B24AC6017E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765893833;
	bh=2G52ImKHF+Z/UxI7PzLgirdDjtAXIOrjx/yhDt6UhJI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OFY8+YRDS8MdCjR8e9ekezHXv2V/Svn35/KjOtfMfbl3I8hWSv9DhQLhnMFGPZbcx
	 HkhHrQqwt/XCpN8eUMeQovRb3pgKDUTYH3CChtD65VCOzvI5kH8tLOfAk+fTLSHuOU
	 gQ2rB99SeszNnp0slzy7ArTKQ2V29KuoG4fFGZcM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 403E4F805DA; Tue, 16 Dec 2025 15:03:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BAF3AF805C9;
	Tue, 16 Dec 2025 15:03:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F58EF80217; Tue, 16 Dec 2025 15:02:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C7C5F800DF
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2025 15:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C7C5F800DF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1881b7071d4f0000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/315@alsa-project.org>
References: <alsa-project/alsa-utils/pr/315@alsa-project.org>
Subject: aplay: add missing break before the default case
Date: Tue, 16 Dec 2025 15:02:59 +0100 (CET)
Message-ID-Hash: I6C26INKRCLLT5YVBR4M3MOVOXTQ2X2J
X-Message-ID-Hash: I6C26INKRCLLT5YVBR4M3MOVOXTQ2X2J
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I6C26INKRCLLT5YVBR4M3MOVOXTQ2X2J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #315 was opened from bardliao:

Add the break before the default case back. Otherwise, all cases will fall into the default/error case.

Fixes: e78583ab7cde ("aplay: reorganize format handling in begin_wave()")

Request URL   : https://github.com/alsa-project/alsa-utils/pull/315
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/315.patch
Repository URL: https://github.com/alsa-project/alsa-utils
