Return-Path: <SRS0=AXAa=7N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B155C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2020 21:54:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363FB206C3
	for <alsa-devel@archiver.kernel.org>; Sun, 31 May 2020 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n2eP8tlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FB206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C604F1693;
	Sun, 31 May 2020 23:53:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C604F1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590962071;
	bh=pf2GvYxUR06Y3rWJKeCALBJXPMrBsWqhuWMdyuSVWdk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2eP8tlITp9fRx46eilYCNia3vg8B5Cve+jHIu6Ky++jivbA2yjiu94frpWDdSOSh
	 TN+QTHuRXvbDoQoHmWdEzzDFaXwuEYtcbcJQehv7gJB+wP334/iCxhGnhr5MdUyQRP
	 3M3+ri9rDRaEJgbqKZl3HSHu/lZqRaFUfIUegPNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39E74F80213;
	Sun, 31 May 2020 23:53:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 130BFF8023F; Sun, 31 May 2020 23:52:45 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CF56AF8013D
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2020 23:52:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF56AF8013D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1590961958912374020-webhooks-bot@alsa-project.org>
References: <1590961958912374020-webhooks-bot@alsa-project.org>
Subject: No way to get notified of playback progress
Message-Id: <20200531215245.130BFF8023F@alsa1.perex.cz>
Date: Sun, 31 May 2020 23:52:45 +0200 (CEST)
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

alsa-project/alsa-lib issue #54 was opened from wm4:

See subject. There is a way to run user code in a signal handler with snd_async_add_pcm_handler(). But that seems extremely questionable, is for sure not supported everywhere, and is probably full of subtle synchronization bugs. There is snd_pcm_poll_descriptors() and related, but that seems to signal only whether at least 1 period is available, nothing else. Judging from the docs.

That seems like a rather big missing thing - I probably overlooked something. Otherwise this is a feature request for an asynchronous notification on period boundaries/underruns/device disconnection, that does not run in a UNIX signal handler. Maybe something relatively similar to that poll() mechanism.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/54
Repository URL: https://github.com/alsa-project/alsa-lib
