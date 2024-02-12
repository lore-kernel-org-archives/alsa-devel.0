Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BECC4829A
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Feb 2024 02:19:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D90EDE5;
	Mon, 12 Feb 2024 03:19:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D90EDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707704362;
	bh=Qf9hpbbXmCdPqCVyNK/W8p9ruZSqKZxRr83BUD1S2T4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GbzzZ70oMWx43XqnbZrMDaBIOPpeSwf+UcsS5T0gbpKdUOqtNWVnbU9kApWI1oKYC
	 cg5aYoWzRBvrVZ2XxEH+7UsNnKxuLvW79KAtEIFuv5b5OhUmYlCFcMFhNBq7hQS6u7
	 PU1zm7E3KNtVzLY0sCyxh5FcET0GEtbZgNUQwArI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDF4CF8056F; Mon, 12 Feb 2024 03:18:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93EBFF805A8;
	Mon, 12 Feb 2024 03:18:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEEA9F80238; Mon, 12 Feb 2024 03:18:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D8FCF800BF
	for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2024 03:18:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D8FCF800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1707704317305438280-webhooks-bot@alsa-project.org>
References: <1707704317305438280-webhooks-bot@alsa-project.org>
Subject: Asus ROG Strix Z790-A Gaming WIFI II audio codec detected as generic
 USB audio, headphones and SPDIF not working
Message-Id: <20240212021844.BEEA9F80238@alsa1.perex.cz>
Date: Mon, 12 Feb 2024 03:18:44 +0100 (CET)
Message-ID-Hash: AF4A6YIS56WSVVXKV3NTJLGQCKTM4QNX
X-Message-ID-Hash: AF4A6YIS56WSVVXKV3NTJLGQCKTM4QNX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AF4A6YIS56WSVVXKV3NTJLGQCKTM4QNX/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #394 was opened from danielton1:

Hi, I have an Asus ROG STRIX Z790-A GAMING WIFI II motherboard with a Realtek ALC4080 audio codec. Sound is working through the speakers via the line out jack, and it does detect when I plug headphones in, but everything I'm finding is that the ALSA UCM is failing to detect the device as a Realtek ALC4080 and instead is just using a generic USB profile, probably due to the USB ID being unknown. Audio always comes out the line out jack no matter what is plugged in to the front panel or SPDIF or how pipewire/ALSA are configured.

This is what lsusb gives as the ID:
Bus 001 Device 002: ID 0b05:1af1 ASUSTek Computer, Inc. USB Audio

This is the output of alsa-info.sh: http://alsa-project.org/db/?f=3dc5eb049583da76a18466a6cf16d144dae95f53

I've tried modifying the files in /usr/share/alsa/ucm2/USB-Audio several different ways per several forum threads I came across online and ended up with no sound at all, so I'm not sure what's going on or how to fix this. Any help would be greatly appreciated!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/394
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
