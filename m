Return-Path: <SRS0=odsy=EP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79CC2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:07:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19AE206ED
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UX6Kcx4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19AE206ED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D32B81673;
	Mon,  9 Nov 2020 22:06:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D32B81673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604956023;
	bh=qIFJoXNVeup4dRbK4rQ9XGxT1s9sbEz1VXHmrWtH6Lk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UX6Kcx4vOOW78d5/G2bbOXNFcgt7C+Q/JVhzG+WNPvt/CYHjejzmt/H7+rJiJ+ug2
	 5YNTQ6Mh1JD96zkdHQKm/U5TxLwatfy7xPmOaapNz1yDf5hJNQrvOQ7vU/hq2x4pnB
	 BG/8HbnWnu2kY/Hf/UUOZSySXUUkiTpm/a6tKMK4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EB95F801F5;
	Mon,  9 Nov 2020 22:06:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26C98F8020C; Mon,  9 Nov 2020 22:06:05 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5D12DF800BA
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2020 22:05:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D12DF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1604955958153023005-webhooks-bot@alsa-project.org>
References: <1604955958153023005-webhooks-bot@alsa-project.org>
Subject: USB Audio device: Shure MV7 not recognized
Message-Id: <20201109210605.26C98F8020C@alsa1.perex.cz>
Date: Mon,  9 Nov 2020 22:06:05 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #98 was edited from vchuravy:

Hello! i hope this is the right venue for reporting not working audio devices.

```
> alsa-capabilities
9: `USB Audio' Digital USB Audio Class audio output on device Shure MV7
    -hardware address:               hw:3,0  (or hw:MV7,0)
    -device label:                   Shure MV7
    -formats:                        (n/a)
    -usb audio class:                UAC2 (isochronous asynchronous)
    -streamfile:                     /proc/asound/card3/stream0
    -character device:               /dev/snd/pcmC3D0p
    -monitor file:                   /proc/asound/card3/pcm0p/sub0/hw_params
```

`alsa-info.sh`: http://alsa-project.org/db/?f=7bfa1d9ac09aac53a52834e95b833d299dfe3896
`pulseaudio -vvv` https://gist.github.com/vchuravy/f5f8ee972d5e2179387c8c53423379f6

During the pulseaudio session I plugged the device in and then unplugged it. I am happy to dig in, but I would need some guidance on where to start. As a side-note the microphone seems to work on Android so I am wondering if they are using a different driver.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/98
Repository URL: https://github.com/alsa-project/alsa-lib
