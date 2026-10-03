Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947F1CA5FE6
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2026 19:13:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F5C7602AB;
	Sat,  3 Oct 2026 21:13:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F5C7602AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791054832;
	bh=FJaiJJb80zDCwfugKCry6xeAdndszQ5XW2+q6HvpxO8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I84lpBWwDdUDf9DooPa5kNQwT8Fa5K0Lh5V/8IO8SGAGyfWu0kkmRhCwbypMTHrVo
	 sNYosBT9qo3CCLHjdNtUl/KrhC0MY8jRz0+ohn9cCSG6d65rL3tLnmTC5Vi2Td6yJN
	 qB1qC8np9Lu3torfGCxE93e3PzEkMLTaZl+1ZKvs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6671F8045D; Sat,  3 Oct 2026 21:13:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 087B1F8045D;
	Sat,  3 Oct 2026 21:13:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5977F80548; Sat,  3 Oct 2026 21:13:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791054789;
	b=VTQPKbjDtqcdE+/9P7E+LDs5MPnUkx0+ANlFuF2/JkKDosSYoiW24QXeQLuqq8aJSei5
	 nndpeAoA7dPgJfa9+GFKZ0EanQ1KocHiJJ8thupVDAcFKaP8XNKJKpe8EH42e9M9z2zlW
	 TdupiSi6Z1gKsRHjj4v/PV/q2aIqRKusIg4VW+JgvacaGQJenthdWkw9853BhjU6Px1t4
	 1Bz8c2Q35m3ZCovtSvJfinjXqEGhSbgqp9stCB56yNRmOSioPWuXAamSRtRgcwowD6wzh
	 Ug10K+ypYx+idEShaIyVwsTlOQxVoH9lioRgBM+LyXpSNCYqQBfppTFXHBzuRtHhQrA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791054789;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=FJaiJJb80zDCwfugKCry6xeAdndszQ5XW2+q6HvpxO8=;
	b=PNa39xY8uI7tc3ya+iU3xklt1Fr7rAn4rCC9QemSw9xA0TD+aeOoMgGcSt5n2hwAMcN5
	 cvd4CjsYkkVKb6w2PUQnQ5yJpNwUGQy+4BfGw0jE2F03JDqdfNn9gqU5ZoR7PBfr2G0O7
	 qJoZDRcnqCzw/CGtSvrJEBZrWaBKm5SzVK+Vxp4e/x7ulAr9WXI2msv+41T0yblyaQJiI
	 QbmUXQpLZWW5dWSaTLWnMx3N4t/SEvosVgeUZSHRb4zfJicxm2dypSzyMEWDGjaMpb3L5
	 ECy3RX4bYNh0AWuG1Q18uqlOlPpbVq2k4Ahv6vrMtQIzPW3wzB2xUkGTutxZHh7dqAQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 219FDF80246
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 21:13:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 219FDF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18db1ad6ef076a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Sat,  3 Oct 2026 21:13:10 +0200 (CEST)
Message-ID-Hash: CDEJXHHKQTFQLKYLZ7FAMZI5SPRQMKBR
X-Message-ID-Hash: CDEJXHHKQTFQLKYLZ7FAMZI5SPRQMKBR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CDEJXHHKQTFQLKYLZ7FAMZI5SPRQMKBR/>
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
-- so the kernel guesses. snd-usb-audio fills a missing channel config
with the standard surround order and publishes FL FR FC LFE RL RR FLC
FRC RC SL as a fixed channel map for the ten playback channels, in the
Playback Channel Map control and in the card's /proc stream file; the
sixteen capture channels are more than a channel map can hold and get
no map at all. Without a profile PipeWire leaves the guess unused and
hands out AUX0..AUX9; wherever the map is used, the desktop believes in
a centre, an LFE and a rear that the hardware does not have. Both
readings break more than cosmetics: with AUX names the balance control
and the speaker test have nothing to work with, with the guess they
work on speakers that do not exist, and either way any per device
equalisation carries ten channel keys where two are meant.

Each bus is therefore published as its own stereo device, split out of
the one PCM. Unless the kernel publishes the output selector described
below, the five are not marked conflicting: they may play at once,
which is the point of having five.

What the card does declare is channel NAMES. iChannelNames points at
"Playback 1" on the playback terminal and at "Analogue 1" on the
capture terminal, each the first of a consecutive run of string
descriptors, and the run reads Analogue 1, Analogue 2, AUX 1, AUX 2,
BT 1, BT 2, Mobile 1, Mobile 2 and Loopback 1 to 8. macOS displays
exactly those because Core Audio follows that field. Every name this
profile shows comes from there. Linux surfaces none
of it: ALSA carries channel positions through chmap and has no notion
of a channel name, so the host sees an anonymous sixteen and this
profile is where the names can live. The order was confirmed by
measurement as well, one column at a time -- feeding the microphone
input lights column 0, and a headphone to AUX loop lights columns 2
and 3.

The inputs are therefore described by the names the card's own panel
and control application use: IN 1, IN 2, AUX, BT and OTG IN. The
two microphone channels are named after the card's mic channels and not
after jacks, because IN 1 is switched on the card between its own
6.3 mm jack, the 3.5 mm jack and the headset jack; that switch lives in
the card's own panel and is not visible to the driver, so a jack name
would be a claim the configuration cannot back.

Those names live in each device's Comment; the device identifiers come
from the vocabulary use-case.h defines -- Mic1 and Mic2 for the two
microphone channels, Bluetooth for the Bluetooth input, and Line1 to
Line11 for the five playback buses, the AUX and OTG inputs and the four
loopback returns. PulseAudio and PipeWire take the leading alphabetic
part of an identifier and look it up in that same list to set the port
type, so a name outside it gives an untyped port.

