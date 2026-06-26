Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904FDCDE00C
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:47:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DBCE601D9;
	Fri, 26 Jun 2026 03:47:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DBCE601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782438460;
	bh=oA6mRBb69lWjnxUVCCbQCaVtwQnE1o3BviqxhM7mcw4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gpQ3R4KShLlx4vqtjE5JdRWA95TmvuHQxiOH6uTfli6YZvX22IJfwpKXakIpqW0da
	 Q0pzEd7jQ+HmEt3yftzik6PzGb40+7WTA+RQaPOqNeMsN1j7+9LdxapMRKYqlwnQV6
	 tDHfT60FdXQluHrmzr/o5meb2DOTTKCSDuLk3dH8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 024BEF805F8; Fri, 26 Jun 2026 03:47:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66786F80602;
	Fri, 26 Jun 2026 03:47:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40E75F804FF; Fri, 26 Jun 2026 03:46:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782438413;
	b=dQlmhs7KWhTdFD3xMAqr/zMJ788Cta/zKaTV/AJmbH9G16/N/hfgKutgmYGH06kT/waW
	 H1R0XZCCBYs8XsiSN+1mNlQG8BWDmms3hlLob5dcfWZkSr9MnJX65uKydi7rFeQ3KBHlp
	 TnFxF2dIoP8/vpJPRGuwJ7ePEDnOG6e3ygqTj/+NfTthPUb5GPdrEfKa6NXvZL6VJyjJE
	 SEepYXAZmb0P9FXINvBC7FU9tkE/BQdx0/PJI0Wh5iB+QbeBEVyf+r8Nt48LDj64bUSLz
	 hXjV71Ckdt9yKMTeorQmvcXo6pLSSCJ97AFPciLIojIsh75oZwyutfWertJXFLD/pLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782438413;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=oA6mRBb69lWjnxUVCCbQCaVtwQnE1o3BviqxhM7mcw4=;
	b=clzaa46z4MRCmqxgwk5XhJDJ61HK6FwxbvaRnuMMWORIXuP4fLbgkdSq6sxhDvUkztXx
	 zHtC9KhOk1Ak9vMQBJuXR6HrquVTmxw8Y/D9yYs5fUsL2LXUzDCC4osTjIquyND8MUtvl
	 5neCObgMymbgD1buaV2boYDPnKzgr4KxVh7fp+h/ei9QApkScTQbpF/DNRIlHqqCaS8/Z
	 Yvhf1e+j1sD+6FDMPPgMQsMB/aClz8iMImjEu5u4WgN6Cd5HvlJGXSnKRWo0HoirrNW+2
	 nTkF5scqm3OkPTKk1XcfH8YXiQLgNXbH2HPC+HvdSa26aRFmDp0foI3gOLxluYTR8jA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 72437F8010B
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 03:46:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72437F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bc7e4abb2f2e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/796@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/796@alsa-project.org>
Subject: USB-Audio: Add M-Audio M-Track Solo
Date: Fri, 26 Jun 2026 03:46:55 +0200 (CEST)
Message-ID-Hash: KRLXZUQO4FDMMZUUCNIRUDUNB22AS4OV
X-Message-ID-Hash: KRLXZUQO4FDMMZUUCNIRUDUNB22AS4OV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KRLXZUQO4FDMMZUUCNIRUDUNB22AS4OV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #796 was opened from busybox11:

The M-Audio M-Track Solo (`08bb:29c0`) is a USB audio interface based on the TI PCM2900C codec.

The chip has a stereo ADC with two physical inputs: Input 1 (XLR/TS combo, channel 0) and Input 2 (TS instrument jack, channel 1), each with its own gain control.
However, the default stereo capture node mixes both into a single stereo stream.

This PR adds a new profile via `M-Audio/M-Track-Solo.conf` and `M-Audio/M-Track-Solo-HiFi.conf` to define the device with two distinct mono capture inputs using SplitPCM, while also providing the proper device name in the labels, instead of the generic `PCM2900C Audio CODEC` prefix.

## Hardware

- Device: M-Audio M-Track Solo
- USB: `08bb:29c0` (Texas Instruments PCM2900C)
- Kernel: `snd-usb-audio`
- Mixer: `PCM Playback Volume/Switch` (stereo output), no capture controls

## UCM configuration

- `Speaker`: stereo output (`hw:${CardId},0`)
- `Mic1`: mono input from channel 0 (XLR/TS combo preamp)
- `Line2`: mono input from channel 1 (TS instrument jack)

## Verification

Before: both physical inputs are mixed into a single stereo capture node.
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/e461bc4d-dfe0-4569-848b-2e7bd1328f52" />
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/e604a8b7-3fad-424d-92d6-a4d87caccbf8" />


After: two independent mono input nodes (`M-Track SOLO Input 1 (Mic)`, `M-Track SOLO Input 2 (Line)`), each selectable individually in PipeWire/PulseAudio.

<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/08c019ea-164c-4cd1-8301-f1c3ee46d5e4" />
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/1ae5e2df-f337-42cd-9e3b-52a1f402032c" />

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/796
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/796.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
