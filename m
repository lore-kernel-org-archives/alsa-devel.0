Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FAC47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 09:05:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5A22075E
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rd22s/lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A22075E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFD4315E0;
	Mon, 11 May 2020 11:04:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFD4315E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589187915;
	bh=WntTpW8hqRRazarcoLbA24mPF7vuZn0MzsWydZqr9CE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rd22s/lKFiU5UYMgs4f6Rn/e8FimwNZasuCbBxKJWIQHBRlzWcPGgAcG0H44ChONh
	 V+S1Qe36ae3ffE45QaQ4zjOyS3ubBXWYZiOUrAR5URUxcTyvfNGHIfK98TrFo6kq1O
	 qfbQlDAvsK2eOmeHk9T115mSfE/iltEE+CzhaLo0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 668DEF800E3;
	Mon, 11 May 2020 11:04:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3ACFF80157; Mon, 11 May 2020 11:04:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9F5C0F800E3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 11:04:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F5C0F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1589187859103775024-webhooks-bot@alsa-project.org>
References: <1589187859103775024-webhooks-bot@alsa-project.org>
Subject: Fix pour Asus Xonar U5 card SPIF in USB-Audio.conf
Message-Id: <20200511090423.B3ACFF80157@alsa1.perex.cz>
Date: Mon, 11 May 2020 11:04:23 +0200 (CEST)
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

alsa-project/alsa-lib issue #48 was edited from burningd0g:

It would be greatly apreciated to add the iec958 correct device in the default USB-Audio.conf for the Xonar USB sound card :

USB-Audio.pcm.iec958_device {
        ...
        "ASUS XONAR U5" 1
        "XONAR U5" 1
       ...
}

It would prevent me (and maybe some other people) to freak out on why it doesn't work out of the box! :)
I know the issue is also present on the U7 but i don't have all the possible device name for it.

Thanks!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/48
Repository URL: https://github.com/alsa-project/alsa-lib
