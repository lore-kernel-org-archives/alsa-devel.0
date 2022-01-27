Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6084C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jan 2022 20:53:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 648711687;
	Thu, 27 Jan 2022 21:52:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 648711687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643316811;
	bh=6RFnYMOPAjpEZAoVWZurJ9ihKnzUEwoJPZNwrIRiJEk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehdJM09sH+Weoo9/qonVoyLTWpfB/QqC10twXcKF0TYPot25Dw67MIM9wMOQtHcoq
	 9MNMtEiKOAaKKdeF2+RHjyJh4r7JRauanvc5gUntdKSbjUxE8JOhcTCeAa+knn3ajU
	 2H5ku20dmfg9ssTGShGXAfMbfm1rztRXRS16ud2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF33BF80249;
	Thu, 27 Jan 2022 21:52:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AB06F80118; Thu, 27 Jan 2022 21:52:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EE2A7F80118
 for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2022 21:52:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE2A7F80118
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1643316754385638952-webhooks-bot@alsa-project.org>
References: <1643316754385638952-webhooks-bot@alsa-project.org>
Subject: acp6x: add initial support for AMD Yellow Carp - ACP6x
Message-Id: <20220127205237.5AB06F80118@alsa1.perex.cz>
Date: Thu, 27 Jan 2022 21:52:37 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #138 was opened from perexg:

https://github.com/alsa-project/alsa-ucm-conf/issues/136

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/138
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/138.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
