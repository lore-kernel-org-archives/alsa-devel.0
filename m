Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA2BC4708E
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 14:06:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 500AF18B7;
	Wed,  7 Dec 2022 15:05:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 500AF18B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670421965;
	bh=vQdlm4JjxIy4o2bYv7V+Ob4SM3ru3nonGJq9vcTPA30=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s+6Js6SLhZRV+7Xaiyw6Je0Sa/sO3MMc0Rom5dt5rp8aAPq7Lky7M+6NGOWqAwi/R
	 0hO+/IVc6DsfGhATMteVX0ibK5ai7C+c4fj1ggqFSqHcow2Yr9AvDRBtuyxFut6CyA
	 bgOJ4A6sSW+b9f6/9iCpHfsPpQC8d9mhs5r4zCG4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC84DF8021D;
	Wed,  7 Dec 2022 15:05:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99BBFF802BE; Wed,  7 Dec 2022 15:05:13 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 887AEF800EE
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 15:05:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 887AEF800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670421906207937956-webhooks-bot@alsa-project.org>
References: <1670421906207937956-webhooks-bot@alsa-project.org>
Subject: topology: plugins: nhlt: fix ssp debug
Message-Id: <20221207140513.99BBFF802BE@alsa1.perex.cz>
Date: Wed,  7 Dec 2022 15:05:13 +0100 (CET)
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

alsa-project/alsa-utils pull request #180 was opened from juimonen:

Nhlt ssp plugin debug feature was broken due to recent change in ssp indexing, thus fix it.

Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/180
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/180.patch
Repository URL: https://github.com/alsa-project/alsa-utils
