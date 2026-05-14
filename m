Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE3CD4F25
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2026 15:41:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B85860216;
	Thu, 14 May 2026 17:40:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B85860216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778773260;
	bh=a5RFHDovFzqbVWerZswQoMRvgOXxkLPfFxXH9vaqZ4I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sTAM0idqKMwRK0ABEvQkmvCb+lqCY44l17iJuK1eBsEgxXicBlfKEtEa/f+MUj/te
	 KEIZvYwVXs43E+5VAqPvQ2mFTf/ZuS45FexdkahA/kRXBWiERIuuqtMlCJ9T+vlGMU
	 qEVUQCXCDShXpI1PjKMhw+iBNQoOl1xeQG1v/904=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88313F80603; Thu, 14 May 2026 17:40:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD357F805EA;
	Thu, 14 May 2026 17:40:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDAE5F805BF; Thu, 14 May 2026 17:40:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BEC1F800D2
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2026 17:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BEC1F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18af78d394905300-webhooks-bot@alsa-project.org>
In-Reply-To: <18af78d3948a4100-webhooks-bot@alsa-project.org>
References: <18af78d3948a4100-webhooks-bot@alsa-project.org>
Subject: [ALSA/usb-audio] Weltrend/XiiSound Headset (040b:0897) splits
 channels into independent 'PCM'/'PCM 1' mixer elements and suffers from
 severe dB volume curve mismatch
Date: Thu, 14 May 2026 17:40:29 +0200 (CEST)
Message-ID-Hash: ENJTW56W3BZDJUDCX2GUNBBNQF36AURE
X-Message-ID-Hash: ENJTW56W3BZDJUDCX2GUNBBNQF36AURE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ENJTW56W3BZDJUDCX2GUNBBNQF36AURE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #760 was edited from skye6034:

<img width="717" height="298" alt="Image" src="https://github.com/user-attachments/assets/3f81ef7d-5973-493c-a2c1-b2046bb958c1" />
<img width="958" height="529" alt="Image" src="https://github.com/user-attachments/assets/b49f830a-255a-4283-a561-0aa957a86b68" />

### Description of the Bug
The Weltrend Semiconductor / XiiSound wireless headset dongle (USB ID 040b:0897) is incorrectly handled by the `snd-usb-audio` driver. Instead of presenting a single unified stereo hardware volume control interface, the driver registers two completely separate hardware playback controls simultaneously:
1. `PCM` (Controls overall initial gain / Left physical channel)
2. `PCM 1` (Controls the hardware amplification exclusively for the physical Right ear channel)

Because of this firmware descriptor misinterpretation, standard desktop environments (like GNOME/KDE) parse the device into separate, conflicting "Analog Output" and "Digital Output (S/PDIF)" hardware profiles simultaneously. 

When a user adjusts the system volume slider, the audio engine modulates the primary `PCM` element but leaves `PCM 1` un-synchronized at 0%. This instantly kills the physical Left audio channel entirely, leaving sound playing exclusively out of the Right side.

Furthermore, the hardware volume scaling curve is completely non-linear and broken. Small adjustments to the user-space volume slider result in massive, disproportionate drops in the hardware mixer levels. For example, lowering the desktop system volume slider slightly from 100% down to 98% causes the ALSA hardware `PCM` channel level to violently plummet down to approximately 33%.

The hardware functions perfectly as a standard, unified single stereo device on Windows and macOS.

### Steps to Reproduce
1. Connect the wireless USB dongle.
2. See two "Analog Output" and "Digital Output (S/PDIF)" profiles on the desktop (GNOME/KDE)
3. Audio won't play until you set "Analog" to 100%, and then, it would only play on the Right Channel
4. Open `alsamixer` and select the `H878 Wireless headset` sound card.
5. Observe two independent, unlinked channel elements: `PCM` and `PCM 1`.
6. Set `PCM 1` to 100. The physical left speaker starts outputting audio.
7. Attempting to lower system volume via desktop controls drops the main `PCM` element while leaving the channels permanently split and mismatched.
8. Drop the system volume slider slightly from 100% to 98% and observe the hardware `PCM` slider collapse immediately to ~33% gain.### 

Current User Workaround:
To achieve functional stereo, a user must manually force both `PCM` and `PCM 1` to exactly 100% in `alsamixer` to force open both physical speaker channels, and then instruct their user-space audio server (PipeWire/PulseAudio) to utilize software-side attenuation rather than mapping to the hardware mixer paths.

### Hardware Details (`lsusb -v`):
Bus 005 Device 003: ID 040b:0897 Weltrend Semiconductor H878 Wireless headset
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x040b Weltrend Semiconductor
  idProduct          0x0897 H878 Wireless headset
  bcdDevice            0.31
  iManufacturer           1 XiiSound Technology Corporation
  iProduct                2 H878 Wireless headset
  bNumConfigurations      1

### Alsamixer Controls Detected:
- Card: H878 Wireless headset
- Chip: USB Mixer
- Item: PCM [dB gain: 0.39, 0.39] -> Controls Left channel pathing
- Item: PCM 1 [Volume: 0] -> Hard-muted by default, controls Right hardware amp pathing

### Suggested Fix / Quirk Needed
This chip requires a custom driver mapping entry added to the Linux kernel (`sound/usb/quirks.c` or `sound/usb/mixer.c`). The driver needs a mixer quirk targeting USB ID `040b:0897` to:
1. Alias or hard-link `PCM 1` to the master `PCM` control for unified, locked stereo tracking.
2. Implement a custom volume map (`dB_map`) to override the broken firmware descriptors, preventing the hardware volume level from collapsing to 33% when a minor user-space attenuation (98%) is requested.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/760
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
