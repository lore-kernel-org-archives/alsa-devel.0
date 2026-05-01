Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15850CD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:35:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58DCE60213;
	Mon,  4 May 2026 13:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58DCE60213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894528;
	bh=QWBXXwbuDrwOrSYq7WJWVSKkBCHPaQ9kqB9p6dp8hZE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DnG/EDaOltzTARAbVu5I6I5XyH/Yo6OvYIqk/QG64CLZ9hja7/VSUx1tJ8ckV8ja3
	 XRAN8lkdN2uq9qtm4wbU+ltbvDNMV0M0cdq310VbWrxqdri5tYLc0UBcjsH2P93yq0
	 TFUTpazMGTxUH2eK7Px9BTmRk5Yr96U4sNjctPDE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B87F8F80615; Mon,  4 May 2026 13:34:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38E00F80617;
	Mon,  4 May 2026 13:34:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 738B4F8055A; Fri,  1 May 2026 19:56:50 +0200 (CEST)
Received: from mx.brightberry.eu (mx.brightberry.eu [185.229.55.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57F8FF80100
	for <alsa-devel@alsa-project.org>; Fri,  1 May 2026 19:56:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57F8FF80100
Received: from mx.brightberry.eu (localhost [127.0.0.1])
	by mx.brightberry.eu (Proxmox) with ESMTP id 01DBC594A;
	Fri, 01 May 2026 19:56:47 +0200 (CEST)
Received: from bug-report.eml (YST00841.fritz.box [192.168.178.64])
	by mx.brightberry.eu (Proxmox) with ESMTP id D5A3712D1;
	Fri, 01 May 2026 19:56:46 +0200 (CEST)
From: =?UTF-8?q?R=C3=A1mon_van_Raaij?= <ramon@vanraaij.eu>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Shenghao Ding <shenghao-ding@ti.com>
Subject: [BUG] ALSA: hda: snd_hda_scodec_tas2781_i2c: DSP firmware silently
 fails to load at cold boot (Lenovo Yoga Pro 9 16IMH9)
Date: Fri, 01 May 2026 19:56:33 +0200
Message-Id: <20260501175633.bug1-ramon@vanraaij.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: ramon@vanraaij.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KLZ4C5X3FYVQAW6BXMEO7GMV55KMEFXT
X-Message-ID-Hash: KLZ4C5X3FYVQAW6BXMEO7GMV55KMEFXT
X-Mailman-Approved-At: Mon, 04 May 2026 11:34:39 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KLZ4C5X3FYVQAW6BXMEO7GMV55KMEFXT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Machine:  Lenovo Yoga Pro 9 16IMH9 (board SSID 83DN)
Kernel:   7.0.3-zen1-1-zen (linux-zen)
Codec:    Realtek ALC287, subsystem ID 17aa:38d6
Amps:     4x TI TAS2781, ACPI HID TIAS2781, I2C bus i2c-4
          (I2C controller: PCI 0000:00:15.2, Intel Designware)
Fixup:    ALC287_FIXUP_TAS2781_I2C (applied correctly via HDA_CODEC_QUIRK 17aa:38d6)

PROBLEM
-------
At cold boot the built-in speakers produce ~10-15% of normal volume.
The TAS2781 amplifiers are powered and the HDA component bind succeeds:

  snd_hda_codec_alc269 ehdaudio0D0: bound i2c-TIAS2781:00
      (ops tas2781_hda_comp_ops [snd_hda_scodec_tas2781_i2c])

However, the DSP firmware (TAS2XXX38D6.bin) is not loaded. The ALSA
control "Speaker Force Firmware Load" -- which is only registered after
a successful firmware load inside tas2781_hda_comp_bind() -- is absent:

  $ amixer -c sofhdadsp cget name="Speaker Force Firmware Load"
  amixer: Cannot find the given element from control sysdefault:0

No error is logged to dmesg. The driver continues without DSP calibration
data, leaving the amplifiers at uncalibrated default gain.

The issue does NOT occur after S3 suspend/resume. After resume, a
modprobe -r / modprobe cycle restores full speaker volume.

ROOT CAUSE
----------
The BIOS initialises the TAS2781 amps during POST and leaves them in a
hardware state incompatible with the kernel firmware load sequence. The
request_firmware_nowait() call in the bind path silently fails when called
against hardware in this BIOS-initialised state.

Critical observation: a PCI-level power cycle of the I2C controller
(0000:00:15.2) reliably resolves the issue:

  echo 1 > /sys/bus/pci/devices/0000:00:15.2/remove
  sleep 2
  echo 1 > /sys/bus/pci/rescan

After this sequence ACPI gates the I2C controller power rail (D3cold),
resetting the TAS2781 amps to factory state. On rescan, i2c_designware
and snd_hda_scodec_tas2781_i2c re-probe, DSP firmware loads, and
"Speaker Force Firmware Load" appears in amixer.

A plain modprobe -r / modprobe cycle WITHOUT the PCI power cycle does
NOT fix the issue, confirming this is a hardware state problem, not a
module loading or firmware subsystem timing race.

WORKAROUND
----------
The following systemd service (After=sound.target,
Before=display-manager.service) reliably restores correct volume on
every boot. It must run before PipeWire opens the device; hot-removing
the PCI device while WirePlumber has an active ALSA handle causes a
SIGSEGV in snd_hctl_elem_get_interface (libasound).

  [Service]
  Type=oneshot
  ExecStartPre=/bin/sleep 2
  ExecStart=/bin/bash -c 'echo 1 > /sys/bus/pci/devices/0000:00:15.2/remove'
  ExecStart=/bin/sleep 2
  ExecStart=/bin/bash -c 'echo 1 > /sys/bus/pci/rescan'
  ExecStart=/bin/bash -c 'modprobe snd_hda_scodec_tas2781_i2c || true'
  ExecStart=/bin/sleep 5
  RemainAfterExit=yes

SUGGESTED FIX
-------------
The driver should detect a failed firmware load in tas2781_hda_comp_bind()
and either:

  a) Perform a hardware reset sequence on the TAS2781 amps (e.g. via an
     ACPI power state transition on the I2C controller) before retrying, or

  b) Schedule a deferred retry after the firmware subsystem has fully
     settled, with a fallback hardware reset if the retry also fails.

The fix should live in tas2781_hda_comp_bind() or the
request_firmware_nowait() completion callback in
snd_hda_scodec_tas2781_i2c.

Signed-off-by: Rámon van Raaij <ramon@vanraaij.eu>


