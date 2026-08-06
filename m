Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB20AC5AC67
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:03:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9253A6021C;
	Thu,  6 Aug 2026 21:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9253A6021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786042988;
	bh=Q6G43Wd9qBbl4NH6z0arvecDDXExV2XZeK5Z/BJyrsE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ka7Uc/XHZyR1dhBRSouEksrDj/Wls5aKJy9gF3yZd3qolZuSiQgC0VRwb59Rx+8Qf
	 2VZb/ddYJUTjN7QiXiiOwUxx30/q/16zyrvIFyQTUkoDYPrV5wZ3KLvtEjl8bIOh5I
	 Gh+H83xHNLN/lCGZC4zcU4GczSrc7AcopX98p5/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11B0EF805FB; Thu,  6 Aug 2026 21:02:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3D5DF805F3;
	Thu,  6 Aug 2026 21:02:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB666F8055A; Thu,  6 Aug 2026 21:02:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786042944;
	b=c/oR3QLZyOpl9rUa2fjxlMBIBRp/vn5RPhXbl+tLgwFjyT8tNZpUMbsElx6vjD5IAl5f
	 D2iC4Wu9pMIQQtqnMN2OzT94vm5eWwN8j033qs3SbKpPZEplwfIYQh6iAvPMMXzxGTpsY
	 LhvFlKX1AciZpo354KVeqY9jVHSIZ3A/fdbspvIpCm0T0qZvVcwvPa9rABf5FLtDbo7kj
	 MefTFfYylWcCPIoMgIe3EYrKMEmnx03/JPgJN+X5cSlETsfBiwtOMwGu8WuGui4q+aRKe
	 HSea+cN+geNjeEodKmYVOCKcZQ69KPPvejSsI2fQWK6YSNL3qko3GdSOJNXXuCY7W8A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786042944;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Q6G43Wd9qBbl4NH6z0arvecDDXExV2XZeK5Z/BJyrsE=;
	b=eI5Ka95hs3qjMjFqQBVIwbkn9GElX/TVMf4wqz/OEXFu1cTknMBBqTXK9KWncLDe6Nn0
	 FvDiEwCloLLtRX4U23RmcxSnieYOZ1NDI84irzBN8GuypFGpv91Tb7Sdzckhh6OnbqUVL
	 bY6siIh4hIpvbZKSgH3pGbt5tJ+YlPbWwV8UklgbpV71h0B9n+JKY/+LIc9FM2fUetsB+
	 46PmqfyaT2lxmeJagWQbEna5WfWhUaiVHPBzfDuHcgt5ELgt9T1KqhF08iXoB8ZpEIpI0
	 /QQV2APEpMaiU86K3d/4yPWQ3rdhqff26IJMoI8kX65y8j1TzX4Evk3q4PMM82cX+fw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AE02DF800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 21:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE02DF800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c94c97df644c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Thu,  6 Aug 2026 21:02:25 +0200 (CEST)
Message-ID-Hash: KVORTALACN72V2OKHHUEFLSYT6WTUD4R
X-Message-ID-Hash: KVORTALACN72V2OKHHUEFLSYT6WTUD4R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KVORTALACN72V2OKHHUEFLSYT6WTUD4R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #826 was opened from NTMan:

The M62 exposes a single ten channel playback PCM and a single sixteen channel capture PCM. The ten playback channels are not a surround layout: they are five independent stereo buses that the card's own mixer sums into its outputs, named Playback 1/2 to Playback 9/10 in the manual. The USB descriptor nevertheless declares the first ten standard surround positions, so without a profile the desktop either hands out AUX0..AUX9 or believes in a centre, an LFE and a rear that the hardware does not have. Both readings break more than cosmetics: the balance control and the speaker test have nothing to work with, and any per device equalisation carries ten channel keys where two are meant.

Each bus is therefore published as its own stereo device, split out of the one PCM. The five are not marked conflicting: they may play at once, which is the point of having five.

The capture PCM has no channel map at all. Every column was found by feeding a jack and recording all sixteen: column 0 is mic channel 1, column 1 is mic channel 2, columns 2 and 3 are the AUX stereo input. The remaining twelve carry exact digital zero rather than noise in every frame of every probe, which reads as unassigned rather than idle, so they are left undeclared.

The mic devices are named after the card's mic channels and not after jacks. Mic channel 1 is switched on the card between its own 6.3 mm jack, the 3.5 mm jack and the headset jack; that switch lives in the card's own panel and is not visible to the driver, so a jack name would be a claim the configuration cannot back.

The card keeps all ten playback channels in one mixer element and all sixteen capture columns in another, so the per bus and per input volumes come from a control remap by channel index, in the same shape the Behringer UMC204HD profile uses.

The card has three operating modes, switched from its own panel, and all three keep the same USB id. Mobile Mode is a plain stereo device with an honest FL FR channel map on both directions and needs no profile; applying this one to it would ask a two channel PCM for ten. The mode is encoded in the high byte of bcdDevice, 01xx Mobile, 02xx Live Streaming, 03xx Pro Audio, so the profile is selected only for the latter two. Live Streaming and Pro Audio have identical channel layouts and differ only in the rates they offer, 44.1 and 48 kHz against those plus 88.2 and 96 kHz.

Tested on Fedora with alsa-lib 1.2.16 and PipeWire in all three modes: in Live Streaming and Pro Audio the five sinks and three sources appear as expected, playback lands on the intended pair, each remapped element moves only its own channels, and a sixteen column recording confirms the input columns; in Mobile Mode the card is left to the generic configuration.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/826
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/826.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
