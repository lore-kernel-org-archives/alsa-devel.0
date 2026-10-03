Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA34CA5FFF
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:00:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20F9F60239;
	Wed,  7 Oct 2026 09:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20F9F60239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356436;
	bh=xXXZ6NWLJJESwv2K8aL+6XMcWN6EQkW3JGTvSg3+MDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OZee5awaIUEsLdBohveKUPGG2wAlGlHe8+yveUliunKf+lvijVGMzB6s4EE77yXlA
	 Y86by1uw+3mx3RB4vpnmV/JlSnjzqhN1XJWjazQIZ+1BuLZOt+wlvC8WkLnocqdJI+
	 hxLPh69ZMJrFCYitmoWBRpNYB/ukwdkfWMi8Y8fc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9BE1F80622; Wed,  7 Oct 2026 08:58:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85D4FF806FC;
	Wed,  7 Oct 2026 08:58:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2829F805B3; Sat,  3 Oct 2026 21:42:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791056535;
	b=rhAFSVBojbTGNGkfhfRoDo8qRd5jSglJfYHutAVLDlf1wuVXJ58gJeZ5xag92bIubgfl
	 /iXqjuc6uIafr4dPHBKB+gnebmmKKf68brLsO0fbJfeyGeZZBqTJFkFeI9PKJl94uWQjM
	 +34665m0C3Zzfx/Whl9qDiWoUeEKnr0hgI3lpv9owXUrGbd/NerRVmYEZm0u0exKZlwkM
	 gHkNmwVW0hlzgb2/1Fz05N9d1Dgo0hg9qt0R/VVdEMvKGbwlImynLbShRHn5Udt5rYAz4
	 PYVd6qlPo+wIASbxbLSUZIE0s+fju6NxZ4h+/ZBX8X9WpCEOSGmkoecNg7EmmYWcfYg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791056535;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xXXZ6NWLJJESwv2K8aL+6XMcWN6EQkW3JGTvSg3+MDQ=;
	b=klhiSVw6L4uPzZW13vMkNwu3OhoIbmmLfvVgQ6VHv2yQnEUj4SeK6QhMxAngzHj/9gjH
	 30Sbr2DgI2ji28a89oqSdPyjIrWt7bwauUFU/kzSmTLhmw1mn8PKGjowwqvqtYlPORGpU
	 /3/Qvlyx4sPC2Jbjj6C4e7Ka2UJXB6kpQzsrctw1f94Sa4TYnBeiKPCKSUc2wjD59I/it
	 gc2OzBbuP6zOujBse4q1uKQneZPoi21vP/3+XUBUk5JF3mphT1xveKoyTPCNikJrEmT5m
	 YT37nLpzza98rBSGo65UoXAvchZpsR5XiklRVzUyT4vOIcd01Lc6ulpqcDOF3TSlNiw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LlsxrsuT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89488F805B3
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 21:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89488F805B3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LlsxrsuT
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so7100175e9.2
        for <alsa-devel@alsa-project.org>;
 Sat, 03 Oct 2026 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056533; x=1791661333;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kB9tQNM9jVA0zwBEF2raZG5TXDEsEQ5Rdtidet5PxWE=;
        b=LlsxrsuTBsvDKqLv3p5aJ9zyauFKVTyNcumKeTL8DhAXO+VUYJwyht/ZeOxVGKx2PD
         +HtLc66XlmEi3+Mh1cEIqWaWRlJMGN1lxTDISTqctVgzQjQfr/TVdkT/WYQ3iFHYNRWy
         HNe38VDdbit71Yy9bvcIX/WeMg8Shaddi0Id0mhmdOq5MZJWEEIzUl6aH7ljQvYETfmU
         vAIJ6RS/ezlxmrIPrLtSP8gjTX2OaGM0V4k2ePA4Ck37tuNNH29spTIWVQ/raJMEGFVa
         l7JMIC80zzTl6a3Moe9dfxY16KI187R9kFmzg5M7o7sw9AgUH1Wr89u+FuuFLCG/kCn7
         nHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056533; x=1791661333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kB9tQNM9jVA0zwBEF2raZG5TXDEsEQ5Rdtidet5PxWE=;
        b=X7lQteT50l+t1Dc+auC85k8zkW01cQZ1Xf9IBn0fYaGFTp8suxUpjpYpBeIbMJ4t6G
         MFVVeyF5JXdfG+DFhyqCvrRbsl0Hs4W/dHNqwnD8vTwMnS41o8im8gFgR0qVv4pRdT9r
         O+Ju1NZmRF/Lr70Z9mkDzcmkrFiZ4yNzAwtu2hXnwXJbn+raO5braXBoEjycrQfzuTDn
         ii2Xkb7rlSi/FhRDjVrPnuWFioNUlzk79C3M+ezKJY2t4F3z7hDYr+KpmdFjm844GEF+
         3yfrWIb8/ttNwBF3BsZpK46amUHBvmUSDMvBlD1JjS2kTdv7DDCLBW7WfsJDchm163gC
         gvew==
