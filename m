Return-Path: <SRS0=odsy=EP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F461C5517A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:13:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9BA206CB
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nAiF1MG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9BA206CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF31D16A6;
	Mon,  9 Nov 2020 22:12:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF31D16A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604956422;
	bh=CfmGiBnB5sfcnJc64rfZJMCbvbdhlIksInZYU6idngg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAiF1MG8XJhG2NKh6sgRBV+N3xNlAqpmjgXl1r3vgEPfcBJt05JsGhI6AE2BNI+ol
	 9sIckHsqP+gXaqT24U8EnvqbXKUMWeYE2PEtSVFZQviDKL/XSzQlgJssusw6EmHeyv
	 LoY3nBH1tHubdhbBaDfgKEnWyYLMvY/F8ch6SJgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E7C3F801F5;
	Mon,  9 Nov 2020 22:12:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03844F8020C; Mon,  9 Nov 2020 22:12:50 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D08F5F800BA
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2020 22:12:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D08F5F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1604956361740870953-webhooks-bot@alsa-project.org>
References: <1604956361740870953-webhooks-bot@alsa-project.org>
Subject: USB Audio device: Shure MV7 not recognized
Message-Id: <20201109211250.03844F8020C@alsa1.perex.cz>
Date: Mon,  9 Nov 2020 22:12:50 +0100 (CET)
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

The device has a head-phone jack with feedback from the mic, and without pulseaudio running I hear the microphone inputs.
So I was wondering if this was in particular a pulseaudio issue.

```
> arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: Generic [HD-Audio Generic], device 0: ALCS1200A Analog [ALCS1200A Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 2: ALCS1200A Alt Analog [ALCS1200A Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: C925e [Logitech Webcam C925e], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: MV7 [Shure MV7], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

> arecord -d 3  -f U8 sample.mp3
ALSA lib pcm_dsnoop.c:638:(snd_pcm_dsnoop_open) unable to open slave
arecord: main:830: audio open error: No such file or directory
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/98
Repository URL: https://github.com/alsa-project/alsa-lib
