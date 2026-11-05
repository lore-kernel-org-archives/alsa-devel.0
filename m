Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADB606A321
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Ou8D/aTB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srkybBQi
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A82FF60205;
	Mon,  9 Nov 2026 16:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A82FF60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236495;
	bh=8ebHXlK81wawHhBoZlpqed47sf41lilDaH7CY51ueN4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ou8D/aTBtiAc7Sxl1Ws0UnKNpuYxzLwCGF5/EGzpawdzMQQ6H/nF76H+YHeKGYQ82
	 Gf+OzigwDJ45cDxw+o4uMtSEbX9MD2uD9L0e+4QY4iDtIgS8cntBJ3nHpsiI1gnCJs
	 Uyuauj30V5Cw5zsv8YxkwQN1DRz2y3ZpmdpZeVdQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11AF5F806CC; Mon,  9 Nov 2026 15:59:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 621B7F806CD;
	Mon,  9 Nov 2026 15:59:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A43D7F804FF; Thu,  5 Nov 2026 16:16:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793891779;
	b=f5+AAUnREQoL7KC+ApKrPXzrEE32JSA3y8fFnLm5CgghdmseMpfdCV63dmo38CaNBARG
	 uB8mTeIHe2zJC+HlFVlfWf6fBIRmXZN4tuuhcQ355bORQcGpAe57v83+24BLDh2SM5jEx
	 IQhBbhpN9H6nXyuw2VBJ6qGIvWwx/QFFwJudGwamHI2Jl1S5Yg7ELjykYy1W+cxS5zwAl
	 Q3b7IAmJR0NsO0NKCG68KgEbHsOAe0AICX6A2R7mqTLtrZZ2zgpQuPS2grCCmJQsbh8/b
	 7b7e3wHPpnbI6WSmOsBoFefkqhAErTGX9GVFzNw6IxZz8MtBZ8iaVi8O7gRxd5wLdEg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793891779;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8ebHXlK81wawHhBoZlpqed47sf41lilDaH7CY51ueN4=;
	b=b9rlFYuicPTRfTgkPZJ9KqawJri8yP2mmAJmoHDqHFqu/4vBaq1I2MMIpIYn738FKDXL
	 zib7dAMz2uTbslJM+aFS6eVO2a1KNGaGML3+2TrrdAPBoJueIg1wtspnmVw3oskc0U2PY
	 BYfMmaJNB/G1yeA2CvqO/ti6dM1vHGYyPWq3mmAfG4j5Cr+4rr90TNnOYkrKXSRkADVkA
	 ZBSacnj7esYWnXAowih6RLR8/NaX0RdZL9QayVbJpe66f9VeZUKvEnxmaGIci1d3srWsR
	 vOslpCNGIUEDINN7U7mxWfr3OFRuNdmy2hAX8rVZRZy39AwwyHg6Uc0G+kMFqappiRg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=srkybBQi;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6150BF800EE
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:16:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6150BF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=srkybBQi
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so3736120eec.1
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 07:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891776; x=1794496576;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brlEe7n5YmVtP+PzOtmThrNjzY6rvyClkX0L0c5JoWs=;
        b=srkybBQicnOA3EMGCxrzx+owVc8Egk01d4LFlLns0CLwesJIcqMpD9gApbe2LHqcI7
         hIBwCGrXulxB5df/eZWR4CY8mAF08v2QbXQXvNDASxujieymyGxk5WvhG7YA8PuxEZDz
         sxUcudJoJ8EPvMxFtIDJKx6Q+L+RMdlRBtqbe6JKQRVZgUwNqrSeVROCBFhNtG9oAIKj
         sg8TMNvEFSF0G8WZ7WY0PlQWwfxwkflaJFbX+mo+r0VAo5ZWJofwRQ2RdVTb+YbfQ6R5
         wwE5ToNFNDRq7HAg33ebPt7gfYHLnU4Cjw36qUUaSHnipo69gwbXqi/0Q7jBS8tWaxS5
         rxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891776; x=1794496576;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brlEe7n5YmVtP+PzOtmThrNjzY6rvyClkX0L0c5JoWs=;
        b=X3WbbM2C9c8chwDAcX7jrbM3PjFRauNpuKl+kWIeEYpL5ex5ALkqRD5SMyP3fgGn/z
         D1cloDwL4ARltH9FrTswPLC1Bbvu6YjM1FvWjLfTvrEs9jt53LmkUPZTI6ErNq+vOVEm
         pLtjq39KjJJdhifvklwElAJqFMQ7beHxgs4o0ZTAUljB8t1MKZgjqKtP2cGEjx8jIFQw
         8Ir++Gvf+EuUiFpIwa7FhlN0wAkzGaY/rXEqi7Ba0agnl6UMuSF46v1x9daWciM8BHmx
         0qAX+BT/MIgBXMqMF89GleL2E32ruHSSrsgPL2VXZ582uDdYRfUczoC0zQ03LCjJDHyu
         EbXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycVbsqzswA8jTA/Y+40DXGTLkqACdmsJ2xFlk7yygm+Vax3RhL9uDe0uZAVIm7iZVFaJv87l7ZJGRp@alsa-project.org
