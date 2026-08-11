Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA3BC5B572
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD684601FC;
	Tue, 11 Aug 2026 17:49:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD684601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786463352;
	bh=AS89bc+l6NTs4qsHCUpT+TuaNd1p0tQl75dlTYJ59XU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EYfFIf4Z1ZqjiA4e7ulhgMzIs4bXmXjil2BYO/AWWG+kl9O4h4T3y25G1Fgd4LiXs
	 nev/3ZrHmbOO/ncnnqx1391rkluUt+Xwttr0U46nmlNQRPm72oQt8Xt6gzEkvyECbi
	 SePPZPrYW51fx0nokF5OlbjSL2WdJAtbZ6s75BG0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12B8FF805FF; Tue, 11 Aug 2026 17:48:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC2D3F805F6;
	Tue, 11 Aug 2026 17:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83A3BF804E5; Tue, 11 Aug 2026 17:48:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786463312;
	b=U0AgcR7++xk44qqj0Vk9BnzzN2ljr6v2fMGPMT1cb4FtgnKH9s1JVM6KxWWflBHwSZy6
	 3cH0BJvnWaNU5hrcqK9TpSoJOs5PVVcODwM/e2w5MtzPzPQWop2zBDLXSeScfS5uSmIGu
	 5FQM96dHjkQj1YMmtjWht5RPwjn5ui1fKJO5LSyeWWQYWtsdimvw3u8p8Stm9j8teV3YM
	 6t4mafhCmrREobWNAfJhJtIUedFwgbYcg7rphopkTgLFq2GHikwEzwL2Y3RaDwmKyPDPf
	 lVWQcYzWnxbNtkb6IMtbtRAIWBOmOmX/ztGkhgRCG4j2PVBxKYU1v8BPXVwHHlEEg3Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786463312;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=AS89bc+l6NTs4qsHCUpT+TuaNd1p0tQl75dlTYJ59XU=;
	b=cKYiB6vdjBHahUbcSi4rBe6j/j5BPxaqZAR2CUlpBpAaC9SzzIExRthhNi1LBZVvfFYi
	 Hoc+Vk9e1Irux3umurmNN5qeMDfx4jhkh1nFAPJ73OdS9kbQRGoY19s7hiRmTPlAl4C5w
	 raOAyaMDbdHU01qHl53tR3Nu4tr2TFY824WnQlCoZ63aGWhyOXTbhjQKPt9eD+B943Aq/
	 LXSj8cOnD28c6hLb2HUlx3QDbxMYB6f4HKVqXB35WVKN/11pjnrmC/dZMP0pa1gxSh4E0
	 O5ZAi3jl11sW/YDLpcNq4jcSBtLOxgyQ0pfoLxG3QIBSfTq1iPnnUZBGdJ90taGg8fg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C633F80075
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2026 17:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C633F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cacaea88082a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Tue, 11 Aug 2026 17:48:33 +0200 (CEST)
Message-ID-Hash: AKALR336AGP4UVAPU6PWPMRDJ2CWYYTW
X-Message-ID-Hash: AKALR336AGP4UVAPU6PWPMRDJ2CWYYTW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AKALR336AGP4UVAPU6PWPMRDJ2CWYYTW/>
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

Bluetooth and Mobile carry audio, and all four inputs record at once: a
sixteen channel recording with a phone on Bluetooth and another on OTG
shows signal on the analogue, AUX, Bluetooth and Mobile columns
simultaneously.

The eight loopback returns do not, and are left undeclared until one of
them is seen to carry a sample. They stay silent with Loopback 5/6
assigned to Bluetooth and Loopback 7/8 to OTG IN in the vendor control
panel, and with those loopback meters active in the panel itself -- the
loop is built and audible inside the card and does not reach the USB
capture stream. Eight always silent entries in a sound panel would be
eight inputs that record nothing, so they wait for an answer from the
vendor.

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
