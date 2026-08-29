Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4427C61DE1
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:17:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 276EC601E5;
	Sun, 30 Aug 2026 20:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 276EC601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788113846;
	bh=ZJlPTeTkTl84V1BFFYQh/dfDP2K84VCKo6miLZPZcR8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=S0gDbOFxczWceSdmCgfk18f4Q0Hrcj/YYSdOnJVfpjQj6g2Rbp09BUoxNW6k/LCxR
	 dk+X3yIU0l6tU/mBhIanQPQwxuP1VDZcqMq1gg/XeI5WhnJfZE882XbvuwWAX9elx5
	 ci9znYs5e82r9KmBI2OuNk66At1kKFhWBeeEqySI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A9EBF805F1; Sun, 30 Aug 2026 20:16:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3110F805FF;
	Sun, 30 Aug 2026 20:16:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 615CCF80272; Sat, 29 Aug 2026 12:03:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787997823;
	b=FqTBpG8bCitH4ENmKxSoTNdC4aq3DqtHVQ1CHD/oJ3H/F11zfbQGwVgxoTZkS1WTTRsT
	 /wdDePKtCu1Meelpv4yAAUyF8bwxuenLAg+UEHe/3HVbIWnRO6CCV5PBeYffASTmlIa9p
	 2h1uSNLPri3guD+am9Y0ooaKxyMzXubsHIRrLvy8AG8SL7dAjmmQgEi18uciJAiV2SWmq
	 oKnj6CH6SmfABtQuwCSDuI7NhmwJ04Gapu33FK9trlYIeVDtzvxueI32dHMnpgTNv+O7p
	 b1qHkO0n/VMFak9yuotaFXaK+J/RdAJD4KffVc3pmtgASTOCk/ivAZGbX5YWTYBaLQA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787997823;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZJlPTeTkTl84V1BFFYQh/dfDP2K84VCKo6miLZPZcR8=;
	b=VQPbY521Ww6C8wGaKyFoDGgR7gyjHtaYRRMd4jcGaj+HtPv8GsLxIGcRibiIeCOkov1w
	 WK/RaSirDQ+9/ph8wAEbRSL9jnlAE+FEawDEmN6ikIcukTdNgOhfojAdEF/qENPIk6q5z
	 O/+Ej9rPtuev/QEkFDdvqKDUliUF1KXBv7lm/T5F6HOmSE26SqeumNKnrmFjSHcWwzJIJ
	 S3nSUS0lAkxVD18lWcYaoUYhnXWpIQE99UTIaVwq4jBtfWepqzJGlo7UeeutMFZB35xtL
	 CzCDvfEGYN6zx+r0N4urSLU8nGkRpJV9QODHQFGLGbV1M6RUpZAAk7F1aM4ZWhxsccg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r3odo6ZN;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56605F80240
	for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2026 12:03:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56605F80240
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r3odo6ZN
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so16426185e9.1
        for <alsa-devel@alsa-project.org>;
 Sat, 29 Aug 2026 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787997821; x=1788602621;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/rWH3ByeNUWPLygXnrE3S/P4geWzis3M/3IKa9BnQc=;
        b=r3odo6ZNhFJM6Q+ixCuSMrEqkwyO/79JvRwgvB6pZg84AIJws09PHaL0TbwwMMH8t/
         LBJ2/PyWfOVuoekw/xJ8r3et+VGCAclB2Q5QfIhKIkXzbf+BYHvERg717nGzfRidp1ES
         CjqO48SEiGxOheWQVKj/3noFrCnVZAsakH/k8RtnQ6EEO3BLNyilYksXOK1CBGIDm4g7
         BMXqCyJQfOT+5G0WAQ3yXlY6pfEv6GRqpsfHkJQOmAyy++Lokdrq+/OjweO43wEtuWWe
         uLkm7LXrfLz8fXmVxOLCHpxTEfEOG1cQWDY01d3p5ZyZF62CRoLNiD+wZwYn5kIoqSwh
         GZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787997821; x=1788602621;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/rWH3ByeNUWPLygXnrE3S/P4geWzis3M/3IKa9BnQc=;
        b=T41zoBHDSuxqYRyEEaO5ReOjZjwctxg/RLZA9dzZV/9uOqb4mlMmrkqhmvc+ht2xaP
         x+14rqne4hVIfwZAsfs79RXszUUzfJNklT1gUXU+kQ97QCoH9xTEYsusIPd2p4z4wLQG
         LF96GhR8yrnm13vQO4nFx0PZzpD9DuV+xV+PeT6HaN2y9oeoi2WIMTtDW3Das0LEm/jw
         esNCYAcBjDE/S7flwImVU7J6sR03zzi8gAt0qIBhqjYFgTd+8kvboro4hpeap66N/LiB
         CzgulFk0D1+lVsrTBHTfsNfGJVFn6qlHwKC8qX/2B2GYNuwN/KwLHxVEX1CHtpkDZ35M
         nwxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt+ZLsivMAsj5rmQsdiLzNgVnQIyyd1gEXVTg3AarSeFQusAymb1llwDNGzzH8Npt4uBRNwjT/XRww@alsa-project.org
