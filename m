Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E436075F4E
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=pVHkr6jw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZ2hw4BH
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42050601DA;
	Thu,  5 Nov 2026 16:54:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42050601DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793894054;
	bh=AV4sL4EBkwy/TW+R6yHlV53n7daKCGs6yL3g6mc8XbA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pVHkr6jwjtbRfDYpA3GQpsKAKfh0Fl3TEI5PZ29TQ2IeVCwoD+O2dMw1A1WoUA31Q
	 TUHpRCpN0b8zgmpBGOQAoyZLzokiKxVdOEo3fe0c85mRiIQ4yhBInzTjEMcrOl/wY2
	 hhWTIwvyiQdm9AcCQsLn2n8mPR2GRBr2eyoZR6ak=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E5BBF805FC; Thu,  5 Nov 2026 16:53:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DB01CF805E3;
	Thu,  5 Nov 2026 16:53:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9213EF804FF; Thu,  5 Nov 2026 16:53:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793894012;
	b=Dd9smYm0YKzWc/AWtW5pAV3EADw208DcaaKGCdTylZaQK7MzXZHji4gscRkOdIYs2u+W
	 eee6Gjx58i2QwPXVCvq6OaS+6XFW0O3YmPKX0jT0sS2KapkoRoNgnt3EtUU2gi/zMR6O8
	 xeL7d/CFX7fSTx9n/KqGC9dnW0uuNT3Px8I/0lH2HS7mSxIqkh2Go2igRbgsOIUFl3Gft
	 lPTCye+0ME1ytO/dWZs0XUfxDqXRzq5iPYEXQiMEuAPvJzo+JXb4uRBvNJLophcl+01bF
	 nIzghCPp9CmSqzanIlMRjWHX6ERi+yKmKROgfnkhNowmRkCT50wdHuiI5Mw7ukQhwyA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793894012;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=AV4sL4EBkwy/TW+R6yHlV53n7daKCGs6yL3g6mc8XbA=;
	b=Jy5MQ5a53Ii1vgQql9GEk62g/xhc5mbw+0xqZZt9pP4SgUs6+JeXyLAIJNbzAWowK0BQ
	 jwZlamHsgyDkmGXUGFlq+BozFdXS9n0KxbPLYm6JsdNhvJtDTlXsAV8pzuCfZR5vRcDb7
	 umc6EYcbIdx4vwZ1oRhP0nFTzgnQKeksojZ6pvezGa6l1Yr7QbsmWH96OdO6uRXB+H4/k
	 bSrc3w5GaYaSk/ho79WDnkv31o3TfXnz3mwVGfPNOEBvW4P90VPclMjHCxC39w3E5XaqM
	 64rTaH+GhSaL4vJ6pGH8pi0V3z/T+xB3t7urdL5vPLRP5S2tSk1/mZS+ejM6i1QQG6g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jZ2hw4BH;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 76C8CF8016D
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:53:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76C8CF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jZ2hw4BH
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 9B44E42A34;
	Thu,  5 Nov 2026 15:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 022391F000C1;
	Thu,  5 Nov 2026 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894008;
	bh=ZoXeME1VoJH8MPp5+b02OOL2nkMX1GuPgK/D2jxmQn8=;
	h=From:To:Cc:Subject:Date;
	b=jZ2hw4BHuu4W566IV++MEfapfw08YJLcgtHHct5XGi70Z0YK2v9MSww/V7TQX/Oig
	 m6QGXFvpEW6Tb87JBxl+vBbTN1J5mSKl+U/PAcADKJ/HKgxXTh8T0PNHrz9JssLO1W
	 z0bORlln0bvJA9yRZRt1hi3/VUhGTITkgTXdacEWrI4Psq1xGBacGZz2gtBYf2MPOO
	 S/yZ0vcLd0AfVikW5xyT6UcJpPhFHods0cbafnOizI9E3tOSH6xeyyNn6w7PNCbQMp
	 emSE5eO9gWW9cmRsTyZTimwx4Z73Xj9fG60M+MsRUznE6yyumFG6Va595ooxiOxqLh
	 QaFKGLPOzmYIQ==
