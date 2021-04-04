Return-Path: <SRS0=LXLF=JB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B5CC433B4
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 10:02:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAE061246
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 10:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAE061246
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F5A0850;
	Sun,  4 Apr 2021 12:01:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F5A0850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617530560;
	bh=RK6SZqG5u+HXbCKzWNtL/h0+l000JpoF9HXa97f3+z8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZylUmBLnM873u4z3Z2fWmigdNa+3DFH56/brv5p5iM4ulI0uMyN8l+PyOLYCjn3Xc
	 L/gCFDxFSlCDrsnqtaGPJpJLs+m2ltgBBsXguxHUIqupQiE8TN+rjAxGEUpypvqcQX
	 tK0YoC4xu5mJpEUYHCBSoevLddZKCI4bt9OwacJI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27F11F80168;
	Sun,  4 Apr 2021 12:01:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9572FF8020B; Sun,  4 Apr 2021 12:01:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4C6E8F800F3
 for <alsa-devel@alsa-project.org>; Sun,  4 Apr 2021 12:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C6E8F800F3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1617530500461167097-webhooks-bot@alsa-project.org>
References: <1617530500461167097-webhooks-bot@alsa-project.org>
Subject: ALC1220 and presence of ucm2/ucm.conf breaks audio
Message-Id: <20210404100148.9572FF8020B@alsa1.perex.cz>
Date: Sun,  4 Apr 2021 12:01:48 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #86 was opened from devnull0000:

I'd want to make a better report but I am not an ALSA expert, so the issue is that after update I lose any sound and I use ALC1220 codec on MSI MEG X570 GODLIKE motherboard.

Deep googling gave me the report: https://bugs.archlinux.org/task/67058 
So indeed deletion of the file helped immediately. 
The bug is super confusing because it looks like the device is present at alsa level but absent on Pulse Audio and it is not shown in GUI at all.

I am at alsa-ucm-conf-1.2.4, linux-5.11.11, pulseaudio 13.0, gentoo.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/86
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
