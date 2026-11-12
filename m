Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FE606A8A7
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ZHhaLzte;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+vozPh8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B943260208;
	Thu, 12 Nov 2026 20:09:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B943260208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794510586;
	bh=eVux9OoaVCo9IVvIZnmxWzCQNut5vi4ZQuvTx6oqnTI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZHhaLzteSW0AKi1u14cmwb52hMox6d21V+xxeEh8Pj6HyM8+h5BL6TjftedDNEyZJ
	 54QZA1u2odTeDhguxLpkCUSJGPrYObA8ctZdW0i9Wopj8uHO8LDjzFjoDefQQODLkx
	 0RUSPmAe60n+Sj3PjmoRLr7P8XuUUeCCjBFQK9tg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0BB8F80603; Thu, 12 Nov 2026 20:09:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6718DF805F2;
	Thu, 12 Nov 2026 20:09:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 720ACF8016E; Thu, 12 Nov 2026 20:09:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794510544;
	b=irKEHNNrlcnIcToADTDmYtA1PkhGVumvvJpNBJuEwQFvf3C+m696ThbONSaUYKylGNt4
	 K9z+cJV8OWFeETZmODkRjxvTyyweHOvYmVKTTI9xwvH+YFCux1PncOjdCa5PPAUjTWz5m
	 fNEW91uU6iIaY0cjV7Rip0SDbkSsNMvTv1W0ElQJWipnH27Xe2OMREm5EtDVcfS2Ec96T
	 QacUHLgc2+IvvkbAW7nXR+wKnEP5EwS3COkmLdML5NixoZWlA58q2qIGCveI8aDhiLuLd
	 EB/omBItWPQYZW57HJKdDwAzcfkVj4iyt5Vl0Kmnm+enPYEhExzA0qEPEOTcDcovrGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794510544;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=eVux9OoaVCo9IVvIZnmxWzCQNut5vi4ZQuvTx6oqnTI=;
	b=iLyygvblmwzi7IOGuZ2visOSu0Cey4EdmP2pLspxuCVC+R08UYV/kHlqha9DeY2Jhipb
	 eN5x2C+F0TpiU3Yg5wT9oo6t3eZiT2k6upjtng9wplWHd1BgQoY+efFsaeMm8dmud18dF
	 1b6OSQqo84WOFk9NPDTrWCn1McAKfdMFifKIyCjvriQpCSeHyb7CH0CUeIjZflmZdjJIi
	 0d0IkF6RroOFmUY88Nnz7G3ze1Td8KQrvPyYzTay/UlQyIZb/E+vSV23N4qTvwHB1F4s7
	 CtqGTj20L3s/h7EMSp+17eeg70XdcBs4sy/AqjVGG7kqv7zsLj8OzTYAHzNOJROz16A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+vozPh8;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 47A49F80016
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 20:09:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47A49F80016
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+vozPh8
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id F2BA641A4A;
	Thu, 12 Nov 2026 19:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5A5D71F000C4;
	Thu, 12 Nov 2026 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510539;
	bh=OdHo3ZQZyH6EvKNdKuQnqRIC5yza3zZ8YxwraOkB5uU=;
	h=From:To:Cc:Subject:Date;
	b=S+vozPh8rnZZGzK80/IXRzJIbrfWdwjFpw3e99/mdcwO1muloZzJqnzBpXcIOI+Kq
	 3Ue7vBf9GrJNU1I552QMFtm5N+ZSg3Bea7WPHzFW90NXsclV1jEvJJoW7IwnHuA93B
	 0cutuUKaZ+BJaty7bxShdcIbiiPZ/78Nv4/EbXjo/z6cqxx8ysQgT9eWS7a2faze65
	 Xk+NA0AyyDjVFs3QrAZRrjKTb34pn/r0mm9VRcxN33BcUciI45xwxvsHJeQn8jphA9
	 vHXxIfQu7uKTSh+tJ3F32MFhiBxddQxz+PaL/FQdgu6dHhDaOLsMtVGl7gQIeCS+Sh
	 omM+WLUDnCV6A==
Message-ID: <da3d9a0821be2c6200c0af618dda6256@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.4-rc2
Date: Thu, 12 Nov 2026 18:55:28 +0000
Message-ID-Hash: MIFSCJCG7L5QIGD34WKA73ULVGHK646D
X-Message-ID-Hash: MIFSCJCG7L5QIGD34WKA73ULVGHK646D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MIFSCJCG7L5QIGD34WKA73ULVGHK646D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc2

