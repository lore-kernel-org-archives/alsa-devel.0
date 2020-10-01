Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAADFC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:40:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1196621481
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WHvNjvkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1196621481
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E445F187A;
	Thu,  1 Oct 2020 08:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E445F187A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601534436;
	bh=7ClyvoKvp/AUgm0tLbxKJZRpFnkiHGe4BqLW33CrZ1g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHvNjvkWVpX3smZwPUrOHp6wNg1cxG4o42SF03RF9rn/i+Qd0/26FTyjG2PumQQvK
	 nKV/312PdHYJNC6Jc8uBAk62vviWkV//Hf3+2m7xo6qf/Ksc8RwwxZKNOu08x+zxNm
	 RXPQ9OmSMZcFEWjlZBgM6LeWaObWdFsFt3l91WZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53577F801DB;
	Thu,  1 Oct 2020 08:39:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75239F801F5; Thu,  1 Oct 2020 08:39:43 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EE527F800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 08:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE527F800AB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1601534369443474054-webhooks-bot@alsa-project.org>
References: <1601534369443474054-webhooks-bot@alsa-project.org>
Subject: unable to initialize sum ring buffer error
Message-Id: <20201001063943.75239F801F5@alsa1.perex.cz>
Date: Thu,  1 Oct 2020 08:39:43 +0200 (CEST)
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

alsa-project/alsa-lib issue #83 was opened from Komal1809:

i am using alsa-lib-1.1.4.1 library version. Whenever trying to play audio from file using aplay  getting error as alsa-lib-1.1.4.1/src/pcm/pcm_dmix.c:1177: **(snd_pcm_dmix_open) unable to initialize sum ring buffer** 

Note : audio is getting played at the start once system reboot

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/83
Repository URL: https://github.com/alsa-project/alsa-lib
