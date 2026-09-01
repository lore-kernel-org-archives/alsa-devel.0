Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8AC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:36:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F321060205;
	Tue,  8 Sep 2026 20:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F321060205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892553;
	bh=KWS0qVrGpOsvoNy7qxR7gT9hQp3vkI+YvKFFNlJfdf8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=k4pVcxYnVDHAttQYhKdGSY5zzGla1mTvnAYwzs9/iso0DzJpOLZufbfGlr5J5M1eY
	 8JFru76KGbPoHFGB+0yJTtx6Tn0KyOqFEmfg2D/2ud3nDgvxNmNxfYX+V79SE+9AYG
	 Q/EDTMm5uQxzEKv+HqkUm8fBWfMBCwARZP7AZQBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C42BF805F9; Tue,  8 Sep 2026 20:35:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D65FDF80600;
	Tue,  8 Sep 2026 20:35:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D609FF805B2; Tue,  1 Sep 2026 11:07:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788253631;
	b=E6xg0/CVas+WvOPCZPwnOMEt5ZLZd+5E3oclAsT68BEQubKK9DORap6nu5CJnqF//tvh
	 7IIbtxpsLR2LCwPg1cnqn5FSTMNvROT6f27deJbfHUztN/1nQmgo63COMfWnh4o2ouv5b
	 gY7xsX92rPa6Rh2JaPsZdLq/gjIgFfGTvp8qRnWRPD3mOTSPpHC1xre4/GffmLITjQvFX
	 803qcMrdAjglVPysOM5NHVWlu/DqON1401mT9haN26eIYZxMxhxVYydoDlg+YbT53G7Tx
	 rPb5riH6QwOxSl40iZzL9oPFNiU1qb8pKYLeQq3v5rRhS6pXH8r+wIGwDhXW36/K+1g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788253631;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KWS0qVrGpOsvoNy7qxR7gT9hQp3vkI+YvKFFNlJfdf8=;
	b=cOmw07oiTPUNaY8OJ3EBMCeIZaHx/f1rgGS8hoDHal1yHh6kNIRBeS5ZnEv5HzzALDlE
	 wajv+a2JmU5vhiETirnnRzrT3mgfyRXD8Qy3OjkfimoX081KaI6FlByy9ohqPC3kerQQw
	 Qbi1p93mn9t7qiSDaRM7zgrrZlbxoAaVCrGddlCG+QAX9xgz9zPl6nSuursNjl5mwoTnj
	 s9wTmqV9hfo04qpuYe3ir8YAazh9Oi3I5IQxABbfetQc0vemUUZSmoY8y+jcsu5DrwOjM
	 cyRW+07iKeucmVI+JIEKq52JpZUSEnrNR35ab741yIHcYa/SGrZTriECia7fKGcN3Rw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=elKMSKcQ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 288A0F80071
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 11:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 288A0F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=elKMSKcQ
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-482fc3327fdso415284f8f.2
        for <alsa-devel@alsa-project.org>;
 Tue, 01 Sep 2026 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788253627; x=1788858427;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6JVpdNX+i8hXfN4+EjgY57DVGT9gcshxSwIwwCoROE=;
        b=elKMSKcQbu+UgWuyTBpcVH5NtWh6EzBnf7cCdFrnGG59d0hCCg0BJ8szEmZZzDBlWx
         fU3c045aR2Lb+oEBVscU3OWXyMUQCPd/rlYzf8ZPh++PfyaNnjX1WmLEM0+3jSimvOsR
         nlgfa5X4wCeouQmXqPQ0q3PGvqOW0quyogKv15Ld6fmuve80RgWbg2PHVymIq9q52lf0
         iRH9ZqRDJDliRG7XvurDoGHfjMmWwLqHRk659ttRcMCtA+lPZaXsiNsDkY5SRfiEqcBd
         SJ6RhgtrrxyqS3TxZmR1UnaKDHuEqC4pO70tH+A/PZmvtHdaUbXHXh+KT87hDSCS9Dgb
         bUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253627; x=1788858427;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6JVpdNX+i8hXfN4+EjgY57DVGT9gcshxSwIwwCoROE=;
        b=LVvQfznQ4rGTj2hHHg2CgrIPH1DfJz5nlQ59s9P4JhFVrPUnq5q5cp3tGaYeRFVRW1
         wpDSaP714gLseu1oVrbsO+4knCTexnVzYYbbgNYb77EdUhE+X0hyJAh2cWE8kine0Nqg
         YGFXPsuFBVgxRJHiUE6kS2W5uACwhee4iPutQCvFul7NbAsapB5CO5vAO7fsVztbDGAX
         GRsmATazOP4/TaNfFEKGcy9TufYBjsZkpm93+kS0blz9Ymmi4iiwQaAdRuxbz5adPFiR
         D45Od+O5GWQgYQGYyQfb532cPbgqQlJh3IxP43N+2qT9iz1Fv2lJrwDJTd5EuV+GwsuE
         l+Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwO4qokZgq8jaNKSq+hko+2BcukJh6Eo9Nw2lnC8QArRAZlEoVuhCTl5klILp8/GZSfyvtZikAIDTt@alsa-project.org
