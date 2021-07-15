Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8FC07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 05:35:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6016161358
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 05:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6016161358
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F05891684;
	Thu, 15 Jul 2021 07:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F05891684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626327336;
	bh=anggAd6nROv+xxCDR3DZ4oxGYu+5MiOImAeEb9kRMx8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRluZqIsMIA8elG5bT8VzvyR7BL15DASi9TifoL1bBcHc2hyRYUhh8jW4skbLVh92
	 tFVjWybSgLAzVvLvJZsGKj+kEkCGW1bq/8dsqhqBL72w70QKjd++gu0u8iXHZHBf9p
	 /KuxPoUeQOfVlr4p/s1RpO/ASQB41bkN+dn8tR+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAD39F80240;
	Thu, 15 Jul 2021 07:34:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A5ECF80430; Thu, 15 Jul 2021 07:34:21 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C1A40F80229
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 07:34:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1A40F80229
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1626327254536343098-webhooks-bot@alsa-project.org>
References: <1626327254536343098-webhooks-bot@alsa-project.org>
Subject: How can turn on auto-mute mode in alsa ?
Message-Id: <20210715053421.0A5ECF80430@alsa1.perex.cz>
Date: Thu, 15 Jul 2021 07:34:21 +0200 (CEST)
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

alsa-project/alsa-lib issue #164 was edited from yufeiluo:

My alsa-utils version:


    aplay --version
    aplay: version 1.1.8 by Jaroslav Kysela <perex@perex.cz>



No auto-mute option in alsamixer gui menu.
[https://www.dropbox.com/s/ie6meqto1t1rv9g/alsamixer.png?dl=0](url)


    debian@debian:~$ amixer -c 0 sset 'Auto-Mute Mode' Enabled
    amixer: Unable to find simple control 'Auto-Mute Mode',0

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/164
Repository URL: https://github.com/alsa-project/alsa-lib
