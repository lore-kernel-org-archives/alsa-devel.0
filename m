Return-Path: <SRS0=fy3w=NW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CAC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 18:19:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F479610F7
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 18:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F479610F7
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E22616FA;
	Tue, 31 Aug 2021 20:18:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E22616FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630433989;
	bh=4Jsu7rrLk+5aC0lbz+W9L7qrwwMV5M4zJS6ATMlWpBg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aVLQaE3Z+HeDuuFlXGcxjpwP6XM7qEan0N4m+HxuMZ9m73FFXv38tWICvhtPcu1mw
	 pgR2nXPfNKCJ5Jh0NdlqXLfJUPBFB7hQA3sCzquZ4FuD+4ajbXeiyW9lyDga3IkHD0
	 beW/TcvHGuX+KWTiGS96Oi3iThjbOf2N+SEEWZY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5EAEF80254;
	Tue, 31 Aug 2021 20:18:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52231F8025B; Tue, 31 Aug 2021 20:18:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CFA52F80127
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 20:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFA52F80127
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630433929608411074-webhooks-bot@alsa-project.org>
References: <1630433929608411074-webhooks-bot@alsa-project.org>
Subject: Sample rate issues with M-Audio M-Track 2x2M
Message-Id: <20210831181857.52231F8025B@alsa1.perex.cz>
Date: Tue, 31 Aug 2021 20:18:57 +0200 (CEST)
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

alsa-project/alsa-lib issue #176 was edited from powerjungle:

At random points the sample rate changes, but the applications continue to use the previous rate. This results in sound being lower/higher pitch then normal. My own voice when using the application [Mumble](https://github.com/mumble-voip/mumble) consistently becomes higher pitch and sounds pretty funny, friends had a good laugh. I have some diffs of ALSA dumps.

My output is to headphones. My input is XLR.

Here for example I open the GNOME settings for "Sound" and my output becomes lower pitch:

```diff
6c6
< !!Script ran on: Sun Aug 29 19:56:57 UTC 2021
---
> !!Script ran on: Sun Aug 29 19:58:27 UTC 2021
1287c1287
<     Momentary freq = 48000 Hz (0x6.0000)
---
>     Momentary freq = 44101 Hz (0x5.8338)
1304c1304,1308
<   Status: Stop
---
>   Status: Running
>     Interface = 2
>     Altset = 1
>     Packet Size = 72
>     Momentary freq = 44100 Hz (0x5.8333)
1346c1350
< crw-rw----+ 1 root audio 116, 12 Aug 29 21:15 /dev/snd/pcmC1D0c
---
> crw-rw----+ 1 root audio 116, 12 Aug 29 21:58 /dev/snd/pcmC1D0c
1400c1404
<   Subdevices: 1/1
---
>   Subdevices: 0/1
2057,2058c2061,2062
< 		value.0 0
< 		value.1 0
---
> 		value.0 3
> 		value.1 4
```

Afterwards at a random point the output gets fixed, but the sample rate that gets logged is weird:

```diff
6c6
< !!Script ran on: Sun Aug 29 19:58:27 UTC 2021
---
> !!Script ran on: Sun Aug 29 20:33:14 UTC 2021
78c78
<       Running - No
---
>       Running - Yes
1287c1287
<     Momentary freq = 44101 Hz (0x5.8338)
---
>     Momentary freq = 47999 Hz (0x5.fff8)
1304,1308c1304
<   Status: Running
<     Interface = 2
<     Altset = 1
<     Packet Size = 72
<     Momentary freq = 44100 Hz (0x5.8333)
---
>   Status: Stop
1351c1347
< crw-rw----+ 1 root audio 116, 11 Aug 29 21:56 /dev/snd/pcmC1D0p
---
> crw-rw----+ 1 root audio 116, 11 Aug 29 22:32 /dev/snd/pcmC1D0p
1404c1400
<   Subdevices: 0/1
---
>   Subdevices: 1/1
2061,2062c2057,2058
< 		value.0 3
< 		value.1 4
---
> 		value.0 0
> 		value.1 0
```

Also sometimes when listening to music in Youtube using Firefox, the sound becomes higher pitch, but I cannot reproduce it, can't find the cause.

I'm running OpenSUSE Tumbleweed 5.13.13-1-default.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/176
Repository URL: https://github.com/alsa-project/alsa-lib
