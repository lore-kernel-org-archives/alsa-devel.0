Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0893ECA1016
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Sep 2025 01:11:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48146601E9;
	Tue,  9 Sep 2025 03:10:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48146601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757380264;
	bh=1WCiAb32uJABe4D2c4VOYpvJdTgOMF2Zy16doANQ3YU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vu8nsivNRNk76Lq3//ncHYhyaH9aHt6jMZQKfj/cl5/dnqDfhkW5CoSbtPm3h3V3/
	 TzOgdWZQnqvJgNFA5gN7JEe667Hfem8/Ws4ZQpChxopWqp8Tg/DKUpBa+DUvTldS5l
	 Kf7/TzesW2fPhycDqyKC3L458nlLhGrMMZFM6j7w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F8FEF805D2; Tue,  9 Sep 2025 03:10:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86466F805D4;
	Tue,  9 Sep 2025 03:10:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 825CCF8027B; Tue,  9 Sep 2025 03:09:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EFADAF801F7
	for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2025 03:09:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFADAF801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <186377f521f2a500-webhooks-bot@alsa-project.org>
In-Reply-To: <186377f51ca34a00-webhooks-bot@alsa-project.org>
References: <186377f51ca34a00-webhooks-bot@alsa-project.org>
Subject: ASRock X870 Riptide: extremely low mic capture volume
Date: Tue,  9 Sep 2025 03:09:38 +0200 (CEST)
Message-ID-Hash: GJODODROY2TDPZDCCP6DJYA7GP7ZOL3V
X-Message-ID-Hash: GJODODROY2TDPZDCCP6DJYA7GP7ZOL3V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GJODODROY2TDPZDCCP6DJYA7GP7ZOL3V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #611 was opened from jktomer:

I'm running with an ASRock X870 Riptide Wifi, which seems to use the same ALC4082 as other ASRock socket AM5 boards:

```
:) 18:00 viola:jkt[3828]alsa% lsusb | grep audio
Bus 001 Device 008: ID 26ce:0a08 Generic USB Audio
```

Playback on this device seems to work and the various ports are recognized apparently correctly, but capture from both the front microphone and rear line-input ports is excessively low volume even with the mixer turned up as high as it goes. (The card does still show in `/proc/asound/cards` as "Generic USB Audio", but editing the relevant section in `ALC4080-HiFi.conf` seems to influence the output of `alsaucm -c hw:1 dump text`, so I'm assuming the recognition part works correctly.)

Output of `alsa-info.sh` and `alsaucm -c hw:1 dump text` attached.

[alsa-info.txt](https://github.com/user-attachments/files/22223994/alsa-info.txt)

[alsaucm.txt](https://github.com/user-attachments/files/22223995/alsaucm.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/611
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
