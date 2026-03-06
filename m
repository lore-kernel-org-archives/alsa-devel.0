Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F71EFCD6D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:32:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB7D26025E;
	Mon,  9 Mar 2026 10:32:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB7D26025E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773048766;
	bh=50mokf7M7OQ37h42yMlhqgJsnruggM2qbUNm7Fe8epo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AwtwPKCDxMkxxMPzuyTUODdsRHBOMQti9em0X+e4WvnsvQnYf5PuGE+bVpM3DWdYa
	 Lgg8SNvvH038ZKvBZNPAqbg3t4GiKybaSHhhc2No73TV4iYLwDaG7DY7rHnV2ra4TP
	 Zy5YuoTAa+E8JCUIVM+1+1rv9k9OiXNT6fZ5MijA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBB2EF805F3; Mon,  9 Mar 2026 10:32:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71AF5F805F3;
	Mon,  9 Mar 2026 10:32:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A486F80495; Fri,  6 Mar 2026 18:34:18 +0100 (CET)
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A85DF8016D
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2026 18:34:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A85DF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cachyos.org header.i=@cachyos.org header.a=rsa-sha256
 header.s=dkim header.b=ao8NQFvJ
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16A56285EA3;
	Fri,  6 Mar 2026 18:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1772818455; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HmN52a4KUOVNr09zTLR+fHOloq/lKWdy/8yAr/dvGWI=;
	b=ao8NQFvJc6RODFu0MG2/Spz7ZyMT37U1z4uJFOgBtthG7AOJj5o6YxPHIqcZnZ4OdBzPdW
	6/kzsTrJw1SkUpHGOmYMqzOyUWYFasVW+xE6YgWkBtfJ7zgWcrYWtP4bXS9eyLJ2uEAEPt
	l+6a0HTuBXGTuZOj7R+xdLq4UzBsjSohuRUgkLcMC6/nn9LFy5pSyD/p96n3qFAbjQrHrk
	aVoReUPhvTBHzUJc9ajUjjsKKxmJJgbpstixu5ZMOafs0hWrCVDmudr/+GVtstbhGdlO6g
	gqPoBbO80ATHqtImJEU3LfO/zV1XKECzEYr+2mA5v5qI5WwBGIO39EhZ99tn7g==
Message-ID: <fb2632ab-6afd-43c2-9c2e-6a160400fee0@cachyos.org>
Date: Fri, 6 Mar 2026 17:34:00 +0000
MIME-Version: 1.0
Subject: Re: ALSA Bug Report: TAS2781 speaker amps not working on ASUS ROG
 Strix SCAR 16 G635LX (2025)
To: Andrzej Hankus <andrzejh07@gmail.com>, alsa-devel@alsa-project.org
References: 
 <CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: 
 <CACB9z7kjs8rhLstEc8fV29BCTb5dd881JwGozoKdO5cwCb=YwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: dnaim@cachyos.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6YBUL4ZAKSEHIJYKIRYYUSHTYEUR7O46
X-Message-ID-Hash: 6YBUL4ZAKSEHIJYKIRYYUSHTYEUR7O46
X-Mailman-Approved-At: Mon, 09 Mar 2026 09:32:04 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6YBUL4ZAKSEHIJYKIRYYUSHTYEUR7O46/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andrzej,

