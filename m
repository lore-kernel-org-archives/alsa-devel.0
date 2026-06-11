Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE37CD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:12:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0413601FF;
	Thu, 11 Jun 2026 20:12:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0413601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781201533;
	bh=2mPdjtvsiUXJwnWeZr/bCd12CI23WbeabXizj60OHUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lrnqtreThB4TnRynwNlHYP95sK525FVwkaGTFSAinH6idmDop4kijzxNKGcC03oc4
	 14oU1SC5S9TLfiSN1Tg+caVDazvoG7FOg/AjRd7q5fc68++EprKfZi1NM9g2FEJgYo
	 Y4aLkMUA0MikngfAMbV+vHEHVhCtROS1betrz0io=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 812C7F805F9; Thu, 11 Jun 2026 20:11:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 293AEF805F5;
	Thu, 11 Jun 2026 20:11:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59D53F805B1; Thu, 11 Jun 2026 20:11:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781201489;
	b=EsJChH3dE+Kt8bbSJ1IQD9c1s1wfL9w6dvRT5sT6AbM62KahNJLzt7wpWVQusth5mv44
	 W3JbUPF5FnWJ83DO0OnlQBDN4ygU63LtRleYh6cmMdm0VdxmV+Np0mgSBDlxSgUtmW8SI
	 yzE7h6u6JuxlPCyW2+NBBM9cfigWNZWKx2Ncy2Z4BUOHTWHXX7ORz9orV839LoHbfnOFp
	 ahhU64vhgcrxQhoiL0OHKYNASpARhw9nGAN34AkqQBd3wq/ZKn4YQMgD1nOLfdYU6wRBa
	 J01vioAVjMlChvvHyxirRAgfAGa+bEm30s91iiwyH5CWzPCKzG2mB2kJ2Olo7IY25yA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781201489;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=2mPdjtvsiUXJwnWeZr/bCd12CI23WbeabXizj60OHUw=;
	b=sKAOJXhzCV9+TM0JKxnrApDHeeAwK/bGWM2z12IjL+y0njerG/dbevmQxc0Q4leuGuCf
	 GyUCZAXfKZRtWuLP9zxWuTmv4DszYIN1/6OUWlrlvF8kXpUrLmt1OKOsoGU45SXFiB/6Y
	 26g7fZpBKbsiCMkkHokPXjcx44NHmRYql0KL3P2gq2rjEMK+BWimvnqRdAJJcQLNn5pBZ
	 OhGGojz+G01dDLnatw/wud4DJ4dc2dHylISqCqIv+E+2GWyjo3lBIaJFlOZ4UstkbUIbU
	 eGgqhORJPWPpXRm2pTmUKhwbig/792mz+RLs6tZeerI89dxZ3RJVwXyIvKQVTDq6A0w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UJw+db5U;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 86AEEF80020
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2026 20:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86AEEF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UJw+db5U
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F038E44429;
	Thu, 11 Jun 2026 18:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966B91F000E9;
	Thu, 11 Jun 2026 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201484;
	bh=0dmoQoa1X598o8W/0EXkMSQt4rutkNrxsgppAFzqAA8=;
	h=From:To:Cc:Subject:Date;
	b=UJw+db5UX2UecNGT5XmrffIzDleigE1n/tbXNxhEosaWg3VoJDqecjG9RUrSxINVZ
	 oNoJITfdWNy+9RkFV7RFYB3S3sQXtCpdGg4RQixBLZC45QHS2ZL1GJLHSJrDCQO9cc
	 B1srk3J756nw9DqzRIyTGUqttlxzOxPwWFwlnfA8rlRAi4iu9BHfL1FMNwSi7tFFRn
	 eGv9zP+NeIKaNg5e2GSmI2OgIrUZQmUCVcDtiLZLk3Roxi/A9yFuTOm9G9U/7stC0J
	 PtMCAz9bne9fU20hvwYikzZNZu27C1i/8I3AE/rTsyhQ0rW0qndr/rrirI2FuWi/l6
	 gwE6S7m5hGH3w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 2822E1AC56C9; Thu, 11 Jun 2026 19:11:19 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc7
Date: Thu, 11 Jun 2026 19:11:12 +0100
Message-Id: <20260611181119.2822E1AC56C9@finisterre.sirena.org.uk>
Message-ID-Hash: 2Y6A5W3ADHFLK3GLZRVXSSG2QO2FRRZ4
X-Message-ID-Hash: 2Y6A5W3ADHFLK3GLZRVXSSG2QO2FRRZ4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2Y6A5W3ADHFLK3GLZRVXSSG2QO2FRRZ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit d2dcd85f9e09fe3566d4cdcd357856a42ac73f93:

  ASoC: amd: acp70: add standalone RT721 SoundWire machine (2026-06-04 11:35:06 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc7

for you to fetch changes up to e4c60a1d4b6ccc66aefb3789cd908d4f9482eefd:

  ASoC: SDCA: fix NULL pointer dereference in sdca_dev_unregister_functions (2026-06-11 15:55:23 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.1

A few more fixes for this release, some smaller driver specific ones
plus a final quirk.

----------------------------------------------------------------
Felix Gu (1):
      spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX

Kean Ren (1):
      ASoC: SDCA: fix NULL pointer dereference in sdca_dev_unregister_functions

Li Jun (1):
      ASoC: loongson: Fix invalid position error in ls_pcm_pointer

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix NULL dereference when removing firmware controls

Vijendar Mukunda (2):
      ASoC: SOF: amd: fix for ipc flags check
      ASoC: SOF: amd: set ipc flags to zero

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1403CDA

 drivers/spi/spi-rzv2h-rspi.c          |  3 ++-
 sound/soc/amd/yc/acp6x-mach.c         |  7 +++++++
 sound/soc/codecs/wm_adsp.c            |  3 +++
 sound/soc/loongson/loongson_dma.c     | 12 ++++++++++--
 sound/soc/sdca/sdca_function_device.c | 24 +++++++++++++++++++++---
 sound/soc/sof/amd/acp-ipc.c           |  4 ++--
 sound/soc/sof/amd/acp.c               | 28 ++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h               |  2 ++
 8 files changed, 75 insertions(+), 8 deletions(-)
