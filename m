Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E802C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Feb 2022 15:22:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA07516C5;
	Fri,  4 Feb 2022 16:21:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA07516C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643988132;
	bh=05mlUNwZ38CxWBWhhZqdSd3uw9rFb17GmfQ+XQq1pt8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YT6TeUidS+hFy4inEYWubUK80RkBuNJU3Vuiyf0i9KtSRMPBkA876EbZDQ2gHH7wW
	 uBZD5j1WW4puJk7q5WXkSsAdLxS00K6wgwUUKr2HEbcST1AxSKzmXavK2+VYl0xA0d
	 Q3SBmFORS1ZSK+oVfWvus5cEFIpGfAU23scmq1eY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 562E4F80159;
	Fri,  4 Feb 2022 16:21:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5070BF80310; Fri,  4 Feb 2022 16:21:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 45F65F80159
 for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2022 16:21:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45F65F80159
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1643988073617794037-webhooks-bot@alsa-project.org>
References: <1643988073617794037-webhooks-bot@alsa-project.org>
Subject: Alsa applies noise cancelling when not desired
Message-Id: <20220204152120.5070BF80310@alsa1.perex.cz>
Date: Fri,  4 Feb 2022 16:21:20 +0100 (CET)
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

alsa-project/alsa-lib issue #211 was opened from Martmists-GH:

In my [original issue](https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1306) on pulseaudio I was told it was an alsa issue.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/211
Repository URL: https://github.com/alsa-project/alsa-lib
