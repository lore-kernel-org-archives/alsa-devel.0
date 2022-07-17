Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE9BC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jul 2022 19:54:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CF1F16A0;
	Sun, 17 Jul 2022 21:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CF1F16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658087657;
	bh=zclOwZkCu15xZnf6wGeyX2U9c4OcAaTOyQjZcVEofVk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rXnQoxKx85uPzqsL5+pH6qbN3H5l2g+9bz8vQiO6eCcEk2N7Dh9QkyHKyXJxHid/q
	 Jb9W3FWTY8xWDJ+BkueyPd1AidApNM6PsHD+elKT8bmMOrKNxg5lA1mzxujCOtnJoa
	 ZztZelBwPI1GIrx+0QhFuw7b0EWjr4P2Ogruva7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BD41F8015B;
	Sun, 17 Jul 2022 21:53:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1097F8015B; Sun, 17 Jul 2022 21:53:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 41693F800FB
 for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2022 21:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41693F800FB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1658087602564901114-webhooks-bot@alsa-project.org>
References: <1658087602564901114-webhooks-bot@alsa-project.org>
Subject: Audio interface unable to be loaded in 1.2.7.2
Message-Id: <20220717195325.C1097F8015B@alsa1.perex.cz>
Date: Sun, 17 Jul 2022 21:53:25 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #190 was opened from KevHg:

I upgraded from 1.2.6.1 to 1.2.7.2 and found that pulseaudio no longer detects my Motu M2 interface.

Main error log seems to be:
`module-alsa-card.c: Failed to find a working profile.`
`failed to load module module-alsa-card`

I'm new to debugging Linux issues, let me know what other info I can provide to help out on this topic.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/190
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
