Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E162AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 24 May 2022 11:52:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2123516A1;
	Tue, 24 May 2022 13:51:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2123516A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653393128;
	bh=SnAFb3qTns7ZPrTCG/KJRl5T1LtwEcp2pfDvGWrr41g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uMLW2n5FsZVphyqQLTmKx2O6rB/pS/sASh/fsry9vlIN8Pcrwg/fRTJPnD7NXVWZE
	 U6eNNOX47WnQV/aAKHrLSIdndlRKGCTmrWg4RaSwDoiPfLQZeld+G0XUwt79LDwFzb
	 kOT/2RBsBgfXl+a/KPXRdF5WyI3ANPGz14w6jZyE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8B73F804CC;
	Tue, 24 May 2022 13:51:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D36CF804D1; Tue, 24 May 2022 13:51:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1A552F80100
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2022 13:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A552F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653393071134835958-webhooks-bot@alsa-project.org>
References: <1653393071134835958-webhooks-bot@alsa-project.org>
Subject: Add missing implementation for topology ignore_suspend flag
Message-Id: <20220524115116.5D36CF804D1@alsa1.perex.cz>
Date: Tue, 24 May 2022 13:51:16 +0200 (CEST)
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

alsa-project/alsa-lib pull request #230 was opened from amadeuszslawinski-intel:

ignore_suspend flag was ignored while parsing topology, add missing support for it. This allows use of it on DAI links and DAPM widgets.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/230
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/230.patch
Repository URL: https://github.com/alsa-project/alsa-lib
