Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CEFC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:38:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8FD9601F0;
	Tue,  8 Sep 2026 20:38:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8FD9601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892726;
	bh=QMrav2+9ybfX5GPSz+vybqujK13g3lwndAAEXHSVXdM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=B0MzHr3nnfMs36VdgyLSqn9aA4RxeitEG6lr1SI3NvqNQKE8HuROUO+tYCwxS4fMF
	 QuTX6i/YM12LkSyNijA5kRs1KicegNIPojMXn0cHjaEehK9GBXpA8NyF+pMWHEoNk7
	 7gDZR+CgT0eCFFiUF55av3SffFEtayW81HhCRVyk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FB8AF8080A; Tue,  8 Sep 2026 20:35:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A812F807FC;
	Tue,  8 Sep 2026 20:35:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B624F805C9; Wed,  2 Sep 2026 12:11:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788343892;
	b=qgriiHQ6i8lxG2tyzFN+qZCasbRtjD/UnLRERsz+XbUr6ydJovSi5Bbhc+NV+GCGJSaE
	 JQ3TLUrDWjNuRiqovKqw4S/+DUGnw3Ig2gRi0FBWxtFsiYX2IUCrzoCZzghZ1JYTbKZmk
	 5x8/HJ3A78+kiwVSedQbvFD2A21pMJMJ4+vXaHE0xs6tu5m4Hk8F7FvQ2cUiDDqNAMrpF
	 unbjAe0tKXUyWmqLrLkRPQlA8tcJZFfwdDxboCTNJ9zflk32gZZOKcl/hFNqD+oaPzSw1
	 BRERtREDHkhClk/dLRrqjimClKSQgiXZe4ZbKxCC3UyddJd25LiQv4JqusSJLRQY20w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788343892;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QMrav2+9ybfX5GPSz+vybqujK13g3lwndAAEXHSVXdM=;
	b=D+oKE+yJ5vUtE5VdaU+J9Gy0j9nfQAHGSx7yHFXAUHIMXd55P9YVUMK8QqSCauW0Pe02
	 9rf3l/PsI388DAJga32cX7GP+m4SRHuq0UmLIVPtCERVyn60MH46KZw+JKT6oAS1fvGTX
	 2YrWnhjXAZjKZaJ+Pv+dG12dqW1Oj3YdXajnZRd+BmT36dqGQB+E71EyjRqrwWxe9YuwE
	 9f835xMuHuRqm5taYFO27eSkgTxwaBX7xbYiYiy4d2GTc4+JJJ0lyD0J0Uwr3grPSBbnA
	 u9Pwpao3NtUpU+Hr7JlGW+N8mBX7fYST7psjnmPNPV5uOZcYO3p6OJwnrJGaZolD3XA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BcwDRm4T;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5318FF8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2026 12:11:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5318FF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BcwDRm4T
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so9510415e9.1
        for <alsa-devel@alsa-project.org>;
 Wed, 02 Sep 2026 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788343890; x=1788948690;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91cnZApvNoI+zKze1q0BxdhUppHXuOBLM133qnSfj40=;
        b=BcwDRm4TUY2cdyU+Qhy9McyodQB+eg8LMsqv5kArvLyIiKrbTqySWtfmOZJHLp7jOr
         RwLQOr0OLEVqLx4f072UuksbA6oA7SBqw+Qdi8VqvLph0F8jC25gyuJkUzmgl3KIweto
         kaYlVFxrAttOsk/yqth2h+19cnOIq0tBTagkNzef1iyPIAWSkFshvYrC8DQ0N8ZXANgt
         YEyiIk3ZP0rIDdjLgYAmtNpeX5RbtNcwELbjMH01Jwx/AzLoKNOghTPrdb917W5FzYLl
         qbV3q7gHGILQ223cGJl3fioIC+yN2Zy8KQCkljuzsnwjFMsujChjLV6XsCO9WinwmbS6
         oiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343890; x=1788948690;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91cnZApvNoI+zKze1q0BxdhUppHXuOBLM133qnSfj40=;
        b=lLAXLOOJMEuCYP9JllXo/eqLZavFolQFjsY43n0GXEenyn065WfMLRZI64zL4qAaPd
         6H1m9syDMfW+dk+bLAGsGXXtxxrE+cCvKhA2kuZssVNDItJnmU56oMnv9WEbtOr5pzS2
         stPReKv6xoxszjbC4jOv62y3EHHIIlTOwjcvjln0jaijwfCYN5xdb98oV/HbrXS05ITo
         PdNNyR4ce1VA7Ex2O+k90VpMVrjGWpsqp0DnGwFXXr9aiaW1KPoKlNYARJdsGhxPuAPq
         I27fTYRz2bFzGMFkA6soQHcErCrb9u7cK/N0LXcHSv6VKzXmMAdjCmW1gqEw9n8vPShJ
         XURQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVr+WMxJIj1aHa/FfbHAnFhwDf7EpeC5eB4ls75D+u1hLmBtEA7NuDENIhU21Rd4eor7ozTRo2YCxs@alsa-project.org
