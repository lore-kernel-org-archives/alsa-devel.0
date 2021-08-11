Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6326BC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 12:19:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788E060FC0
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 12:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 788E060FC0
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B6411739;
	Wed, 11 Aug 2021 14:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B6411739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628684366;
	bh=adM6uy6hm9WkSpJ1scTOFY3dE4w1MbgbvXPw4LeHQXc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axeVrUyHbtQt80azuqtCbWTe80v610k+sRjufMoY7eCPfqt0OVW1hdzDkiFe9hS8a
	 sbnKYoyNh1o8TGVLR+cFNNATermHb2U4EuhG0hEDr22e04f0tuR+4FFeZxbOLlhoFg
	 tFZOzx/ZuQOg0ejE+2o7RI/0a1I8BYDfdk59d66c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D06A9F8020D;
	Wed, 11 Aug 2021 14:18:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75B93F802D2; Wed, 11 Aug 2021 14:18:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E79AFF80148
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 14:18:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E79AFF80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1628684304109122992-webhooks-bot@alsa-project.org>
References: <1628684304109122992-webhooks-bot@alsa-project.org>
Subject: Unable to clone repo from windows or yocto
Message-Id: <20210811121834.75B93F802D2@alsa1.perex.cz>
Date: Wed, 11 Aug 2021 14:18:34 +0200 (CEST)
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

alsa-project/tinycompress issue #11 was opened from boppana113:

Attempted to clone the github repo using the following command: 

- git clone git://git.alsa-project.org/tinycompress.git

I got the following error: 
```
$ git clone git://git.alsa-project.org/tinycompress.git
Cloning into 'tinycompress'...
fatal: unable to connect to git.alsa-project.org:
git.alsa-project.org[0: 207.180.221.201]: errno=Unknown error
```

Issue URL     : https://github.com/alsa-project/tinycompress/issues/11
Repository URL: https://github.com/alsa-project/tinycompress
