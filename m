Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E248C982FA
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:16:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FEF5601CC;
	Tue, 22 Sep 2026 20:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FEF5601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790100964;
	bh=7hz5m/2GUslvzEhBVqtxd3BXNxYXtG8hiw68gtMZork=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vLPLh6U7yMvWMdaCVpyx03J99fakw34obCrjpNVKYmeE6IeDKd1LRe+OMm+EVzudt
	 fTXRH+jdY4FELp6HWNsl9FzgdT8Ek1hACJheLxysFhxJB08RICt0g5MofNnyGGaoxi
	 b+6nwfrNlpF6Yb8MC2KACS3B8duCGtLGpwZgxmDk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88997F805FC; Tue, 22 Sep 2026 20:15:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD5EEF805F7;
	Tue, 22 Sep 2026 20:15:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F897F8051F; Tue, 22 Sep 2026 20:15:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.217.178.61
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790100921;
	b=NcTiv4VT3TcmiZEVcDjM4CgARQfTFf7PnkHEaC+dMIkI6lGb/byxrOoii+exd7gSKuVr
	 GZpxmLvauLmgoog+TMkqZEy/3lZqJtd5o5p2Oj4oZgSGLVxtR1vlXkJOdVQ1+Iuq3PTE2
	 vMHCNUBXpPafrASsziKr0dLzk32gcbdhRTZNefYj9EpynFoa34+Iz504kI4TR+3zvVUh4
	 /e+vS9Y4DDiC4mXsmv+fLHzzrtstCzGD56mbNhbdFxlB+S53TmVqmr0A/nIBPcchlXjD5
	 KYBGrkXFFPWhzHbVREEZ02EMcam3BKNpdVV73EvQOKhAbshEf4bILyrm8zc3YWEM/KA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790100921;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-Id:
	 Mime-Version;
	bh=7hz5m/2GUslvzEhBVqtxd3BXNxYXtG8hiw68gtMZork=;
	b=k5zZLQGnA5IXL2ZOfAyMBn/JewU+x8vPYHRv6JJ+5GuTulPn8Yf1WNzpsy+h6aqYK+7R
	 HDMVJvCVmAxDcZfNWwVyvEDgyJYx/pZ1YBU+UI4/+ZJpPlNmIe/eMnMJKWmhgVB25bCRU
	 S+K1PdeZ38sLbyQNGcErqKiEHw6g2nKBfq/SgL8+IlH5sluw1YuFsoMkQEOqhNfMoXVB6
	 FfwcZI5uFC2r37PE+8UznWsrDVEpD/Fo1YD7XipHY0prs1tRHs3/uv2ZW+Nk9HUU4Ks89
	 XH0a2+P22Khqk5qizYuAkljKhOIMmZ5GiGO4xyMPd9xt2xmPMOcznBs2KiIiOWZQPlQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=6jZRwASn;
	dkim=pass header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=VGEOZ0FM;
	arc=none smtp.remote-ip=95.217.178.61
