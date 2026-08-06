Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A321CC5AC7C
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:23:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0003601F2;
	Thu,  6 Aug 2026 21:22:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0003601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786044179;
	bh=tqViWJV+PGrvDlQTD9zMmbm0iMcWqwHqbrCsGtUghPs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Hv5WWC0gsrDED90VnzvPX00tZuhWrUhXebGK7aUSniSJl46tWKmczLftxxz/kKJRs
	 4ThVOnpskyWd2Gg7hPF08fU2JZKQXY80TPIPhD4gEsWOydWWgWsYEOQCocGrT1wWor
	 oTOHZuZbRZOBJo2fO9NGlEgBZuWxGq6FwQlHbCqo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F02D4F80606; Thu,  6 Aug 2026 21:22:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57C8DF80603;
	Thu,  6 Aug 2026 21:22:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E05F5F805D7; Thu,  6 Aug 2026 21:22:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786044146;
	b=kTol4u3rDVuYpthUyjGPNJd+KgNNjI5mavc42pyb4y7tuuYFnP5jpOZVKFyVUeuzsEeM
	 xZ+02nQHDjUqoAdU0X4NLFIHrnFMmN+fcfZpBTs4gpmJUEnrjvodSFJBj3QewaVg1NXQ2
	 cFhY/OUKiPfJhMFcxGHPljTzhyjv8jbaVRJfpgd4PQDUfuvQimob0uCo+fJV9lKEVBn+0
	 5cqqgbOEXeOeioBNWfIq7vC9rhRUi6NCObMyA5yUBy5NHGgJkZK/LcBGG/o78TnYwSWQY
	 uVZwB6uPq907WLkpJGB+1D84th4VdE76/tW+/XT7J6hkGqGQFSPOTPg/jhkw+zpQB4Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786044146;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=tqViWJV+PGrvDlQTD9zMmbm0iMcWqwHqbrCsGtUghPs=;
	b=SmwCsgWPrsFjM4ltUoA+nJv6dG5cTBMi3U+E639lqxuZI/QBDTbIYZ3b0659isNhapfg
	 xZ/W85aFTmXnrO6EgVki9lmIUuH6yFOW+vxoAI7NxPTcZJwY1xVn6Iw+aK9KQ+ZZ31SCd
	 ifJro1nQaIMGMW580cojR/53Xo2DsWDL8ALzJ21NKym2dBasYMhPlpvnoRi16j4JG7ERY
	 bDX+ngW3MkuOEIyuHyoegDmPOZ00EwLUyiittdneQ7cGHDNEy5oEnbr1zWM8vOhk5QYEN
	 6SArxa809FJlgBPSITSnV25xEBnkyM+U64iKQXXUDfw3IdKVmvY7NMTqBhsTJtr/8mA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 420BBF800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 21:22:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 420BBF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c94dafe656ed00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Thu,  6 Aug 2026 21:22:26 +0200 (CEST)
Message-ID-Hash: ZERVYGYT3PL3NDYVOKB6SMJ2T4TWUKZV
X-Message-ID-Hash: ZERVYGYT3PL3NDYVOKB6SMJ2T4TWUKZV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZERVYGYT3PL3NDYVOKB6SMJ2T4TWUKZV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #826 was edited from NTMan:

The M62 exposes a single ten channel playback PCM and a single sixteen channel capture PCM. The ten playback channels are not a surround layout: they are five independent stereo buses that the card's own mixer sums into its outputs, named Playback 1/2 to Playback 9/10 in the manual. The USB descriptor nevertheless declares the first ten standard surround positions, so without a profile the desktop either hands out AUX0..AUX9 or believes in a centre, an LFE and a rear that the hardware does not have. Both readings break more than cosmetics: the balance control and the speaker test have nothing to work with, and any per device equalisation carries ten channel keys where two are meant.

Each bus is therefore published as its own stereo device, split out of the one PCM. The five are not marked conflicting: they may play at once, which is the point of having five.

The capture PCM has no channel map at all. Every column was found by feeding a jack and recording all sixteen: column 0 is mic channel 1, column 1 is mic channel 2, columns 2 and 3 are the AUX stereo input. The remaining twelve carry exact digital zero rather than noise in every frame of every probe, which reads as unassigned rather than idle, so they are left undeclared.

The mic devices are named after the card's mic channels and not after jacks. Mic channel 1 is switched on the card between its own 6.3 mm jack, the 3.5 mm jack and the headset jack; that switch lives in the card's own panel and is not visible to the driver, so a jack name would be a claim the configuration cannot back.

The card keeps all ten playback channels in one mixer element and all sixteen capture columns in another, so the per bus and per input volumes come from a control remap by channel index, in the same shape the Behringer UMC204HD profile uses.

The card has three operating modes, switched from its own panel, and all three keep the same USB id. Mobile Mode is a plain stereo device with an honest FL FR channel map on both directions and needs no profile; applying this one to it would ask a two channel PCM for ten. The mode is encoded in the high byte of bcdDevice, 01xx Mobile, 02xx Live Streaming, 03xx Pro Audio, so the profile is selected only for the latter two. Live Streaming and Pro Audio have identical channel layouts and differ only in the rates they offer, 44.1 and 48 kHz against those plus 88.2 and 96 kHz.

Tested on Fedora with alsa-lib 1.2.16 and PipeWire in all three modes: in Live Streaming and Pro Audio the five sinks and three sources appear as expected, playback lands on the intended pair, each remapped element moves only its own channels, and a sixteen column recording confirms the input columns; in Mobile Mode the card is left to the generic configuration.

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