X-Gm-Message-State: AFuF++m6bJiDbfmRP+SjPs+dneAeuGBLh6NmLyFWBAzp6UNKuN4FVx7m
	dJWwq7aRTsiZ0HjQLNta3Bv8DUyw0XBipbWQvFL30jmix2LLM2HWIiPH
X-Gm-Gg: AR+sD12Jj4JHh+jkdPdiWlMVW/ioQ9DjGvlZL4+squ7VVQDQPcdhJralnEZJNF0tkj/
	96cEU+KYllFggyM8nQGfq8mgVPoUxJAQWm8BkEfL+a7FYoVgejAU2xuG0ofpPboBMTm0xSXZx/V
	y8J/BOsqxkUncZpv9oG/3LYWxBQ2CwrXsSnsEJiYqfy+WHWU1jivICmsRgdMefm6LIhec7EECMK
	331PgoNqYo4YF5QcoTuZF2iU0nYKzs+rVRZjrontO2JEHFsV1ihpa/b6HIVTrwbYgYfb0fn+ck6
	xeWOpzE14XlxAWQg7aPbv2oGzdjDrSGLGn6I5YXm5Ans5yddHfWKeyLnn15+7lKXEETtDS6p1fA
	DDHj6mHbzhdvXoWfxpD7XQUuiCeCBLtN3ySSgZ11cOrYGL71W9G/CFqJRilRoihUO2J9arq5Vcf
	QwYa3hzn7VQkr0gSHyvzbDKwcINW6KTBm4mLkU2oEjk6TN9Oz/lTHKqno076WrmxjMHSbnT0ayp
	HCrG0z1XESS00kpX+WS+2GnpKOd
X-Received: by 2002:a05:600c:c4a7:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49cca26ceeemr79124365e9.0.1787997821309;
        Sat, 29 Aug 2026 03:03:41 -0700 (PDT)
Received: from cachyos ([105.158.202.217])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cca1ed292sm66211735e9.8.2026.08.29.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:03:40 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH 0/1] RME Babyface Pro FS driver (proprietary mode)
Date: Sat, 29 Aug 2026 11:03:32 +0100
Message-ID: <20260829100333.32933-1-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PTFEKLGBJ7DOGOFPIVJLQLBH52PHILDH
X-Message-ID-Hash: PTFEKLGBJ7DOGOFPIVJLQLBH52PHILDH
X-Mailman-Approved-At: Sun, 30 Aug 2026 18:16:45 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PTFEKLGBJ7DOGOFPIVJLQLBH52PHILDH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

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
design, the control naming and topology, the two-file split, and
whether a subdirectory (sound/usb/babyfacepro/) is the right layout.
I sent it as a single patch (4651 lines, 7 files) because that's how a
wholesale new-driver addition is usually submitted, but I can split it
into a series if that's preferred.

Thanks for reading,
Ismaïl

Ismaïl Bahloul (1):
  ALSA: usb: add RME Babyface Pro FS driver (proprietary mode)

 MAINTAINERS                             |    6 +
 sound/usb/Kconfig                       |   18 +
 sound/usb/Makefile                      |    2 +-
 sound/usb/babyfacepro/Makefile          |    2 +
 sound/usb/babyfacepro/babyfacepro-ctl.c | 2782 +++++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c     | 1449 ++++++++++++
 sound/usb/babyfacepro/babyfacepro.h     |  391 ++++
 7 files changed, 4649 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/babyfacepro/Makefile
 create mode 100644 sound/usb/babyfacepro/babyfacepro-ctl.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.h

-- 
2.55.0

