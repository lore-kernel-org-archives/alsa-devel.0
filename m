Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F595606A331
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=isPNw9/V;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2Q5aYHO
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2BAD6018E;
	Thu, 19 Nov 2026 23:42:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2BAD6018E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795128174;
	bh=hO9jYRGam2jpJGQplyxUZyD7doS9Qj0TCRCaOP0zYBU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=isPNw9/VZk+F4SJ8/2zfzVth/qxV9R+MBQgx85JbZVCHYoNrTs1kAo3+lTWZB/Dxa
	 Vf+W5JGXiVXCMLYzWd+k+biEEWQWRw0QiJSkdp2oZCnAyIiug+KV5NktXYoybvtVNG
	 i7/SNxavNvD5LdUnwjFQg+alsYvkfEPo/jVV7hzM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A7A7F805F8; Thu, 19 Nov 2026 23:42:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A343EF805F7;
	Thu, 19 Nov 2026 23:42:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93B3FF805C5; Thu, 19 Nov 2026 23:42:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795128133;
	b=egv7AO+GHtSed0l7G/2qdKdrwXP0PM73Cn7x06VkaOL6m5LTeGyGxvBxyBbue/wwF9hI
	 t1PvirLvphWP4KtdFtIEsethQiGUel74ie/Y18K4PdtBIyTIuj7/ys18lm4y7bGg6R5lQ
	 /e9kc4o8/4VMx0K57BCH1uvuCBAK7VEmrBzgDN+tuLnaFYEd1iP/2Gs0BHhd5U8m3Fub2
	 Vqv9U933mhLEQupwAH4b7JrlGTXv+ABqWx9VxwkoNf+hbRbyrsjvC14Ro86fAbmTZAJAE
	 YsC8TVQSSuJVI9StPFwl9Imo2B+QZ5J0qvjPahdMMx/WU/B64Vuq1Amb0ePF/0keDdg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795128133;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=hO9jYRGam2jpJGQplyxUZyD7doS9Qj0TCRCaOP0zYBU=;
	b=FNiQykx+2osz4BJDNct8gPMIh9QwYtIC+YcwwSSnQQIole/Xe9qgYTBkPAwFvk/x5fv+
	 mSaDk3txgr6HjcppkanqfGTthpS29EAxBPByyZ/A6ug5nYaw0oeAoH8hgNkrQJcgcCnnR
	 ja1+EZj6gq2jMRYRhHGmLXlBRF8Tak4Bs7ZpqGA7z1RH2MfSo7ulCfwl6MUh/m0t5XkkG
	 tn0xmKvOEYuiUs9MmlIGhsrn3IbT8OY58HG0IVkZMEqsUyBwQ4c2YZppO7SvhyF4ip6rd
	 MvYi9MVt3bNLe5fwfGMxj5Hnn8zKmw2OMlpi9NOS4grzzEea27ZLy/zmQebezmZOzvg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a2Q5aYHO;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 4C6ECF80124
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2026 23:42:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C6ECF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a2Q5aYHO
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 1639945C8C;
	Thu, 19 Nov 2026 22:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7156D1F000C6;
	Thu, 19 Nov 2026 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795128128;
	bh=/O1B1xDAZlirZkNxJzaQl6uJoZo21AYtgyaaiGTPBGg=;
	h=From:To:Cc:Subject:Date;
	b=a2Q5aYHOboRXFZPmuS9Le00ETRVWXOc3ky1KX6BJRs8oHHFUH7Bj1HFacIEHwPEAV
	 6uITPrLxlRqDhdTaUayWNDgzSH/fuWUriE1cxqOWhkQ1lUa5OBY6lknSgaxSvawTzH
	 WHnbq/jL0coapV1SwZIqn+htGm0Ub2M0MgN/H+Z9WGhrnXUg+wgS3cISTPu/n+qnSq
	 WPUhDnmcltf1B+5iQDIa8nFylJWHjIqXMAyNIA4hNHUgUlwCrlVxzWRj0mJYKmB5Ly
	 eWehnhXyCRrr9iiCoRBYAC+q4/FJ0dM0kzZu/IN2fXZP/91sjBjdKOXxQEQ/ynT+b8
	 xOPubtGoHxepA==
Message-ID: <1d2dffbb27f822112be2ca68c0bcf7d8@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.4-rc3
Date: Thu, 19 Nov 2026 22:41:25 +0000
Message-ID-Hash: 6C2E4DPZYMFTLJROVZR55BY5CO54J6IG
X-Message-ID-Hash: 6C2E4DPZYMFTLJROVZR55BY5CO54J6IG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6C2E4DPZYMFTLJROVZR55BY5CO54J6IG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc3

