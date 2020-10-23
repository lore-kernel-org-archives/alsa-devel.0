Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5FC388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:43:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD1320FC3
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l0+gOfpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD1320FC3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B24901822;
	Fri, 23 Oct 2020 12:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B24901822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603449780;
	bh=le1iJv6KXfrckAVvuyuFDq5Bt3BOvdm1Vx9nr+zI0dI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0+gOfpKY8HmpSPdZbjiJ/uVFt56HK50bcQtZzNJ/ndIPtPv7gfl4URvmx3zmtaSD
	 FO5CR2/dZY/C0iaKWlAGCs8fs9Gj+slVXFD+nnqTIn0IH5UpdSIM7cjVnXZoWxJ3C/
	 ar4aQLu9JsDNYQrZyC7q3u6LzlqSawyM/UHZ4WGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F8BDF8026F;
	Fri, 23 Oct 2020 12:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4F8EF80272; Fri, 23 Oct 2020 12:41:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E332BF800BD
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 12:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E332BF800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603449690724879980-webhooks-bot@alsa-project.org>
References: <1603449690724879980-webhooks-bot@alsa-project.org>
Subject: PA - snd_pcm_avail() returned a value that is exceptionally large
Message-Id: <20201023104137.B4F8EF80272@alsa1.perex.cz>
Date: Fri, 23 Oct 2020 12:41:37 +0200 (CEST)
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

alsa-project/alsa-lib issue #68 was edited from reezer:

I hope this is the right place to report this. This occurred in relation to a crash.
http://alsa-project.org/db/?f=52e8505d884682fc06adac4ab8ce92a4ca3e0870


```
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: snd_pcm_avail() returned a value that is exceptionally large: 177312 bytes (923 ms).
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: snd_pcm_dump():
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: Soft volume PCM
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: Control: PCM Playback Volume
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: min_dB: -51
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: max_dB: 0
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: resolution: 256
E: [alsa-sink-ALC887-VD Analog] alsa-util.c: Its setup is:
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   stream       : PLAYBACK
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   access       : MMAP_INTERLEAVED
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   format       : S16_LE
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   subformat    : STD
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   channels     : 2
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   rate         : 48000
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   exact rate   : 48000 (48000/1)
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   msbits       : 16
E: [alsa-sink-ALC887-VD Analog] alsa-util.c:   buffer_size  : 4800
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/68
Repository URL: https://github.com/alsa-project/alsa-lib
