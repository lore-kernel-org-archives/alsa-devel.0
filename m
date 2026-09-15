Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF38C88E5C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:32:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48CA660299;
	Wed, 16 Sep 2026 08:32:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48CA660299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540336;
	bh=AlsR6h0vKGLwhIkQD66g6AVWzcXn4xX+r9fA5W6cfCI=;
	h=Date:From:To:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UYfou+ja7ev/W5IyHgED2JhM4pEVft8ZnxGPrTC/RSnG8AGaxlybLaVTF2gCDuPjv
	 VrWkB3XSkufWOPlLDKtFr3spgQsAfLsf4oUwMF7vzuFNFGEB57bGVIS4s5R+N4FZnK
	 6UtjfPeu8jOZnxyzLoMVm7gPsHEg/B3AFCTqZX8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 685F7F8077B; Wed, 16 Sep 2026 08:29:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58403F80787;
	Wed, 16 Sep 2026 08:29:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E219F80588; Tue, 15 Sep 2026 14:10:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789474199;
	b=pQ9ZIEsM2w6TSq2XERBJ49eybmsu8XgEeCiGGlNwRFBjhhKd8STgJBllioedogWAOigI
	 o+ObVAZtbws5mU3i0zSWk8OkLB2kx6enfYtZv6a7GR0exU1Mq5AMYWObNXo7wiMj9Wg3f
	 UdIJ2t6UCWYiH9l/Hx96ic8vMQ9isLB3TQmdpcVxKfYAUtn8DyEVtWt5UB/VljL9vyETI
	 /v6q/0mqUk9fJyLruLWsd7EgFSbT+XI7T1FDrKe6YIBG5R1BiFRpalT6EnghkZx+035+r
	 MYT01lCm+X/MVcIa29YipnkY6k9x6xKnSCjnp77XPpMW1u9KNM+2Lrniyv4zFBf+O7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789474199;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=gF6d+5nWY90og3Q7V6zZ/k3Ztzmbow9ZnAMw7MAWQDs=;
	b=RhXI9pLj5wP5oaawK0N1ZxNU8eyLe1DgFMVqHAOkMjApdTfNx0Znn3Vy9tpOKiIcDxiD
	 QE8PlxFKyLGJQhvnaaxIZUvYwLqJv+RI72YS24YncHxVi3a6HpddobhWFjN1YjM19moKM
	 3ljlfEHMm57VsOj91Md6liTAmsNtQByApBIHMqsugXeRxcxu4+jSH6oHbVcbaW1TKZwxf
	 t0Ig8zLX4dWsCFPh+jLrE8fO+JbUErir9xEk9xE57lxKmPlOBHuOcWv7pmfkXe6Ot9Es+
	 /XSlovfqD1lXI4FJHBKxdeGzvddz47kSt7r5i2btEvuWQJltsF4E89kGf8p+yn++f7w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=haering.me header.i=@haering.me header.a=rsa-sha256
 header.s=MBO0001 header.b=n9zGMdHz;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A6962F80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 14:09:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6962F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=haering.me header.i=@haering.me header.a=rsa-sha256
 header.s=MBO0001 header.b=n9zGMdHz
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hkgnF75Y3zKp22;
	Tue, 15 Sep 2026 14:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haering.me; s=MBO0001;
	t=1789474194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GXVlF5fc0vGP0e7E8YmYjpIrL0zikSInwRubEWb49vs=;
	b=n9zGMdHzKkVesKbAfZjPUi6+of/VDP4UGST83kmqbYlRsqiRSe3t81LqbE4TjUS9+8Yfll
	DH3TdrxLRJ3k7jOWZXDybazlFXzS4Mr4I0K5k0CqG2OKcTfkxLMRt4FeG/65eqa3Dg+lG7
	0zGafeMBC5JaxbGkCquq/8q11QYDnhfMY3TIpIEwpR1Fchcug0hPrTUn4Y0IJhOMmOPxla
	IaLRjxbQga/8DbB7yJW4prBs+/4FMcdkFTSiP+IdcHwSBFjse6rrDfoFGo9mSjeRDl7vvr
	J73Ce4B4SjWh1DJpalHGfmQq2McDc0PCkBuvaGgqL+q0FVD5UMl4AJpfGQVS+w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of alsa-project@haering.me designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=alsa-project@haering.me
Date: Tue, 15 Sep 2026 14:09:51 +0200
From: Marlo <alsa-project@haering.me>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: "tiwai@suse.de" <tiwai@suse.de>
Subject: =?US-ASCII?Q?Conexant_SN6140=3A_ThinkPad_E14_?=
 =?US-ASCII?Q?Gen_8_=2817aa=3A513e=29_-_PCM_stream_?=
 =?US-ASCII?Q?RUNNING_at_correct_rate_but_an?=
 =?US-ASCII?Q?alog_outputs_silent=2C_HDMI_works?=
