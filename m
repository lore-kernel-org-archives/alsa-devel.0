Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB93C5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:26:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48CF76023A;
	Wed, 12 Aug 2026 11:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48CF76023A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526764;
	bh=NrmA0+G3AEQTc1Bz66qy8Kcxss0J8x9WyLb4GqwQICc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mSXp7R44XziQb+d6LaZY46UCxcWTxE5+bk/imo6bdD9uZpCTih59xqet5stcLVjkD
	 j4kTHL3VrmSf5LP8u+dBvGa+GueCB90yxPVg59RaC0/pkkY+4jJI7dC8QwmQrYM0tq
	 6T95ZzJsVL0gjc5h0JAslfkJL9Y5s1Onjeb09V8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DD2DF8061D; Wed, 12 Aug 2026 11:24:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7C71F80612;
	Wed, 12 Aug 2026 11:24:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FC28F8026A; Sun,  9 Aug 2026 09:35:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786260954;
	b=angXAmMD+DHIG6f3ceJwqakRQdByxu4eqOrzvysURk4hHIaN2kKDgn8gB6nMv+I+4kM0
	 geYgzbfZ7bvsOvVotuwvnLU+ugu0N3o2jXfdIlYgsiEMvCwMqzbQH2t7OjYUnTqsiIGQZ
	 gy3NkwSj61wlfpD+fEBjYT9pqDI4hoO4TbSua4x10aHw7NoeOWaImV7BjSx6HCYTR6SdC
	 YTopgJcRZICWtYydPf7Ks9pnL0SuCJbIWtM5q7CKhJCWf1nN9q+vvBsycewgPCJxsPNy1
	 BnoxCEhvNw4QAroWWFIzMCh2Yn618xD2al3Wrroqw9+D5v+yTPUTAARdtIG/rTAgX8A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786260954;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NrmA0+G3AEQTc1Bz66qy8Kcxss0J8x9WyLb4GqwQICc=;
	b=UmMvb6/SNNzV6MLUsluiR7csBP9fSvOUXC5K2CviXS2c70LT7vQ5X3gAmYTLjEiuuruq
	 4OEyHJcCqEfEs92081ctPHeqFz82RZzVUqKgBAp/Lp7ff/e5LK9a7raKw2bdMHGY3PbuJ
	 kFofDVPNfZHYDijT/Q+PpDVL3ANyMbg7uD5SAdNqtXJWEMP/Rju4ATm3s7u90b6XhfHUP
	 YyzSl2f0x48vagq4TnxzVIgy45j7iuvX/7blQsPcl+C6tBuZ6xj9+epKBZbVMXIxMIUJg
	 b9hTz2zCSF4ECo1YK0arNyR8Cz9gMI88BISGQxK+bQDvsJO4IZdnfDDq061wyrQFDPw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CGpwF9WV;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2453F80240
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 09:35:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2453F80240
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CGpwF9WV
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39c9452244aso6754481fa.3
        for <alsa-devel@alsa-project.org>;
 Sun, 09 Aug 2026 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786260952; x=1786865752;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HfDYGJ8lTG/u23ihBW9a9gv104x3UycqR82NwEtOUE=;
        b=CGpwF9WVC7qbSMHhzJtlH5wD/+ns2SIuEiHvLTO2w7251kvIWcIHfjJYKaAxfteOA6
         K0ezWAZ9gFp0V48HOOqZT65atWlnBnzxQps2f575hwnwgRRpmiZt/SjKTDmjhRI6ob6t
         M2lslQP4CokSHLcMYm5mxCIqIyt21fTs+cabqICtCqUT2wxrGm0O73bxagSv7YdgTuVW
         Dn5ijLiYFfF42epgebfE3pZHM2mODYSQMd3DdDBIb5WRzmJ2Y4qVwMB3i9XPmmgp4Sm/
         LqaPO8qS9gDwGZNXt61WRlksZv3UuoiJ0kvmEhQ/RFW4pHRHs8hmcYSdBNHm6SfSo+3e
         jYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260952; x=1786865752;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9HfDYGJ8lTG/u23ihBW9a9gv104x3UycqR82NwEtOUE=;
        b=dhlg7N9emr3O3iJyG5KcD1+YCWd0mziWW/nQVAWfNdjjO4M8fmaN1xmyfkdxPFRr6h
         i5WYxzGewyKKd1SpGNjtq+kFHoPlDwSZ3TbcxBvgqzfRMHX0HW46EEZX79LrUuAEVSeT
         d7jXCzRZRVfPZMRr4NRe+qcpO4F7yEGPPt2fPvPQJPaAkuD2ZQN1+CY4k/4VwTO+u5nS
         HOiC3jvkC+Bs0zURKynxLKYMr17qs9fpUDeUPp2FXwouP2HlIln/cSgkQJysQFAjHxLa
         tyWKiFXPR+ANULqlDdVwOq5Zha6NWJwcAl5OCRqvhfYS7WqR3GK6jxVwxNUBh4NqQY5P
         ISkA==
