Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78071E668AB
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2024 13:04:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B36C71EC;
	Sun, 24 Nov 2024 14:04:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B36C71EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732453467;
	bh=jwRdIxoyJMwRB9dV2GauN1tZ6AtXqrC5iKzIK3w32ig=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=S+5fa6Vszu0V4ycViynq9jh5lU3seluxBwrZXvUGuJ+ql5MiAUmvdeuuTCI12iK21
	 2kU9SnMZJkGWnx1zgShYTcyaZEmt5S6OjbkyOAdK5tm8+3WWGekqgQCMgXl8xi0dcj
	 z1kRMrB15SVduTZjMu2l5Bw2IyKIzgatix0Lvqbc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDC91F805BE; Sun, 24 Nov 2024 14:03:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65248F805C4;
	Sun, 24 Nov 2024 14:03:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF3E6F80496; Sun, 24 Nov 2024 14:03:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DFD06F800F0
	for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2024 14:03:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFD06F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732453427260947466-webhooks-bot@alsa-project.org>
References: <1732453427260947466-webhooks-bot@alsa-project.org>
Subject: UCM Configuration for Roland BridgeCastX
Message-Id: <20241124130353.DF3E6F80496@alsa1.perex.cz>
Date: Sun, 24 Nov 2024 14:03:53 +0100 (CET)
Message-ID-Hash: MPECPIJDHSOQPL72CWEMT3UCOOQ3QABX
X-Message-ID-Hash: MPECPIJDHSOQPL72CWEMT3UCOOQ3QABX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MPECPIJDHSOQPL72CWEMT3UCOOQ3QABX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #469 was edited from Konna1337:

Added Configuration for the X version of Bridge Cast. Config is based on the non X version but it's wired differently and has two more Hardware Channels. It's for the 2.0 Firmware of the Device. The "Game" channel has a virtual 5.1 mode which doesn't work properly and isn't configured.  

- Added condition to USB-Audio.conf
- Added BridgeCastXV2.conf
- Added BridgeCastXV2-Hifi.conf with configuration for channels

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/469
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/469.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
