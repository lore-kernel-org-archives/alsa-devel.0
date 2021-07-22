Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09720C76197
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 18:47:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E68560EB6
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 18:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E68560EB6
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33C5716EB;
	Thu, 22 Jul 2021 20:46:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33C5716EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626979652;
	bh=uI1JF9iByXHDuhAOh0i3FOJ4OfPBfygCJOJB/khs3zc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DyUlkW5HqsV4BUzUDygLnWAAoR7ShGEgiWYQA0RjGQxM1ZrtGCsK26XRwaYH3cPhG
	 2PTlfGYZvz0VeTH53JTNva7a0xcVNxTOLPylCKVn2BaZeHPQgL6oNzgS8k77afR+u7
	 6Kg2Aof4/QMdXsLBQYxIGe0LP/ACVVybuL0bVkCk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4931F80218;
	Thu, 22 Jul 2021 20:46:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD730F80227; Thu, 22 Jul 2021 20:46:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C087CF800F2
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 20:46:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C087CF800F2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1626979594101609945-webhooks-bot@alsa-project.org>
References: <1626979594101609945-webhooks-bot@alsa-project.org>
Subject: ASRock (A320M-HDV R4.0) No analog audio driver detected -
Message-Id: <20210722184639.AD730F80227@alsa1.perex.cz>
Date: Thu, 22 Jul 2021 20:46:39 +0200 (CEST)
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

alsa-project/alsa-lib issue #165 was opened from PedePanoOriginal:

Hello guys!
I just got a new PC and I was so happy about it. It's a Ryzen 5 - 3600, GeForce GT 1030 GPU, the motherboard is a ASRock A320M-HDV R4.0. The first thing I did when I pluged it in was installing Pop!_OS 20.04 LTS. Everything worked fine except my audio analog ports. They are simply not detected by OS, the only output audio device detected is "GP108 High Definition Audio Controller Digital Stereo".
I've done a lot of googling, tried everything I could find, but, no success. I noticed that when I turn on the PC a message is displayed, something like that: "snd_hda_intel 0000:23:00.4: no codecs found". This message disappear if I turn off onboard audio stuff at the bios.
I would love some help if possible. I'm a linux noob, so I'm sorry to not be able to provide better information now but, I can do it later with some help.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/165
Repository URL: https://github.com/alsa-project/alsa-lib
