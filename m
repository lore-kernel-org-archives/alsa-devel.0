Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3228AD232CC
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jan 2026 02:07:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1A44601F8;
	Fri,  9 Jan 2026 03:07:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1A44601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767924466;
	bh=vDG+cVWOKQv3qbNGuWu7CfeH37MWPeSjPqQyZo38YqI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dhppdcbGaYjwCU8+O8LROBgE2mg6euRJ54CrNSe6TBxFbIrs9incCidIMNRkBfZgP
	 cV0KlNWTBQlxyokvcIRvnWOBlZUj7q3tLPkkrSariaYVnEEuqCyrqWmrseDS7FLd5U
	 SSnyNOvTgEn8eunrSguZtKTGsrUQ+3FkQugZNX00=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21341F805E8; Fri,  9 Jan 2026 03:07:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0514F805E3;
	Fri,  9 Jan 2026 03:07:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1D06F80526; Fri,  9 Jan 2026 03:04:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EF6F1F80423
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2026 03:04:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF6F1F80423
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1888edc7276ee900-webhooks-bot@alsa-project.org>
In-Reply-To: <1888edc726f04e00-webhooks-bot@alsa-project.org>
References: <1888edc726f04e00-webhooks-bot@alsa-project.org>
Subject: ASUS ROG Maximus XIII Hero (Tiger Lake,
 ALC4082) - Microphone not working - Missing USB ID 0b05:19ac
Date: Fri,  9 Jan 2026 03:04:59 +0100 (CET)
Message-ID-Hash: EJYHWIYZO6NJMDBBVOEPOQKMVCRN7LXG
X-Message-ID-Hash: EJYHWIYZO6NJMDBBVOEPOQKMVCRN7LXG
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EJYHWIYZO6NJMDBBVOEPOQKMVCRN7LXG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #683 was opened from FallonBlue:

## Hardware
- **Motherboard**: ASUS ROG Maximus XIII Hero (Z490/Z590 chipset, Tiger Lake)
- **Audio Codec**: Realtek ALC4082 (connected via USB)
- **USB Device ID**: `0b05:19ac`
- **OS**: Bazzite (Fedora-based), kernel 6.17.7
- **Audio Stack**: PipeWire + WirePlumber

## Problem
The microphone input on the rear panel does not work. The device is detected as "Generic USB Audio" but ALSA UCM does not recognize it, so proper audio routing is not configured. Speaker/headphone output works fine.

## Root Cause
The USB device ID `0b05:19ac` is missing from the UCM configuration files:
- `/usr/share/alsa/ucm2/USB-Audio/USB-Audio.conf`
- `/usr/share/alsa/ucm2/USB-Audio/Realtek/ALC4080-HiFi.conf`

## Requested Fix
Please add `0b05:19ac` (ASUS ROG Maximus XIII Hero) to the ALC4080 UCM configuration, similar to how issue #165 was resolved for the Z690 Hero (`0b05:1a27`).

The device appears in lsusb as:
```
Bus 001 Device 002: ID 0b05:19ac ASUSTek Computer, Inc. USB Audio
```

## Additional Info
- Microphone works correctly in Windows
- Workaround: Using external USB microphone
- Related boards already in config: `0b05:1996` (Maximus XIII), `0b05:1a27` (Z690 Hero)

Thank you!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/683
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
