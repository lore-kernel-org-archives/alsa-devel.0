Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4CBCD342C
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2026 14:06:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5E8A60224;
	Wed,  6 May 2026 16:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5E8A60224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778076401;
	bh=R6F38CqNLNqRG+cFUfxfGsJMsiKTyn6CCJXNGR/rlqU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PZ5rg2gbIjbjUTa59zk3Q5F3R9PNuOS1JgTpV+GtRWMwdwtnHa6d6/SOlAriSQq+C
	 abI5K4tDcLGJARmeiHo5upYCPfblzzvyjWGP0vaDnLL5nKKV91ohR7+o8oq7G40phZ
	 Ifp76uuKxWHU9UEpRPrL88bOMXm/Hz0pGRYdeFB8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 158BFF8051F; Wed,  6 May 2026 16:06:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8AADF805F2;
	Wed,  6 May 2026 16:06:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F073F80217; Wed,  6 May 2026 16:06:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ADDB3F8014E
	for <alsa-devel@alsa-project.org>; Wed,  6 May 2026 16:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADDB3F8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Yp5DMqta
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 563E840AA2;
	Wed,  6 May 2026 14:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D47C2BCB0;
	Wed,  6 May 2026 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076355;
	bh=R6F38CqNLNqRG+cFUfxfGsJMsiKTyn6CCJXNGR/rlqU=;
	h=From:To:Cc:Subject:Date:From;
	b=Yp5DMqtasUqJfz2zl4rM261fZEkwBuxaOAV/HyfLBNeOSNTV9YRvsRu4lo0yVmRs9
	 zWfxUcdk1V1TzYiZx3ejWYoIJymWb7E059FsO7SoWcLVOMoufdShzSERaOX4NglVuI
	 5QRibM9EczbQhQlP15Kjm5LR7nB7TizqUXeB26BQTT8W18Rkfh8V5W8tvMjiuk01ax
	 wiiQ3sQMwAknARS5Spok5S1vnOAlC10npoVnlvTF9gjJ9IhA53KujVFKEjDnBGEyLD
	 YXi48ZKGHZQrLJDCHmiVEyNdVslYOzxAS6tILTANQrHmG7FpVSnjl/3oRuFpPj9pgr
	 nakUPMqjP+xBg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 603EF1AC587E; Wed, 06 May 2026 15:05:52 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc2
Date: Wed, 06 May 2026 23:05:47 +0900
Message-Id: <20260506140552.603EF1AC587E@finisterre.sirena.org.uk>
Message-ID-Hash: B6BXWCMLRB5WYVKDUFJBGACZ77YNYKSK
X-Message-ID-Hash: B6BXWCMLRB5WYVKDUFJBGACZ77YNYKSK
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B6BXWCMLRB5WYVKDUFJBGACZ77YNYKSK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc2

for you to fetch changes up to 5776bcdf4dccac8edc1160482792b512da5c08b4:

  ASoC: cs35l56: Fixes for driver cleanup (2026-05-06 21:22:53 +0900)

----------------------------------------------------------------
ASoC: Fixes for v7.1

Another batch of fixes, plus a couple of quirks (mostly AMD ones, as has
been the case recently).  All driver changes, including fixes for the
KUnit tests for the Cirrus drivers that could cause memory corruption.

----------------------------------------------------------------
Bob Song (1):
      ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VE

Cássio Gabriel (1):
      ASoC: fsl_xcvr: Fix event generation for cached controls

Derek Fang (1):
      ASoC: sdw_utils: avoid the SDCA companion function not supported failure

James Calligeros (2):
      ASoC: tas2764: Deal with bogus initial temperature register value
      ASoC: tas2770: Deal with bogus initial temperature value

Mark Brown (2):
      ASoC: wm_adsp_fw_find_test: Fix a couple of bugs
      ASoC: cs35l56: Fixes for driver cleanup

Richard Fitzgerald (6):
      ASoC: cs35l56: Fix hibernate write in runtime resume error path
      ASoC: cs35l56: Fix out-of-bounds in dev_err() in cs35l56_read_onchip_spkid()
      ASoC: wm_adsp_fw_find_test: Redirect wm_adsp_release_firmware_files()
      ASoC: wm_adsp_fw_find_test: Clear searched_fw_files in find-by-index test
      ASoC: cs35l56: Don't use devres to unregister component
      ASoC: cs35l56: Destroy workqueue in probe error path

Tommaso Soncin (1):
      ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table

Troy Mitchell (1):
      ASoC: spacemit: fix RX DMA params not set when TX is running

Uwe Kleine-König (The Capable Hub) (1):
      ASoC: codecs: ab8500: Remove suspicious code

 sound/soc/amd/yc/acp6x-mach.c           |  21 +++
 sound/soc/codecs/ab8500-codec.c         | 304 +-------------------------------
 sound/soc/codecs/cs35l56-shared.c       |  11 +-
 sound/soc/codecs/cs35l56.c              |  11 +-
 sound/soc/codecs/tas2764.c              |  35 +++-
 sound/soc/codecs/tas2770.c              |  23 ++-
 sound/soc/codecs/wm_adsp_fw_find_test.c |  57 ++++--
 sound/soc/fsl/fsl_xcvr.c                |  17 +-
 sound/soc/sdw_utils/soc_sdw_utils.c     |   1 +
 sound/soc/spacemit/k1_i2s.c             |   7 +-
 10 files changed, 151 insertions(+), 336 deletions(-)
