Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9EBC4167B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Dec 2023 14:58:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37AB0A4C;
	Wed,  6 Dec 2023 15:58:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37AB0A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701874725;
	bh=ssSn6GAwb0cJBjH46SnqSuOmqPVFY7exKY9cXToXE70=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SNSpwoRbKiVYdA7KupTfFeCydKofj5wjm9FUqfClYo5W2jA2QOHiaA5OJQo+AOl93
	 rgaHO0gYKLGIqLNEm7H+DOdFl63GWuuTModjdTL8YZ9OicU/IWF+b+tl+SawFaa5iI
	 yOTHIuEPotNX5XC9GmTqlA30lmvPdiYdXzh+i8go=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6570CF80563; Wed,  6 Dec 2023 15:58:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5C7BF80571;
	Wed,  6 Dec 2023 15:58:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EBF3F8024E; Wed,  6 Dec 2023 15:58:07 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E4BCCF800D2
	for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2023 15:58:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4BCCF800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1701874680760279894-webhooks-bot@alsa-project.org>
References: <1701874680760279894-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-soundwire: Use one file for speaker codec initialization
Message-Id: <20231206145807.2EBF3F8024E@alsa1.perex.cz>
Date: Wed,  6 Dec 2023 15:58:07 +0100 (CET)
Message-ID-Hash: TNJAMUJOJMULEGN7YKERHYSJLLOFEH7H
X-Message-ID-Hash: TNJAMUJOJMULEGN7YKERHYSJLLOFEH7H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TNJAMUJOJMULEGN7YKERHYSJLLOFEH7H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #370 was opened from perexg:

Use macros to minimize configuration blocks.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/370
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/370.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