X-Gm-Message-State: APuU4Z+6D5Sw7URU+VzyHW+E/40Am2lE2T8uLqvX6/Mtv0g6L5+g6pA+
	c9Oh1h+Mhk+Ny3AHd8tw/zqWZVtlNSusA8v4s2V9iTRhBB87K5X4Gwf6
X-Gm-Gg: AYBFou0ODqCgEPKb3R2sbRsuwFwbA/+zwXE2JFY2jC4rrITQv441UWRLUzm5YKYOuHL
	2YDngumbSgsuPyeFxxbB4bPs9emsnxb51MuYp7cbGsmA9US81zTkObsTT4eoaQo/x6YdYnOZYPB
	2WE8xGXZTH21tT6NeF4lpftfjcSrDKMYlltIXyiywOfv8KdHRXo4QNmzOUpS5veqlwcC8vu2kG2
	PqQ36Hs3xJt1dl6uXX/j7J5RMGEX4JOese+okR1ECeenoCBPOXps3pm5pwrxnQn4tOchiJrJkvC
	K1VdBxjZiO7al9MvQFdd7rZnb0dlVd1c0QoCYhaQ2bJvbKlG4aUwW+YvodYODmuk764aULdTZpa
	R7WQptkgW6gC402UcWCvvhzlf0c4VWOPDC66kodA9uwSzfMrgxrVgO2II+0oaJry3orRzWXL9Kt
	KS2U3rQm3b6EzCDPIvTHhqKdgSmjBfB6+CwOmxeu3wgFK6Amale72ss5Pt32sGQaUKcuf5w1MDZ
	9eQbbHxxl0sTqM6sfLphXkEWm3CbZpuSx75rWtI2yUH369C1WzjHU3RtJrKBCUTmGlb7hW1NxwK
	2SIvclhRT0pBculIxvsGhmYvJBjEYUeUBpx9tN44TF+JrG7nh3SeT5/JAze1ylniXiwnkPTgeiz
	BSAlOxsN0mnE7BMLiOw1yHf6mC8xAnP/zpcUEglTJTZNOqUS9
X-Received: by 2002:a05:7301:4306:b0:369:44b3:99c0 with SMTP id
 5a478bee46e88-36a42340c9bmr27998581eec.8.1793891775413;
        Thu, 05 Nov 2026 07:16:15 -0800 (PST)
