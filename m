Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145DC5AC67
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:22:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 297786021C;
	Thu,  6 Aug 2026 21:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 297786021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786044160;
	bh=Q/UlTx/WQaFFRdwKcN4bASvcwOvomsFnB+H2MW3p94E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eIr14MUtFLn8tPqMvmxWFtn+lIBWU02kkCQHTspdxl6DxibxQfe0eQYUE0M3Qh5PM
	 J2ZICrKrImkX+cXbRxKFvzuOIlJPxzpoWVWCSybj47HRnSV5fuksuYVSKHH72q05Nm
	 jn69ktBZhSGkV7GmNE/ntl2nI/sheFFsmFmqBciM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CBA2F805F4; Thu,  6 Aug 2026 21:22:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A6A4F805F5;
	Thu,  6 Aug 2026 21:22:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77D2DF8055A; Thu,  6 Aug 2026 21:22:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786044120;
	b=ZIEMCXlgZiSKyzxXBUCX+qnrYwNmIXinicBA4XpIXUgut353vP3je0O6l7OdsR8OGndv
	 5+GFfq9N9IOdX6qokyIiQvAJyMSwoUCGTWn5alvyJvEjCJ9OmCT7jKL6GdTSNyVu7ysai
	 LwaiBnlybSmjxCXDdeLavFDdViYUDvVVBrRmuItfujmg2mX3wwzzkxKR2Eqwsu7YjipK4
	 EgF/Clduug1WwP9geh3JqSXJW8w2CHdsxy6cO3s0mVIuf/ct+jZ0UMN4ieeFoDxlng1vf
	 Mg8NpKGyff3X/b/usbr0EpfqLfIopFSI1ZUX/Lxe+4SgKAZmK0FnVUODuNJ2xDCCzbw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786044120;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Q/UlTx/WQaFFRdwKcN4bASvcwOvomsFnB+H2MW3p94E=;
	b=I20wIJPS0udKEN1fKT8OaV5h5jnVbMFr/IMcnwB6iRa9JWQ3xFnYmYqV3D+jBsHHjmzV
	 eoQjTrBgctIEFtBfHMB08vv6B1kGpvD4VEQuySU7Y+MbnkxgNXsPQfHWa5ULFQDYZbYJS
	 Z+bG8zWO7aYDIJ7Gpnrq48/oH9E80A3tPpscAys480Eopd/9p7AulAfYaFpAxgduUUxKo
	 Kj5ub3r+kiZhJ2XZaGLB4CN0RVatv4+E+MCkyAg+ZM7EjeVF407DTa4UnWN665KxlDOzy
	 1ANWJu68COF73UVnrjI8ZQx3SQk3/gIOPFcbyiQC7oHl9XgwmpTOBmXpZLy1ioExNpQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 84CB7F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 21:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84CB7F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c94da9ed572a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/826@alsa-project.org>
Subject: ucm2: USB-Audio: add Topping M62 configuration
Date: Thu,  6 Aug 2026 21:22:01 +0200 (CEST)
Message-ID-Hash: B4PSGMYX42PELPM56JVIHVW5HEHJBAKT
X-Message-ID-Hash: B4PSGMYX42PELPM56JVIHVW5HEHJBAKT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B4PSGMYX42PELPM56JVIHVW5HEHJBAKT/>
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

Attached alsa-info from all three modes. The `bcdDevice` value is what
the profile keys on:

| Mode | bcdDevice | Playback | Capture | Rates (kHz) | Profile |
| --- | --- | --- | --- | --- | --- |
| [alsa-info-MobileMode.txt](https://github.com/user-attachments/files/30801211/alsa-info-MobileMode.txt) | 0145 | 2ch, FL FR | 2ch, FL FR | 44.1, 48 | not applied |
| [alsa-info-LiveStreamingMode.txt](https://github.com/user-attachments/files/30801208/alsa-info-LiveStreamingMode.txt)| 0248 | 10ch | 16ch | 44.1, 48 | applied |
| [alsa-info-ProAudioMode.txt](https://github.com/user-attachments/files/30801204/alsa-info-ProAudioMode.txt) | 0327 | 10ch | 16ch | 44.1, 48, 88.2, 96 | applied |

In the two ten channel modes the descriptor declares the channel map
`FL FR FC LFE RL RR FLC FRC RC SL`, which the hardware does not have:
those are five stereo buses. Mobile Mode declares `FL FR` on both
directions and is left to the generic configuration.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/826
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/826.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
