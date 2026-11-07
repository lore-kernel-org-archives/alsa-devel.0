Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5E606A336
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=nN+HKLye;
	dkim=fail reason="unknown key version" header.d=ylion.eu header.i=@ylion.eu header.a=rsa-sha256 header.s=default header.b=OdR//Vn2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A58A602B3;
	Mon,  9 Nov 2026 16:04:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A58A602B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236677;
	bh=VlkgQrjqMLEGt+zqFsh3sJMZ3gvXcAWUH3apq5fA7iQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nN+HKLyePJntlHbk4bORlvNZ4JOwo7UBm8DLoubriwRrwS6ygb/EwWRLvtMPjnySE
	 Lgt06iAvIRE2Y1KJOCsPpkDZQsXHu0mu6q+c/yZ24Y3oSwm8ijTHo7DeuE9WNA4H3Y
	 BFLGvjvb0cHdALyMRmsnFrZY/9kIooxHRxAefUo0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9399EF806C7; Mon,  9 Nov 2026 16:01:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF519F80C18;
	Mon,  9 Nov 2026 16:01:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BABB3F805A8; Sat,  7 Nov 2026 15:19:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=81.169.234.116
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794061147;
	b=RpkBz93ep5LXTFlvd1Wd5FAhJo1wG00coXh8GjeEpspmAHxULwL4XnT8EFwwFNTu894c
	 HAQdBBOtN60n6PsfS16DrvfhyPXB6KS6lZXg5aSbWOVj499d7pl8oiTHQsSKy1n+8Gzz3
	 wDUO+x0U5e0Y86Ukgbe+s40h3bXk0FUiqaYMZTkS0tP2sFuFWJ4FvhdWSo9EPGLegp/ZB
	 N6mU/b/iG2YZltY2bNTydN6Y8TwTwLJt90728K1Lg2DikYjD46L+I/cIUWnPb0KJxkJ9K
	 fcduqBgP0FKR/de0w8Oya4HMSanSQFsibA0RhgCbInA3VAk64R7dbd3s4cdRo0Sy3eA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794061147;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=VlkgQrjqMLEGt+zqFsh3sJMZ3gvXcAWUH3apq5fA7iQ=;
	b=WGEtbwhcznqxlQHp3UxDwIWbIOI1F/0p6XqrC6P9xt493Q0RLVoSkqiHV8rp2bm8LkDf
	 jKjzSGqdTWHmfKSu7Gpp9iiN5iv6cFgiQmMEnp92g89cyI11y3K331nPiJpux5M50tRt/
	 oyY9qXbtxUa3Zyl8pPp3Z3olTgE3cUQTlrd8UYbWFb0jZ9PcFDT6gGoUeTUeoXOLgyRxY
	 1Q/JwcSljjWdz/Sw6/fcizwuIei4daC+qjyOnfGV2dFDoduqE8oQThcl+PDxVZaVSQV2w
	 tLKVbiz/x1MJnOTnFYn9XsSuFDLlLRFjmeARn/tzGxdtQpJvay2cvmV2F7UWqYBAbQQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=fail reason="unknown key version" header.d=ylion.eu header.i=@ylion.eu
 header.a=rsa-sha256 header.s=default header.b="OdR//Vn2";
	arc=none smtp.remote-ip=81.169.234.116
