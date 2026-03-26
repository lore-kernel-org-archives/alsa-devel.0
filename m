Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B810A62CF
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:33:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA317601F7;
	Thu, 26 Mar 2026 14:33:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA317601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774532024;
	bh=K3Pd2wZkhD65L8VyfD4iqOk4NHmtEZ5e2hdzs3gqMyU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sdiFLh94T/0/Z4UKGpLBkG4CSylCpNdsekG+LrabzX1LImUGK1QK3Ih/Xju/pv1vp
	 U0+s6OKh+L76FXNCo5id0yf27VMgyBSx2ByULl2XTvN3JZzyQSIhHMpk25e4luGiNK
	 mW4sl1vwooSSTRkj/R25Wyw+UbKLxJ+7x7nXRZGY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB82FF805F3; Thu, 26 Mar 2026 14:33:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A54A1F805F3;
	Thu, 26 Mar 2026 14:33:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F1E4F80525; Thu, 26 Mar 2026 14:32:58 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E376EF800AC
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2026 14:32:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E376EF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=njD/iAdD
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CD4960103;
	Thu, 26 Mar 2026 13:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBBC116C6;
	Thu, 26 Mar 2026 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774531973;
	bh=K3Pd2wZkhD65L8VyfD4iqOk4NHmtEZ5e2hdzs3gqMyU=;
	h=From:To:Cc:Subject:Date:From;
	b=njD/iAdDKjHxlIowGSVbwhXpO+anmgu62ZawZyKTj3CSwnXuIpgXu5M7S3Y5i0faR
	 xQi6CkLg6lsXo9rUldpns7xHuRpJDJ/wYvVgPGuyQhVYJ7Guu5c6VrK8hG0Q0/Z2dZ
	 7PYfpx0IsgxksHvGNojKGpplJzGs01eVNFcGYra5DYOdb+mgHTv/CJQnHgo2ZIxDou
	 Xyp2r4zveCBfRnMro7nUiVMROi2cYGcH6EcUpj7bEU0VWLg4Pmb6+skXB0bS3HfDDm
	 fOU3gflUsXcx4CmOuCPFXzfvoeId/uC236Ss5JLVYwfN5lFaGglCuX0HSoDagR4hkm
	 5aepVD1XsDK7A==
Message-ID: <35eee6c4ded9dcae303afc38a82c36a1@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.0-rc5
Date: Thu, 26 Mar 2026 13:32:46 +0000
Message-ID-Hash: I4EQZRIJST63EL5A5XAYW34WVZGZDWDA
X-Message-ID-Hash: I4EQZRIJST63EL5A5XAYW34WVZGZDWDA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4EQZRIJST63EL5A5XAYW34WVZGZDWDA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc5

for you to fetch changes up to d40a198e2b7821197c5c77b89d0130cc90f400f5:

  ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload (2026-03-26 11:16:03 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.0

This is two week's worth of fixes and quirks so it's a bit larger than
you might expect, there's nothing too exciting individually and nothing
in core code.

----------------------------------------------------------------
Baojun Xu (1):
      ASoC: tas2781: Add null check for calibration data

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix the device initialization

Cássio Gabriel (1):
      ASoC: SOF: topology: reject invalid vendor array size in token parser

Guangshuo Li (1):
      ASoC: sma1307: fix double free of devm_kzalloc() memory

Hasun Park (3):
      ASoC: amd: acp: add DMI override for ACP70 flag
      ASoC: amd: acp: add PX13 SoundWire machine link for rt721+tas2783x2
      ASoC: amd: acp: add ASUS HN7306EA quirk for legacy SDW machine

Jihed Chaibi (3):
      ASoC: dt-bindings: stm32: Fix incorrect compatible string in stm32h7-sai match
      ASoC: adau1372: Fix unchecked clk_prepare_enable() return value
      ASoC: adau1372: Fix clock leak on PLL lock failure

Mark Brown (2):
      ASoC: fix usage of playback_only and capture_only
      ASoC: adau1372: Fix error handling in adau1372_set_power()

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload

Sebastian Reichel (1):
      ASoC: dt-bindings: rockchip: Add compatible for RK3576 SPDIF

Shengjiu Wang (2):
      ASoC: simple-card-utils: Check value of is_playback_only and is_capture_only
      ASoC: fsl: imx-card: initialize playback_only and capture_only

Shuming Fan (2):
      ASoC: SDCA: remove the max count of initialization table
      ASoC: SDCA: fix finding wrong entity

Srinivas Kandagatla (1):
      ASoC: codecs: wcd934x: fix typo in dt parsing

Vee Satayamas (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK BM1403CDA

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Thin A15 B7VF

 .../devicetree/bindings/sound/rockchip-spdif.yaml  |  1 +
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |  2 +-
 include/sound/sdca_function.h                      |  5 --
 sound/soc/amd/acp-config.c                         | 15 +++++-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |  8 +++
 sound/soc/amd/acp/amd-acp70-acpi-match.c           | 61 ++++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c                      | 14 +++++
 sound/soc/codecs/adau1372.c                        | 34 ++++++++----
 sound/soc/codecs/sma1307.c                         |  6 ++-
 sound/soc/codecs/tas2781-fmwlib.c                  |  3 ++
 sound/soc/codecs/wcd934x.c                         |  2 +-
 sound/soc/fsl/imx-card.c                           |  2 +
 sound/soc/generic/simple-card-utils.c              |  4 +-
 sound/soc/intel/catpt/device.c                     | 10 +++-
 sound/soc/intel/catpt/dsp.c                        |  3 --
 sound/soc/sdca/sdca_functions.c                    | 14 +++--
 sound/soc/sof/ipc4-topology.c                      |  2 +-
 sound/soc/sof/topology.c                           |  2 +-
 18 files changed, 156 insertions(+), 32 deletions(-)
