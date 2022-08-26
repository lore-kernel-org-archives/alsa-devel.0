Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3144ECAAD5
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 22:57:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F917161E;
	Sat, 27 Aug 2022 00:56:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F917161E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661554661;
	bh=ENZYTD7Czthu+WPsBupdCQXLyXodAcu8lXuPSArddzQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUGoplQSEMci2AfjjGo6KJb5IccVu2wl/y+Y5zjolhlhfd7KK9Ka8HoP5cAR3Zq2q
	 +zIC7LocLJnw/0wmompd5GxEro44hbw61fxegzJkVJTzrGdpw5+njpcZxpkycHefI2
	 arBJa7ZQUfpf0qOmDgEXvzvZ5E65J/V4x0yEM+X8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1E82F8014B;
	Sat, 27 Aug 2022 00:56:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AA42F80238; Sat, 27 Aug 2022 00:56:49 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B5563F80105
 for <alsa-devel@alsa-project.org>; Sat, 27 Aug 2022 00:56:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5563F80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661554606155276060-webhooks-bot@alsa-project.org>
References: <1661554606155276060-webhooks-bot@alsa-project.org>
Subject: Update USB-Audio.conf
Message-Id: <20220826225649.3AA42F80238@alsa1.perex.cz>
Date: Sat, 27 Aug 2022 00:56:49 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #206 was opened from RomanAverin:

Fix for ALC4080 (ASUS ROG Strix B660-F Gaming WiFi)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/206
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/206.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
