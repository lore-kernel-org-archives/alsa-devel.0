Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD54C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 14:53:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48823238A1
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 14:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48823238A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89EAE18CD;
	Thu, 21 Jan 2021 15:52:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89EAE18CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611240786;
	bh=8mzL1fO8o8ujfgofmvffiRvTlEGsE5X/vQcYn9DewP4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rppp9eOjCFQNidt49w4MjSoa2qZ1BvO1OWNJMYzAERd+KaT36iu0zrnBrmOckEZ45
	 Lcx3SZT6TMadMcdlt9gTT5CupuVU1JV7m9u5HjnPZOvSwYZ1N76nrv5yns20UwU1Xl
	 mPmT4yaNk/oG1DEZ8M3uFqEDBKkEQsIuE3n2ieHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABF24F80255;
	Thu, 21 Jan 2021 15:52:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 972A6F80257; Thu, 21 Jan 2021 15:52:13 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0C270F80164
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 15:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C270F80164
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1611240720891453028-webhooks-bot@alsa-project.org>
References: <1611240720891453028-webhooks-bot@alsa-project.org>
Subject: pcm: pcm_ioplug - fix the avail_update mmap capture copy issue
Message-Id: <20210121145213.972A6F80257@alsa1.perex.cz>
Date: Thu, 21 Jan 2021 15:52:13 +0100 (CET)
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

alsa-project/alsa-lib pull request #115 was opened from perexg:

It seems that the commit "pcm: ioplug: Transfer all available data"
introduced new regressions (wrong memory access). The second issue
is that the avail_update in ioplug does not move appl_ptr nor hw_ptr,
so it's possible that the transfers may be repetitive.

This patch moves the transfer calls to mmap_begin callback where it
should be. The pointer wraps are handled by design now.

Fixes: 1714332719 ("pcm: ioplug: Transfer all available data")
BugLink: https://github.com/alsa-project/alsa-lib/pull/103

Request URL   : https://github.com/alsa-project/alsa-lib/pull/115
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/115.patch
Repository URL: https://github.com/alsa-project/alsa-lib
