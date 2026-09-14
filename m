Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88124C88E77
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:30:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B50FC6025D;
	Wed, 16 Sep 2026 08:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B50FC6025D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540238;
	bh=4oHF2Eat6k72PJTngrCMahrVR9myK7ASkiIuFcNmiZo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lVnJAWPQcFV7rIosFRyUl7uhjiHHNEJvkVhvsAjHwKGbvFXL1lYpcIoFw6KeqMJ42
	 cIZPkgirOLRQk/sra0KCX1iVdTbjjKKmKI/VAicjIqHPRSU/8T2ipYzjSbEEFjVeTA
	 oouRQA/Ak9F1wx10VSGDYUiCM4VL2h24B5rKvNLo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5241AF8069F; Wed, 16 Sep 2026 08:29:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCCB9F806A2;
	Wed, 16 Sep 2026 08:29:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9E89F8049C; Mon, 14 Sep 2026 19:23:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.225.76
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789406624;
	b=Fjr3sxE1+FhbgHwveeaPjuZAr1nYDY7Msefdh6vFAXuNJ/qMlADF3emxdqsvHD3BcKSo
	 QXZ9kbeTPg9x59VvPqI4+4voYn3AVe0mlMazigtX/icWc2PDIg09c7lD9yeO3rwF2NIO7
	 O+AFbvt3k14SsfqpQleT5yVnSZV6NYcqG4STSXvFqTEQE7AJ9SRrQSJ9HoNpi0YlVrKA5
	 Q1I8Zb3/OG5M2SKHs99S8M10hCXO9LI8eeEuHTxwwqe6A2KaUS8F5oBA2kVBVU2Zq8I1i
	 nttYrspd9wJ7CKtEOWYoyjWROmbv22f5yf2gGHmofBDe++xQ865Om/c4/aaSP2GR6JQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789406624;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4oHF2Eat6k72PJTngrCMahrVR9myK7ASkiIuFcNmiZo=;
	b=XsAHXaPku0AzsdJhZTpPwddvICau7QNWjrCgzQEvGocQxNloR8I3lb25fo95o/udYaHc
	 8kG7UY8vYCxnyVcWU65LemU8oifA/EWR7LwbCB8Ot8QVSVj4TppwWyHiPNl0/0j9rnd8n
	 jAhg903Iz/Y3vE7VdAkUOUgCwgxLi74ew0WbiIvTSEGEEo3mCTs2xoMDHZ5uWfCXXafb7
	 bIQBDkoLDXl1b47w8i4Bs1HErTXgHK21phtAIzb18WzjD1m/QJwcq+E0VtR74bKk/q10W
	 cuBNqa8i5tQfuivw10KMGQF30drI2RSkbONNVKRQjnrkz+XFByO2ZqJR9L25UPmht8w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g7ajKERq;
	arc=none smtp.remote-ip=74.125.225.76
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FECCF80217
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 19:23:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FECCF80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g7ajKERq
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so1204464f8f.1
        for <alsa-devel@alsa-project.org>;
 Mon, 14 Sep 2026 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789406622; x=1790011422;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYF4ZfbMwnUrNRIM8rc7WKTmFbe7IkNY9IAOIcyuFNc=;
        b=g7ajKERqsyTpGB9FqvAIYuCNh20ubryVcTtCKQNeSBPJgqUoL0twX1WnLKqZ9xoOss
         piYcirJ1bGKIAWUxYH2viFaxkupeRqeYisuvkv5qG20IzIfYg3YF5LMVSYsfCtcmJcUJ
         Sb8jQEHl2fkJVbJ61eIwNn0Iq6EKch5Wl+V5qFOOVxEdT7U07mfVLHkyUIRPO23GREgZ
         qFh7PutEyEzIx9G9pSgmziXvqKlxS0h6k2uuPgXaQrB//wUfuXLlav4iPbjX3E0g4G8X
         NJXExvbnViVxt0pAF7so5pJdb9ZpYn6m9jDGHqiZEWFp7Pq2fPsWRhU9R7HJZNbumr5N
         jn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789406622; x=1790011422;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYF4ZfbMwnUrNRIM8rc7WKTmFbe7IkNY9IAOIcyuFNc=;
        b=bcoShcqUlOaUZ6kGq7KXHF47RcmiEdBUHxsmm/C2JDpdjxvPXYfmChbw1GMyVmslFu
         Jp19rtFww/mPL7hPBuSi5fiYvrySL2O1daUcHPr0Ud2FiptbgMhwoQWsC2Tp3qxkNQ8C
         OVnAvQVZq9mHcvxvukOZkXPuCfaOhlHE1r9641pSdb347rwjqioUIocGNH3I58zgpnIB
         r8g/MUV3jTvic051jACd7At1/fwZywst+x6c9dhrEd2pXoDrbQ2eSncBOyZuyOswFyQ5
         OcYH1JxOuc4Dn+wv12VDqczWMUnTh5X276KqIPLPFMpJzB+HT73l3+pmf3J6I8rTb1JB
         aGbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxVBF+ninn64Fet8W5h95a+O2eQQMKrLgSL0OVxWWNgiIN4tbtc8KjdKfjaKlilPIq4Pq1/sOTjeAS@alsa-project.org