X-Gm-Message-State: AFuF++nZtd6zKlUvM5kXAI0iRD9WKFeRmRMZ5EDGMX/v0Qz9EkuDBc7g
	CT+WMegzfQv2jQH6+Lc/5eIzoh4X+KnAXEvo+uy9P18XHxzwMgDfz/Ld
X-Gm-Gg: AYBFou3XxARWnwWjOcv1SW4GsVq+VjSUQe0swNUIoJ/CJKr2StmeAFBSUJQ0HMIkiGi
	BVrW+7aJwoEHeVoTHECwEp4/2Cp0zdrfGzww2IxKqcQfv3SaA1hjQ8RuQpw8Mkuh9eHtNgHnldk
	iyJji+lsmpJ5b1V4oTGdkkeQcsN9mX3C7WhazVnbWykoqQbHVYHULWNcXAx64JGRcmYPC+b+t2L
	aJ4OKQm4wcCrCxHhDhP2SQRwWZhyetPMdQ4QMT0HRhzyHq7/QQFmgVv/lq52XNFCSkYag5jlbNk
	xoQrynNWcUz+OFvPz/bRrTQO+Ap4hno9d0vvd70SS0lEhR+rupYctBgVMHggWzW4fGAD0gqq2ec
	+ZII81t/QHPHDsgMaPNx/KjkqCJPa9u8bwj4LlAnEW4RG/LXV6OiU4nmRKDipetVidMmSPN7eQd
	2Wy3OFPuW6+Wgpf9wlDJtudga7xLblEcpmNEd/8fAgE23U4ffrfS3KJq111PY1REsbc52NrjL/z
	A6/yl2Vv0OdaUmm
X-Received: by 2002:a05:6000:27c1:b0:482:de48:c445 with SMTP id
 ffacd0b85a97d-482f79b36d4mr46780042f8f.11.1788253626636;
        Tue, 01 Sep 2026 02:07:06 -0700 (PDT)
Received: from cachyos ([41.142.112.134])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6e905sm3124471f8f.23.2026.09.01.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:07:05 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v2 0/4] ALSA: usb: add RME Babyface Pro FS driver
 (proprietary mode)
Date: Tue,  1 Sep 2026 10:06:31 +0100
Message-ID: <20260901090635.9208-1-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IJGUBDV4KTKB2JIM3JVKKJ2A3FHTHCOO
X-Message-ID-Hash: IJGUBDV4KTKB2JIM3JVKKJ2A3FHTHCOO
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJGUBDV4KTKB2JIM3JVKKJ2A3FHTHCOO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Changes since v1:

 - Split into a 4-patch series (core+PCM / mixer / front panel / DSP EQ),
   per Takashi's note that splitting would help review. Each patch builds
   on its own; the control surface in [1/4] is stubbed so the module
   links at every step.
 - Clarified the volume model: the system volume is PipeWire's host-side
   software gain (no hardware write), matching Windows. The only
   in-kernel volume work is the dB TLV metadata and the register-law
   mapping for the non-1 dB hardware steps.
 - Fixed the 32-bit ARM build (undefined refs to __aeabi_ldivmod /
   __aeabi_uldivmod) by switching to div_u64/div_s64/div64_s64 from
   <linux/math64.h>. Reported-by/Closes from the kernel test robot.
 - Added an Assisted-by tag disclosing LLM assistance, per your request.

I'm sending this as an RFC for a driver I've been working on for the
RME Babyface Pro FS in its proprietary USB mode (VID 0x2a39, PID
0x3fc0). In that mode the PCM stream runs on interrupt endpoints
(interface 5, ep 0x01 OUT / 0x82 IN) instead of the class-compliant
isochronous path, so it can't be handled as a quirk on top of
snd-usb-audio. It needs a standalone driver, and I modeled it on
snd-usb-caiaq, which is the existing in-tree precedent for
interrupt-based USB audio streaming. The driver is hardware-validated
on a real unit and the code is checkpatch, sparse and W=1 clean.

