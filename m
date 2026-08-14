Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEBC5CFC1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:39:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFCCB60218;
	Fri, 14 Aug 2026 22:38:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFCCB60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786739938;
	bh=DcuVmMqedYem6fg+hSoJMwrjOYjxAd60xyFEbqgMW28=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=N8AImRsBPpBZEthB86wvTgbt91rudiYmR//7gjm+Sp9ICNoEb0vAw6AqZ447HAh2j
	 UiEPhI80JPPJnIgJMHQFz8QUmOY/L6HvtkI4CfQFhnXyTTq9FXqeRDt9/Man0mpFgq
	 9VoaXXU0ZpOBw+JYeQKkKSw3e1+OC7WNqkrXItY0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 686ADF805FE; Fri, 14 Aug 2026 22:38:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7522DF805FA;
	Fri, 14 Aug 2026 22:38:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 398E1F805A8; Fri, 14 Aug 2026 22:38:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786739893;
	b=BsQvqOK+Z5/6b1qwhB5IlzH0doDFSxSfsmeRYAX8dEVGPnBAQM1TTtU262x4JQmbMUm7
	 9aceDmwqc63RPfWGUU9+SB4W3Znsgq8tYp+GM1rjd3nL+Rfxfy1FEPNTZpQUb/Dmm8V6Y
	 GEkpXQ9fr8yMSjsHzwbphvEugVnCwmlM4Rhd4wjlYnlNjbrVkB7eHnxhZlNUMF9l6KuR6
	 UfjJxN5/ZxTEnW96tcHx9DqchQalRalC1e/uXRZh9MHyL/56Ckm4Xl0UJIoqP9AlUj4kw
	 xqpat/oX+yO7q8uJomE9tMQgtTbn1rtqBRDl0dRQq3f97by/rCkJ4FEYqEloEAZMSyQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786739893;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=DcuVmMqedYem6fg+hSoJMwrjOYjxAd60xyFEbqgMW28=;
	b=m0fejDvD9NbQrcdzX5F8MQgK/mufNOYBbdPExkW8Bdk8TXbhCuN/FvzBBHHvsLmXvVfG
	 Oc5ayHRUXwyXCted+lNcIdumuHoScnkcCPkocFPHA8go45uAg9thwrmSpFFKFn4Bp1/yZ
	 DnLvactB0msYrwoLiHcmyErJKSIt7xFz0UyIOKDrVmNui0UmOZZ+gfX2yTK+/kI0xRx9E
	 i5Nob+AEzWVvd+dZedxjkss6vs+XSF3ijNY76za8E5CATt8pXXIueIFroQXiSB9tzO5eN
	 y5b11RIOF8GRWHzfEF7+EdUXq36/efm9flvCDXAtABmh5TUmKdTLDhOICrwUGWIFkgQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E29EF80525
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2026 22:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E29EF80525
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cbc67722d16d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/832@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/832@alsa-project.org>
Subject: ucm2: sof-rt5682: add support for SOF rt5682 Chromebooks
Date: Fri, 14 Aug 2026 22:38:15 +0200 (CEST)
Message-ID-Hash: ZFDSVOJ5W66K7FTYRVLUD2YP5CJARJSA
X-Message-ID-Hash: ZFDSVOJ5W66K7FTYRVLUD2YP5CJARJSA
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZFDSVOJ5W66K7FTYRVLUD2YP5CJARJSA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #832 was opened from samson1357924:

## Summary

Add UCM configuration for the `sof-rt5682` sound card used on ChromeOS devices (Dratini/hatch family and others).

The configuration includes:

- `ucm2/conf.d/sof-rt5682/` - card UCM with HiFi profile, rt5682 headset/init sequences
- `ucm2/platforms/intel-sof/` - platform detection (DMI-based, glk/cml/tgl/jsl/adl/mtl) and codec probing helpers
- `ucm2/codecs/` - speaker amp and headset codec support files (max98357a, max98360a, max98373, max98390, rt1011, rt1015, rt1015p, rt1019p, rt5682s)
- `ucm2/codecs/hda/hdmi234.conf` - HDMI device helpers (reuses the existing `hdmi.conf` macro)

## Why

ChromeOS Chromebooks using the SOF driver with the `sof-rt5682` machine driver currently have **no audio** on Linux distributions without a UCM configuration: ACP/PipeWire cannot build a usable profile (only the "off" profile is available) and the system ends up with a Dummy Output. This affects at minimum the HP Pro C640 (Dratini), the Acer Chromebook Spin 513 (Dalboz) and several other hatch-family devices.

This was previously reported at https://github.com/WeirdTreeThing/chromebook-linux-audio/issues/265 (dummy output on LTS userspace) and discussed in PipeWire MR !2946.

## Testing

Verified on an **HP Pro C640 Chromebook** (Dratini, `Google_Hatch`, Intel Comet Lake) running Ubuntu 26.04 LTS:

- alsa-lib 1.2.15.3 (UCM syntax 7)
- kernel 7.0.0-29-generic (Ubuntu official), SOF firmware 2:2:0-57864
- pipewire 1.6.2 / wireplumber 0.5.13

Result: HiFi profile available and active, internal speakers (PCM 5), headphone jack (PCM 0, auto-switch works), DMIC capture and HDMI 1/2/3 all working. No Dummy Output, no WirePlumber errors.

All files are byte-identical to the standalone branch of WeirdTreeThing/alsa-ucm-conf-cros (verified via md5).

The UCM validator CI should cover the syntax; no alsa-info hardware emulation was added since the current `ucm-validator2` used by CI performs static verification.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/832
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/832.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
