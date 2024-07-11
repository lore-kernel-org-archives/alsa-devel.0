Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E147FC3DA45
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:51:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27CC3852;
	Thu, 11 Jul 2024 16:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27CC3852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720709475;
	bh=jIm0gbSdlluRGwzaIYKo6qKZk7oEjv4Q+rIwTgym9d4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hrPiB4ralXPD1R5dhJWXbJCKJqKSduQy3KydayJzY1g/I/mmOp4eKWWtt/chkplOv
	 dFwOJaaHLWpcfVkCRPYxwNhTvZR61kc4Iu/r6JNvvuqVwl0C8cYTJId3s4ZswRlV8a
	 5zn7+54AyhfvxFegK2910PSLRzwUoJGS0etxw5ck=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77E70F801F5; Thu, 11 Jul 2024 16:50:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3752F805B4;
	Thu, 11 Jul 2024 16:50:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88A12F801F5; Thu, 11 Jul 2024 16:47:17 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD749F8013D
	for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2024 16:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD749F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OO0Uw3Cd
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C6582CE12C7;
	Thu, 11 Jul 2024 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C250C116B1;
	Thu, 11 Jul 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720709222;
	bh=jIm0gbSdlluRGwzaIYKo6qKZk7oEjv4Q+rIwTgym9d4=;
	h=From:To:Cc:Subject:Date:From;
	b=OO0Uw3Cd5g7suSLJd06nXuSQmZ6GHhegSq0TVorsu4PzJZywx1BgftIySRE3kfghX
	 Ky8x4rIuH6d6vhL0OMuFmNa/v690EcRz0MrK38oNuqsR254CHQR5NdSLLSd9bmcpYX
	 JVjO5cY0UmuCfm9ZBdymXg95aYryDhfAf4lL8cScrPporvHGKjMuSup9dQahExJD4t
	 rpyUGJTGaiN4FBuH+DFUahKIo4k1h8wPa5AvyaU6dSSWgeAJXWJRGJv/laYju0015T
	 xFWb2Txr4IjPdGzahOPJ2ycy0zY128rKu/qZYz33IllsXlRbfTo55id/sH2bgngZFj
	 i4StsIGZhS3hg==
Message-ID: <b612cf49c9449f240cfb709d876b7d0c.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.10-rc7
Date: Thu, 11 Jul 2024 15:46:50 +0100
Message-ID-Hash: SO5AVXWPUK67XPHAMLYUIGMHDMYIKMS3
X-Message-ID-Hash: SO5AVXWPUK67XPHAMLYUIGMHDMYIKMS3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SO5AVXWPUK67XPHAMLYUIGMHDMYIKMS3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 68f97fe330e01450ace63da0ce5cab676fc97f9a:

  ASoC: rt5645: fix issue of random interrupt from push-button (2024-06-26 16:34:48 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.10-rc7

for you to fetch changes up to 680e126ec0400f6daecf0510c5bb97a55779ff03:

  firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files (2024-07-08 15:55:11 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.10

A few fairly small fixes for ASoC, there's a relatively large set of
hardening changes for the cs_dsp firmware file parsing and a couple of
other small device specific fixes.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt711-sdw: add missing readable registers

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix null deref on system suspend entry

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-pcm: Limit the maximum number of periods by MAX_BDL_ENTRIES

Richard Fitzgerald (5):
      firmware: cs_dsp: Fix overflow checking of wmfw header
      firmware: cs_dsp: Return error if block header overflows file
      firmware: cs_dsp: Validate payload length before processing block
      firmware: cs_dsp: Prevent buffer overrun when processing V2 alg headers
      firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

 drivers/firmware/cirrus/cs_dsp.c | 227 ++++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt711-sdw.c     |   2 +
 sound/soc/sof/intel/hda-dai.c    |  12 +--
 sound/soc/sof/intel/hda-pcm.c    |   6 ++
 4 files changed, 176 insertions(+), 71 deletions(-)
