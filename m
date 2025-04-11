Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68542C36010
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:54:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42ABC6A12E;
	Fri, 11 Apr 2025 13:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42ABC6A12E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1744372478;
	bh=6ABG1ZFmbBEXp5NO6ilg/AqZBi8gpFC8O1zgkDOQYJk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=D84VirEW1GusniJbeNYdTo5698J7kKck0rlCdznzTcLQTav3JpX0VigZX5N1oVV1T
	 tdvUWl7RFeY8mb+PlXRUocp6G+GF9IvjmyvzQpxo58JoAL8Ei8NI+3xkDKPHcSr1+M
	 hkZY3gtPay6xSY7YXE3OAi7X3cloaQxNvK3+Vjaw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B892F805C5; Fri, 11 Apr 2025 13:54:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA38BF805C0;
	Fri, 11 Apr 2025 13:54:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58594F8025F; Fri, 11 Apr 2025 13:53:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F2044F80124
	for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2025 13:53:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2044F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sCVmRcQA
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 546B55C67E0;
	Fri, 11 Apr 2025 11:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97435C4CEE2;
	Fri, 11 Apr 2025 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744372393;
	bh=6ABG1ZFmbBEXp5NO6ilg/AqZBi8gpFC8O1zgkDOQYJk=;
	h=From:To:Cc:Subject:Date:From;
	b=sCVmRcQASDHO7DFYUwml4/+IF3uDLXKLfapYijqpiIRg4/zCas3TzJTzcrbhQOSiS
	 F/3sLLKn/vR9fg0BAv5WAF/1WhJErBSWtzjnGaKnyYmKngZUSdmMnUaW3bu6rKH5i4
	 AY7G0s/Fw1/rKFmD/nGtTIpSlrwFYM1K7oAICmnoLYzRRc79Tz6HUoElLzkWeHQJ9x
	 TE3Glmjm26/NAxSrQiToZPeH/K9KEsm/PcnPrElvqjfnW5qWbc80RjAQc5hxPsQYBE
	 zpDCgS/kE2rFWQhwN3HZ0Cw168MoXdaqrpjGbTU7KZWrU1Lg+eNHDkGE+u8HiUaRz+
	 2KxWzPC37+2uw==
Message-ID: <4188eaa8e7f745f659ea1adbc4cf3375.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v6.15-rc1
Date: Fri, 11 Apr 2025 12:53:04 +0100
Message-ID-Hash: VZI4TJ5QNJ6KFU6FUQ7SZZZXNPVQIRLC
X-Message-ID-Hash: VZI4TJ5QNJ6KFU6FUQ7SZZZXNPVQIRLC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VZI4TJ5QNJ6KFU6FUQ7SZZZXNPVQIRLC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.15-rc1

for you to fetch changes up to e6c4618422a25cb266bf752040eb509865caeb0e:

  MAINTAINERS: update my email address (2025-04-11 06:17:24 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.15

A set of small fixes, quirks and device ID additions that came in since
-rc1, none of them super stand out.  There's also a change to Srini's
email address in MAINTAINERS.

----------------------------------------------------------------
Amadeusz Sławiński (1):
      ASoC: Intel: avs: Constrain path based on BE capabilities

Brady Norander (1):
      ASoC: dwc: always enable/disable i2s irqs

Charles Keepax (1):
      ASoC: cs42l43: Reset clamp override on jack removal

Evgeny Pimenov (1):
      ASoC: qcom: Fix sc7280 lpass potential buffer overflow

Henry Martin (1):
      ASoC: Intel: avs: Fix null-ptr-deref in avs_component_probe()

Herve Codina (1):
      ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on TRIGGER_START event

Kuninori Morimoto (1):
      ASoC: hdmi-codec: use RTD ID instead of DAI ID for ELD entry

Mark Brown (2):
      ASoC: codecs: lpass-wsa: fix VI capture setup.
      MAINTAINERS: update my email address

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S16

Richard Fitzgerald (1):
      firmware: cs_dsp: test_bin_error: Fix uninitialized data used as fw version

Shengjiu Wang (1):
      ASoC: fsl_asrc_dma: get codec or cpu dai from backend

Srinivas Kandagatla (4):
      ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
      ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels
      MAINTAINERS: use kernel.org alias
      mailmap: Add entry for Srinivas Kandagatla

Weidong Wang (1):
      ASoC: codecs: Add of_match_table for aw888081 driver

 .mailmap                                           |   2 +
 MAINTAINERS                                        |   8 +-
 .../firmware/cirrus/test/cs_dsp_mock_mem_maps.c    |  30 ------
 drivers/firmware/cirrus/test/cs_dsp_test_bin.c     |   2 +-
 .../firmware/cirrus/test/cs_dsp_test_bin_error.c   |   2 +-
 include/linux/firmware/cirrus/cs_dsp_test_utils.h  |   1 -
 sound/soc/codecs/aw88081.c                         |  10 ++
 sound/soc/codecs/cs42l43-jack.c                    |   3 +
 sound/soc/codecs/hdmi-codec.c                      |  22 +++-
 sound/soc/codecs/lpass-wsa-macro.c                 | 117 +++++++++++++++------
 sound/soc/dwc/dwc-i2s.c                            |  13 ++-
 sound/soc/fsl/fsl_asrc_dma.c                       |  15 ++-
 sound/soc/fsl/fsl_qmc_audio.c                      |   3 +
 sound/soc/intel/avs/path.c                         |  72 +++++++++++++
 sound/soc/intel/avs/path.h                         |   5 +
 sound/soc/intel/avs/pcm.c                          |  52 ++++++++-
 sound/soc/intel/boards/sof_sdw.c                   |   1 +
 sound/soc/qcom/lpass.h                             |   3 +-
 18 files changed, 277 insertions(+), 84 deletions(-)
