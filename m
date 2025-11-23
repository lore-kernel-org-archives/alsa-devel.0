Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BC2CFC518
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Nov 2025 08:45:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 396206020F;
	Sun, 23 Nov 2025 09:44:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 396206020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763887501;
	bh=IQmC4p4TQEzWjBBMFz6HWbl8Iae8WbBiP3I+QD+TKD8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NhWGIbL46uysnSIBpt49v7my+T7y1ceh9jvOla163WYy82OQ9QcNSAG/dcxHXJLaK
	 IQxrfDCEu5bSUGHdsn6cZwzxp7e98Law7xsFUP9HCaYjpHxMtjvTCnAodhCWY9RNC0
	 FVPj3qU3S9pe2fTjhPvyU2aNgdTcqLegdHC4VrhA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9BD9F805C1; Sun, 23 Nov 2025 09:44:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1951FF805C1;
	Sun, 23 Nov 2025 09:44:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7CDAF8051D; Sun, 23 Nov 2025 09:43:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A7EC0F8016E
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2025 09:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7EC0F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187a96465f610200-webhooks-bot@alsa-project.org>
In-Reply-To: <187a96465ea09d00-webhooks-bot@alsa-project.org>
References: <187a96465ea09d00-webhooks-bot@alsa-project.org>
Subject: Add MSI MPG B850I Edge TI Wifi motherboard support for ALC4080
Date: Sun, 23 Nov 2025 09:43:58 +0100 (CET)
Message-ID-Hash: RAZYDJYPAPL3FXLQLDM4ZAVFGQN6AM7R
X-Message-ID-Hash: RAZYDJYPAPL3FXLQLDM4ZAVFGQN6AM7R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RAZYDJYPAPL3FXLQLDM4ZAVFGQN6AM7R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #647 was opened from YourNumNums:

The MSI MPG B850I Edge TI Wifi motherboard only plays sound out of the rear i/o panel auxiliary port. I do not see any way to activate the rear optical output or the front auxiliary port.

Here is my [alsa-info](https://alsa-project.org/db/?f=67f95e30cfe710cefa38544c4b5dd6c1b31cb1ad), and the device ID is below:

```
$ lsusb | grep Audio
Bus 001 Device 004: ID 0db0:d4fa Micro Star International USB Audio
```

This looks like a similar issue to [issue 172](https://github.com/alsa-project/alsa-ucm-conf/issues/172), except this time `d4fa` needs to be added to the 0db0 regex for ucm2/USB-Audio/USB-Audio.conf for ALC4080 support.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/647
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
