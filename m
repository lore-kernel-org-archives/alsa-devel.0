Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDA6C3DA60
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:22:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EEEEE9A;
	Thu, 18 Jul 2024 10:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EEEEE9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721290929;
	bh=n67JUQGvD7XVv/DgJW0b9FEQDkSnKdNG9o5e1WzxSw8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SL9y1hJrF4bSkrsXrjDcsDGvM/VJ03vfoQXdQpti6q0cZGJl80c1HC1/OUNNcraBE
	 RJlUGjfFGUphDzCShVoFIAiFyyAfXdasYQRqw/Wj12+YHtoGOerPmdOvrSIrna6R+2
	 lOoZkAsCe8HndRXstr/2HbI0d/9CNuaQXOQJKauA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE3B2F805AD; Thu, 18 Jul 2024 10:21:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EB35F805B4;
	Thu, 18 Jul 2024 10:21:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26DDBF8026D; Thu, 18 Jul 2024 10:19:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E2C3CF8007E
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2024 10:18:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2C3CF8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1721290735478631973-webhooks-bot@alsa-project.org>
References: <1721290735478631973-webhooks-bot@alsa-project.org>
Subject: ThinkPad P14s Gen 5 AMD micmute LED is not working sometimes.
Message-Id: <20240718081918.26DDBF8026D@alsa1.perex.cz>
Date: Thu, 18 Jul 2024 10:19:18 +0200 (CEST)
Message-ID-Hash: UZUQ4RHJBSLRJMIEU3RCUCFWJWAQRTBI
X-Message-ID-Hash: UZUQ4RHJBSLRJMIEU3RCUCFWJWAQRTBI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UZUQ4RHJBSLRJMIEU3RCUCFWJWAQRTBI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #433 was opened from pma1:

The mic and sound output works fine.
The mute LED works fine.
But when press Fn+F4, the mic-mute led is not working sometimes after bootup.
The failrate is like 1/10.

Tested with latest alsa-ucm from git, it's reproduced.
/sys/class/sound/ctl-led/mic/card1# cat list
7
# amixer -c 1 controls
numid=12,iface=CARD,name='Headphone Jack'
numid=11,iface=CARD,name='Mic Jack'
numid=13,iface=CARD,name='Speaker Phantom Jack'
numid=10,iface=MIXER,name='Master Playback Switch'
numid=9,iface=MIXER,name='Master Playback Volume'
numid=2,iface=MIXER,name='Headphone Playback Switch'
numid=1,iface=MIXER,name='Headphone Playback Volume'
numid=16,iface=MIXER,name='PCM Playback Volume'
numid=17,iface=MIXER,name='Mic ACP LED Capture Switch'
numid=8,iface=MIXER,name='Mic Boost Volume'
numid=7,iface=MIXER,name='Capture Switch'
numid=6,iface=MIXER,name='Capture Volume'
numid=5,iface=MIXER,name='Auto-Mute Mode'
numid=4,iface=MIXER,name='Speaker Playback Switch'
numid=3,iface=MIXER,name='Speaker Playback Volume'
numid=15,iface=PCM,name='Capture Channel Map'
numid=14,iface=PCM,name='Playback Channel Map'

# echo 'Capture Switch' > detach
# echo 'Mic ACP LED Capture Switch' > attach
/sys/class/sound/ctl-led/mic/card1# cat list
17

Then the micmute LED will work.
[alsa-info-amd-micmutled.txt](https://github.com/user-attachments/files/16279936/alsa-info-amd-micmutled.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/433
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