The two microphone channels are offered as two mono devices and not
additionally as one stereo device covering both. A stereo pair would be
useful, since a balanced source arrives on both at once, but it can only
be declared as conflicting with the two halves, and alsa-lib treats a
conflict list as a group of mutually exclusive devices: it closes the
relation transitively, so a stereo device conflicting with each half
makes the two halves conflict with each other. Two microphones that work
perfectly well at the same time would then be offered only one at a
time, which is the worse loss. Expressing it the other way round, as
SupportedDevice, fails for the same reason: the closure fills the lists
until nothing excludes anything, and all three end up coexisting and
overwriting each other's preamp gain.

Bluetooth and Mobile carry audio, and all four inputs record at once: a
sixteen channel recording with a phone on Bluetooth and another on OTG
shows signal on the analogue, AUX, Bluetooth and Mobile columns
simultaneously.

The eight loopback returns arrive MUTED. Mic Capture Switch carries one
value per capture column and reads on for the first eight and off for
the rest, so columns 8 to 15 deliver digital silence until something
turns them on. That is why they look as though the loop never reaches
the USB stream, while the vendor's control panel meters it happily and
while the same card delivers those returns to a host whose software
turns the switch on. The verb turns all sixteen on, and the four
returns are then declared as stereo devices, below the physical inputs
in priority because a return is what the card is already playing rather
than something arriving from outside. The Direct verb unmutes them too:
it is where someone asks for all sixteen columns at once, so it is the
verb where silence on half of them misleads most.

The card's own faders are digital and sit after the converter, so
raising one lifts the converter's noise floor with the signal. The
analogue stages -- the two microphone preamps before the converter and
the headphone stage after it -- are reachable only over a vendor
protocol on the card's HID interface, and a kernel that speaks it
publishes them as ordinary mixer controls. Each device therefore picks
its volume with a ControlExists condition: where the analogue control
exists the device takes it and the verb pins the digital trim open,
since the two are in series and a fader over their product describes
neither; where it does not exist the device takes the trim, which is
what this profile did before. No particular kernel is required.
The analogue stage after the converter is a single headphone output,
and which of the ten channels reaches it is a choice inside the card;
the next paragraph is where that choice is made, and it is what lets a
playback device name that stage as its own.

Each output on this card listens to one source chosen inside it, and
where the kernel publishes that selector -- a control separate from the
headphone volume, so the two are conditioned separately -- the five
playback devices own it: they conflict with one another, and enabling
one points the headphone output at its own bus. That is what makes the
analogue headphone stage theirs -- the active device is the one the
output is listening to, so its volume is that stage and not the digital
trim. Two things follow. The five buses no longer play at once, which
they can do on this card, their sum reaching an output through one of
the card's internal mixes. And a headphone output left listening to such
a mix is moved to a single bus the first time a device is enabled, a
setting this profile cannot restore. Where the selector is not
published the five stay independent, each with its own trim.

The card keeps all ten playback channels in one mixer element and all
sixteen capture columns in another, so the per bus and per input
volumes come from a control remap by channel index, in the same shape
the Behringer UMC204HD profile uses.

The card has three operating modes, switched from its own panel, and
all three keep the same USB id. Mobile Mode is a plain stereo device;
its descriptor declares no positions either, but the kernel's guess,
FL FR in both directions, is right for two channels, so it needs no
profile, and applying this one to it would ask a two channel PCM for
ten.
The mode is encoded in the high byte of bcdDevice, 01xx Mobile, 02xx
Live Streaming, 03xx Pro Audio, so the profile is selected only for the
latter two. Live Streaming and Pro Audio have identical channel layouts
and differ only in the rates they offer, 44.1 and 48 kHz against those
plus 88.2 and 96 kHz.

The analogue controls and the output selector come from a kernel series
under review:
https://lore.kernel.org/all/20261003184217.34671-1-mikhail.v.gavrilov@gmail.com/

Tested on Fedora with alsa-lib 1.2.16 and PipeWire in all three modes:
in Live Streaming and Pro Audio the five sinks and the named sources
appear as expected, playback lands on the intended pair, each remapped
element moves only its own channels, and a sixteen column recording
confirms the input columns, the loopback returns among them once the
verb has unmuted them; in Mobile Mode the card is left to the generic
configuration.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Attached alsa-info from all three modes. The `bcdDevice` value is what the profile keys on:

| Mode | bcdDevice | Playback | Capture | Rates (kHz) | Profile |
| --- | --- | --- | --- | --- | --- |
| [alsa-info-MobileMode.txt](https://github.com/user-attachments/files/30801211/alsa-info-MobileMode.txt) | 0145 | 2ch, FL FR | 2ch, FL FR | 44.1, 48 | not applied |
| [alsa-info-LiveStreamingMode.txt](https://github.com/user-attachments/files/30801208/alsa-info-LiveStreamingMode.txt)| 0248 | 10ch | 16ch | 44.1, 48 | applied |
| [alsa-info-ProAudioMode.txt](https://github.com/user-attachments/files/30801204/alsa-info-ProAudioMode.txt) | 0327 | 10ch | 16ch | 44.1, 48, 88.2, 96 | applied |

In all three modes the descriptor declares no channel positions: all ten `bmChannelConfig` fields in each file's `lsusb` section read `0x00000000`. The channel maps in the stream sections are the kernel's guess. In the two ten channel modes it is `FL FR FC LFE RL RR FLC FRC RC SL` for playback, which the hardware does not have -- those are five stereo buses -- and the sixteen channel capture gets no map. In Mobile Mode the same guess gives `FL FR` on both directions, which is right for a stereo device, and the card is left to the generic configuration.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/826
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/826.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
