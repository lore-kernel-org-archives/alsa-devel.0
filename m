Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E16C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 17:20:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 609C42CFC;
	Fri,  5 May 2023 19:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 609C42CFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683307234;
	bh=5Hoo8Gfvy47Fbtpr1Dsa0tmH8XcmJ4EFh1TPTmk6kW4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BuTdh8odirB5fQ0iX5Sq4gF3E1o3dFudh+hHJFSVS3YoW079MbygjKNwbtAvPRNa2
	 +nAsiMof2gH2KjghEyQlgOFrzGxcq4KAfUHoxnzi4FzB28G9+mF2dyWMZEQvRkyrmj
	 Q+GqXyGC7szrAoScF3iGF5GKScBStOZ8kFuas++U=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F64EF80087;
	Fri,  5 May 2023 19:19:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16066F8052D; Fri,  5 May 2023 19:19:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 44661F80520
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 19:19:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44661F80520
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683307151396736860-webhooks-bot@alsa-project.org>
References: <1683307151396736860-webhooks-bot@alsa-project.org>
Subject: Added double quotes to variables of three `rm` commands
Message-Id: <20230505171915.16066F8052D@alsa1.perex.cz>
Date: Fri,  5 May 2023 19:19:15 +0200 (CEST)
Message-ID-Hash: O2BTZWLCWZEOWJWC32JNWKKZICGY5NRC
X-Message-ID-Hash: O2BTZWLCWZEOWJWC32JNWKKZICGY5NRC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O2BTZWLCWZEOWJWC32JNWKKZICGY5NRC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #210 was opened from wileyhy:

lines 73, 80 and 98

Request URL   : https://github.com/alsa-project/alsa-utils/pull/210
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/210.patch
Repository URL: https://github.com/alsa-project/alsa-utils
