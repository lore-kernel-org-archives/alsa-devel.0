Return-Path: <SRS0=G+w+=AX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01ACC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jul 2020 15:55:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFD12068F
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jul 2020 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RF9LYuLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFD12068F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 074E015E5;
	Sun, 12 Jul 2020 17:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 074E015E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594569316;
	bh=IjsFFLXJSesLITw99QtzW0y+oYF4uDfY6SqamD0JPsI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RF9LYuLwpGKeGChlFR+hBsjbwqiW2ok1S6FtMMj4PEBpyceJmwU383tvkd3/iqP+p
	 ew17VtVU5odYK84PwdTIeaKUR0FcuOu7Rgsjkm/2J4TtjOTCRJlroGWz/5NxB2tTTm
	 Vqr6cpxSJwUmkWPLHN8tGL95fSl4jGlIiasdvtS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8858AF8011C;
	Sun, 12 Jul 2020 17:54:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E044AF800B2; Sun, 12 Jul 2020 17:54:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1D71DF800B2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2020 17:54:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D71DF800B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594569257036328077-webhooks-bot@alsa-project.org>
References: <1594569257036328077-webhooks-bot@alsa-project.org>
Subject: alsactl do not save all the parameters
Message-Id: <20200712155420.E044AF800B2@alsa1.perex.cz>
Date: Sun, 12 Jul 2020 17:54:20 +0200 (CEST)
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

alsa-project/alsa-utils issue #46 was opened from alemirandap:

Hello everyone, my laptop need to mute the speaker for the full sound experience, when I configure alsamixer with all the levels and mute the speaker I execute "sudo alsactl store"  but after rebooted all the levels and configuration are saved except for muting the speaker. I made some tests muting the master or the headphones and the executed "sudo alsactl store" and these are saved.

I have to manually in every boot mute the speaker, I 'm under arch linux, with others distros doesn't happen, can you give me a hand with this?, thank you
[alsa-info.txt.](https://github.com/alsa-project/alsa-utils/files/4908789/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/46
Repository URL: https://github.com/alsa-project/alsa-utils
