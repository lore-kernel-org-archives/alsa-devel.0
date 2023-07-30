Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B1C001DF
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Jul 2023 12:44:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1D1D828;
	Sun, 30 Jul 2023 14:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1D1D828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690721074;
	bh=kEsbsBR438oqf/SazjePCxTh8UPj3aOwMP8rYPZZIM4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FTMbbo1xo8xsoN/otwG/x9GhtrhelQ3QxnvTzN7TSL9tdVL5EDCHZHhqXjXazVJUe
	 eVOXuvMPfdTMf/zb3nmDmPHwgFWDgvlj+NwLlIH0AxN42iMmd8w9NVnY0uHUZbTCSe
	 3Hv/kY6jYf+SJGXRU5rgI/5siDbA2/IRvKCbjyBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BA25F80549; Sun, 30 Jul 2023 14:43:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E6CCCF80153;
	Sun, 30 Jul 2023 14:43:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAFEFF8016D; Sun, 30 Jul 2023 14:43:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E50C7F80153
	for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2023 14:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E50C7F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690720986457345486-webhooks-bot@alsa-project.org>
References: <1690720986457345486-webhooks-bot@alsa-project.org>
Subject: Documentation cleanup
Message-Id: <20230730124310.EAFEFF8016D@alsa1.perex.cz>
Date: Sun, 30 Jul 2023 14:43:10 +0200 (CEST)
Message-ID-Hash: CQURXHTLZ462JRALU7JTAKE7E424SCVF
X-Message-ID-Hash: CQURXHTLZ462JRALU7JTAKE7E424SCVF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQURXHTLZ462JRALU7JTAKE7E424SCVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #340 was opened from borine:

Fixes missing doxygen tags and macros so that now doxygen picks up all of the documentation comments and completes cleanly without any errors or warnings.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/340
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/340.patch
Repository URL: https://github.com/alsa-project/alsa-lib
