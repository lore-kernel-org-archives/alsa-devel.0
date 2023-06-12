Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0960C7EE2E
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jun 2023 20:09:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36196823;
	Mon, 12 Jun 2023 22:08:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36196823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686600568;
	bh=e3SpnNGKp4t7GsZV/TK9x9s/uJzP/f1uyz3TgTAeWC0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Y9/qJTrZu7yaeyVoapo/jwTcP5qFiiCs51+2RB2QxjFwdayeWmNgJLDQhQxNGfpz3
	 ln/VuNDoJrlNWIYizlKXY6UbGWiiAyULRb74lQYEIoKDAPI6hCsZAzgdJewSFF4xZZ
	 wKhuIve1Isz1HPem0jPspOdTHAusHJxdPKDVNIjM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DB4DF8052E; Mon, 12 Jun 2023 22:08:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4F88F80149;
	Mon, 12 Jun 2023 22:08:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2538DF80149; Mon, 12 Jun 2023 22:08:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E034F800BA
	for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2023 22:08:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E034F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1686600484466417074-webhooks-bot@alsa-project.org>
References: <1686600484466417074-webhooks-bot@alsa-project.org>
Subject: Alsa without support to usb headphone
Message-Id: <20230612200809.2538DF80149@alsa1.perex.cz>
Date: Mon, 12 Jun 2023 22:08:09 +0200 (CEST)
Message-ID-Hash: RQNCHUZ6WY6M3K2EHKKQJIGWMKY7ORH2
X-Message-ID-Hash: RQNCHUZ6WY6M3K2EHKKQJIGWMKY7ORH2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RQNCHUZ6WY6M3K2EHKKQJIGWMKY7ORH2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #326 was opened from wellinton-capixaba:

Hello. O recently built a media player (mplayer) with alsa support. However, telling mplayer to play multimedia files with alsa, specifying the usb headphone as the output device, didn't work.

However, latter I built another mplayer, this time using the system provided Also. Then I redid the test, and it worked as I originally expected.

The only difference I am aware between both also as is their version. The one I built it is the 1.0.17, while the system uses a 1.0.21.

Can be this the cause of the problem. Or is something else?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/326
Repository URL: https://github.com/alsa-project/alsa-lib