Received: from gorgnet.net (gorgnet.net [95.217.178.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7F05F80038
	for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2026 20:15:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F05F80038
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=6jZRwASn;
	dkim=pass (2048-bit key,
 unprotected) header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=VGEOZ0FM
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple;
  d=gorgnet.net; s=b1; x=1790705497; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:
  References:Mime-Version:Content-Type:Content-Transfer-Encoding;
  bh=7hz5m/2GUslvzEhBVqtxd3BXNxYXtG8hiw68gtMZork=; b=6jZRwASnuqydI
  DiA82PDEvJuaKccQHYQ/WSuif/66BU+55ZTYHYhbz19nhfCNdNiz8e++YAA/MH/D
  2knctBTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=gorgnet.net; s=a1; x=1790705497; q=dns/txt; h=Received:
  Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:
  References:Mime-Version:Content-Type:Content-Transfer-Encoding;
  bh=7hz5m/2GUslvzEhBVqtxd3BXNxYXtG8hiw68gtMZork=; b=VGEOZ0FMv4+pU
  pcBTs0rw2iBITTK9nzmJ5T8oJqu9MBhrqyJHYqkAEtdN3R+p/EB5L9kPX6yUdXxe
  Wop54GKuZuuWqdmCyoUdVYyc77aVVFPiGKNadCjwgAOvBVwFaNSXzURNCaHkQ1rM
  DoVfuWmmS7fe3YgK1gnk+BVrUKbbhoK1ASfyYd9YsO95hi6vrK0tXvIXQpHWIusv
  ju0oQg+uuU+AWymDbF1hrMPmOoyz+C3xifXD7LzRidJB8d6qaA9f0McUrQe8g2Bt
  am9Z+lIj/MgCO/H5lWN/WUnF3NYGMmttIXX/AlJXfTlAOOfnp//Pv+6c0ZoU+JSp
  GsJTDEC3w==
Received: (qmail 4361 invoked from network); 22 Sep 2026 18:11:37 -0000
Received: from unknown (HELO void1)
 (gorg@gorgnet.net@2600:1003:b011:f020:4ea4:6da1:8299:387e)
  for <alsa-devel@alsa-project.org>
  de/crypted with TLSv1.2: ECDHE-ECDSA-CHACHA20-POLY1305 [unknown/unknown]
  by 0 with ESMTPSA; 22 Sep 2026 18:11:37 -0000
Date: Tue, 22 Sep 2026 11:15:16 -0700
From: George Matsumura <gorg@gorgnet.net>
To: alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de
Subject: Re: [PATCH] alsa-lib: Revert
 "A try to fix one rouding problem in refine"
Message-Id: <20260922111516.2974da927822b36db853f410@gorgnet.net>
In-Reply-To: <b2b98034-918a-40c9-8b3d-1b55b38ebe39@perex.cz>
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
	<f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
	<20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
	<fe1c4c8d-1a2f-4d4b-a3e3-654b0a011f0a@perex.cz>
	<20260920204939.62536218e5f1804d2b6f819f@gorgnet.net>
	<b2b98034-918a-40c9-8b3d-1b55b38ebe39@perex.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-musl)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: UHWVVLUOZWSHGLSXVPAG4II3HY2HNG6M
X-Message-ID-Hash: UHWVVLUOZWSHGLSXVPAG4II3HY2HNG6M
X-MailFrom: gorg@gorgnet.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHWVVLUOZWSHGLSXVPAG4II3HY2HNG6M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 21 Sep 2026 20:49:18 +0200
Jaroslav Kysela <perex@perex.cz> wrote:
> Could you also show the output with patched alsa-lib ?

Certainly, I obtain the following output from alsa-lib with patched
snd_pcm_rate_hw_refine_cchange:

$ aplay -v -D dmixT -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero
Playing raw data '/dev/zero' : Float 32 bit Little Endian, Rate 44100 Hz, Mono
Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 8334
  period_size  : 926
  period_time  : 21000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 926
  period_event : 0
  start_threshold  : 8334
  stop_threshold   : 8334
  silence_threshold: 0
  silence_size : 0
  boundary     : 4691624911813214208
Slave: Rate conversion PCM (48000, sformat=S16_LE)
Converter: linear-interpolation
Protocol version: 10003
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 8334
  period_size  : 926
  period_time  : 21000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 926
  period_event : 0
  start_threshold  : 8334
  stop_threshold   : 8334
  silence_threshold: 0
  silence_size : 0
  boundary     : 4691624911813214208
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 9072
  period_size  : 1008
  period_time  : 21000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1008
  period_event : 0
  start_threshold  : 9072
  stop_threshold   : 9072
  silence_threshold: 0
  silence_size : 0
  boundary     : 5107081977438142464
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 9072
  period_size  : 1008
  period_time  : 21000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1008
  period_event : 0
  start_threshold  : 9072
  stop_threshold   : 9072
  silence_threshold: 0
  silence_size : 0
  boundary     : 5107081977438142464
Hardware PCM card 1 'chtrt5650' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16128
  period_size  : 1008
  period_time  : 21000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1008
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 9079256848778919936
  silence_threshold: 0
  silence_size : 9079256848778919936
  boundary     : 9079256848778919936
  appl_ptr     : 0
  hw_ptr       : 0

with this asound.conf:

defaults.pcm.!card 1
defaults.ctl.!card 1

pcm.dmixT {
    type plug
    slave {
        pcm "dmix"
        rate 48000
    }
}

Audio output works correctly in this case.

> It seems that the Intel SST driver may be the culprit (different constaints in 
> the kernel code). Could you try to force dmix to use fixed period and buffer 
> sizes ?

I apologize if I translated the config you sent incorrectly, but here
are outputs I obtain from test aplay commands:

$ aplay -v -D dmixT -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero
ALSA lib pcm_direct.c:1287:(snd1_pcm_direct_initialize_slave) [error.pcm] unable to set buffer size
ALSA lib pcm_dmix.c:1012:(snd_pcm_dmix_open) [error.pcm] unable to initialize slave
aplay: main:850: audio open error: Invalid argument

$ aplay -v -D dmixT /dev/zero
ALSA lib pcm_direct.c:1287:(snd1_pcm_direct_initialize_slave) [error.pcm] unable to set buffer size
ALSA lib pcm_dmix.c:1012:(snd_pcm_dmix_open) [error.pcm] unable to initialize slave
aplay: main:850: audio open error: Invalid argument

with this asound.conf:

pcm.dmixT {
     type plug
     slave {
         pcm {
             type dmix
             ipc_key 1024
             ipc_perm 0600
             slave {
                 pcm "hw:1"
                 period_size 1024
                 buffer_size 4096
                 format "S16_LE"
                 rate 48000
             }
         }
     }
}

I had originally thought that due to the error occuring in the
refinement process, as shown in the snippet below from the unpatched
library with REFINE_DEBUG and RULES_DEBUG enabled, that it was due to
alsa-lib rather than the kernel driver. However, I would not able to
explain the differences of our results and I apologize if I submitted a
patch for the wrong component.

https://gitlab.com/-/snippets/6058384

Regards,
    George
