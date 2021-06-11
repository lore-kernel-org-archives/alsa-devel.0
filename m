Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C9C48BE0
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 18:21:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2DD613AE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 18:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2DD613AE
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C55171A9E;
	Fri, 11 Jun 2021 20:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C55171A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623435685;
	bh=oaaPp4Lp8JS2BY7Jfd1o5Hs44/bMEK1mJ8eygJ+ZlV0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHPRJtydhh7lhCUst4udMO0QVxhObWVwKFQZJDBijhxkBejQbBdjAXWaa+rXhiu/d
	 nPmPpT1U9Ycifq29e2Y2Kqd3s1G8cbyNsf3kw78QR+3kp12zNiCDDyeGmHJsNbmyfK
	 dlsldk4x/9Vw9rkv8y0p2A5FvDAY5FsEG3pWrvak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51223F80212;
	Fri, 11 Jun 2021 20:20:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD6A6F80149; Fri, 11 Jun 2021 20:20:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 73D0BF80149
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 20:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73D0BF80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623435630525024891-webhooks-bot@alsa-project.org>
References: <1623435630525024891-webhooks-bot@alsa-project.org>
Subject: Question about upmix plugin
Message-Id: <20210611182033.CD6A6F80149@alsa1.perex.cz>
Date: Fri, 11 Jun 2021 20:20:33 +0200 (CEST)
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

alsa-project/alsa-plugins issue #25 was opened from krumpfwylg:

Hi, I've noticed the [latest commits](https://github.com/alsa-project/alsa-plugins/pull/2) done to the upmix plugin, but there's something I don't understand.
Line 24 of pcm_upmix.c is _#define UPMIX_PCM_FORMAT	SND_PCM_FORMAT_S16_ 
Does that mean the upmix plugin is still only capable of using S16_LE format ?
Or does the UPMIX_PCM_FORMAT value can get changed to S32_LE by tweaking it in asoundrc file ?

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/25
Repository URL: https://github.com/alsa-project/alsa-plugins
