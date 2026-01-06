Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78359C47BE2
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:37:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF931601F9;
	Tue,  6 Jan 2026 12:37:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF931601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767699467;
	bh=PsAR72ratg22KnDQ2gcDwUdecL9/DXl7YTR1aYNgd1k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=s7oSNQCVqYFrNiKDlc5ShD1OjEaKZUOmP/5EktCe/Jcj/9CRl20RXbradjyArSCfP
	 cYH4RjEQ5X4IBy6/miJgXQ+GTVElF5GJIEYrJ+EdejPgiwwxCoorv1iyKtoP1XOqrv
	 6lY659K5uGbczDYXKyWygrPcu0OtrYNWDaCVlSr0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DB6DF805E3; Tue,  6 Jan 2026 12:37:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D9D0F805D3;
	Tue,  6 Jan 2026 12:37:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B17BEF804F3; Tue,  6 Jan 2026 12:35:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 29C61F802DB
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2026 12:35:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29C61F802DB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1888213253b8ae00-webhooks-bot@alsa-project.org>
In-Reply-To: <1888213253323900-webhooks-bot@alsa-project.org>
References: <1888213253323900-webhooks-bot@alsa-project.org>
Subject: [bug] Commit 36a111a is interfearing with and crashing steam games
 with native Dualsense support
Date: Tue,  6 Jan 2026 12:35:58 +0100 (CET)
Message-ID-Hash: IC74PTQU7BORKFQWRV52FIXWUQ6SERWL
X-Message-ID-Hash: IC74PTQU7BORKFQWRV52FIXWUQ6SERWL
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IC74PTQU7BORKFQWRV52FIXWUQ6SERWL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #677 was opened from tamodolo:

[The commit](https://github.com/alsa-project/alsa-ucm-conf/commit/36a111ad007f2f424e6b00155970aaf07e86cee3) is interfearing with games that have native support for the Sony's Dualsense controller.

On Arch after this update games cannot send haptics properly to the controller over USB and crash after some time or at launch.

In my case, Final Fantasy XIV Online became unplayable after this update because it is crashing at launch. When it works haptics don't.

The problems does not happen when the profile is deleted from the system. Solution found by [this reddit user](https://www.reddit.com/r/ffxiv/comments/1q480jc/comment/nxqtn2v/)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/677
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