X-Forwarded-Encrypted: i=1;
 AKwUvBywlM2871d2Az/uv1/T+vdPNFojol6qeIay8B0L6EBSWcUWYlZVM3c6fL8IrAsLQSoBFGv5QYbamtQd@alsa-project.org
X-Gm-Message-State: AFuF++mAs5iHkjBv0EJ33G7CFYleduEwTBIa5Crb1h7R6q5JGL7KrUz/
	7EBZPqgLgx8xjJLjQbPd1qMdT7jJqOdIT+OkOZVm/iUTLOw6eauofry8
X-Gm-Gg: AYBFou0CRnqxAnzGPW1E313Gu1JnPeVqi5RE00G+/IDNc4inpKDV1QfDafuEqihYXZY
	fkz+ORsavDcsH/RvBzcRxKIXHPG3nBtc8W6LGBXw2VmX7EMjJn7w/Ybx1II+ESyJgL8B/rMy9Zj
	BH4A5avlKlGeu1ICH7PlbuNiHz0qyzgYRNK85U+UmagLtpmq+76hU8u6gBpJWHuAOlXH7iNebff
	z3BfNkKag0iAvYBH5Ho7VqYT7/U0zVW66J04a1WbMmjF9GqYIOzDbEaPCsm3awd0nWOpiJ0vfSk
	I0lSpgHu7egR6O8jUy62RyNz7K85uSS2PwnFCi+jy0n97M3moNH7BY62ZQsyeZV9d1wIFvZ5U6I
	KbpnxvMNqiroMDq1x7WmR61Ls26uS0aRHXPzMkCcquoN/XST/Jw5d3YhvjLtW9NvZTYLr8MiVrU
	j3nK+Uh6nJv64Cff+dgKHyrXLFr+xU266FVkDU0LkGRuBeKDXTgHmdgcfE9J5jzjDuu3oO0HEZb
	Yb0jxICwhUknPZk5jYJURV6iajrALumAZOZP2rexHMptbG9NCKy4AF6b1s8stsjxAWh7vip2Yel
	/mguA7lrtHLz5Q2shKE9cOna
X-Received: by 2002:a05:600c:3509:b0:4a1:69c0:a1f7 with SMTP id
 5b1f17b1804b1-4a169c0a338mr37718025e9.34.1791056533488;
        Sat, 03 Oct 2026 12:42:13 -0700 (PDT)
Received: from cachyos.home
 (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a162e867e8sm161520495e9.15.2026.10.03.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:42:13 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v6 8/8] Documentation: sound: add the Babyface Pro
 proprietary-mode design doc
Date: Sat,  3 Oct 2026 21:41:37 +0200
Message-ID: <20261003194137.86176-9-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003194137.86176-1-i.bahloul01@gmail.com>
References: <20261003194137.86176-1-i.bahloul01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WLDAMZMJ4LK3JUJI427WIVDRNZFMKPGD
X-Message-ID-Hash: WLDAMZMJ4LK3JUJI427WIVDRNZFMKPGD
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:57:58 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLDAMZMJ4LK3JUJI427WIVDRNZFMKPGD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A big-picture companion to the patch series, for human reviewers:
why the proprietary mode needs a standalone driver instead of a
snd-usb-audio quirk, the vendor protocol's write-only/no-readback
shape and what that forces onto the driver, the stream session
model, why the mixer state has to be cached and replayed, and why
the driver has to emulate TotalMix's own role for the front panel.

Requested by Takashi Iwai's v4 review: documentation for reviewers,
not restating what the code comments already say inline.

Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 Documentation/sound/cards/babyface-pro.rst | 193 +++++++++++++++++++++
 Documentation/sound/cards/index.rst        |   1 +
 2 files changed, 194 insertions(+)
 create mode 100644 Documentation/sound/cards/babyface-pro.rst

