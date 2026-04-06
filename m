Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E9F46C4E
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:18:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2487601F2;
	Mon,  6 Apr 2026 17:18:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2487601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775488690;
	bh=A1sb8JtSLdG9q5BF07y62aPSCAoQAb/+aQRzvSl4k60=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GKbLOCYW822rDiS/7P/bPFmY3yWBNvZHG+76TpaqKAlkBhAoscmvN/lGrBwI7USEM
	 NMw/yCR9YZ+8i9Hj6atnP7rE2zmd6A+/xQg7QAQ63fhsPsn473ctoK6LwnTkwsGOZ7
	 RyjCNffVLp3T3smNTWz5dLvZh9kFhALflvF7ugMs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 632B1F805F3; Mon,  6 Apr 2026 17:17:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0941CF805E7;
	Mon,  6 Apr 2026 17:17:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC69CF8049C; Mon,  6 Apr 2026 17:17:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B8A48F80169
	for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2026 17:17:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8A48F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a3cd8311e0cf00-webhooks-bot@alsa-project.org>
In-Reply-To: <18a3cd8311b48b00-webhooks-bot@alsa-project.org>
References: <18a3cd8311b48b00-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?HP_Pavilion_14-ce3xxx_=28ALC295=29_=E2=80=93_mute_LED_does_not_work_in_Linux?=
Date: Mon,  6 Apr 2026 17:17:23 +0200 (CEST)
Message-ID-Hash: 77FM7G3XIP7WWYSNYDP7E5FVEEBW2MTL
X-Message-ID-Hash: 77FM7G3XIP7WWYSNYDP7E5FVEEBW2MTL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/77FM7G3XIP7WWYSNYDP7E5FVEEBW2MTL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #324 was opened from lakshyaelite:

**Laptop:** HP Pavilion Laptop 14-ce3xxx
**SKU:** 172V6PA#ACJ
**Audio codec:** Realtek ALC295
**Kernel:** 6.17.0-20-generic
**OS:** Linux Mint 22.3 (Ubuntu-based)

#### Problem

The audio mute key works correctly, but the **red mute LED on the keyboard never lights up**.

The LED **works correctly in Windows**, so the hardware itself is functional.

#### What happens in Linux

* Pressing the mute key mutes/unmutes audio normally.
* The mute LED does not turn on when muted.

#### System information

```
lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ uname -r
6.17.0-20-generic

lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ cat /sys/class/dmi/id/product_name
HP Pavilion Laptop 14-ce3xxx

lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ cat /sys/class/dmi/id/product_sku
172V6PA#ACJ

lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ cat /proc/asound/card*/codec* | grep Codec
Codec: Realtek ALC295
Codec: Intel Icelake HDMI

lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ ls /sys/class/leds
enp6s0-0::lan  hda::micmute    input3::capslock    phy0-led
enp6s0-1::lan  hda::mute       input3::numlock
enp6s0-2::lan  hp::hddprotect  input3::scrolllock
```

#### dmesg excerpt

```
lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ dmesg | grep -i alc
[    0.078833] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.089069] Calibrating delay loop (skipped), value calculated using timer frequency.. 2380.80 BogoMIPS (lpj=1190400)
[    4.773630] snd_hda_codec_alc269 hdaudioC0D0: ALC295: picked fixup hp-gpio-led (model specified)
[    4.775205] snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC295: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.775220] snd_hda_codec_alc269 hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.775226] snd_hda_codec_alc269 hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    4.775231] snd_hda_codec_alc269 hdaudioC0D0:    mono: mono_out=0x0
[    4.775235] snd_hda_codec_alc269 hdaudioC0D0:    inputs:
[    4.775241] snd_hda_codec_alc269 hdaudioC0D0:      Internal Mic=0x12
[    4.775246] snd_hda_codec_alc269 hdaudioC0D0:      Mic=0x19

lakshya@lakshya-HP-Pavilion-Laptop-14-ce3xxx:~$ dmesg | grep -i hda
[    4.706427] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    4.706882] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
[    4.773630] snd_hda_codec_alc269 hdaudioC0D0: ALC295: picked fixup hp-gpio-led (model specified)
[    4.775205] snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC295: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.775220] snd_hda_codec_alc269 hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.775226] snd_hda_codec_alc269 hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    4.775231] snd_hda_codec_alc269 hdaudioC0D0:    mono: mono_out=0x0
[    4.775235] snd_hda_codec_alc269 hdaudioC0D0:    inputs:
[    4.775241] snd_hda_codec_alc269 hdaudioC0D0:      Internal Mic=0x12
[    4.775246] snd_hda_codec_alc269 hdaudioC0D0:      Mic=0x19
[    5.501057] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    5.501119] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    5.501174] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    5.501230] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    5.501269] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    5.501307] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
```

#### Notes

* `hda::mute` LED device exists but does not control the physical LED.
* The LED worked correctly when the laptop was running Windows.

This laptop may require a **specific ALC295 mute-LED quirk or DMI entry**.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/324
Repository URL: https://github.com/alsa-project/alsa-utils