Received: from cachyos (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm21567087eec.7.2026.11.05.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:16:14 -0800 (PST)
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
Subject: [PATCH v8 0/8] ALSA: usb: add RME Babyface Pro driver (proprietary
 mode)
Date: Thu,  5 Nov 2026 16:15:45 +0100
Message-ID: <20261105151553.223722-1-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TAVUMF65XFAOP7JXTD5OM3UNAF2SR2FE
X-Message-ID-Hash: TAVUMF65XFAOP7JXTD5OM3UNAF2SR2FE
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:25 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TAVUMF65XFAOP7JXTD5OM3UNAF2SR2FE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi Takashi,

This is v8 of the RME Babyface Pro proprietary-mode driver.  The split
is unchanged from v5: a minimal core first, the mixer added piece by
piece, suspend/resume near the end, the front panel and the DSP EQ
last, and a design document.  The series is still based on
next-20261026, so this is a fix round, not a rebase.  It answers your
reply to v7: your three points are the first item below, and what I
did with the Sashiko findings is the second.

This is not an RFC.  Apart from the stereo split one, which a user
reported from USB captures of the vendor software, every point below
is a fix to a defect found in review of v7, or a change you asked for.
None of them changes the protocol or the control layout.

Changes since v7:

 - Your comments on v7.  The mutexes, the spinlocks, the RCU read
   sides and the PCM stream locks use guard(), scoped_guard() and
   guard(rcu) in place of paired lock and unlock calls with goto
   labels, so the driver has no manual lock handling left.  Each
   critical section covers the same code as before, and the places that
   used to jump to an unlock label now return.  The per-channel loops
   in babyface_capture_copy() and babyface_playback_copy() are one
   memcpy() of the words the frame and the stream have in common, and a
   memset() of the rest: the words are S32_LE with 24 msbits on both
   sides, so they go over as they are.  bf_seen_before() keeps the last
   eight units it saw in a fixed table (patch 6) instead of a list that
   grew with every unit; a unit pushed out by eight newer ones is taken
   for a first probe again.

 - Sashiko.  I went through its findings on v7 again.  The ones that
   hold are fixed in the items below.  Two I left alone: the control
   names, which stay as they are (see patch 3), and the module
   parameters it wants in kernel-parameters.txt, which documents the
   kernel's own; the driver's are in the Kconfig help and in patch 8.

 - Probe and stream (patch 1).  probe() returned 0 after freeing the
   card when an URB or DMA buffer allocation failed; it now returns
   -ENOMEM.  Trigger START re-checks the rate and period that prepare()
   checks, so a substream prepared before the other direction changed
   the session cannot start against stale geometry.  in_done and
   out_inflight are initialised before the URBs go out, and a URB that
   cannot be resubmitted is treated as fatal instead of waiting for a
   run of errors that a later good completion would clear.

 - Output masters (patch 2).  Every snd_ctl_new1() result is checked
   before the name is written.  The output pair switch is a mono
   switch, which is what the hardware does; it used to advertise two
   channels and ignore the second.

 - Preamp and trim (patch 3).  The same NULL checks in the trim
   controls, with trim_kctl stored only after snd_ctl_add() succeeds
   (it could be left dangling on failure).  The Boost 0x0003 commit
   value is re-sent on AN 1>2, on the input link and in the state
   replay, not only on preamp writes, so Boost no longer falls back to
   -10dBV.  The ref level is derived from the 0x17 readback at probe,
   the phantom bit is sampled under the mutex, and the unused
   bf_gain_db() is gone.  The preamp and capture control names stay as
   they are, with .index selecting the channel: the companion mixer
   and the asound.state files already reference them, and the index is
   the ALSA convention for a per-channel control.  Turning a playback
   pair's stereo split off wrote 0x1000 to both sides of its AN1/2
   crosspoint, 6 dB below what the vendor software writes for a joined
   pair, and lost the level set on that crosspoint; it now restores
   the cached crosspoint.

 - Routing flags (patch 4).  bf_state_apply_flags() used to write
   0x1000 to the AN1 and AN2 crosspoints on every probe and resume,
   even at width 0, after the default mixer had left those inputs
   muted.  The cache still said 0, so a later write of 0 returned early
   and could not mute them again.  The width replay is now guarded and
   shares one helper with the width control.  DIM, mute, the master
   controls and the front-panel wheels all derive the Phones level from
   one helper, so they no longer cancel each other.  bf_ms_put()
   restores each output block's own crosspoint, the loopback control
   notifies the pair it clears, and the enum and integer puts check
   their bounds before narrowing.

 - Suspend/resume (patch 5).  No change of its own; it inherits the
   replay fixes from patch 4.

 - Front panel (patch 6).  The MIX level is kept in dB2 instead of the
   quantised register value, so clicks below the curve's first point
   are no longer lost and a muted input comes up on the first click;
   SELECT re-seeds the level while MIX is on.  The MIX gate is no
   longer re-armed on the tick that leaves the mode, reprobe is set
   before the card becomes visible, and the panel master writers
   respect DIM.

 - EQ (patch 7).  The low-cut frequency uses div64_s64() for the
   variable divisor, so a 32-bit module does not need __divdi3 (not
   exported on ARM).  A band of type Off is identity rather than a high
   shelf, the default slope matches the value the control reports, and
   a failed strip upload is returned to the caller.

 - Documentation (patch 8).  Wording follows the one-map crosspoint
   model; no functional change.

Every patch builds in-tree on its own against next-20261026 with W=1
and no warnings.  checkpatch --strict reports no errors; the known
false positives are the same as v7 ('ang' for the CORDIC angle, and the
MAINTAINERS note on the patches that add files).

Validated on the unit with this tree:

 - regress.sh --mixer-restore --disconnect-test passes 41/41: the
   full-duplex sweep of the nine rates at periods 256 to 2048 with no
   xruns, runtime renegotiation, 30 start/stop cycles, the mixer state
   restored across an unbind/rebind, and an unbind in the middle of a
   capture.

 - The DIM/mute/volume matrix was checked on the wire with usbmon:
   DIM writes the exact 0xcb/0x0333 pair, a volume change while DIM
   is on keeps that pair, mute writes 0x3b/0x0000, unmute while DIM
   is on restores 0xcb/0x0333, and releasing DIM restores the new
   volume.

 - The probe/rebind replay was checked on the wire too: after the
   default mixer writes 0x0000 to the AN1/AN2 crosspoints, no 0x1000
   write follows, so the width block no longer unmutes the inputs.

 - The MIX-wheel arithmetic is covered by fader_selftest: a muted
   crosspoint seeds at the curve's first point, one clockwise click
   leaves mute, and two counter-clockwise clicks from the old -52 dB
   sticking point move.

 - The physical MIX-wheel gesture was checked on the unit: from a
   muted AN3 crosspoint, one clockwise click moved it to 0x0004 (the
   old code left it at 0 for the first five clicks), two clockwise and
   two counter-clockwise clicks stepped it to 0x0003, and the level
   followed the wheel in both directions.

 - The stereo split was checked through the AN1/2 digital loopback:
   with PB1 at the default crosspoint, split then join comes back at
   the level it started from (-51.5 dB before and after; it used to
   come back at -54.5 dB).

Known limitations, unchanged from v7:

 - USB autosuspend is not supported; it is disabled at probe.  S3
   suspend/resume works.

 - A few protocol details remain open (documented in the source, not
   blocking): the preamp readback index semantics, a width
   strip-ownership edge case, whether DIM's scope follows TotalMix's
   Main Out setting, and the exact high-frequency warping of the EQ
   coefficients against the vendor curve.

 - The URB size and count are load-time parameters, though the size
   follows the period the application asks for.

Disclosure: as with previous versions, the reverse-engineering and
substantial portions of the kernel implementation were written with
heavy assistance from AI coding assistants.  All of it was verified by
hand on real hardware; the human authors remain responsible for the
result via Signed-off-by.

Thanks,
Ismaïl


Ismaïl Bahloul (8):
  ALSA: usb: add RME Babyface Pro driver core (probe, PCM stream)
  ALSA: usb: babyfacepro: add output masters and crosspoint routing
  ALSA: usb: babyfacepro: add mic preamp, phantom/pad and input trim
  ALSA: usb: babyfacepro: add routing flags and varispeed pitch
  ALSA: usb: babyfacepro: add S3 suspend/resume
  ALSA: usb: babyfacepro: add the front-panel poll and controls
  ALSA: usb: babyfacepro: add the hardware DSP EQ
  Documentation: sound: add the Babyface Pro proprietary-mode design doc

 Documentation/sound/cards/babyface-pro.rst |  218 ++
 Documentation/sound/cards/index.rst        |    1 +
 MAINTAINERS                                |    6 +
 sound/usb/Kconfig                          |   17 +
 sound/usb/Makefile                         |    2 +-
 sound/usb/babyfacepro/Makefile             |    4 +
 sound/usb/babyfacepro/babyfacepro-ctl.c    | 3946 ++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c        | 1943 ++++++++++
 sound/usb/babyfacepro/babyfacepro.h        |  568 +++
 9 files changed, 6704 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sound/cards/babyface-pro.rst
 create mode 100644 sound/usb/babyfacepro/Makefile
 create mode 100644 sound/usb/babyfacepro/babyfacepro-ctl.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.h

-- 
2.56.0

