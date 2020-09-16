Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383EC433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:09:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CD622274
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QcekYtus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CD622274
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF9F016B6;
	Wed, 16 Sep 2020 15:09:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF9F016B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600261793;
	bh=exJ4B0E8ZOtJLqRGXEepgGDMdI5G6V3kXysajnFYBl8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QcekYtusHlsFwnXZnPY9o64OzIbVV+yzSEk5aNSK6VdzwmyPvWKMQjdMJD4oUErMt
	 I/JeCMeOR27UlbgvBVDaZkncMZLQMcrIT+DEpsdN0RnNY/dhM3Y2lXzxtf3T2CsiZQ
	 cy71ENe4lALnP9l92pPd9kwSKRgawYD+eOS6LsIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70C8BF800BB;
	Wed, 16 Sep 2020 15:09:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E85F9F80292; Wed, 16 Sep 2020 15:09:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 980B5F8015A
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 15:08:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 980B5F8015A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1600261734400299072-webhooks-bot@alsa-project.org>
References: <1600261734400299072-webhooks-bot@alsa-project.org>
Subject: aplay: playing mono audio file alteres pulseaudio default Master left
 or right volume level
Message-Id: <20200916130900.E85F9F80292@alsa1.perex.cz>
Date: Wed, 16 Sep 2020 15:09:00 +0200 (CEST)
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

alsa-project/alsa-utils issue #55 was edited from maxmbed:

### Description

I am encountering an unexpected behaviour with pulse audio master volume in my application. 

If I set for example left channel to 100% and right channel 0%, and play mono audio file (i.e. audio file with 1 channel only), then I would expect to hear only the audio file on left channel.

The actual behaviour in the example of above is when playing the audio file, the Master volume right channel will be automatically adjusted to 50%. If play again it increases to 75% and so on. 

This issue happens also with other R/L volume level, the case of above is just an example.

**Important to note the case does not happen with stereo audio file** where audio sounds on left only channel as we can expect.

### Steps to repeat issue:

(a) Set mixer Lch to 100%, Rch to 0%
```
$ amixer -D default sset Master 65535,0
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 65535 [100%] [on]
  Front Right: Playback 0 [0%] [on]
```

(b) Play mono audio file
```
$ aplay -D default ringtone.wav
Playing WAVE 'ringtone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
```


### Request
(1) Is it by design expected ? 
(2) Is there a way to prevent this phenomenon (command option) ?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/55
Repository URL: https://github.com/alsa-project/alsa-utils
