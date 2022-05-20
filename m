Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3681BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 17:16:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 501241743;
	Fri, 20 May 2022 19:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 501241743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653067015;
	bh=Iwah93i5d51ANWS7oTw5dzrlreHIjwnqhBLApjM1n/k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a66rZohF5LjoHvnyFrZWThZAoxEvSxBQ2ZiMeENMGtZgH5NYotp01QkHXQ40KsIjY
	 dwmrJDybXV8BiefmQFSwRyR2c+p49uscXgwQirY7DnVN5xZ9QDroUUZjpmwkvllD6a
	 anPmauT4A3Fcs+po5qejvHTvITETEqe3BduopTME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DC3AF8019D;
	Fri, 20 May 2022 19:15:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82342F8019D; Fri, 20 May 2022 19:15:32 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 22403F80109
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 19:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22403F80109
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653066929912477016-webhooks-bot@alsa-project.org>
References: <1653066929912477016-webhooks-bot@alsa-project.org>
Subject: Complete support for "Pro" USB multichannel cards
Message-Id: <20220520171532.82342F8019D@alsa1.perex.cz>
Date: Fri, 20 May 2022 19:15:32 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #154 was edited from perexg:

- [x] channel split using alsa-lib
- [x] channel split inside app
- [x] channel split hide the specific configs (alsa-lib, app side support)
- [x] mixer control remap using alsa-lib
- [x] simplify the mixer control remap

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/154
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