Message-ID: <e5aded615cb3e714bfe90050876a9f98@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.4-rc1
Date: Thu, 05 Nov 2026 15:52:47 +0000
Message-ID-Hash: SJDZ4HTZFQHWTLNTSB6X3Q34TPTR7OAD
X-Message-ID-Hash: SJDZ4HTZFQHWTLNTSB6X3Q34TPTR7OAD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SJDZ4HTZFQHWTLNTSB6X3Q34TPTR7OAD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc1

for you to fetch changes up to cf09d02dc0c49593fdd9e0ec2f17251cba39a94e:

  ASoC: amd: yc: drop duplicated DMI quirk entries (2026-11-05 00:25:11 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.4

More fixes that have come in since -rc1, a lot of this is quirks but
there's some bug fixes as well.  The bug fixes should mostly be those
that seem to be affecting actual users rather than just being pure
static analysis work.  I also took some fixes for missing Kconfig
dependencies which won't have any runtime impact.

----------------------------------------------------------------
Baojun Xu (1):
      ASoC: amd: acp: Add support for more projects on ACP7.0

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

James Calligeros (2):
      ASoC: tas2770: Configure transmit clock edge when setting DAI format
      ASoC: tas2770: Fix error detection in tas2770_set_dai_tdm_idle

Jerome Brunet (1):
      ASoC: meson: axg-fifo: request the irq with the clock enabled

Jude Gyimah (5):
      ASoC: rockchip_i2s: select REGMAP_MMIO
      ASoC: rockchip_i2s_tdm: select REGMAP_MMIO
      ASoC: rockchip_pdm: select REGMAP_MMIO
      ASoC: rockchip_sai: select REGMAP_MMIO
      ASoC: rockchip_spdif: select REGMAP_MMIO

Lee Jones (1):
      ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams

Mark Brown (1):
      ASoC: rockchip: fix missing REGMAP_MMIO dependencies

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Qianghua Wang (2):
      ASoC: Intel: soc-acpi: use dummy topology for SN624x
      ASoC: codecs: sn624x-sdca: limit DMIC capture to 2 channels

Richard Fitzgerald (2):
      firmware: cs_dsp: Fix memory leak on cs_dsp_power_up() error path
      ASoC: wm_adsp: Prevent negative string length in wm_adsp_control_add()

Rodnei Cilto (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 AMN G6

Stefano Radaelli (1):
      ASoC: wm8904: Enable FLL when switching an active SYSCLK to FLL

Tang Bin (1):
      ASoC: codecs: lpass-rx-macro: fix PM ref leak in swclk_gate_enable

Wei Lixiang (1):
      ASoC: amd: yc: drop duplicated DMI quirk entries

Zhang Yi (1):
      ASoC: codecs: ES8389: Fix the issue of hpf_freq keep increasing

 drivers/firmware/cirrus/cs_dsp.c                  |  6 ++++
 sound/soc/amd/acp-config.c                        | 35 +++++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c                     | 35 ++++++++++++++---------
 sound/soc/codecs/es8389.c                         | 17 +++++------
 sound/soc/codecs/lpass-rx-macro.c                 |  2 +-
 sound/soc/codecs/sn624x-sdca-sdw.c                |  2 +-
 sound/soc/codecs/tas2770.c                        | 23 ++++++++++-----
 sound/soc/codecs/tas2770.h                        |  4 ++-
 sound/soc/codecs/wm8904.c                         | 14 +++++++++
 sound/soc/codecs/wm_adsp.c                        | 10 +++++++
 sound/soc/intel/common/soc-acpi-intel-arl-match.c |  4 +--
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c |  4 +--
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |  4 +--
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c |  6 ++--
 sound/soc/meson/axg-fifo.c                        | 28 +++++++++---------
 sound/soc/qcom/qdsp6/q6apm.c                      |  6 ++--
 sound/soc/qcom/qdsp6/q6prm.c                      |  3 ++
 sound/soc/rockchip/Kconfig                        |  5 ++++
 sound/soc/sof/intel/hda-sdw-bpt.c                 |  6 ++++
 19 files changed, 155 insertions(+), 59 deletions(-)
