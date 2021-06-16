Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840CBC48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 14:15:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6C96109D
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 14:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6C96109D
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8385216C5;
	Wed, 16 Jun 2021 16:14:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8385216C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623852949;
	bh=LI4/ax9vC/QmBOvGf7/s9AxLcBDdBLruriGzYMAiUcQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qLUCJ4ICLjrpw2W2x1tSbdqp+YkgI69sKdd1JvMbqrrD/togoX9nXQ2SfYwjb3vfc
	 82cLjPXlKRZnYnxKFPSQPe0YSIYna8oxAws+Aw5eJU+j48s4FEDs+rHSu5iJNPU81S
	 3DqxFn6roOYJD9Pcvy+pchakflPhAOKz31mRHUZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C313F8028B;
	Wed, 16 Jun 2021 16:14:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6745F802E8; Wed, 16 Jun 2021 16:14:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 35836F80165
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 16:14:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35836F80165
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623852884465854883-webhooks-bot@alsa-project.org>
References: <1623852884465854883-webhooks-bot@alsa-project.org>
Subject: HDSPconf don't recognize RME RayDat
Message-Id: <20210616141457.E6745F802E8@alsa1.perex.cz>
Date: Wed, 16 Jun 2021 16:14:57 +0200 (CEST)
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

alsa-project/alsa-tools issue #6 was opened from profejuanca:

Hi, I'm using a RME Raydat (PCI express) many years ago, but HDSPconf don't recognize my card never, hdspmixer and the rest of jack/alsa tools see my card without problems, but hdspconf in various distros never sees my card.

The output is:
`HDSPConf 1.4 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes WITH ABSOLUTELY NO WARRANTY
HDSPConf is free software, see the file copying for details

Looking for HDSP cards :
Card 0 : RME RayDAT S/N 0x3250cb at 0xfe300000, irq 57
Card 1 : HDA ATI SB at 0xfe800000 irq 16
Card 2 : HDA NVidia at 0xfe080000 irq 60
No Hammerfall DSP card found.
`
Card 0 es my RME card...

I suposse that raydat is not in the list of the tool.

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/6
Repository URL: https://github.com/alsa-project/alsa-tools