X-Gm-Message-State: AFuF++mFR2HU91Uv9FnXO4x3kdeRAdxSovqfHKM5OJITjzch9tsFWE8d
	c3X4MlZCMlgW+FcRzOmqdVJA3TX0CDeGtDrU1wNkFcpXrvj8El1NbSYI
X-Gm-Gg: AR+sD10d6jqLqcnxdIo5zmD2o5oRysVCVGJeCP+SufuRb3b9JtEM41nmZQlRHVz1sv4
	OSyhbQCcW8pQgUVM/B6gBJGeS1xuTa5Fl8NK0bnony+EdWau6JVQrJvROZhblThl6UuuxsoY8Yu
	63fnj1qwu6hbD6Yuv2M2NojUCQFQGdkE9FIAvnVYnCP5WVFfVh2T+3gFKfnG9KU4OnLXTfGB/s4
	IThtr0FWCe7UVMON28CBRmT1EGqcj3L0FeFRe79e6P0UPPffCX7HJdvsQu5WUfZK9a7hMEANCj0
	hvJPhmgUVRtVzHV7D+MZVt/zDoj+ezDP2nsaeo8gfh30CDD7aq/++VOzgbJ5S6KqM71j3YfulBu
	gk1vj7AardIuhOH7R0JchS/3S9DQNH7U4wx5MbuUCcHwkED/VTWuzWeBSfXd+Ut4UBwuJaSEavO
	MAvCF822Ulhk57eTY/+pUWtJ1CKQmKm8FINpfWhRE5RWRA+iqkFGWE/klC4yKfpe1/OmmDD2gNe
	1pbAq3cp1PVTgqc
X-Received: by 2002:a05:600c:6992:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49ce58034admr69502135e9.7.1788343889339;
        Wed, 02 Sep 2026 03:11:29 -0700 (PDT)
Received: from cachyos ([196.77.120.180])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm57294265e9.14.2026.09.02.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:11:28 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v3 0/4] ALSA: usb: add RME Babyface Pro FS driver
 (proprietary mode)
Date: Wed,  2 Sep 2026 11:11:13 +0100
Message-ID: <20260902101117.11671-1-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IU434GAGBFH6RWFLJA5MAHYCSLXUWYCP
X-Message-ID-Hash: IU434GAGBFH6RWFLJA5MAHYCSLXUWYCP
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IU434GAGBFH6RWFLJA5MAHYCSLXUWYCP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Changes since v2 (thanks Takashi for the review):

 - Removed the Reported-by/Closes tags from the commits (they belong on
   follow-up fixes to an applied patch, not a fresh submission).
 - Added the missing SPDX tag to the babyfacepro/Makefile.
 - Converted all comments to plain ASCII (the fancy unicode dashes,
   arrows and separators are gone).
 - Named the control-transfer timeout (BF_CTL_TIMEOUT) instead of the
   magic 1000.
 - Defined the crosspoint L/R register offsets (BF_CROSS_L/R_FIRST/LAST)
   instead of the hard-coded 4..23 loop bounds.
 - Factored the per-transaction flag-cycle write into
   bf_vendor_write_cycle(), used in bf_crosspoint_clear_cross().
 - Switched the PCM format from S24_LE to S32_LE with 24 msbits: the
   device word is copied as-is (24 valid bits left-justified), no byte
   shifting.  A standard, simpler format for user-space.
 - Rewrote the playback-frames clamp comment (the logic is unchanged:
   never read past appl_ptr) and added a big-picture comment above
   babyface_stream_work() explaining the stream_users / stream_work
   model.

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
  ALSA: usb: add RME Babyface Pro FS driver (proprietary mode) - core +
    PCM
  ALSA: usb: babyface-pro: add the mixer control surface
  ALSA: usb: babyface-pro: add the front-panel poll + controls
  ALSA: usb: babyface-pro: add the hardware DSP EQ

 MAINTAINERS                             |    6 +
 sound/usb/Kconfig                       |   18 +
 sound/usb/Makefile                      |    2 +-
 sound/usb/babyfacepro/Makefile          |    3 +
 sound/usb/babyfacepro/babyfacepro-ctl.c | 2853 +++++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c     | 1488 ++++++++++++
 sound/usb/babyfacepro/babyfacepro.h     |  402 ++++
 7 files changed, 4771 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/babyfacepro/Makefile
 create mode 100644 sound/usb/babyfacepro/babyfacepro-ctl.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.h

-- 
2.55.0

