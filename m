Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56464C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 18:44:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBA7239ED
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 18:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBA7239ED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5264816A4;
	Thu, 14 Jan 2021 19:43:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5264816A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610649874;
	bh=GtMaGUEOmB3/LbhwV5xEl19RUaC2L/5Us6Azka0lDZo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NFOEtMHzw/a97MQkF6fUFwBmlyGVcKaEmynJz2oynT4RU24GLlJs76ycSO7Lr381L
	 lV2bueoFMQwWc4V57ZEXEE8IoSfk51hvbKMy+J+6a27lxq8SS2a2LFFNInAL0Zq0ya
	 l11lHYnZZ8gJ3KRBWceS/jhlKZ1MD2WN84I4qsws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB348F80249;
	Thu, 14 Jan 2021 19:43:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E277DF8025E; Thu, 14 Jan 2021 19:43:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E7CE8F80113
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 19:43:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7CE8F80113
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1610649815576633930-webhooks-bot@alsa-project.org>
References: <1610649815576633930-webhooks-bot@alsa-project.org>
Subject: USB-Audio/ALC1220: Bump analog Speaker priority over S/PDIF
Message-Id: <20210114184341.E277DF8025E@alsa1.perex.cz>
Date: Thu, 14 Jan 2021 19:43:41 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #73 was opened from MarijnS95:

Suggestion from https://github.com/alsa-project/alsa-ucm-conf/pull/25#issuecomment-760141633

The `S/PDIF` port does not have any jack sensing, and with a priority higher than the `Speakers` it will always be selected by default instead of the `Speakers` even if unplugged.

Swapping the priorities around allows analog `Speakers` to be selected first, _if_ they are plugged in. Otherwise `S/PDIF` is used.

The sections are reordered to adhere to this priority, including some indentation fixes.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/73
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/73.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
