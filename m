Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB85CD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:56:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EF516023F;
	Tue, 26 May 2026 17:56:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EF516023F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779810974;
	bh=LjI4qPSL1+2+mJadT52AuvMCUaj2xhqWz4hh5if/nBs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mPxm+xZyBc8G7yF4dgkzKgFvQF2gPRBef/LwFWoj0ujkb0bWKUTJkGelGYvVphe6E
	 Mel+lPY1RmGxq26FK0gfurx0AgKBPmbgMue0rX9fGBJluBlIRTD+TISaCsowPl4rce
	 eIWVzwVybmB3eTjU3xHVBBkvklEsQAbuXs0ezAqA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A9BBF805F3; Tue, 26 May 2026 17:55:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D8CBF805EF;
	Tue, 26 May 2026 17:55:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1EABF80217; Tue, 26 May 2026 17:55:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 26273F800BD
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 17:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26273F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b3289ca18e7e00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b3289ca16e0100-webhooks-bot@alsa-project.org>
References: <18b3289ca16e0100-webhooks-bot@alsa-project.org>
Subject: Fender Quantum LT4 misdetected as Surround 4.0/5.1 instead of
 discrete Pro Audio pairs
Date: Tue, 26 May 2026 17:55:33 +0200 (CEST)
Message-ID-Hash: WGFJPPIV3VPTIZB6V3B52EWUG5ILMCOD
X-Message-ID-Hash: WGFJPPIV3VPTIZB6V3B52EWUG5ILMCOD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WGFJPPIV3VPTIZB6V3B52EWUG5ILMCOD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #767 was opened from rvfsvncss:

[pw-dump.json](https://github.com/user-attachments/files/28273508/pw-dump.json)
[wpctl-status.txt](https://github.com/user-attachments/files/28273507/wpctl-status.txt)

## Description
The Fender Quantum LT4 is a USB Audio Class 2 (UAC2) compliant audio interface. It features 4 analog inputs and 2 analog outputs, alongside 2 virtual inputs and 2 virtual outputs (total 6-in, 4-out stream). 

While it works perfectly plug-and-play as discrete stereo pairs/mono streams on Windows and macOS without drivers, WirePlumber's/ALSA's default heuristics misdetect the channel counts:
- The 4 outputs are forced into a legacy `surround40` (Quadraphonic) home theater matrix.
- The 6 inputs are forced into a `surround51` matrix.

This causes significant routing failures in consumer applications like Discord (which expects standard stereo/mono nodes and chokes on the surround matrix layout), and causes severe audio phase/routing bugs (L/R channels dropping completely to mono) when engaging the hardware's physical "Direct Monitor" button.

## Expected Behavior
The device should be mapped via a configuration rule to expose independent, discrete stereo pairs for outputs (e.g., Main Out 1/2, Virtual Out 3/4) and discrete mono/stereo streams for inputs, rather than fallback consumer surround sound profiles.

## Steps to Reproduce
1. Connect the Fender Quantum LT4 to a Linux machine running PipeWire/WirePlumber.
2. Observe available profiles in GNOME Sound Settings or `pavucontrol`. Only Surround profiles are available; standard "Analog Stereo" or discrete multi-channel tracking configurations are missing.
3. Switch to the "Pro Audio" profile to bypass it. Observe that consumer WebRTC applications like Discord distort heavily (robot voice artifacts due to raw multi-channel stream confusion) and direct hardware monitoring collapses the stereo field.

## Environment Data
- **OS:** Fedora Silverblue / Bazzite (Immutable GNOME)
- **Sound Server:** PipeWire / WirePlumber

(Please see attached `pw-dump.json` and `wpctl-status.txt` for the exact hardware topology descriptors.)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/767
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