diff --git a/Documentation/sound/cards/babyface-pro.rst b/Documentation/sound/cards/babyface-pro.rst
new file mode 100644
index 000000000..f75b80886
--- /dev/null
+++ b/Documentation/sound/cards/babyface-pro.rst
@@ -0,0 +1,193 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+RME Babyface Pro / Pro FS (snd-usb-babyface-pro)
+=================================================
+
+This document describes the design of the ``snd-usb-babyface-pro``
+driver - what problem the driver solves, why it is a standalone
+driver instead of a snd-usb-audio quirk, and the four design
+decisions (protocol shape, stream model, mixer-state persistence,
+front-panel emulation) that shape most of the code.
+
+Two USB personalities, one device
+==================================
+
+The RME Babyface Pro and Babyface Pro FS present two different USB
+configurations depending on a physical/firmware switch: a
+class-compliant one, already handled by ``snd-usb-audio``, and a
+proprietary one (USB ID ``2a39:3fc0``) that this driver covers.  The
+two hardware models share the same USB ID, ``bcdDevice`` and
+``iProduct`` string shape; nothing in the descriptors tells them
+apart, and the driver runs unmodified on both.
+
+In proprietary mode, interface 5 carries the PCM stream on two
+INTERRUPT endpoints (``0x01`` OUT, ``0x82`` IN) instead of the
+isochronous endpoints the USB Audio Class specifies.  Isochronous
+transfers are rejected there with ``-EINVAL``.  ``snd-usb-audio`` has
+no interrupt-PCM transport, so this mode cannot be a quirk on top of
+it; the driver is standalone, modelled on ``snd-usb-caiaq`` (another
+interrupt-streaming RME/NI-style device).
+
+Why interrupt endpoints and not isochronous is a hardware/firmware
+choice on RME's side, not something this driver can change - the
+class-compliant mode already exists on the same device for users who
+want a fully standard, quirk-free path with a subset of the
+functionality (no mixer, no front panel).  This driver is for users
+who want the full mixer, routing matrix, and hardware DSP EQ that
+only the proprietary mode exposes.
+
+The vendor protocol: writes only, no readback
+==============================================
+
+Every mixer and clock function is one of a handful of USB vendor
+control requests (``bmRequestType 0x40``, i.e. host-to-device,
+vendor, device-recipient), each identified by its request number and
+a 16-bit value/index pair - there is no larger command structure.
+The commonly used ones are:
+
+======  ========================================
+0x10    settings word, rate family, stream trigger
+0x12    16-bit crosspoint and output-master writes
+0x14    stream session arm
+0x16    cold-init register clear
+0x17    front-panel + preamp state (read and write)
+0x1a    8-bit gain / output-master writes
+0x1b    varispeed (DDS quad)
+0x1d    stream session start
+======  ========================================
+
+The full register map, decoded from Windows USB captures and
+cross-checked against hardware, lives in the driver's own development
+repository (not shipped in-tree) - the constants and the comments
+next to each vendor write in the source are the authoritative
+in-tree reference.
+
+The one property that shapes the rest of the driver: **almost nothing
+here can be read back**.  The 0x17 request returns the front-panel
+and preamp state, but the crosspoint matrix, the output masters, the
+routing flags and the clock all have to be tracked host-side - the
+device will accept a write blindly and never confirm what it actually
+holds.  Two consequences follow directly from this:
+
+* The ``struct snd_usb_babyface`` device state (see
+  ``babyfacepro.h``) is not a cache in the usual sense of "avoid a
+  slow read" - it is the *only* record of what the hardware should
+  currently hold.  Every mixer control's ``.get`` callback reads this
+  state directly; none of them ever talks to the device.
+
+* A full reset of the device's registers - which the cold init at
+  probe and at resume does - has to be followed by replaying the
+  *entire* cached state back, in the right order, or the card comes
+  back silent or at the wrong levels.  This is what
+  ``babyface_restore_state()`` and ``bf_state_apply_flags()`` do (see
+  "Mixer-state persistence" below).
+
+The stream model
+================
+
+Playback and capture share one physical stream: the device only
+advances it while both interrupt endpoints have a pending URB, so the
+IN and OUT URBs are always submitted as a pair, and both directions run
+at one sample rate.  The driver runs one stream *session* for both
+substreams:
+
+* ``hw_params`` counts a substream as a user of the session;
+* ``prepare`` starts the session if it is not running - the rate write,
+  the session trigger pair, the IN/OUT URBs, then the arm - which is
+  what the RME Windows driver sends at a stream start;
+* trigger START/STOP only decides whether the URB handlers move that
+  substream's audio.  The URBs keep running either way, carrying
+  silence while nothing plays, so an xrun restart does not restart the
+  session;
+* ``hw_free`` drops the user, and the last one stops the session.
+
+The device keeps its mixer registers between sessions, so a session
+start writes no mixer state.  A session triggered within about 15 ms of
+the previous one stopping comes up with the outputs silent, so a
+session start waits until 50 ms have passed since the last stop.
+
+Both directions share one clock, so while another application has the
+other direction set up, the rate belongs to it: ``open()`` offers that
+rate alone, and the sound server resamples, rather than the device
+changing rate under a running stream - as with RME's own drivers, which
+grey the sample rate out while a stream runs.  The application that
+holds both directions may change the rate or the buffer size itself, as
+a DAW does from its settings; the direction it left running then stops
+with an xrun and is set up again.
+
+The size of the URBs follows the period the application asks for, so
+the latency follows the application's buffer instead of a fixed queue:
+``hw_params`` splits the period into the fewest URBs of at most
+``frames_per_urb`` frames, each a whole number of the device's IN
+packets, and keeps two periods' worth in flight (at most ``nurbs``).
+The URB handlers copy to and from the ring the core allocates and take
+the application's position from the shared control page, so the ring can
+also be mapped by the application, which JACK requires.
+``runtime->delay`` reports the audio queued in the URBs plus the fixed
+delay of the converters and of the device, per speed, so that an
+application that uses ALSA directly can line up what it records.
+
+URB completions run in interrupt context; the work that needs to sleep
+(stopping the session after repeated URB errors) runs from
+``stream_work``.
+
+Mixer-state persistence across re-probes
+==========================================
+
+A userspace client can claim the proprietary interface directly via
+``usbfs`` (``USBDEVFS_DISCONNECT_CLAIM``) - both PipeWire grabbing the
+device for a sink and the project's own TuxMix userspace daemon do
+this via libusb.  That detaches the kernel driver and the ALSA card
+disappears for the duration; when the client releases the interface,
+the driver re-probes.  The device keeps its register contents across
+this detach, but the cold init the probe runs clears them - so the
+driver saves the in-memory mixer state at ``disconnect()`` and
+restores it at the next ``probe()``, keyed by the device's USB serial
+number (or its sysfs path, if it has no serial) so the same physical
+unit gets its state back across the cycle.  The same state is also
+what a system-suspend resume replays, since the device loses its
+registers across a suspend the same way.
+
+Front-panel emulation: the driver plays TotalMix's role
+==========================================================
+
+The front panel (IN/OUT/SET/MIX/SELECT/DIM buttons, the rotary
+wheel) has no on-device intelligence of its own for turning a wheel
+click into a mixer change - on Windows/Mac, RME's TotalMix
+application polls the same 0x17 status register this driver polls,
+decodes button/wheel deltas, and performs the resulting mixer writes
+itself.  Standalone (no host software) mode exists on the hardware,
+but the proprietary USB mode this driver targets always has a host
+attached, so this driver has to do what TotalMix does: poll 0x17 on
+a delayed work item (``panel_poll_ms`` module parameter, default
+20 ms to match TotalMix's own ~50 Hz), decode the button flash and
+signed wheel delta, and apply the resulting change (an output level
+step, a preamp gain step, a monitoring level step, a phantom toggle)
+exactly like the corresponding ALSA control's ``.put`` would.  A DIM
+press is only counted, for a mixer application to act on.  The
+front-panel ALSA
+controls this driver exposes are the read side of this: a way for
+userspace (WirePlumber, TuxMix) to observe what the physical panel is
+doing, not a way to drive the hardware.
+
+Some panel state - which channel SELECT currently has chosen, for
+instance - is not part of the 0x17 readback at all and exists only on
+the device's own internal state machine, which the driver cannot
+read.  The unit keeps one such selection for each IN pair, across IN
+switches and even across a power cycle; its LEDs stay dark until the
+next SELECT press, which only shows the selection again, and later
+presses step it.  The driver follows the presses and exposes the
+selection of each pair as a "Front Panel Selection" control (index 0
+is Ch 1/2), so that alsactl keeps it across boots like any other
+mixer setting.  It cannot know what the unit holds before it has been
+told once, so a pair starts out unknown, and SET and the wheel then do
+nothing instead of acting on a channel that may not be the lit one;
+setting the control to what the LEDs show for the pair tells it.  A
+re-probe, which does not change the unit, keeps what the driver had,
+and the older values alsactl restores shortly after probe are ignored
+for a pair the driver already knows.  The stored values can be wrong
+only if the selection was changed while the driver was not running
+(the unit used on its own, or with another host).  The relevant code
+comments (``babyface_panel_start()``, the ``panel_select_armed``
+handling in ``bf_panel_tick()``) explain the details.
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index e68bbb13c..31051b7a4 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -12,6 +12,7 @@ Card-Specific Information
    emu10k1-jack
    via82xx-mixer
    audiophile-usb
+   babyface-pro
    mixart
    bt87x
    maya44
-- 
2.56.0