The vendor protocol (control requests, register map, front-panel
readback) was reverse-engineered from Windows USB captures and
verified bit by bit on hardware. The capture analysis, the calibrated
laws, and a userspace reference implementation live in the sibling
TuxMix repo (https://github.com/ismail-bahloul/TuxMix). This driver is
the kernel side of that effort.

What's included:

 - Interrupt-URB PCM streaming, full-duplex, 2-12 channels, S24_LE,
   9 sample rates from 32 to 192 kHz across 3 USB bandwidth classes.
 - ALSA mixer: 6 output masters and mutes, the 6x14 crosspoint routing
   matrix, 4 mic/instrument preamp gains with phantom power and PAD,
   pitch/varispeed, loopback, and a few device-specific toggles
   (AN 1>2, input link, MS processor, DIM, width, FX send).
 - Front-panel emulation. The unit has no onboard DSP for its own
   panel, so the host mirrors TotalMix's role: it translates physical
   wheel/button events into mixer writes and exposes the decoded panel
   state as read-only ALSA controls.
 - A hardware 3-band plus low-cut parametric EQ for the 4 analog-input
   strips, computed in fixed-point (no FPU use) and uploaded as
   coefficient blocks.
 - Mixer-state persistence across interface re-probes and system
   suspend/resume, because the firmware has no state readback of its
   own.

Validation: a full-duplex sweep across the whole rate x period matrix
with a signal-integrity tap, start/stop stress (30 cycles), mixer-state
restore across an interface unbind/rebind, and a mid-stream disconnect.
All of that runs through the automated regression suite kept in the
driver's development tree.

Known limitations, stated up front:

 - USB autosuspend is not supported yet. I disable it explicitly
   (usb_disable_autosuspend at probe, balanced at disconnect) rather
   than ship something untested. The front-panel poll and keepalive
   work items run continuously, and nothing pairs usb_autopm_get/put
   around the stream, so an autosuspend request could race a live
   stream. S3 suspend/resume works and is tested. Full autosuspend
   (pausing the panel/keepalive work plus autopm pairing) is a
   follow-up.
 - A few protocol items aren't fully pinned down, but they don't affect
   the shipped controls; the relevant paths are hardware-verified. They
   are documented as open in PROTOCOL.md: the preamp readback index
   semantics (0x003F vs 0x0000), a width strip-ownership edge case, and
   the exact high-frequency warping of the EQ coefficient computation
   versus TotalMix's curve.
 - The latency profile is selected at load time via the frames_per_urb
   and nurbs module params. Default is 256 frames/URB, matching
   TotalMix's 256-sample buffer; frames_per_urb=16 nurbs=16 gives a
   0.33 ms monitoring-grade floor. Changing profile currently means a
   module reload. A runtime reconfiguration (like RME's own Fireface
   USB Settings panel) is a post-merge follow-up.

This is an RFC. I'm mainly after feedback on the interrupt-URB PCM
design, the control naming and topology, the subdirectory layout
(sound/usb/babyfacepro/), and the two-file structure.

Per your note that splitting would help review, I've submitted this as
a 4-patch series instead of one big patch. Each patch builds on its own
(verified in-tree against linux-next):

 - [1/4] core driver + PCM streaming (control surface stubbed)
 - [2/4] the ALSA mixer (masters, crosspoints, gains, flags)
 - [3/4] the front-panel poll + controls
 - [4/4] the hardware DSP EQ

The control surface in [1/4] is stubbed (not shipped as written) purely
so the module links at each step; the final patch lands at the complete
driver. Happy to re-cut the boundaries if you'd prefer a different
granularity.

Disclosure: the reverse-engineering (decoding the Windows USB
captures, magic packets, and the hardware/front-panel behavior) and
the substantial portions of the kernel implementation were written
with heavy assistance from an AI coding assistant (DeepSeek V4 Flash,
credited per patch as Assisted-by). The code was additionally re-
reviewed by a separate AI pass for correctness and security issues.
All of it was then verified by hand on real hardware; the human
author remains responsible for the result via Signed-off-by.

Thanks for reading,
Ismaïl

Ismaïl Bahloul (4):
  ALSA: usb: add RME Babyface Pro FS driver (proprietary mode) — core +
    PCM
  ALSA: usb: babyface-pro: add the mixer control surface
  ALSA: usb: babyface-pro: add the front-panel poll + controls
  ALSA: usb: babyface-pro: add the hardware DSP EQ

 MAINTAINERS                             |    6 +
 sound/usb/Kconfig                       |   18 +
 sound/usb/Makefile                      |    2 +-
 sound/usb/babyfacepro/Makefile          |    2 +
 sound/usb/babyfacepro/babyfacepro-ctl.c | 2853 +++++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c     | 1451 ++++++++++++
 sound/usb/babyfacepro/babyfacepro.h     |  391 ++++
 7 files changed, 4722 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/babyfacepro/Makefile
 create mode 100644 sound/usb/babyfacepro/babyfacepro-ctl.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.h

-- 
2.55.0

