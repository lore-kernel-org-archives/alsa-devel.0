Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77469ECAAD8
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Sep 2022 21:24:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A224AE9;
	Sun, 18 Sep 2022 23:23:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A224AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663536283;
	bh=sboZKMwHMLLdmuMgyBkgmY146S7JhKHMeSt8HA6VB6g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p67c08lBTTFgzp+exl3fBaIAWvdEh2AjE24fBitgg1u6sDVO5rY5hBPGd64MBBdJ9
	 4sFIKDVxtTYHjRZPMYt8AUfz2YQJbVx9+GwekaMRsROVxDJ81hhxrDKsQ9v2JDvyB6
	 KIPfC+Xrg20oEfgKh3OrRsyqaR1Ajmz45hTJPPq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13C6BF80310;
	Sun, 18 Sep 2022 23:23:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7266FF804B3; Sun, 18 Sep 2022 23:23:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8D5CAF800E5
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2022 23:23:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D5CAF800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1663536226952555895-webhooks-bot@alsa-project.org>
References: <1663536226952555895-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Motu M4: no duplex profile
Message-Id: <20220918212350.7266FF804B3@alsa1.perex.cz>
Date: Sun, 18 Sep 2022 23:23:50 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #214 was opened from pisquaredover6:

I have compiled alsa-ucm-conf v1.2.7.2 with the patches [3a6acaa5090a0c5a0d29c8a4906b6a60378774e2](https://github.com/alsa-project/alsa-ucm-conf/commit/3a6acaa5090a0c5a0d29c8a4906b6a60378774e2) and [ad1618cdd33f5c78ee1a0a9d3db362ffcb9f2596](https://github.com/alsa-project/alsa-ucm-conf/commit/ad1618cdd33f5c78ee1a0a9d3db362ffcb9f2596). With this, I have simplex audio, but no duplex profiles any more.

Is there any chance we can add a duplex profile, as it used to be the case before alsa-ucm-conf introduced the M4?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/214
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
