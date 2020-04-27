Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF42C5519B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:41:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B7C2080C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IMnRxR6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B7C2080C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D44F615E0;
	Mon, 27 Apr 2020 10:41:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D44F615E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587976915;
	bh=8V695ec+yCR20bZGikPyZxvTRLGzwSI1ARn9ADe5wPc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IMnRxR6WgQQ5AI9CwDct/ep8owuNj3Ps6e0Kx3N8er1p3BB6HH2nEgBTZ4L4N4lM6
	 Wd8z1xeMhzygtwDbeBaWyoVyUAjdnsvOf8PYtv764ux/wbZF08GNk9wfJRg9sOxopI
	 Nua0in9Z4hiKhaywTrXu3UhG8qsIn+y3TGfUY9Lk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 463A5F8010A;
	Mon, 27 Apr 2020 10:41:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89321F8022B; Mon, 27 Apr 2020 10:41:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E4B3FF8010A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 10:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4B3FF8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1587976854206866026-webhooks-bot@alsa-project.org>
References: <1587976854206866026-webhooks-bot@alsa-project.org>
Subject: error: possibly undefined macro: AM_PATH_ALSA
Message-Id: <20200427084103.89321F8022B@alsa1.perex.cz>
Date: Mon, 27 Apr 2020 10:41:03 +0200 (CEST)
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

alsa-project/alsa-utils issue #40 was opened from zeerd:

Hello!

Seems alsa-utils using gettext, but have no check in the configure.ac

But my question is , could we just ignore the using of gettext by some parameter of configure?
My target-board-sdk has no gettext.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/40
Repository URL: https://github.com/alsa-project/alsa-utils
