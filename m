Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8AC606A31F
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=WeMgpTsi
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FD0F601F9;
	Sun, 15 Nov 2026 17:04:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FD0F601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794758683;
	bh=4bdZ3LuoOuzbfAYRmKegDQEURn5x5j+9CgSjePJ7tTs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WeMgpTsi2Wd0SmLlTBOtCsax9BxAEPgR4wXpAZbWH2wogmfYO4zVGb637ecmCJobG
	 UVCYWth4sRuCKb76VqjWrPUCPubOEb+cvLs+QWp/1O7fGZSHMBfRlyqlz5EHzUUuWE
	 HoW05qLFAt60GAFjEdpMVgxS4lJZy4VSleP2Ltgw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C738AF805F7; Sun, 15 Nov 2026 17:04:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AABDF80601;
	Sun, 15 Nov 2026 17:04:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18B13F80568; Sun, 15 Nov 2026 17:03:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794758636;
	b=hTsho0zWcDmcniXIA+za8RIDvjMSCouiLEwl/0Aikf8VuSZl5rd+YmyHA2YZpixXlCwz
	 T0He/NCoXR0qGFyRJPR7P8U+2nsykCYmmnnfDG6DjYMFKaUbWuLns7sRHfdF12xYCfzKg
	 nFefej8Q4IJkDPToW9AOgsY+m5Wgdxi1Q2EDVCz/rOgY2ZHwdZcAR5mljA3UeOZFU0S1F
	 ocmUbeloOxh/AJWO97zHhNlvGwP9NUkqHOWQXNVmWgMEb4rpWti83+i5Hrg2Ikxl2pPsn
	 krspZjcNoa4vB9Jnnd0WdcyCc5CPmDRfno/187XhvdYgXpvjrOBrXIf88mFLVEbak7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794758636;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=4bdZ3LuoOuzbfAYRmKegDQEURn5x5j+9CgSjePJ7tTs=;
	b=R6ORHO6eD2aDKiSGYKsQehYl270cwa0vrvpT3HFqpAVxaSDsEnPK94weutxDzIpIAdJf
	 SJFIxUNlEr7y4F4NrS3IcHwHwpcOrAaUll3fPG+MyZxRb/422Xc6lmxiUoL1yUKNzuLCz
	 oQg7SJLRVKT0vOIi7UncjLxMjAlsHFX7Rbtw1hec6cW1HwFYGVvaN+3kdMhMjOl1XtQei
	 Gj2X7OejDsKEGVmyRqjL9rleI8MKr68MsBl7NR3N34TNddumOu/sDD/bulDydiIhzXC6G
	 MjnmTp3A6lLYoUL5c9k152WQXJLG74kX8UJSTN/YFotfSkKloNvKE+rx4rYHrltlQXA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A211FF800E4
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2026 17:03:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A211FF800E4
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e843783821fb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/916@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/916@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add Microsoft Surface Laptop 7
Date: Sun, 15 Nov 2026 17:03:59 +0100 (CET)
Message-ID-Hash: TMRQEO6O5DGOPL3S5IX2GOHFBPRNZ23Z
X-Message-ID-Hash: TMRQEO6O5DGOPL3S5IX2GOHFBPRNZ23Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TMRQEO6O5DGOPL3S5IX2GOHFBPRNZ23Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #916 was opened from fidecastro:

On the Microsoft Surface Laptop 7 (Snapdragon X Elite), plugging in headphones gives no sound: with PipeWire and WirePlumber, no headphone sink is ever created.

The laptop is matched to the ThinkPad T14s profile, which has three DisplayPort outputs. Its sound card has two DisplayPort links (`displayport-0-dai-link` and `displayport-1-dai-link` in `x1e80100-microsoft-romulus.dtsi`), so:

- HDMI2's `JackControl "DP2 Jack"` names a control that does not exist. The port's availability is "unknown", which PipeWire treats as available.
- Headphones and the DisplayPort outputs share a PCM and are `ConflictingDevice`s, so they become alternative card profiles of equal priority. With HDMI2 always "available", WirePlumber stays on the HDMI2 profile when headphones are plugged in.
- At every start PipeWire logs `spa.alsa: '_ucm0001.hw:X1E80100Romulus,0': playback open failed: Invalid argument` and fails to create the HDMI2 sink, and the kernel logs `MultiMedia1 Playback: ASoC: no backend DAIs enabled for MultiMedia1 Playback`.

The jack, the codec and the routing are fine: selecting the headphone profile by hand gives a working sink at once.

This adds a profile for the laptop that is the T14s one without HDMI2 (`MICROSOFT-Surface-Laptop-7.conf`, `SurfaceLaptop7-HiFi.conf`) and takes the laptop out of the T14s match. The only differences from the T14s files are the removed HDMI2 device, its entries in the other devices' `ConflictingDevice` lists, and the `DISPLAY_PORT_RX_2` mixer lines.

**Tested** on a Surface Laptop 7 15" (`Surface_Laptop_7th_Edition_2037`), kernel 7.3, PipeWire 1.6.11, WirePlumber 0.5.19:

- The card has HDMI0, HDMI1 and Headphones profiles, and the errors above are gone.
- The active profile and the default sink follow the jack in both directions, within a second, unaided.
- Headphones play on the correct channels, and the headset microphone records.
- `alsaucm -c X1E80100-Romulus list _devices/HiFi` on this branch's tree lists Speaker, Headphones, Headset, Mic, HDMI0 and HDMI1.

**Not tested:** DisplayPort audio itself (no monitor with speakers at hand; HDMI0 and HDMI1 are unchanged from the T14s profile), and the 13.8" model, which shares the device tree's sound card and the DMI product name, so this profile applies to it too.

I kept the shared-PCM design of the T14s profile. The commit that added the IdeaCentre Mini describes giving each DisplayPort output its own frontend as the better arrangement; I have not attempted that here and would be glad to test it on this hardware.

Prepared with Claude Fable 5.2; tested by me on my own laptop.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/916
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/916.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
