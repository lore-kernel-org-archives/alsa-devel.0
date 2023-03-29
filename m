Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87EEC6FD18
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 09:42:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B35B1F4;
	Wed, 29 Mar 2023 11:42:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B35B1F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680082970;
	bh=V+x/QCwGMqjFU08SMHiysjVO3872JdbGwKCZQ85x7nA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DFtSgDbhg1/HbjtcE3vD+mmtpb9OLYDqxpqoeQoazxqRxuHMqkq6IeNogOMlaYico
	 zbRu7uvIH71s1YZft1UaZZEXhekq3WSFr3FMHn1XbxfNidmBzjI07J02BmTl8sIpCl
	 Gb5yEmJ7RUUMMkwUNtOFck6xjR71ZhcsK3aQsIGM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D55AFF80272;
	Wed, 29 Mar 2023 11:41:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A485F80272; Wed, 29 Mar 2023 11:41:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F3A5F80249
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2023 11:41:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F3A5F80249
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680082883887437105-webhooks-bot@alsa-project.org>
References: <1680082883887437105-webhooks-bot@alsa-project.org>
Subject: ALC1220 DualCodec - changing to headphone (front panel) port doesn't
 work without toggling pro audio profile
Message-Id: <20230329094130.6A485F80272@alsa1.perex.cz>
Date: Wed, 29 Mar 2023 11:41:30 +0200 (CEST)
Message-ID-Hash: ZDRUNYH26GE6WHGGNBIL2VJJ2P336AQ4
X-Message-ID-Hash: ZDRUNYH26GE6WHGGNBIL2VJJ2P336AQ4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZDRUNYH26GE6WHGGNBIL2VJJ2P336AQ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #299 was opened from metronidazole:

I have a Gigabyte x570 aorus pro motherboard with the ALC1220 audio device using the dualcodec model. I have two issues:

A. jack sense doesnt work. I'm not sure if this is a UCM thing, but in my desktop environment (KDE Plasma 5.27) the headphones port shows as "unplugged" in system settings, and hdajacksensetest shows it as not detected "Pin 0x1b (Green Headphone, Front side): present = No". this is a minor issue

B. more importantly, when i want to use my frontpanel headphones input, i have to do the following work around otherwise no sound comes out:

1. Start with Profile set to 'analog stereo output' and port 'line out'

2. Plug in headphones and set port to 'headphones (unplugged)'
-> sound stops from speakers (rear line out port) and there is no output from the headphoens

3. Set profile to pro audio
-> audio comes through headphones (front port). 

4. Optionally, i can set the profile back to analog stero output and sound continues to come out through headphones (the port is however set to the default of 'line out')


**to return back to speakers (rear out)**
5. While keeping the profile the same (as analog stereo output), i change port to 'headphones (unplugged)' and then change it back to 'line out'
-> sound comes out of speakers

I have attached some debug info below:

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/11099085/alsa-info.txt)
[alsaucm.txt](https://github.com/alsa-project/alsa-ucm-conf/files/11099087/alsaucm.txt)

Any help would be appreciated

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/299
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
