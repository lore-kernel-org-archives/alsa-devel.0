Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB1CC7EE39
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Jun 2025 15:16:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1404E601EC;
	Sun, 29 Jun 2025 17:15:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1404E601EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751210158;
	bh=G02GPmpiAQkZ4YnHIk/5bHsJpLLAMC1+Rkh4rOhd9sE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UWQRIyHyCvLSwgpIUBmefWZGqlx8SZD8A2BR/98XZmuW8XVNFc9FDGCUqvUjBfcB4
	 hC/F1MC7BDsAKaeejxWDn/N3fAkS7pz9rr3ys/Z/b/8ILcSGOJMMiQ830aIoyv7F/+
	 QcZ80cq7SdSbQfG/z+whOSn0uFCKkutR+XYIen00=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8307CF805D5; Sun, 29 Jun 2025 17:15:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DE36F805BD;
	Sun, 29 Jun 2025 17:15:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67843F80254; Sun, 29 Jun 2025 17:15:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C3497F800B5
	for <alsa-devel@alsa-project.org>; Sun, 29 Jun 2025 17:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3497F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184d8c52550dd700-webhooks-bot@alsa-project.org>
In-Reply-To: <184d8c5255085f00-webhooks-bot@alsa-project.org>
References: <184d8c5255085f00-webhooks-bot@alsa-project.org>
Subject: Focusrite Scarlett 18i20 Gen 1: UCM configuration defines incorrect
 capture channel count
Date: Sun, 29 Jun 2025 17:15:17 +0200 (CEST)
Message-ID-Hash: A73LNQJ4WDFHU4ESRPQRICUHP7F6YKCS
X-Message-ID-Hash: A73LNQJ4WDFHU4ESRPQRICUHP7F6YKCS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A73LNQJ4WDFHU4ESRPQRICUHP7F6YKCS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #588 was opened from mkuhl:

## Summary
The ALSA UCM configuration for Focusrite Scarlett 18i20 incorrectly defines 20 capture channels (`Define.DirectCaptureChannels 20`), but the 1st generation hardware only supports 18 channels. This causes the device to fail initialization with UCM profile errors.

## Device Information
- **Device**: Focusrite Scarlett 18i20 (1st Generation)
- **USB ID**: 1235:800c
- **USB Name**: Focusrite Scarlett 18i20 USB
- **Driver**: snd_usb_audio

## Channel Configuration (Gen 1)
- 8 analog inputs
- 8 ADAT inputs  
- 2 S/PDIF inputs
- **Total**: 18 input channels (not 20)

## Error Message
```
spa.alsa: Error in ALSA UCM profile for _ucm0007.hw:USB,0 (HiFi: Direct 2: source): CaptureChannels=20 > avail 18
spa.alsa: Errors in ALSA UCM profile for card Scarlett 18i20
```

## Affected Files
The channel definition is in the main configuration file:
`/usr/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-18i20.conf`

Current (incorrect):
```
Define.DirectCaptureChannels 20
```

Should be:
```
Define.DirectCaptureChannels 18
```

This file then includes `Scarlett-18i20-HiFi.conf` which uses the defined value.

## System Information
- **Distribution**: Fedora 42 / Aurora-dx
- **Kernel**: 6.15.3-200.fc42.x86_64
- **PipeWire**: 1.4.5-1.fc42
- **WirePlumber**: 0.5.8-1.fc42
- **ALSA UCM**: 1.2.14-2.fc42
- **ALSA lib**: 1.2.14-2.fc42

## Steps to Reproduce
1. Connect Focusrite Scarlett 18i20 Gen 1 (USB ID 1235:800c)
2. Start PipeWire/WirePlumber
3. Check device status: `wpctl status | grep Scarlett`
4. Device shows "[ALSA UCM error]"
5. Journal shows channel count mismatch error

## Workaround
Users can create a local override:
```bash
mkdir -p ~/.local/share/alsa/ucm2/USB-Audio/Focusrite/
cp /usr/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-18i20.conf \
   ~/.local/share/alsa/ucm2/USB-Audio/Focusrite/
cp /usr/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-18i20-HiFi.conf \
   ~/.local/share/alsa/ucm2/USB-Audio/Focusrite/
sed -i 's/Define.DirectCaptureChannels 20/Define.DirectCaptureChannels 18/g' \
   ~/.local/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-18i20.conf
```

## Root Cause Analysis
The UCM configuration appears to be written for newer Scarlett 18i20 generations (2nd/3rd/4th Gen) which may have 20 channels due to additional loopback channels. The configuration includes generation detection logic but doesn't properly identify USB ID 1235:800c as a 1st Gen device, causing it to use the default 20-channel configuration.

## Proposed Solution
The UCM configuration should detect Gen 1 devices and set the appropriate channel count:

1. Add detection for USB ID 1235:800c as Gen 1
2. Set `DirectCaptureChannels` to 18 for Gen 1 devices
3. Keep 20 channels for newer generations if applicable

## Impact
- Device fails to initialize properly
- Users cannot use the audio interface without manual workarounds
- Affects all Linux distributions using this UCM configuration

## Additional Information
- This is a regression - older ALSA versions worked correctly
- The issue affects PipeWire/WirePlumber but not JACK when using Pro Audio profile (which bypasses UCM)
- Other Gen 1 Scarlett devices (6i6, 8i8) may have similar issues

## References
- Device specifications: https://support.focusrite.com/hc/en-gb/articles/206849839-Scarlett-1st-Gen-Tech-Specs

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/588
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
