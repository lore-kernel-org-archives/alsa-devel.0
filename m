Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF6AC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:05:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48445206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sdqRg86+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48445206FA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3B551865;
	Thu, 25 Jun 2020 23:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3B551865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593119098;
	bh=h4vbCgQp3itjRiukNAj5oJIDo3JmVPpxWu3X9euzp5M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdqRg86+bN8HbjLpKCf8buj1RjxnZMXkzWCmuguzTOYicgM9MaVARMD2d6wMzMHXe
	 xSVvrPRXIjR6u6trJtYWHb/yG+yhj0USvwjlcT2trpA4RSEF6+IzZLRnpMyNSnH9s9
	 6NXG4i+9sHjkDJfxZViWCLZf324bB7oLhclCZTM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4714CF80218;
	Thu, 25 Jun 2020 23:04:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7F37F80234; Thu, 25 Jun 2020 23:04:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 431F5F800B2
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 23:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 431F5F800B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1593119038485641003-webhooks-bot@alsa-project.org>
References: <1593119038485641003-webhooks-bot@alsa-project.org>
Subject: Cannot use HyperX Cloud Flight S Microphone
Message-Id: <20200625210406.A7F37F80234@alsa1.perex.cz>
Date: Thu, 25 Jun 2020 23:04:05 +0200 (CEST)
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

alsa-project/alsa-lib issue #65 was opened from DirtyCajunRice:

I have a New USB headset that was added/fixed in kernel patch 5.7rc3 (https://lkml.org/lkml/2020/4/4/197). It now loads all the output options but no input options. Is there something i can do to force it?
also have this if it helps: http://alsa-project.org/db/?f=7cf962fe3df280a9a81f5cd1e82633d8cba7b02e

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/65
Repository URL: https://github.com/alsa-project/alsa-lib
