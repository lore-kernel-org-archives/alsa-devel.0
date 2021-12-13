Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8069DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 14:59:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FA4417EC;
	Mon, 13 Dec 2021 15:58:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FA4417EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639407558;
	bh=R6tYf6sMkDQqUcVxwxmU/CQHKkEHpsJ3NGTh1w/Z60o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNg28kMZY6Ww+l3yGDdATLFP8XkWpAXbTjNmtB1/JTpymkKfJkzzNUuK7FQgefGDG
	 LQwMw/WUvK56tdme2p58qu74iAmdAxOPON7CwyC0ResC9BH4MSgSxfhg19l2bVNZVD
	 3XOEdVVzMvq846kGiBLf3J2m4DXvFymA2WwyNZLw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E254F80229;
	Mon, 13 Dec 2021 15:58:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A88EF8025D; Mon, 13 Dec 2021 15:58:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8ECB9F80161
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 15:58:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ECB9F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639407499717098951-webhooks-bot@alsa-project.org>
References: <1639407499717098951-webhooks-bot@alsa-project.org>
Subject: alsa crashing each time my screen gets locked
Message-Id: <20211213145826.3A88EF8025D@alsa1.perex.cz>
Date: Mon, 13 Dec 2021 15:58:26 +0100 (CET)
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

alsa-project/alsa-lib issue #203 was opened from Fallast:

each time i get my screen lock after being inactive for 5 minutes i log back in and alsa stops working and my volume icon disappears
i have to run volumeicon to get it working back again
i'm on mx linux, based on debian bullseye

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/203
Repository URL: https://github.com/alsa-project/alsa-lib