X-Gm-Message-State: AFuF++lsCBdApfhOhFGBlQB2/vyVMGP4zrtqNKJm/3VuDdwvmbqDBNFz
	Pm826CDCgyhxETg5OffHk0rmLVk6sTYd7kHANkon7PR1tTLk33m1k5rN
X-Gm-Gg: AYBFou0z1SHzX1/ajPfUftK/p6XyWvLaIW0vReVkMtxmL9xZqq3scrPYRZwGMp1k917
	r+LeW42vtXfa/qiz8AlWnjwhj7I9yPHy7TNaGs13V+hvqvaUOJWuG4d+HDWkumS7e8Ckmt45faj
	831MhEy/fKBlGRVVwdwokf5gjiI6bsLqD+7fVheAqDkLTeGDE1CHtZ46FY5y2ChtLk3zaCz365z
	uL+Fi6ZLjsTPa9+qCzpuCRFaxpCD7tjfQhltgcoHFhrdTp52SU3EEUfACCQBVAWaaiK+x/aklvu
	VAHL2OrUkbKIEml5LID/lATRlCO7/OwOOFQCDUQHSgHVAC3+byhNHAc9OCEr6NxG8C4tuyLgjBm
	5CWU198+icoDQ7LN+irumn9K1CXqwjzzAl3k6YaF2CeBv6qdw0ixb6O4Ssb+Q5aeUIuyPe0upvh
	sStvqWp8O+eKSTsNluitt2poCuflaE2Q0me/TljslHf0y4f759f6Eu8OoLOvxG7JaWtoijnTL7k
	kbwZtYdobnwrcFl322TCSg2BBc=
X-Received: by 2002:a05:6000:3c8:b0:487:8:1d25 with SMTP id
 ffacd0b85a97d-48702ab924emr4811637f8f.17.1789406621970;
        Mon, 14 Sep 2026 10:23:41 -0700 (PDT)
Received: from cachyos ([41.249.70.189])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ea60sm28064873f8f.17.2026.09.14.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:23:41 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/3] ALSA: usb: add RME Babyface Pro driver
 (proprietary mode)
Date: Mon, 14 Sep 2026 18:23:31 +0100
Message-ID: <20260914172334.49074-1-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2J67XOWWJFRF6Q7HUNWZUSXSEI2TUWBD
X-Message-ID-Hash: 2J67XOWWJFRF6Q7HUNWZUSXSEI2TUWBD
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:29:07 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2J67XOWWJFRF6Q7HUNWZUSXSEI2TUWBD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

This is v4 of the RFC for a driver for the RME Babyface Pro in its
proprietary USB mode (VID 0x2a39, PID 0x3fc0).  In that mode the PCM
stream runs on interrupt endpoints instead of the class-compliant
isochronous path, so it cannot be a quirk on top of snd-usb-audio and
needs a standalone driver, modelled on snd-usb-caiaq.