On 3/1/26 5:43 PM, Andrzej Hankus wrote:
> IHello,
> I would like to report the following bug.
> 
> ## Summary
> 
> Internal speakers produce only thin, high-pitched audio (tweeters only) on
> the ASUS ROG Strix SCAR 16 G635LX (2025 model). The TAS2781 woofer
> amplifiers are never initialized because the HDA component binding between
> the ALC285 codec fixup and the TAS2781 I2C side-codec driver fails silently.
> 
> ## Hardware
> 
> - **Laptop:** ASUS ROG Strix SCAR 16 G635LX (2025)
> - **Platform:** Intel Meteor Lake (800 Series ACE)
> - **Audio Codec:** Realtek ALC285
> - **PCI SSID:** `1043:3ef0`
> - **Amplifiers:** Texas Instruments TAS2781 × 3 (ACPI device `TXNW2781:00`)
> - **Speaker layout:** 2 tweeters (ALC285 direct) + 2 woofers (TAS2781 smart
> amps)
> 
> ## Software
> 
> - **Distro:** CachyOS
> - **Kernel:** 6.19.5-3-cachyos
> - **Audio server:** PipeWire
> 
> ## Problem Description
> 
> The kernel applies fixup `0x119` for PCI SSID `1043:3ef0`, which maps to
> `ALC287_FIXUP_TAS2781_I2C`. The `serial-multi-instantiate` driver
> successfully creates 3 I2C sub-devices for `TXNW2781:00`. However, the
> TAS2781 HDA I2C side-codec driver (`snd_hda_scodec_tas2781_i2c`) never
> binds to any of the 3 I2C devices. The component matching between the HDA
> codec and the side-codec appears to fail.
> 
> ### Suspected Root Cause
> 
> The fixup `ALC287_FIXUP_TAS2781_I2C` chains to `tas2781_fixup_tias_i2c`,
> which sets up HDA component matching for ACPI ID `TIAS2781`. However, this
> laptop uses the official ACPI ID `TXNW2781`. The fixup should instead use
> `tas2781_fixup_txnw_i2c` to match the correct ACPI ID.
> 
> ### Proposed Fix
> 
> The quirk entry for SSID `1043:3ef0` should point to a fixup that calls
> `tas2781_fixup_txnw_i2c` instead of `tas2781_fixup_tias_i2c`, or
> alternatively a new `ALC285_FIXUP_ASUS_TAS2781_TXNW_I2C` fixup should be
> created.
> 
> Other nearby ASUS SSID entries that use `TXNW2781` devices (e.g.,
> `1043:3ee0`, `1043:3f00`, `1043:3f10`, `1043:3f20`, `1043:3f30`) may have
> the same issue.
> 
> ## Diagnostic Evidence
> 
> ### dmesg (relevant lines)
> 
> ```
> [   13.209667] Serial bus multi instantiate pseudo device driver
> TXNW2781:00: error -ENXIO: IRQ index 0 not found
> [   13.209759] Serial bus multi instantiate pseudo device driver
> TXNW2781:00: error -ENXIO: IRQ index 0 not found
> [   13.209810] Serial bus multi instantiate pseudo device driver
> TXNW2781:00: error -ENXIO: IRQ index 0 not found
> [   13.209827] Serial bus multi instantiate pseudo device driver
> TXNW2781:00: Instantiated 3 I2C devices.
> [   13.673467] snd_hda_codec_alc269 hdaudioC1D0: ALC285: picked fixup  for
> PCI SSID 1043:3ef0
> [   13.673974] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC285:
> line_outs=2 (0x14/0x17/0x0/0x0/0x0) type:speaker
> [ 3599.385547] tas2781-hda i2c-TXNW2781:00-tas2781-hda.0:
> tasdevice_prmg_load: Firmware is NULL
> ```
> 
> Note: The fixup name after "picked fixup" is blank, but fixup ID `0x119` IS
> applied (confirmed via hexdump of the compiled quirk table in the kernel
> module).
> 
> ### I2C devices present but unbound
> 
> ```
> $ ls /sys/bus/i2c/devices/ | grep TXNW
> i2c-TXNW2781:00-tas2781-hda.0
> i2c-TXNW2781:00-tas2781-hda.1
> i2c-TXNW2781:00-tas2781-hda.2
> 
> $ ls /sys/bus/i2c/devices/i2c-TXNW2781:00-tas2781-hda.0/driver
> ls: cannot access: No such file or directory
> (no driver bound to any of the 3 devices)
> ```
> 
> ### Firmware files exist
> 
> ```
> $ ls /usr/lib/firmware/TAS2XXX3EF0*
> /usr/lib/firmware/TAS2XXX3EF00.bin.zst ->
> ti/audio/tas2781/TAS2XXX3EF00.bin.zst
> /usr/lib/firmware/TAS2XXX3EF01.bin.zst ->
> ti/audio/tas2781/TAS2XXX3EF01.bin.zst
> ```
> 
> ### TAS2781 I2C driver supports TXNW2781
> 
> ```
> $ strings snd-hda-scodec-tas2781-i2c.ko | grep TXNW
> TXNW2781
> alias=acpi*:TXNW2781:*
> ```
> 
> ### Codec info
> 
> ```
> $ cat /proc/asound/card1/codec#0 | head -6
> Codec: Realtek ALC285
> Address: 0
> AFG Function Id: 0x1 (unsol 1)
> Vendor Id: 0x10ec0285
> Subsystem Id: 0x10433ef0
> Revision Id: 0x100002
> ```
> 
> ### Relevant loaded modules
> 
> ```
> snd_hda_codec_alc269
> snd_hda_scodec_tas2781_i2c
> snd_hda_scodec_tas2781_spi
> snd_hda_scodec_tas2781
> snd_hda_scodec_component
> snd_soc_tas2781_i2c
> snd_soc_tas2781_fmwlib
> snd_soc_tas2781_comlib_i2c
> snd_soc_tas2781_comlib
> ```
> 
> ## What has been ruled out
> 
> - PipeWire is working correctly
> - All ALSA mixer channels are unmuted and at full volume
> - Bass Speaker switch is on
> - TAS2781 driver modules are loaded
> - Firmware files for this SSID exist in linux-firmware
> - This is not a userspace configuration issue
> 
> ## Steps to Reproduce
> 
> 1. Install any Linux distribution on ASUS ROG Strix SCAR 16 G635LX (2025)
> 2. Boot with kernel 6.19.x
> 3. Observe only tweeter output, no bass/woofer audio
> 4. Check dmesg for blank fixup name and "Firmware is NULL"
> 5. Verify no driver is bound to the TAS2781 I2C devices
> 
> ## Additional Notes
> 
> The `-ENXIO: IRQ index 0 not found` errors during TXNW2781 initialization
> (3 occurrences for 3 devices) may be a separate ACPI table issue but do not
> prevent device instantiation.
> 
> The "Firmware is NULL" message at timestamp 3599s (60 minutes after boot)
> indicates a late playback attempt reached the TAS2781 code path despite the
> driver never having properly probed.

I noticed the ALC287_FIXUP_TXNW2781_I2C quirk exists and built a kernel with the modifications. Can you please try it?

Link: https://share.cachyos.org/x86_64_v3/asus/

-- 
Regards,
  Eric
