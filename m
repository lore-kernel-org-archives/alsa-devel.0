Return-Path: <SRS0=xNGQ=3B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1554C32771
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jan 2020 07:06:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A68E20842
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jan 2020 07:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GhVJhRyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A68E20842
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1659168C;
	Sun, 12 Jan 2020 08:05:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1659168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578812795;
	bh=YJ8zZSflyH/GU31TSLqj9f4RX6gJG2DKedyUzEX/5eg=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GhVJhRyys2e3j50F6a3qVQf7+Hklxh6C3KDHAcWZoHALOaV+pj/c3cXYV+3mk7tTG
	 xPPxo46CD5xGPS9xzN3R/Rjp0Eg8JpiOYDUBy8sMMBhdxOawTKMGlkO/kswm0mfP6f
	 APfXDY/gWF692L8neDPL8Cq6R9Pf+QDdZEv3Mq+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4281DF8014D;
	Sun, 12 Jan 2020 08:05:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49FE7F8014E; Sun, 12 Jan 2020 08:05:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C9F96F8012E
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2020 08:05:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9F96F8012E
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1578812739066721916-webhooks-bot@alsa-project.org>
References: <1578812739066721916-webhooks-bot@alsa-project.org>
Message-Id: <20200112070543.49FE7F8014E@alsa1.perex.cz>
Date: Sun, 12 Jan 2020 08:05:43 +0100 (CET)
Subject: [alsa-devel] alsa-gobject: ctl: fix wrong operation for values in
 enumerated type of element
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-gobject pull request #4 was opened from takaswie:

The 'snd_ctl_elem_value' structure includes union member for values.
Although it includes 'enumerated' member for values in enumerated type
of element, current implementation of alsactl library uses 'integer'
member to pick up the values. As a result, in any 64 bit System V ABI,
the library fails to get/set values for the enumerated type of
element. This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/4
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/4.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
