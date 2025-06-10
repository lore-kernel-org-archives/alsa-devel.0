Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD3CC61DB2
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Jun 2025 18:59:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C4A1601F7;
	Tue, 10 Jun 2025 20:58:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C4A1601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749581940;
	bh=cRkWurCpHp72IwaIlbazELthAF+nP/HwCO2faeMbf78=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=q2TOEfxqYxME56EZeMeKkVc07oBm31SGLs/upBK2yJjHLC5Gj2mbA8MeDU6wfWTeT
	 FTGLIY8YMuGwhip5XUM6pvw4WgCrQ5ktxwKyHjWLL58Yq0S9/rho+2QZfZH0bzazK4
	 VYocvkuVwjTrUjP4KM5VEjxjE5hL8xv2chOEeZj8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC45EF805B6; Tue, 10 Jun 2025 20:58:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA6BEF805B6;
	Tue, 10 Jun 2025 20:58:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBB65F804B2; Tue, 10 Jun 2025 20:58:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A5F6F8025A
	for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2025 20:58:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A5F6F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1847c377995bd600-webhooks-bot@alsa-project.org>
In-Reply-To: <1847c37799543800-webhooks-bot@alsa-project.org>
References: <1847c37799543800-webhooks-bot@alsa-project.org>
Subject: Asus Zephyrus G16 2025 GA605KM (AMD)
Date: Tue, 10 Jun 2025 20:58:20 +0200 (CEST)
Message-ID-Hash: 6TNIPOAZ23QU5FXR5IUJYGO3IP345XHW
X-Message-ID-Hash: 6TNIPOAZ23QU5FXR5IUJYGO3IP345XHW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6TNIPOAZ23QU5FXR5IUJYGO3IP345XHW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #578 was opened from nefelim4ag:

[alsa-info](https://alsa-project.org/db/?f=eca30fae9c2bfca031f9cc921462dd7bc864d8fb)

I'm not too familiar with the audio stack to really make a fix.
>From my small investigation, it seems like there is no UCM for my card:
```
~ cat /proc/asound/cards
 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xd0080000 irq 128
 1 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xb02c8000 irq 129
 2 [Generic_1      ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xb02c0000 irq 130
```

My issue is that audio control from KDE is borked.
![Image](https://github.com/user-attachments/assets/0636ad48-7edf-4de0-bb68-e8669e2ab5e2)

Instead of just adjusting the PCM volume, it adjusts the master, then the speaker, and then the PCM.
Other knobs seem to do no useful work, except the speaker balance (AMP1/AMP2).

(also, I'm not sure that master and speaker actually do what they are named; they both seem to just make the sound "dull")

I can clone repo, test PR & etc.

Thanks.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/578
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
