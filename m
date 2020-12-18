Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC7C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 01:01:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB767238A0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 01:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB767238A0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 755141737;
	Fri, 18 Dec 2020 02:00:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 755141737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608253297;
	bh=VPketymZ+YqwwdnOVpLUAtLptn1btZfG+hZiaw0K8UQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmbFJv5QxAKIJFxa4QuLqPZvazgGd4QHPfRoPzEg63HmYsdJ37doHBPx0f9TuaoTK
	 2+K5jrJuklOTpMlQESCf1uOhVupJfeSWi0OES5kBK2hTF9NfVxRFns7luaRLXXfvd8
	 9UZn2Hf4RD6FkjnTCth/cl18B+TwTmrvQAer0Ai4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDE57F80259;
	Fri, 18 Dec 2020 02:00:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0DEAF80260; Fri, 18 Dec 2020 02:00:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D53E6F8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 02:00:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D53E6F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1608253235134378910-webhooks-bot@alsa-project.org>
References: <1608253235134378910-webhooks-bot@alsa-project.org>
Subject: UCM fails as CardDriver may not be defined
Message-Id: <20201218010043.C0DEAF80260@alsa1.perex.cz>
Date: Fri, 18 Dec 2020 02:00:43 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #69 was opened from coolstar:

UCM doesn't load as CardDriver isn't set on some platforms

Changing https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/ucm.conf#L69 to `Directory "${CardLongName}"` resolves the issue

```
I: [pulseaudio] source.c: Created source 1 "alsa_input.platform-sound.analog-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
I: [pulseaudio] source.c:     device.api = "alsa"
I: [pulseaudio] source.c:     device.class = "sound"
I: [pulseaudio] source.c:     alsa.class = "generic"
I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
I: [pulseaudio] source.c:     alsa.name = ""
I: [pulseaudio] source.c:     alsa.id = "ADMAIF1 CIF ADMAIF1-0"
I: [pulseaudio] source.c:     alsa.subdevice = "0"
I: [pulseaudio] source.c:     alsa.subdevice_name = "subdevice #0"
I: [pulseaudio] source.c:     alsa.device = "0"
I: [pulseaudio] source.c:     alsa.card = "1"
I: [pulseaudio] source.c:     alsa.card_name = "tegra-snd-t210ref-mobile-rt565x"
I: [pulseaudio] source.c:     alsa.long_card_name = "tegra-snd-t210ref-mobile-rt565x"
I: [pulseaudio] source.c:     device.bus_path = "platform-sound"
I: [pulseaudio] source.c:     sysfs.path = "/devices/sound/sound/card1"
I: [pulseaudio] source.c:     device.form_factor = "internal"
I: [pulseaudio] source.c:     device.string = "front:1"
I: [pulseaudio] source.c:     device.buffering.buffer_size = "32768"
I: [pulseaudio] source.c:     device.buffering.fragment_size = "16384"
I: [pulseaudio] source.c:     device.access_mode = "mmap+timer"
I: [pulseaudio] source.c:     device.profile.name = "analog-stereo"
I: [pulseaudio] source.c:     device.profile.description = "Analog Stereo"
I: [pulseaudio] source.c:     device.description = "Built-in Audio Analog Stereo"
I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] source.c:     device.icon_name = "audio-card"
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/69
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
