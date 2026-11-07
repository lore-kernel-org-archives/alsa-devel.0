Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40660606A326
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ho1tK1yX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp2D95PT
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 001F9600D7;
	Sat,  7 Nov 2026 12:33:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 001F9600D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794051202;
	bh=AV4sL4EBkwy/TW+R6yHlV53n7daKCGs6yL3g6mc8XbA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ho1tK1yXF7ZulEyzR/+XrnGiOGs0UebWDMMeKHQaMA5WX2ROPXIcbDf2hEtynRvsN
	 LCepwaFlHcEJtkr/kxqXqbkWrXS0/0WHeW5e35UZc5scrEQuzp9Wt7Jd+5tigUN39l
	 ZtSjHxIjOJxgfwXDcB1FZSMZLnZ/WnIWs9zhCErU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 001B2F805FC; Sat,  7 Nov 2026 12:32:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB5AF80600;
	Sat,  7 Nov 2026 12:32:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 412C1F805A8; Sat,  7 Nov 2026 12:32:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794051162;
	b=N4S7IY+H1zwBIF1VQHIirdA57JlFM67M35FgbO7NjuqUcu9vvAbOD5VAEe3ba7Im8Tcd
	 o9qGwd91ociUSzCQqfVQ3x+OPQtGpB0hLdPH4xxS4Vu+RRu1tGmZpEnP1WJr7pRuPaHpr
	 O2Th/t4ZoYqRJ6eDUgXPGHS91rGKWMe7sPdURrjiFlYHniSJSeDgjI6NpX07gDRZNcQdm
	 ys/DbDtluAFJEYzGQa063GSnzdVszbHF2jQQ2XdNBYGBIm/EPkx5J/R87yOn788OAf7F+
	 42K+9QhknAqJlYEBb8Oa4duzd//JFbkoNM6o440E+4m+0uGE9MRfYDaeZUKUe3ghgZA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794051162;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=AV4sL4EBkwy/TW+R6yHlV53n7daKCGs6yL3g6mc8XbA=;
	b=ff3KStvQtAGLHpmmvsv3jHYD82IIyLqtvAigskXfs7t9Mo6Qf2j+m86b7S1HHBAMgoia
	 nqoARWDT4qFEfGKzfcUElzkMscaoyCsJ42xHvbzi3WW72RZzf7UbaFgkAqnpyuMM0zv34
	 H1L0XIj3N97nK+z48YBRJ2JF78aL5pnIkxSjxbX71/ZLIAAWsZtG3dS+/Zzii6AcJOc3C
	 PAOwgGKGa+34CkFDq8EvuMwS2OcDE7RNmuckL/GMszXffjwlC4EApMONnuRaPfNpIxcLu
	 uLAoHrc3FeI7OhrEOMsqV0W0UCSuLHPLn1TXuv6dp1pmJe21IR44glN4CG15DH8zVhw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sp2D95PT;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1732DF80124
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 12:32:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1732DF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sp2D95PT
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F255E4077B;
	Sat,  7 Nov 2026 11:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1A11F0089F;
	Sat,  7 Nov 2026 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051156;
	bh=ZoXeME1VoJH8MPp5+b02OOL2nkMX1GuPgK/D2jxmQn8=;
	h=From:To:Cc:Subject:Date;
	b=Sp2D95PTnEKgGiwGWu8Kq7UPrY0JX1PSpDqbMETJ7fgYmElJajtMfi/PPKAT2kM6q
	 dNIgAQxO2QlmiSV1tPzAUAdn29UAqxh3ixtjQu/+bkDl51S96SGnJlwbuu70JQ62J6
	 6Z02Sugp0HvT3xdmSWfBruO7VnThIhCP78lKaF6fhwMly5Gs0QoVAGgVrb+gEdUqla
	 W+xRdRsQT0r1624X0wuVd9nZeSf7bAyuaQH95ecTq9yKq99qOVHxgYkhgxA55MEQ9x
	 Pt+gYWRtuYEMawqObDufiKDojw4Dn5BSACHGaaW3ydNo/rX6LKl52Cw0zvSCJ1bhzm
	 g/3/hVl6q0Eew==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 7C6DB28F32EB; Sat, 07 Nov 2026 11:32:34 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.4-rc1
Date: Sat, 07 Nov 2026 11:32:34 +0000
Message-Id: <20261107113234.7C6DB28F32EB@traversing.sirena.org.uk>
Message-ID-Hash: Q5EI2XZP2Z4SJPAB2YX5XERWTBTIACGA
X-Message-ID-Hash: Q5EI2XZP2Z4SJPAB2YX5XERWTBTIACGA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q5EI2XZP2Z4SJPAB2YX5XERWTBTIACGA/>
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
