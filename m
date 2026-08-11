Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D5FC5AC67
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:30:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCAD96016D;
	Tue, 11 Aug 2026 14:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCAD96016D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786451438;
	bh=aV7pD4rMhHGmaSDgg5ZWwOQfut6R4fnyrIbenA/5mDE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DcJs2eYx3q2fdgAUEQ4bMXlXn8R5vFE7jrL1gtXgYMC6Sn39ltNpx9fG1b/GEja4o
	 X8gZCKaHePN00h/GneA6ZjrSsd2qoDLqNExFn1tD60atNqrgW0aABHlrK186R8qpTA
	 RejbKIekXNDgWoTq3fAKX2thyKjaGdOXfOBFYnTw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D69FEF805F9; Tue, 11 Aug 2026 14:30:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3CF8F805F3;
	Tue, 11 Aug 2026 14:30:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27ED4F804E5; Tue, 11 Aug 2026 14:29:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786451396;
	b=SJ/+KyHAD9c3wQtrbzZE7UAEpqhDWZLo9g89v+C3CT+jSZ6jGNeABY11n3q6X5QSVarr
	 0vCN4YGJ3QHjii0gpQKY9/RDwnMo+H0LzvBe9k3fPb/7Uekh3pYiuWw7bFYkJy9FWK0hD
	 9ukdoFNzHROvveww1GQ5YLzkEm1oaxiGCKcs0kMd3VP+FMKogr7ilFDAGwU2uhse0USbe
	 4AjBpez3Qn3xVj6UuSmnoDLfXGFfD6xSRV/L0Q2X0rX3tePSrEsII3G7bB5UswUCJEehN
	 MUt7At2LC846Axn1YQ7sxwj8u8cd2FXmDEAbJZfcDu0uQ+rPQwgmrn3Z7bi2hMVFwog==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786451396;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=aV7pD4rMhHGmaSDgg5ZWwOQfut6R4fnyrIbenA/5mDE=;
	b=OwWg+9oz9zqxrovQef7mgUC9Uqiratzu7X8/dZ40KZ+i+wBSF2/BL0yxx6BxQmwF/CfC
	 UbKYRnbLUcmdUChQDkM6zIkJEBIhnItPhY5oR6EqjhOCqWTFSIoGs+VXthIeRie3optMl
	 /h4HGwmbKc3NSqmlpcoeYmwp7OYRSnMo4oDVV86WU2wy9td/HwUMEX7qRiiOxgAGhc8IG
	 oNMMc92ReFoLCeCQFj5jcRIkSlCXGHCgqSkF1fzSaZs8FXj0hzXWnbF2k+7cWYY7bbPf+
	 a6HRXrs/Sjk0LnEDyioDEjYF6Fz4+eVq/3jUD7kF4HEuh9TKzBUPEmoCIPYMvz6nOKg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A5A6EF8032D
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2026 14:29:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5A6EF8032D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cac01437004100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Tue, 11 Aug 2026 14:29:58 +0200 (CEST)
Message-ID-Hash: QVVWA537ZRD5VNEQNFLVIT3WCHZXO6HN
X-Message-ID-Hash: QVVWA537ZRD5VNEQNFLVIT3WCHZXO6HN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QVVWA537ZRD5VNEQNFLVIT3WCHZXO6HN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #826 was edited from NTMan:

ucm2: USB-Audio: add Topping M62 configuration

The M62 exposes a single ten channel playback PCM and a single sixteen
channel capture PCM. The ten playback channels are not a surround
layout: they are five independent stereo buses that the card's own
mixer sums into its outputs, named Playback 1/2 to Playback 9/10 in the
manual.

The descriptor declares no channel positions at all -- bmChannelConfig
is 0x00000000 on both the ten channel and the sixteen channel terminal
-- and the card exposes no ALSA channel map either, neither a kcontrol
nor a /proc entry. Without a profile the host therefore invents one:
PipeWire fills ten unnamed channels with its default surround layout,
so the desktop believes in a centre, an LFE and a rear that the
hardware does not have, or else hands out AUX0..AUX9. Both readings
break more than cosmetics: the balance control and the speaker test
have nothing to work with, and any per device equalisation carries ten
channel keys where two are meant.

Each bus is therefore published as its own stereo device, split out of
the one PCM. The five are not marked conflicting: they may play at
once, which is the point of having five.