for you to fetch changes up to f66297be665c067d2e96da9ce1c5767b587e17b7:

  ASoC: tas2781: Avoid possible zero-division (2026-11-19 17:34:26 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.4

Quite a lot of fixes here together with a few quriks for new devices,
mostly not particularly remarkable.  The Cirrus changes are relatively
large but reasonably so, there's a bunch of data table updates and a
couple of new functions needed and they come with clear reasonining.

----------------------------------------------------------------
Adolfo Morales Tena (1):
      ASoC: amd: yc: Add DMI quirk for GIGABYTE EAGLE 9MJ

Chen Yuxi (1):
      ASoC: wm8962: Fix broken headset button caused by wrong guard constant

Gaurav Suman (1):
      ASoC: codecs: wcd934x: keep MCLK enabled so init writes reach the codec

Julius Bairaktaris (2):
      ASoC: qcom: q6apm-dai: reject compress rings larger than the DMA buffer
      ASoC: qcom: q6asm-dai: reject compress rings larger than the DMA buffer

Karl Asseily (1):
      ASoC: es9039q2m: Enable the DAC clock at component probe

Louis-Alexis Eyraud (1):
      ASoC: mediatek: mt8195: Fix ETDM3_OUT DAI startup error

Marc Herrero (2):
      ASoC: qcom: audioreach: use a 32-bit container for S24_LE PCM
      ASoC: qcom: audioreach: only disconnect the route a mixer control owns

Mark Brown (4):
      ASoC: cs35l56: Series to stop writing ASP registers the driver doesn't own
      ASoC: qcom: audioreach: fix S24_LE playback and route mixer disconnects
      ASoC: qcom: qdsp6: bound the compress ring by the DMA buffer
      ASoC: meson: gx-formatter: change stream lock from mutex to spinlock

Nicholas E. Andrade (1):
      ASoC: amd: acp: fix PDM ring buffer address on ACP7.x resume

Qianghua Wang (1):
      ASoC: sn624x: add support for the SN6245 part ID

Richard Fitzgerald (2):
      ASoC: cs35l56: Only write ASP1TXn registers when widget is powered-up
      ASoC: cs35l56: Fix unwanted writes to ASP config registers

Takashi Iwai (1):
      ASoC: tas2781: Avoid possible zero-division

Tim Surber (1):
      ASoC: rockchip: i2s-tdm: Don't reset a pending clear in consumer mode

Valerio Setti (3):
      ASoC: meson: aiu-fifo: prevent sleeping when spinlock is held
      ASoC: meson: gx-formatter: change stream lock from mutex to spinlock
      ASoC: meson: gx-formatter: add lockdep_assert_held check

suso (1):
      ASoC: amd: acp: Add ACP70 ACPI flag override for LG gram 16U55U

yzddMr6 (1):
      ASoC: qcom: q6dsp-lpass-clocks: Set driver data before registering clocks

 include/sound/cs35l56.h                           |   2 +-
 sound/soc/amd/acp-config.c                        |   7 ++
 sound/soc/amd/acp/acp-legacy-common.c             |   5 +-
 sound/soc/amd/yc/acp6x-mach.c                     |   7 ++
 sound/soc/codecs/cs35l56-shared.c                 |  38 +-----
 sound/soc/codecs/cs35l56.c                        | 147 +++++++++++++++++-----
 sound/soc/codecs/cs35l56.h                        |   1 +
 sound/soc/codecs/es9039q2m.c                      |  12 ++
 sound/soc/codecs/sn624x-sdca-sdw.c                |   2 +
 sound/soc/codecs/tas2781-fmwlib.c                 |   2 +-
 sound/soc/codecs/wcd934x.c                        |   6 +
 sound/soc/codecs/wm8962.c                         |   2 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c |  18 ++-
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c |  18 ++-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c |  18 ++-
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c |   9 ++
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c       |  30 ++++-
 sound/soc/meson/aiu-fifo-i2s.c                    |  15 ++-
 sound/soc/meson/aiu-fifo-spdif.c                  |  14 ++-
 sound/soc/meson/aiu-fifo.c                        |   3 +-
 sound/soc/meson/gx-formatter.c                    |  26 ++--
 sound/soc/meson/gx-formatter.h                    |   4 +
 sound/soc/meson/gx-interface.h                    |   3 +-
 sound/soc/qcom/qdsp6/audioreach.c                 |  10 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                  |   3 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                  |   3 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c         |  14 +--
 sound/soc/qcom/qdsp6/topology.c                   |   4 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c             |  47 +++++++
 sound/soc/sdw_utils/soc_sdw_utils.c               |  56 ++++++++-
 30 files changed, 413 insertions(+), 113 deletions(-)