X-Gm-Message-State: AOJu0YzgplglKnnnhpjSF7s4bHniVzuTWTb4NhZ3RsKKnbq2tw+HnD/A
	+90frAMw4sv6j8a+zf0ZBJaRKkI/wB4k9n9ImU2Z22D2sswYfb15FkCTqh3rhQKup3YycA==
X-Gm-Gg: AR+sD10M0nDAZUQ4yPjSvyaFvNGRbDJDqhnG7I6u4yBEEgVilJwXDUjeoxOQNqAbWri
	jm6NqZXR0Zw/X+ymFXJJ/fbunZpXhLllHr6uiDLxJkLzl7EELlE0UpEdNw987idVaMLo3zb7MXk
	z5Aj4sQu27uVZI+Cq7+K+wbVymzKa36BOm+/AKKELYzLgFBdjgn9VYKHaNSCpFsg2G1hprSP83G
	FWpburO+CMGIFVex1/FhU7vKq3LF8MSVl4e29NnmtMHzofvzEb0zWTLn/nigATyLFREJGCEHE8y
	wIDEy7gQ/FwtjMIeC2PZdN04nEpNDzvRIMIS68kygytSRS6qCx6VSgjFdSIwTe/jrwIUjq/kh4Q
	TxmWRpC5mf3aX4wPlHJUkq3FYLZy8U8GjDG07TC0XOEFEuX3qEQWYY9w0cn3c7lr+nAH8inGC/1
	woBdJT8mQO84Q9+7cusiudZPCgzcQ7IRoULQTUNddLQ2rWV9McvMfxuiI=
X-Received: by 2002:a05:651c:43d2:20b0:39a:cfe9:2481 with SMTP id
 38308e7fff4ca-39fbb2c93c8mr30397111fa.30.1786260951855;
        Sun, 09 Aug 2026 00:35:51 -0700 (PDT)
Received: from riper-83lr ([37.29.88.175])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b3050d0152sm1320739e87.31.2026.08.09.00.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:35:50 -0700 (PDT)
From: Viktor Menshin <ripeeerr@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Subject: Missing Cirrus CS35L56 firmware for Lenovo Xiaoxin Pro 14 ASP10 (SSID
 17aa:3912) causes distorted/crackling audio
Date: Sun,  9 Aug 2026 16:35:39 +0900
Message-ID: <20260809073540.17923-1-ripeeerr@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: ripeeerr@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RIACNGDCTIOGMH7GEKZMNX7H36QHDFV4
X-Message-ID-Hash: RIACNGDCTIOGMH7GEKZMNX7H36QHDFV4
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:24:40 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RIACNGDCTIOGMH7GEKZMNX7H36QHDFV4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I'm running Linux on a Lenovo Xiaoxin Pro 14 ASP10 (83LR), an AMD Ryzen AI 9 365
(Strix Point) laptop. Audio through both the internal speakers and the
headphone jack is heavily distorted/crackling on every kernel and distro I've
tried (self-built 6.19-arch1, current 7.1.6-arch1-1 on EndeavourOS, and a
Fedora live image).

The same distortion is present on Windows before installing the Realtek
driver package, which suggests the issue is a missing/incorrect vendor
configuration rather than something purely Linux-side.

System info:
$ uname -a
Linux riper-83lr 7.1.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Tue, 04 Aug 2026 11:19:27 +0000 x86_64 GNU/Linux

$ lspci -nnk | grep -iA3 audio
c2:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [1002:1640]
	Subsystem: Lenovo Device [17aa:3852]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
