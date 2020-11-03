Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC8BC388F2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:04:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2413522384
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R7SdxSLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2413522384
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A268D1829;
	Tue,  3 Nov 2020 09:03:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A268D1829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604390660;
	bh=t2g/N9obupJwYMnsow846hL+0DrS/Q3Fykpd+9s97rc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7SdxSLaqFfY6NNLwk9Z9EiLvaUry4BZc5LxPKD/Pei2iFAqqG3vOfRAeZlhlNezZ
	 xiXdydzxaoi/7lgWmyter2B8ccMXqxkbRe1QTlVHKxj8xik3vc9AThA5P0n8ShX8Pu
	 LaFIxbb4SBzjMEFbQLczSZcXE8AXQ/9KsVLmD7+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52409F805C9;
	Tue,  3 Nov 2020 09:00:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BAA4F805C6; Tue,  3 Nov 2020 09:00:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 779EAF80515
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 09:00:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 779EAF80515
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1604390411503396034-webhooks-bot@alsa-project.org>
References: <1604390411503396034-webhooks-bot@alsa-project.org>
Subject: ucm2:sof-soundwire: Add Support For Dell Privacy Mic Mute LED Control
Message-Id: <20201103080036.9BAA4F805C6@alsa1.perex.cz>
Date: Tue,  3 Nov 2020 09:00:36 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #60 was opened from GoPerry:

Dell is going to add internal microphone mute led control for Dell privacy system,
which has hardware level protection for audio privacy, when mic mute
state is changed, the ucm2 will help to switch the Mic Mute LED state.

Signed-off-by: perry_yuan <perry_yuan@dell.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/60
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/60.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
