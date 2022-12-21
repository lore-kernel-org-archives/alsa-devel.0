Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4483C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 20:44:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F45C16E8;
	Wed, 21 Dec 2022 21:43:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F45C16E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671655447;
	bh=w+r0rlD43KKgkeeoDWt1SuFeuKtPezuHSjegKcS4ozU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vzlkehw3r1g2smzmAYUwKR9DkSX4qM5wp+JZqBIaCKF8MBnfaYxGhvOl6bTyNh3lP
	 7qj7w9IYZNGfLXhmg9m2/YPcPyS/7emdmA0Z68x9pq2dF/OrvODkNNfkeyIa71saEO
	 kY5HAMhUta7OoNpkRQ/xCTcHXg+l5FEPjLFxePr0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08F20F804AD;
	Wed, 21 Dec 2022 21:43:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65169F8047B; Wed, 21 Dec 2022 21:43:15 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E1297F80022
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 21:43:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1297F80022
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671655392348664045-webhooks-bot@alsa-project.org>
References: <1671655392348664045-webhooks-bot@alsa-project.org>
Subject: ALC4080 broken on MSI MPG X570S Carbon Max Wifi
Message-Id: <20221221204315.65169F8047B@alsa1.perex.cz>
Date: Wed, 21 Dec 2022 21:43:15 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf issue #256 was opened from lordhoto:

With the current ALC4080 UCM2 configuration, sound is completely broken on my MSI MPG X570S Carbon Max Wifi Mainboard with an ALC4080. Regardless of whether I use the "HiFi 2.0 channels", "HiFi 5.1 channels" or "HiFi 7.1 channels" configuration on the front headphone output, the audio is sometimes "stuck" and not playing at all.

This causes all sorts of issues: when you play a YouTube video it might not even start, after a while sound might play for a bit and then suddenly stop again. Even in Gnome's audio settings dialog when testing left/right the sound sometimes just does not play at all.

I'm using pulseaudio 16.1. When I insert my old ALSA UCM2 configuration, the sound works flawlessly. I suppose there is something wrong with the current configuration, but I can't figure out what. Are there any logs or similar I might look into?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/256
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