for you to fetch changes up to 58d51fa6ff1d21e79c3c340bfb3155dfa3025ca3:

  ASoC: max98090: keep the MIC boost across mic input power-up (2026-11-11 18:05:03 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.4

Another week, another pile of driver specific fixes and quirks.  We do
have one major fix which addresses a bug introduced by confusion with
the counted_by interfaces that was causing major disruption for a number
of platforms.

----------------------------------------------------------------
Baoli Zhang (1):
      ASoC: SOF: ipc4-topology: Fix pin format leak in process widget setup

Emanuele Ghidoli (1):
      ASoC: soc-core: reset rtd->num_components after allocation

HyeongJun An (1):
      ASoC: Intel: sof_sdw: Add quirk for Dell Latitude 9420

Jaehoon Kim (2):
      ASoC: amd: acp: Add ACP70 ACPI flag override for LG gram 16Z95U
      ASoC: amd: acp70: Add rt713 + rt1320 SoundWire machine for LG gram 16Z95U

Janne Grunau (1):
      ASoC: apple: mca: Fix clock selection for clock consumer FEs

LiangCheng Wang (1):
      ASoC: max98090: keep the MIC boost across mic input power-up

Mario Limonciello (1):
      ASoC: SOF: amd: Load alternatively signed firmware with an "_l" suffix

Mark Brown (3):
      ASoC: fix the x1e80100 card after an ADSP restart
      ASoC: amd: acp: Support Huawei MateBook D 14 (NBM-WXX9)
      ASoC: amd: SoundWire audio for LG gram 16Z95U (rt713 + rt1320), speaker still silent

Michael McAllister (1):
      ASoC: qcom: q6asm: Reset PCM positions when preparing a stream

Olivier Louvignes (1):
      ASoC: cs43130: Power the playback path down when the stream closes

Samuel Leyva (2):
      ASoC: amd: acp: Add DMI quirk for Huawei MateBook D 14 (NBM-WXX9)
      ASoC: amd: acp: es83xx: Enable speaker amplifier after the codec output

Tyler Baker (2):
      ASoC: soc-core: copy the DAI link names into the card
      ASoC: qcom: x1e80100: recreate the headset jack on card rebind

Viacheslav-Illia Detsyk (1):
      ASoC: amd: yc: Add DMI quirk for Acer Nitro AN16-41

Vijendar Mukunda (2):
      ASoC: amd: ps: guard adata->sdw dereferences with NULL check in IRQ handler
      ASoC: SOF: amd: guard adata->sdw dereferences with NULL check in IRQ handler

Zachary Huang (1):
      ASoC: es9356: fix the capture gain dB scale

Zhang Heng (3):
      ASoC: amd: yc: Fall back to DMI quirk table when _WOV returns 0
      ASoC: amd: yc: Add DMI quirk for ASUS TUF Gaming A16 FA607NUQ
      ASoC: amd: acp: Add Lenovo Legion 5 15AGP11 to ACP70 override table

 sound/soc/amd/acp-config.c                    | 28 +++++++++
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 24 +++++---
 sound/soc/amd/acp/amd-acp70-acpi-match.c      | 83 +++++++++++++++++++++++++++
 sound/soc/amd/ps/pci-ps.c                     | 32 +++++++----
 sound/soc/amd/yc/acp6x-mach.c                 | 16 +++++-
 sound/soc/apple/mca.c                         | 10 +++-
 sound/soc/codecs/cs43130.c                    |  2 -
 sound/soc/codecs/es9356.c                     |  4 +-
 sound/soc/codecs/max98090.c                   | 22 +++----
 sound/soc/intel/boards/sof_sdw.c              | 10 ++++
 sound/soc/qcom/qdsp6/q6asm-dai.c              |  3 +
 sound/soc/qcom/qdsp6/q6asm.c                  |  2 +
 sound/soc/qcom/x1e80100.c                     | 18 ++++++
 sound/soc/soc-core.c                          | 22 +++++++
 sound/soc/sof/amd/acp.c                       | 61 +++++++++++++++-----
 sound/soc/sof/amd/acp.h                       |  2 +
 sound/soc/sof/ipc4-topology.c                 |  2 +-
 17 files changed, 290 insertions(+), 51 deletions(-)
