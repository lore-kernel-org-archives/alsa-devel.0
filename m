Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE9CCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:51:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA61601F5;
	Wed, 14 Oct 2026 10:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA61601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791967901;
	bh=wEHvXVXAn7qF10YGXtpZZTIFDuEGih3XjREhWEu2hsE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EQq9EqWc0QtukT7QXpk5VNTrIe/diymB6VtEDrYhvDpDL8IfsydN1JXPwhR7hPxil
	 gWGMWKAV9gKdKAIzKt7rJmg1b21QFr+Aze++uT/98C+YGu1oCiyhyXe9WlfCfkY3PU
	 Ae+MSfrkqyRgIUMj8c2Q7BJ/tCr2/CQeUJ7/vDSI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D86CF80601; Wed, 14 Oct 2026 10:51:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BEE98F80600;
	Wed, 14 Oct 2026 10:51:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A032FF80448; Wed, 14 Oct 2026 10:51:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791967857;
	b=n0QGPzPI5Ssw+Q+cTl2La/sxH5Km3VobbHsRJi4FflcIe1qNT7+jAWq3BXyzSiZXAbNH
	 Gj5wqMOmdJlQWxO7mfMFDvG7jqTebpHnWzCAcORJM+Gf7RPNLdbhTW27sHRt4xKFQPzIV
	 vtSR2Ejdv+pnjhxXDAy2hHjD8FFfG1CcQmmswGaKxDWtK63FZIwiqoXSBcKk23I1MjiwW
	 JaE8vjoSfhEQzANABntvYok9UUouVKfAPQPBnPG8cUiK7cFSstMcNXotuqMwfs5ucgeSE
	 WIol3HWYJ3a9Zts8HJ2fsvGQSVMLTS9/lSNlKsWw1gFe9gkRLBlbx4pIE38Ok0fuevA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791967857;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=wEHvXVXAn7qF10YGXtpZZTIFDuEGih3XjREhWEu2hsE=;
	b=AN8S31FPSZSDqvShr10fkKt635trOpE1LbY2x1A2DDn9n02pqCCyGPqjFbVtLcqWY0CZ
	 Ao7+TzP3UpqW9q3AhNUeJ4VYkhhaJEZlHVTzTh5TB1EjiMFmLwC7ENT3uUh4UHtpLb3kX
	 X4ZuCGh0D2traFMWmGetBJRu51wIJPSVQFmLa/v52LD0LW+wFG+GSirOdeCSi+YwnBXaT
	 mJeL0VDFtC2vvtzKDIfsuM1kPBDFLVULnAO1jm5Qsp/cndkwRxDNJoFH4SQN5Zwb01y4v
	 V1JhE/pUQ/PxC/YNGteqzFZSM7ng/43/7Ha2gZHDjMD9zx7hjTQrPGmEsd0gTwsvqeg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B3620F800FA
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2026 10:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3620F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de5945497cef00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Wed, 14 Oct 2026 10:51:00 +0200 (CEST)
Message-ID-Hash: Z6KF3RYHTJFDNJ63CALTZ5Y7AY2RHCMW
X-Message-ID-Hash: Z6KF3RYHTJFDNJ63CALTZ5Y7AY2RHCMW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z6KF3RYHTJFDNJ63CALTZ5Y7AY2RHCMW/>
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
"Playback 1" on the playback terminal and at "Analogue 1" on the capture
terminal, each the first of a consecutive run of string descriptors, and
the run reads Analogue 1, Analogue 2, AUX 1, AUX 2, BT 1, BT 2,
Mobile 1, Mobile 2 and Loopback 1 to 8. macOS displays exactly those
because Core Audio follows that field. Every name this profile shows
comes from there. Linux surfaces none of it: ALSA carries channel
positions through chmap and has no notion of a channel name, so the host
sees an anonymous sixteen and this profile is where the names can live.
The order was confirmed by measurement as well, one column at a time --
feeding the microphone input lights column 0, and a headphone to AUX
loop lights columns 2 and 3.

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
than something arriving from outside. The Direct verb unmutes them too,
and its ten playback channels with them: it is where someone asks for
every column and channel at once, so it is the verb where silence on
some of them misleads most.

The card's own faders are digital and sit after the converter, so
raising one lifts the converter's noise floor with the signal. The
analogue stages -- the two microphone preamps before the converter and
the headphone stage after it -- are reachable only over a vendor
protocol on the card's HID interface, and a kernel that speaks it
publishes them as ordinary mixer controls. Each device therefore picks
its volume with a ControlExists condition: where the analogue control
exists the device takes it and the verb pins the digital trim open, its
switch on included, since the two are in series and a fader over their
product describes neither, and nothing else would turn a trim's switch
on that someone had left off; where it does not exist the device takes
the trim, which is what this profile did before. No particular kernel is
required. The loopback returns are picked the same way: the card applies
its own gain to each, up to +12 dB, before USB, and where the kernel
publishes that gain the return takes it, since the trim after it can
only lower what the gain let through. The analogue stage after the
converter is a single headphone output, and which of the ten channels
reaches it is a choice inside the card; the next paragraph is where that
choice is made, and it is what lets a playback device name that stage as
its own.

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

