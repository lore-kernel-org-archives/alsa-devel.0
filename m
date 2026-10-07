Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC4CA5FF1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:40:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA560601DB;
	Wed,  7 Oct 2026 12:39:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA560601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791369603;
	bh=SZgjvGAb5fQIh5t7nOaafX1yhw720D8I277QGczLHrQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AOdjVMIs7phaB5y4Q5CouHSvvxJ1QVubAU8O0wdoY7u5RfRs6M4M8lH2yc+rcPlzG
	 yEukna+YmaGIxRamnOQQZ9tjlKujLNlaS4+Q+Emf1H1LOApd9okiHBihs0PwgOFOls
	 4gBZV46TU/p5zb1jcoVpmeq5NvI1JE+Qua2W0tOc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7BD1F80153; Wed,  7 Oct 2026 12:39:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A048F80601;
	Wed,  7 Oct 2026 12:39:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 545A3F8051E; Wed,  7 Oct 2026 12:39:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791369569;
	b=RPutNBOycB0PSMMVQcy3ufmvrQvikBbAMh4jjvt1/sGVGb6VmlGlgltAwuYhNhRUd3lR
	 pN6tSZZN3btP3yISvjzcuxE6XeftCc+oL8uuyYF9bCgU8I7jsU5hra+Wi9cLO2pShZK88
	 CrN13MKk8uI32oNLnJ1IoR7UMeEwltMVSOuIZg0zf+gY5gB9NGVWRxOQ23goUqSgs//6R
	 GsIOBq5GNGENKdH5cLZPf02OBpS+PIB5g+wVLKKJn16ovR7wxU1YY8CqfJiN8yBcPI3uM
	 uWLBzk4juPbyC62f+DXlW5hM+5/2bzArazFAtjHkQ1GsVQ+RM2hmmbVx7SEy+KkHtxQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791369569;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=SZgjvGAb5fQIh5t7nOaafX1yhw720D8I277QGczLHrQ=;
	b=mboagb8LgxNkFqj9ah7zmLgp53aRWQLu5tCsKUAGV0Xgd++V8hUeK4EAMaxtSq6jmmsb
	 oALAvB11LYTmo08p983GWSaOJJP0L7wSiFJIozY+G/BRg+mDP9czMvDy8x4oJupxypEWU
	 t+jRUpyJ/lZbRIE2U5VW9UEkqnhL7j5trj29vBZsRfvGNPZ+ZIMX2VtMUGT9ZVGyPd07C
	 PZeDbk5Izq5ukhgc68PPHUgqoC9qDA/3/MlRieJbSVchgO/rtaVnxP0ebXKnP9CVLQKva
	 EXN8Vc5bRUjEN+HlQrtDd72frHkgUS3Lui43rxLPhWaPzDpBlXiEjxqwCAfCy1KXVUQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FD79F8007E
	for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2026 12:39:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FD79F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dc39215776f800-webhooks-bot@alsa-project.org>
In-Reply-To: <18dc39215743b200-webhooks-bot@alsa-project.org>
References: <18dc39215743b200-webhooks-bot@alsa-project.org>
Subject: Distorted/garbled sound on high channel count USB audio interface
 (class compliant) at certain altsets
Date: Wed,  7 Oct 2026 12:39:33 +0200 (CEST)
Message-ID-Hash: 2WE4AT5J6I5PUR3XOQWHRI6KBIVZK6ZQ
X-Message-ID-Hash: 2WE4AT5J6I5PUR3XOQWHRI6KBIVZK6ZQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2WE4AT5J6I5PUR3XOQWHRI6KBIVZK6ZQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #529 was opened from fripholm:

I don't know if I'm in the right place to address this issue here. If not, please feel free to point me in the right direction.

I recently purchased an RME Madiface XT II, which is (among others) a class compliant USB audio interface with a channel count of up to 196 input and 198 output channels over three MADI connections plus Phones Out, one AES I/O and one Stereo Analog I/O. I'm on Debian based MX 25.3, running liquorix kernel 7.2.8. My digital audio workstation is Reaper, native Linux build, running on ALSA, as pipewire(-jack) currently doesn't support more than 128 channels.

The interface offers 3 different altsets to ALSA for each set of sample rates. 

At 44.1/48kHz: setting Reaper to the device's native channel count (I: 196/O: 198) it switches to altset 3, on I: 100/O: 102 to altset 2 and on I: 52/O: 54 to altset 1. Altsets 1 and 2 work fine but as soon as altset 3 is active, the audio is heavily distorted and sounds like a bitcrushed, modulated, glitchy mess. This is what `/proc/asound/card2/stream0` looks like when Reaper is running:

```
RME MADIface XT (xxxxxxxx) at usb-0000:00:14.0-1, super speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 3
    Packet Size = 4096
    Momentary freq = 48000 Hz (0x6.0000)
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 54
    Endpoint: 0x02 (2 OUT) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
    Sync Endpoint: 0x82 (2 IN)
    Sync EP Interface: 1
    Sync EP Altset: 1
    Implicit Feedback Mode: No
  Interface 1
    Altset 2
    Format: S32_LE
    Channels: 102
    Endpoint: 0x02 (2 OUT) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
    Sync Endpoint: 0x82 (2 IN)
    Sync EP Interface: 1
    Sync EP Altset: 2
    Implicit Feedback Mode: No
  Interface 1
    Altset 3
    Format: S32_LE
    Channels: 198
    Endpoint: 0x02 (2 OUT) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
    Sync Endpoint: 0x82 (2 IN)
    Sync EP Interface: 1
    Sync EP Altset: 3
    Implicit Feedback Mode: No

Capture:
  Status: Running
    Interface = 2
    Altset = 3
    Packet Size = 4096
    Momentary freq = 48000 Hz (0x6.0000)
  Interface 2
    Altset 1
    Format: S32_LE
    Channels: 52
    Endpoint: 0x81 (1 IN) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
  Interface 2
    Altset 2
    Format: S32_LE
    Channels: 100
    Endpoint: 0x81 (1 IN) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
  Interface 2
    Altset 3
    Format: S32_LE
    Channels: 196
    Endpoint: 0x81 (1 IN) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
```

At higher sample rates, only altset 1 works and obviously the channel count is further reduced.

According to the hardware developer, the device is confirmed to be working fine in class compliant mode on all three altsets on MacOS (although it also has native Mac drivers), so everything points to some incompatibility/bug with ALSA.

There are several topics on RME's Linux sub forum about this, if more info is needed.
[https://forum.rme-audio.de/viewtopic.php?id=41751](url)
On the following thread, the relevant part starts at post no. 12: [https://forum.rme-audio.de/viewtopic.php?id=31000](url)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/529
Repository URL: https://github.com/alsa-project/alsa-lib
