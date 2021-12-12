Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF543C433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Dec 2021 22:24:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ECB818D5;
	Sun, 12 Dec 2021 23:23:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ECB818D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639347841;
	bh=WolQv3/F6HKRifFDywYDrI/6T+QHrxkO/R5qG0aD6Mc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNSGzFVBZBvi/6o8AKUed+bYToidZ7bsju3ITaspLITUBUvt+2wJ21WxM1iM0Yy6R
	 GyapOvNUlr+URput3Lh0AiLz0j46lMk7OFxHqK9+WdHgnJNtF5Ei8rSBDii5Ykpq3J
	 n0sQp2NUvQMB6enkZauf7hL7jL/xtx1M/n/8nP1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A087EF80059;
	Sun, 12 Dec 2021 23:23:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE3BDF80246; Sun, 12 Dec 2021 23:23:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6E2FCF800BC
 for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2021 23:23:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E2FCF800BC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639347783652843952-webhooks-bot@alsa-project.org>
References: <1639347783652843952-webhooks-bot@alsa-project.org>
Subject: No audio from Starship/Matisse HD Audio Controller
Message-Id: <20211212222308.EE3BDF80246@alsa1.perex.cz>
Date: Sun, 12 Dec 2021 23:23:08 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #129 was edited from SirFooOfBar:

I have an AMD ryzen 3900X paired with a Gigabyte AX370-Gaming 5 motherboard. I use arch linux. Upon upgrading the package alsa-ucm-conf from version 1.2.6.1-1 to 1.2.6.2-2 and rebooting, my onboard audio stops working completely. Downgrading restores functionality after another reboot. In pavucontrol, for 1.2.6.1-1 there are many available profiles, but for 1.2.6.2-2 there is only one, which says unavailable. I also use pipewire rather than pulseaudio if that makes a difference

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/129
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