Message-ID: <38B8FF75-CF35-4EDA-87D4-99FABC272213@haering.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4hkgnF75Y3zKp22
X-MailFrom: alsa-project@haering.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5WGZC5QCFUCVTXRQT7COQLX6ZT5L3SIB
X-Message-ID-Hash: 5WGZC5QCFUCVTXRQT7COQLX6ZT5L3SIB
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:29:22 +0000
Content-Type: text/plain;
 charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WGZC5QCFUCVTXRQT7COQLX6ZT5L3SIB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello ALSA developers,

I would like to report what appears to be the same class of issue recently discussed for the ThinkPad E16 Gen 4 (thread: "Conexant SN6140: ThinkPad E16 Gen 4 (17aa:513f) has no speaker output, wrong PCI SSID fixup selected", 2026-07-17). My hardware has a different but neighboring subsystem ID (513e instead of 513f), and I have gathered some additional data points that hopefully narrow down the root cause further.

Hardware
--------
Laptop: Lenovo ThinkPad E14 Gen 8
Product: 21Y6000SGE (Machine Type 21Y6)
CPU: Intel Core Ultra (Panther Lake)
Audio controller: Intel HD Audio [8086:e428]
PCI subsystem: 17aa:513e
Codec: Conexant SN6140
Codec-reported Subsystem Id: 0x17aa513e
BIOS: version 1.02 (no newer version available; fwupdmgr reports no update for System Firmware)

Software
--------
Distribution: Fedora 44
Kernel: 7.2.5-200.fc44.x86_64
PipeWire: 1.6.8

Problem
-------
Both analog outputs are completely silent:
- Internal speakers (pin 0x17)
- 3.5mm headphone jack on the laptop itself (pin 0x16)

The following DO work correctly:
- USB-C connected earbuds (separate USB audio device, as expected)
- A headphone plugged into an external HDMI monitor (digital HDMI audio path of the same Intel controller)

This suggests the issue affects the entire analog output section of the codec specifically, while the digital HDMI path on the same chip works fine.

During boot:

snd_hda_codec_conexant hdaudioC0D0: SN6140: BIOS auto-probing.
snd_hda_codec_conexant hdaudioC0D0: SN6140: picked fixup for PCI SSID 17aa:0000

Same symptom as the E16 Gen 4 report: the driver falls back to PCI SSID 17aa:0000 instead of the actual Lenovo subsystem ID (17aa:513e in my case).

Mixer / pin state
------------------
Master: 88% (unmuted)
Speaker: 100% (unmuted), both channels
Auto-Mute Mode: Disabled

Node 0x17 [Pin Complex] (speaker):
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD enabled
  Pin Default 0x91170110: [Fixed] Speaker at Int Rear

Node 0x11 [Audio Output] (Speaker DAC):
  Speaker Playback Volume / Switch both present, unmuted

GPIO block (from /proc/asound/card0/codec#0):
  GPIO: io=5, o=0, i=0, unsolicited=1, wake=1
  IO[0..4]: all enable=0, dir=0, data=0

Stream-level confirmation (the key new data point)
---------------------------------------------------
With PipeWire/WirePlumber stopped, running speaker-test directly against plughw:0,0 while inspecting the kernel PCM state twice, 1 second apart:

cat /proc/asound/card0/pcm0p/sub0/status:
  1st read: state RUNNING, hw_ptr = 144336
  2nd read (+1s): state RUNNING, hw_ptr = 192616

That is a delta of 48280 samples in ~1 second, matching the configured 48000 Hz rate almost exactly. hw_params for this stream:
  access: RW_INTERLEAVED, format: S16_LE, channels: 2, rate: 48000, period_size: 12000, buffer_size: 48000

So the PCM stream is correctly opened, configured, and demonstrably running at the correct real-time rate at the kernel/ALSA level - audio data is being delivered to the codec continuously and on time - yet no sound comes out of either analog output. This rules out any PipeWire/ALSA-lib/stream-configuration/timing issue and narrows the problem down firmly to the codec's analog output stage itself (DAC->amp->pin), consistent with the GPIO block being entirely unconfigured (all 5 GPIO pins disabled) as noted above.

Tests already performed without success
----------------------------------------
- normal snd_hda_intel path (current default)
- cold boot / full shutdown+restart cycle
- checked for a newer BIOS (none available)

I have not yet tried aliasing via the model option with an existing quirk entry's $VENDOR:$DEVICE string as Takashi suggested in the E16 Gen 4 thread - happy to test that or any other patches/instrumentation if pointed in the right direction.

Full diagnostic report (alsa-info.sh):
https://alsa-project.org/db/?f=5f8598a774edfeba0d09022c694a0014e3022bfc

Thank you very much for your work, and please let me know what further information or testing would help.

Best regards,
Marlo