The card has three operating modes, switched from its own panel, and all
three keep the same USB id. The mode is encoded in the high byte of
bcdDevice -- 01xx Mobile, 02xx Live Streaming, 03xx Pro Audio -- and
Topping/M62.conf picks the verb file by it. Live Streaming and Pro Audio
have identical channel layouts and on USB differ only in the rates they
offer, 44.1 and 48 kHz against those plus 88.2 and 96 kHz, so they share
M62-HiFi.conf. Mobile Mode is a two-in, two-out device: its descriptor
declares no positions either, and the kernel's guess, FL FR in both
directions, is right for two channels. Its capture is not two inputs but
the stereo output of one mixer over all of them, which the vendor's
control application calls Recording. A microphone on IN 1, a phone on
Bluetooth and a source on AUX are all in it at once; the host's own
playback is not, and is heard in the headphones with the inputs. It gets
a profile all the same, M62-Mobile-HiFi.conf, so that the sound server
takes the card from UCM in every mode instead of falling back to probing
it: one playback device, Playback 1/2, and one stereo capture device,
Recording, each on the card's own stage where the kernel publishes it --
the headphone stage and the Recording fader -- and on the USB trim where
it does not. Where the kernel also publishes the application's
Playback 1/2 knob, which sets the playback within the headphone mix, the
verb pins it at 0 dB, as it pins the trims. A bcdDevice outside the
three ends in an Error that names it.

The ten and sixteen channel layout of Live Streaming and Pro Audio
needs a high-speed link. A full-speed isochronous endpoint carries at
most 1023 bytes a millisecond, and ten 32-bit channels at 44.1 kHz, the
lowest rate the card offers, need 1764. After a marginal contact the
card came up at full speed, still in Pro Audio Mode and still with
bcdDevice 0327, and its playback was a two-channel S24_3LE stream. The
five stereo devices were then split out of channels the stream did not
have, and WirePlumber crashed on every start while probing them, since
alsa-lib checked the bindings only against the ten channels the
configuration asked for; that is fixed in alsa-lib on its own,
https://lore.kernel.org/alsa-devel/20261014065417.261594-1-mikhail.v.gavrilov@gmail.com/
Topping/M62.conf therefore offers the layout only at 480 Mbit/s and
otherwise ends in an Error that names the speed, which leaves the card
to the sound server's own probing, the way it treats a card without a
profile. Mobile Mode's two channels fit a full-speed link, and its verb
is left as it is.

The analogue controls, the loopback gains, the output selector, the
Mobile Mode levels and the MUTE switches come from a kernel series under
review. The names used here are those of its next version, which will be
linked here once it is posted; its v8 is at
https://lore.kernel.org/all/20261003184217.34671-1-mikhail.v.gavrilov@gmail.com/

Tested on Fedora with alsa-lib 1.2.16 and PipeWire in all three modes:
in Live Streaming and Pro Audio the five sinks and the named sources
appear as expected, playback lands on the intended pair, each remapped
element moves only its own channels, and a sixteen column recording
confirms the input columns, the loopback returns among them once the
verb has unmuted them; in Mobile Mode the one sink and the one source
appear, on the headphone stage and the Recording fader.

On 7.3-rc7 with that next version, in every mode: a tone played through
each playback device is heard in the headphones, the output selector
following the device in Live Streaming and Pro Audio; each sink's and
source's volume moves the card's own control behind it, and its mute
turns off the switch the series publishes beside that control or, on the
loopback returns, which have none, takes the gain to its lowest step;
the headphone knob on the card moves the sink's volume; the USB trims
stay at 0 dB and on, and so does the Playback 1/2 knob in Mobile Mode.

The speed condition was checked on a high-speed link: the card reads
480 there and the HiFi and Direct verbs come up as before; with the
condition inverted, alsa-lib stops on the Error that names the speed,
and PipeWire takes the card through its own probing, as one without a
profile. A full-speed link was not reproduced on purpose.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>


Attached alsa-info from all three modes. The `bcdDevice` value is what the profile keys on:

| Mode | bcdDevice | Playback | Capture | Rates (kHz) | Profile |
| --- | --- | --- | --- | --- | --- |
| [alsa-info-MobileMode.txt](https://github.com/user-attachments/files/30801211/alsa-info-MobileMode.txt) | 0145 | 2ch, FL FR | 2ch, FL FR | 44.1, 48 | M62-Mobile-HiFi.conf |
| [alsa-info-LiveStreamingMode.txt](https://github.com/user-attachments/files/30801208/alsa-info-LiveStreamingMode.txt) | 0248 | 10ch | 16ch | 44.1, 48 | M62-HiFi.conf |
| [alsa-info-ProAudioMode.txt](https://github.com/user-attachments/files/30801204/alsa-info-ProAudioMode.txt) | 0327 | 10ch | 16ch | 44.1, 48, 88.2, 96 | M62-HiFi.conf |

In all three modes the descriptor declares no channel positions: all ten `bmChannelConfig` fields in each file's `lsusb` section read `0x00000000`. The channel maps in the stream sections are the kernel's guess. In the two ten channel modes it is `FL FR FC LFE RL RR FLC FRC RC SL` for playback, which the hardware does not have -- those are five stereo buses -- and the sixteen channel capture gets no map. In Mobile Mode the same guess gives `FL FR` on both directions, which is right for a stereo device.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/826
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/826.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
