Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF3AC74A5B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Mar 2023 05:30:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89E711F1;
	Thu, 30 Mar 2023 07:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89E711F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680154227;
	bh=cT9AJbLu9VfjmxzwOM2mkerVmpwD4psvLPjal6paJ+c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fVuGyDi+qETXTvksGII/eDgLgRKZ1OTHYyPovl5UnnjyHHFq0e487dAtGMgNs1nV2
	 oM14K+9wouO57c+D9M6YsoZyHmb0Y0hyItsGK81Rf/fw2os484J2yz0TbjTupi28Sc
	 H0bYxmkH6jSyMWDHL1ZQHerJzZMKMR6LMeq4ez0I=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1D5BF80272;
	Thu, 30 Mar 2023 07:29:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C8E3F80272; Thu, 30 Mar 2023 07:26:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D229F80114
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2023 07:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D229F80114
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680153961402135611-webhooks-bot@alsa-project.org>
References: <1680153961402135611-webhooks-bot@alsa-project.org>
Subject: No sound output of headphone on Senary SN6140
Message-Id: <20230330052617.3C8E3F80272@alsa1.perex.cz>
Date: Thu, 30 Mar 2023 07:26:17 +0200 (CEST)
Message-ID-Hash: CVJSWCDOCFBYPJLBHSWDBTTISJSO6XVV
X-Message-ID-Hash: CVJSWCDOCFBYPJLBHSWDBTTISJSO6XVV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CVJSWCDOCFBYPJLBHSWDBTTISJSO6XVV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #300 was opened from pyma1:

Thinkpad L14 got a senary SN6140 codec, speaker, Dmic, headset mic works fine.
Only no sound output from headphone.

add snd-intel-dspcfg.dsp_driver=1 to kernel cmdline the issue is reproduced too.

When not fully plugin headset, it didn't trigger headphone switch, sound output can be enabled in alsamixer.

Disable pipewire or pulseaudio, the issue is the same as before.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/11108039/alsa-info.txt)
[alsaucm.txt](https://github.com/alsa-project/alsa-ucm-conf/files/11108047/alsaucm.txt)

Would be appreciated for your help.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/300
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