--
c2:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor [1022:15e2] (rev 70)
	Subsystem: Lenovo Device [17aa:38c1]
	Kernel driver in use: snd_acp_pci
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x, snd_pci_acp6x, snd_acp_pci, snd_pci_ps, snd_sof_amd_renoir, snd_sof_amd_rembrandt, snd_sof_amd_vangogh, snd_sof_amd_acp63, snd_sof_amd_acp70
c2:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Ryzen HD Audio Controller [1022:15e3]
	Subsystem: Lenovo Device [17aa:38b2]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

Codec: Realtek ALC287, Subsystem ID 17aa:3912 (reported by /proc/asound/card1/codec#0)
Amplifier: Cirrus Logic amp present via ACPI HID CIRQ1080

Relevant dmesg (fixup selection):
[    7.206943] snd_hda_codec_alc269 hdaudioC1D0: ALC287: picked fixup  for PCI SSID 17aa:0000
[    7.207280] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC287: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    7.207282] snd_hda_codec_alc269 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.207283] snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    7.207284] snd_hda_codec_alc269 hdaudioC1D0:    inputs:
[    7.207285] snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x19

The codec falls back to the generic "17aa:0000" Lenovo fixup, since there is
no specific quirk entry for SSID 17aa:3912 in patch_realtek.c.

The snd_hda_scodec_cs35l56 module is present in the kernel tree and loads
successfully when probed manually via modprobe, but produces no dmesg output
at all — no firmware-related errors and no successful init messages either.
It is not auto-loaded/bound on boot (lsmod shows nothing for cs35l56 without
manual modprobe).

Checking linux-firmware, there are many SSID-specific Cirrus CS35L56
firmware files under /usr/lib/firmware/cirrus/, including neighboring SSIDs
such as 17aa3910 and 17aa3911, but nothing for 17aa3912:

$ find /usr/lib/firmware/cirrus -iname "*17aa3912*"
(no output)

As a test, I temporarily copied the 17aa3911 firmware files
(cs35l56-b0-dsp1-misc-17aa3911-spkid0.wmfw.zst and the matching amp1/amp2
.bin.zst files) and renamed them to 17aa3912, rebuilt the initramfs, and
rebooted. This did not fix the distortion, which is expected since amp
calibration data is board/speaker-specific and not interchangeable between
models. I've since removed these test files.

I've also ruled out several other possible causes:
- hdajackretask pin overrides — no effect
- snd_hda_intel position_fix=1/2/3 — no effect
- PipeWire buffer/quantum tuning (quantum 1024/512/2048) — no effect
- Forcing S16LE format in WirePlumber to avoid resampling — no effect
- Testing with plain aplay directly against ALSA (bypassing PipeWire
  entirely, with an increased buffer/period size) — still distorted
- The distortion is present continuously during playback on both speakers
  and headphones equally, not tied to idle/wake power transitions

Given the codec pin configuration looks sane (attached below) and the amp
module is present in the kernel but never successfully probed, I believe the
missing piece is CS35L56 firmware/calibration data specific to SSID
17aa:3912 for this laptop model.

Is it possible to get Cirrus Logic firmware submitted for this SSID, or
could you point me toward the right process/contact to request it? Happy to
gather any additional diagnostics needed (full alsa-info.sh dump, acpidump,
etc).

Thanks,
Viktor Menshin

--- Full codec dump: cat /proc/asound/card1/codec#0 ---

Codec: Realtek ALC287
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0287
Subsystem Id: 0x17aa3912
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 D3cold CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=5, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x38 0x38]
  Converter: stream=0, channel=0
  PCM:
    rates [0x40]: 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC287 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=0, channel=0
  PCM:
    rates [0x40]: 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x40]: 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x40]: 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC287 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x3f 0x3f]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x40]: 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x25
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40000000: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 4
     0x02* 0x03 0x06 0x08
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x04a11040: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00013734: IN OUT EAPD Detect
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40600001: [N/A] Modem Line at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x1
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=142
Node 0x21 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x04211020: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x02 0x03*
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x19 0x1a 0x1b 0x1d 0x13
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x19 0x1a 0x1b 0x1d 0x12
Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x12* 0x13 0x18
Node 0x25 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x12* 0x13