Received: from suspicious-bhabha.81-169-234-116.plesk.page
 (h2868040.stratoserver.net [81.169.234.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2E057F80538
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 15:19:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E057F80538
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="unknown key version" header.d=ylion.eu header.i=@ylion.eu
 header.a=rsa-sha256 header.s=default header.b=OdR//Vn2
Received: from debby (92-70-93-169.biz.kpn.net [92.70.93.169])
	by suspicious-bhabha.81-169-234-116.plesk.page (Postfix) with ESMTPA id
 0F1F54004D;
	Sat,  7 Nov 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ylion.eu; s=default;
	t=1794061142; bh=2o0L6E8xu4jedpl7sijQkbu1KheobwalSyFY9cID9J0=;
	h=From:To:Subject;
	b=OdR//Vn2gY9/JASH5HCpynBjOg3ztN1m261JJ0j7T1IPYA2+2AwCgDiygP4TyQfJf
	 JwUzEVze936O3FEJ+KN8lUi5sif5cN/+sxs4A8FRjpw++QT7S+ypV0NGghksw/QOtJ
	 cJw0fO1V08Ss8uG12XXD3LFWQiwLp10r0WmDKuWSfDGTAcsuLOC6mYUusHJTAAkdCJ
	 61FRMSCSNmKWb2T+ClpJRV9XowVjvEEwDj4Fxd9bDqb3uDtU3MMA5/8n4X2Ka3CJxG
	 fkkd/25aEKN7XK6FN4dj+WtxhJHG/2OqOiMofRZb1M4FVHvwCHWzBmHJ7kXw36eGGw
	 KjC+6p2buxXew==
Authentication-Results: suspicious-bhabha.81-169-234-116.plesk.page;
        spf=pass (sender IP is 92.70.93.169) smtp.mailfrom=sub@ylion.eu
 smtp.helo=debby
Received-SPF: pass (suspicious-bhabha.81-169-234-116.plesk.page: connection is
 authenticated)
Date: Sat, 7 Nov 2026 16:25:38 +0100
From: sub <sub@ylion.eu>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Subject: [REGRESSION 6.12.115] ALSA: usb-audio: Audient iD4 (2708:0009)
 playback stalls at hw_ptr 0 with -EIO after CVE-2026-23208
Message-ID: <20261107162538.5bd2d0fa@debby>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailFrom: sub@ylion.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AMAYKEVXLNP2Z2DZQP6PHWIMBL4EWI43
X-Message-ID-Hash: AMAYKEVXLNP2Z2DZQP6PHWIMBL4EWI43
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AMAYKEVXLNP2Z2DZQP6PHWIMBL4EWI43/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Package: src:linux
Version: 6.12.115-2
Severity: important
Tags: regression

Dear Maintainers,

Following the update from linux-image-6.12.113+deb13-rt-amd64
(6.12.113-1) to linux-image-6.12.115+deb13.1-rt-amd64 (6.12.115-2), USB
audio playback on the Audient iD4 MKII (USB ID: 2708:0009) is
completely broken.

Audio capture continues to work normally, but playback fails immediately
with -EIO (Input/output error), with the ALSA hardware pointer
permanently frozen at hw_ptr: 0.

Reverting / booting back to 6.12.113-1 restores full working playback.

========================================================================
1. Hardware Details
========================================================================
Device: Audient iD4 (MKII revision)
USB ID: 2708:0009
USB Host Controller: AMD Renoir/Cezanne USB 3.1 xHCI (06:00.3)

ALSA /proc/asound/card2/stream0 descriptors:
  Format: S32_LE (24 bits)
  Channels: 4 (FL FR FC LFE)
  Playback Endpoint: 0x01 (1 OUT) (ASYNC)
    wMaxPacketSize: 0x00d0 (1x 208 bytes)
    bInterval: 1 (125 us)
  Sync Endpoint: 0x81 (1 IN) (Interface 2, Altset 1)
    Implicit Feedback Mode: Yes
  Capture Endpoint: 0x81 (1 IN) (ASYNC)
    wMaxPacketSize: 0x00d0 (1x 208 bytes)

========================================================================
2. Symptoms & Diagnostic Findings
========================================================================
- Capture:
  Running 'arecord -D hw:2,0 -f S32_LE -r 48000 -c 4' works correctly.
  /proc/asound/card2/pcm0c/sub0/status shows hw_ptr advancing normally.

- Playback:
  Running 'aplay -D hw:2,0 /tmp/test.wav' or 'speaker-test -D hw:2,0'
  fails: aplay: pcm_write:2178: write error: Input/output error (-5)

  Low-level inspection of /proc/asound/card2/pcm0p/sub0/status shows:
    state: RUNNING
    delay: 3072
    hw_ptr: 0
    appl_ptr: 3072

  The stream enters SNDRV_PCM_STATE_RUNNING, but hw_ptr never advances
  even after several hundred milliseconds. As soon as the buffer is
  full, subsequent writes block until timing out with -EIO.

- Sound Server Impact:
  In PipeWire, the follower playback node repeatedly resyncs every
  period: spa.alsa: hw:2,0p: follower avail:2048 delay:2048 target:1280
  thr:256, resync

========================================================================
3. Suspected Regression Cause
========================================================================
The Debian 6.12.115-1 changelog includes:
  - ALSA: usb-audio: Prevent excessive number of frames (CVE-2026-23208)

This patch introduces strict frame-size bounds checking / clamping on
implicit feedback endpoints. For devices such as the Audient iD4 MKII
with 4-channel 32-bit audio (16 bytes/frame) and a 208-byte packet
descriptor, the calculation appears to reject or drop outgoing playback
URBs from being scheduled against the sync endpoint, preventing
completion callbacks and freezing the hardware pointer at 0.

Please consider reviewing the frame validation logic in CVE-2026-23208
for multi-channel implicit feedback devices or adding a quirk for
2708:0009.

Thank you.