What the card does declare is channel NAMES. iChannelNames points at
"Playback 1" on the playback terminal and at "Analogue 1" on the
capture terminal, each the first of a consecutive run of string
descriptors, and the run reads Analogue 1, Analogue 2, AUX 1, AUX 2,
BT 1, BT 2, Mobile 1, Mobile 2 and Loopback 1 to 8. macOS displays
exactly those because Core Audio follows that field. Every name in
this profile comes from there. Linux surfaces none
of it: ALSA carries channel positions through chmap and has no notion
of a channel name, so the host sees an anonymous sixteen and this
profile is where the names can live. The order was confirmed by
measurement as well, one column at a time -- feeding the microphone
input lights column 0, and a headphone to AUX loop lights columns 2
and 3.

The inputs are therefore published under the names the card's own
panel and control application use: IN 1, IN 2, AUX, BT and OTG IN. The
two microphone channels are named after the card's mic channels and not
after jacks, because IN 1 is switched on the card between its own
6.3 mm jack, the 3.5 mm jack and the headset jack; that switch lives in
the card's own panel and is not visible to the driver, so a jack name
would be a claim the configuration cannot back.

IN 1 and IN 2 are also offered together as IN 1 + 2. A balanced stereo
source -- a synthesiser, a mixer's main output -- arrives on both
microphone channels at once, and offering it only as two mono devices
makes the desktop pick one half of it. It conflicts with the halves
rather than coexisting with them, since the same two columns cannot be
two devices at the same time.

Bluetooth and Mobile are declared although they carry digital silence
on the unit tested here. With Bluetooth and OTG audible in the
headphones, the card's own control panel metering both, and the
loopbacks pointed at those sources, a sixteen column recording found
signal on columns 2 and 3 only, identically under PipeWire and under
Core Audio. The vendor reports the same channels recording normally on
Windows with the same firmware and the same operating mode, so the
behaviour is not universal and the enquiry is open; a unit that fills
them should present them by name rather than as an unlabelled column.

The eight loopback returns are left undeclared until one of them is
seen to carry a sample. Eight always silent entries in a sound panel
would be eight inputs that record nothing.

The card keeps all ten playback channels in one mixer element and all
sixteen capture columns in another, so the per bus and per input
volumes come from a control remap by channel index, in the same shape
the Behringer UMC204HD profile uses.

The card has three operating modes, switched from its own panel, and
all three keep the same USB id. Mobile Mode is a plain stereo device
with an honest FL FR channel map on both directions and needs no
profile; applying this one to it would ask a two channel PCM for ten.
The mode is encoded in the high byte of bcdDevice, 01xx Mobile, 02xx
Live Streaming, 03xx Pro Audio, so the profile is selected only for the
latter two. Live Streaming and Pro Audio have identical channel layouts
and differ only in the rates they offer, 44.1 and 48 kHz against those
plus 88.2 and 96 kHz.

Tested on Fedora with alsa-lib 1.2.16 and PipeWire in all three modes:
in Live Streaming and Pro Audio the five sinks and the named sources
appear as expected, playback lands on the intended pair, each remapped
element moves only its own channels, and a sixteen column recording
confirms the input columns; in Mobile Mode the card is left to the
generic configuration.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Attached alsa-info from all three modes. The `bcdDevice` value is what the profile keys on:

| Mode | bcdDevice | Playback | Capture | Rates (kHz) | Profile |
| --- | --- | --- | --- | --- | --- |
| [alsa-info-MobileMode.txt](https://github.com/user-attachments/files/30801211/alsa-info-MobileMode.txt) | 0145 | 2ch, FL FR | 2ch, FL FR | 44.1, 48 | not applied |
| [alsa-info-LiveStreamingMode.txt](https://github.com/user-attachments/files/30801208/alsa-info-LiveStreamingMode.txt)| 0248 | 10ch | 16ch | 44.1, 48 | applied |
| [alsa-info-ProAudioMode.txt](https://github.com/user-attachments/files/30801204/alsa-info-ProAudioMode.txt) | 0327 | 10ch | 16ch | 44.1, 48, 88.2, 96 | applied |

In the two ten channel modes the descriptor declares the channel map `FL FR FC LFE RL RR FLC FRC RC SL`, which the hardware does not have: those are five stereo buses. Mobile Mode declares `FL FR` on both directions and is left to the generic configuration.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/826
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/826.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