Changes since v3:

 - A real bug in the crosspoint routing matrix, found while trying to
   hardware-verify the dB TLV metadata added to the crosspoint faders
   (below): the AN1/2 output's own crosspoint fader had no audible
   effect on the signal, for every source, for as long as the matrix
   has existed - a generated tone swept from off through +6 dB
   produced no change at all, while the identical control targeting
   any other output tracked the fader correctly. The vendor software's
   own capture shows why: for this one output it always writes a
   second register (the "low map") alongside the usual crosspoint
   address, at the same value; the driver wrote only the usual
   address. Three call sites (the live control, the probe-time
   default, and the reconnect/resume replay) needed the same fix,
   folded into one exported helper. Verified fixed with the same
   tone-sweep method that found it, and that a real crosspoint value
   survives an actual unbind/rebind, both the cached control and the
   audible level.

 - Two real bugs found, diagnosed and fixed by David Fredman, who also
   became this driver's second tester, on an original (2015, non-FS)
   Babyface Pro:

   * The stream URBs were submitted without URB_NO_TRANSFER_DMA_MAP
     even though their buffers come from usb_alloc_coherent(), so the
     USB core tried to map them a second time and failed with -EAGAIN
     on any IOMMU-translated host.  That is the default on current AMD
     and Intel desktops, which means v3 as posted would not have
     streamed at all on most machines.  Every other sound/usb driver
     that allocates coherent buffers sets this flag; this one was the
     exception.

   * The mic preamp gain register was decoded as a 5-bit value plus a
     rotating transaction counter.  Bits 5-7 are in fact the fine part
     of the gain: value = (fine << 5) | coarse, coarse 3 dB per step
     saturating at 20, fine the 0-2 dB remainder.  The control was
     therefore reaching 21 of its 66 positions, and because the
     rotating value landed in those same bits, the gain actually
     applied depended on where the rotation stood - the same requested
     setting did not give a repeatable gain.  Measured on hardware
     before and after: 0.808 dB per dB of control, against 1.000 after
     the fix.

 - The power-on masters no longer come up at unity, and the -20 dB
   safety default is scoped to the two analog outputs only.  The
   routing default sends all 14 sources into every output at unity,
   and they sum, on every fresh module load before alsa-restore can
   restore the user's levels; AN1/2 and PH3/4 now come up at -20 dB,
   the level the hardware's own DIM button writes.  The four digital
   outputs (AS1/2, ADAT3/4, ADAT5/6, ADAT7/8) keep the vendor
   software's own 0 dB default instead, since nothing downstream of a
   digital feed can be damaged by a loud signal the way a speaker or a
   pair of headphones can - David Fredman flagged that the original
   six-output default reached those too, for no reason a receiving
   digital device could infer.

 - The driver is no longer FS-specific.  It runs unmodified on an
   original (2015) Babyface Pro; the two models share VID:PID,
   bcdDevice and iProduct shape, and nothing in the descriptors tells
   them apart.  card->driver, the card id, the shortname and the
   Kconfig text are model-neutral accordingly.  This seemed worth
   getting right before the strings are frozen by a release, since
   card->driver is what alsa-lib configs and UCM profiles match on.

 - The front-panel DIM button acts now instead of only being decoded.
   SET already toggled phantom from the same poll.  Its scope (Phones
   only) matches the one vendor capture we have of it; whether that is
   the only possible target or just the default "Main Out" assignment
   is an open protocol question, noted rather than guessed at.

 - Added dB TLV information to the preamp gain, trim and crosspoint
   controls; only the output masters had any before.  Hardware-
   verifying the crosspoint curve is what surfaced the routing bug
   above.

 - Fixed a state-restore bug in the input trim: it is one shared
   register per input pair but two per-channel controls, and the
   restore replayed the pair from its even index, so a trim set on the
   odd channel was silently dropped on re-probe.

 - Split into three patches rather than the four of v3.  The v3 split
   put the mixer in its own patch, which meant earlier patches carried
   stub control functions that later patches replaced.  The mixer and
   the core share the device state structure and the whole
   save/restore path, so that seam was artificial.  The front panel
   and the DSP EQ are genuinely separable: each of the three patches
   here contains only final code, nothing a later patch rewrites, and
   each builds in-tree on its own.

Known limitations, stated up front:

 - USB autosuspend is not supported.  It is explicitly disabled at
   probe rather than left as an untested path: the panel poll and
   keepalive work items run continuously and nothing pairs
   usb_autopm_get/put around the stream.  S3 suspend/resume works and
   is tested.

 - A few protocol details are not fully pinned down and are documented
   as open: the preamp readback index semantics, a width
   strip-ownership edge case, whether DIM's scope is reassignable with
   TotalMix's Main Out setting, and the exact high-frequency warping
   of the EQ coefficients against the vendor curve.  None of them
   affect the shipped controls.

 - The latency profile is chosen at load time through the
   frames_per_urb and nurbs module parameters; changing it means a
   module reload.  Runtime reconfiguration is a follow-up.

Validation: a full-duplex sweep across the whole rate x period matrix
with a signal-integrity tap, 30 start/stop cycles, mixer-state restore
across an interface unbind/rebind, and a mid-stream disconnect - 40 of
40 on the current tree.  Each patch was also built in-tree on its own
against next-20260911.

I am still mainly after feedback on the interrupt-URB PCM design, the
control naming and topology, and the subdirectory layout.

Disclosure: the reverse-engineering (decoding the USB captures, the
magic packets and the front-panel behaviour) and substantial portions
of the kernel implementation were written with heavy assistance from
AI coding assistants, credited per patch as Assisted-by.  All of it
was verified by hand on real hardware; the human authors remain
responsible for the result via Signed-off-by.

Thanks for reading,
Ismaïl

Ismaïl Bahloul (3):
  ALSA: usb: add RME Babyface Pro driver (proprietary mode)
  ALSA: usb: babyfacepro: add the front-panel poll and controls
  ALSA: usb: babyfacepro: add the hardware DSP EQ

 MAINTAINERS                             |    6 +
 sound/usb/Kconfig                       |   20 +
 sound/usb/Makefile                      |    2 +-
 sound/usb/babyfacepro/Makefile          |    4 +
 sound/usb/babyfacepro/babyfacepro-ctl.c | 3494 +++++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c     | 1593 +++++++++++
 sound/usb/babyfacepro/babyfacepro.h     |  494 ++++
 7 files changed, 5612 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/babyfacepro/Makefile
 create mode 100644 sound/usb/babyfacepro/babyfacepro-ctl.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.c
 create mode 100644 sound/usb/babyfacepro/babyfacepro.h

-- 
2.55.0

