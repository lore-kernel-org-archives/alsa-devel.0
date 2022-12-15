Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A81CC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Dec 2022 22:13:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CA87184E;
	Thu, 15 Dec 2022 23:12:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CA87184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671142398;
	bh=WK7DVlkK/PXsM12yLvrb4rPdwLMUSOHyTrTvHqnlG6M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/F8Xz8xapkpSymNsK52Oh4GhN4FcXK1IeZm08L0YZcsrGfPCwUK7VM54W5ZHSzIT
	 oNH6iXwG4LMJ/eB0P0Sr7y/9ScLEIiEkLrpH5lhix9E0UtVwi7lVvT00Ze73gJedse
	 Uw0JRfqra978Qv/eystBBon47VPWO9G3rNS4cYeE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15A09F804E7;
	Thu, 15 Dec 2022 23:12:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17E9F804ED; Thu, 15 Dec 2022 23:12:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2B383F801D5
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2022 23:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B383F801D5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671142344513089895-webhooks-bot@alsa-project.org>
References: <1671142344513089895-webhooks-bot@alsa-project.org>
Subject: aplay,axfer: Replace off64_t with off_t
Message-Id: <20221215221226.A17E9F804ED@alsa1.perex.cz>
Date: Thu, 15 Dec 2022 23:12:26 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-utils pull request #183 was opened from kraj:

Also replace lseek64 with lseek.

_FILE_OFFSET_BITS=64 is passed to needed platforms since configure uses AC_SYS_LARGEFILE macro. Therefore off_t is already 64-bit and lseek is same as lseek64.

Additionally this fixes buils with latest musl where these lfs64 functions are moved out from _GNU_SOURCE and under _LARGEFILE64_SOURCE macro alone. This makes the builds fail on 32-bit platforms even though default off_t on musl is 64-bit always.

Signed-off-by: Khem Raj <raj.khem@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/183
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/183.patch
Repository URL: https://github.com/alsa-project/alsa-utils
