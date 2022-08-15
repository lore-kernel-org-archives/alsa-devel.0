Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA9C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 16:46:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65BD6162F;
	Mon, 15 Aug 2022 18:45:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65BD6162F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660581988;
	bh=vDJoyABWK4QkIeU1xWcPi8YmykdycsCp0zxabfx5LXg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbAWwqbqlhdAtlKXdaDjkrMB4LKh03EpsI/gm8T4uV/H14UbjNJiFegkA5MZ7Qa9q
	 sZqa4WL5dH60dlix7hFS10aR2Ion0KzaxLT1NBSCL6pAnt1Z2nRUW3xOZU/Ax18tyI
	 OlRaX+x6sDyqs+/yJ3t5Pi1ACM3viPjd25oy0kdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F26E7F8025A;
	Mon, 15 Aug 2022 18:45:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56521F8025A; Mon, 15 Aug 2022 18:45:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 04E0AF80125
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 18:45:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04E0AF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660581933620764971-webhooks-bot@alsa-project.org>
References: <1660581933620764971-webhooks-bot@alsa-project.org>
Subject: trying to open ucm2/conf.d/simple-card/Unknown-UnknownProduct-.conf
 for PinePhonePro
Message-Id: <20220815164536.56521F8025A@alsa1.perex.cz>
Date: Mon, 15 Aug 2022 18:45:36 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #199 was opened from ollieparanoid:

Hi,

we are trying to narrow down why alsa-lib tries to open `/usr/share/alsa/ucm2/conf.d/simple-card/Unknown-UnknownProduct-.conf` instead of the proper path `/usr/share/alsa/ucm2/PinePhonePro/PINE64-PinePhonePro-.conf` with custom (to-be-upstreamed to alsa-ucm-conf.git) ucm configurations we are using in postmarketOS for the PinePhonePro: https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/community/device-pine64-pinephonepro/ucm

It only happens for some users, but not for everybody. I've taken a quick look at the code but didn't see right away where the wrong path is built, `git grep UnknownProduct` gives no results.

Could somebody give us a hint where to look? I don't really have a clue how this works. Thanks!

Downstream discussion: https://gitlab.com/postmarketOS/pmaports/-/merge_requests/3356

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/199
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
