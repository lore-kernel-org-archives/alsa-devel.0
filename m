Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8768AC61DC6
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:24:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6689D60274;
	Thu, 27 Aug 2026 15:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6689D60274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787837040;
	bh=I6FlKsaIiTQxYA5IAPr48r8AXyk9ZIVzBV8TSggdKro=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qBScPP5S83wZV7rCKw6DZrIi2ZkOdIo5iu9Sk02TDGKDmo4ZARjOeBYYRdJwY+bYg
	 z3t/ruSRAoG/Rs42mgmBLRyYW3qJ7+EaVCQWdBUHgURw35rcptCh/4jwxwYWPr38r1
	 60qQkkLv9SZw18boBk1UNZPoGkA2DH1O9VZHEbwo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECEEEF805EF; Thu, 27 Aug 2026 15:23:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B66F8F80602;
	Thu, 27 Aug 2026 15:23:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F111BF8047D; Thu, 27 Aug 2026 15:23:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787836995;
	b=OYv+YWVZrbCQWPL5Xcl4ec2baIWsaBEMSbf6y4aD6EmjBUCLVwAfNMMTVuwJdsavlM5r
	 7gnJi7nPHXrSKUJajyUuWS2RkBssiNdScMi6wA3Vd3VRYpXfJ/2mBV7tIfP7kpfOmKr8I
	 zmIl5zosSgDj2/aG8A+2wBIFoKpXHQMli6tJX38ax7dOETqKvyjpS8mRGW82KASqPkFGN
	 6HV9xhqGcgwWa9LmWX2bE/CZPSWyPxUFSN98KHcss6rUEMR1rcg8a4IU1tGfqA5Yo1dyz
	 UsuPo7bRhFPxIjNG4J7XPxzSxHxkAw8DruUeknXHa3VyAkjGMu7Cw5zinsdUXxypKuA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787836995;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=I6FlKsaIiTQxYA5IAPr48r8AXyk9ZIVzBV8TSggdKro=;
	b=c14oWs3O8NRHrEJqCILViSzGj35miY/gPosIRCNgOOJrVT5iliFqgqi7I/8y0nlLt+5P
	 MMZxdlHgj9impTNOs15df9pr+pkzV0P9gTIOTNkj6BDsY9QqyCzJrtKVx78DK2RHE7vx1
	 uq/AwTLIWk05oe6z7zFYO54rPp1gY6ZQEXvgRYlVjarPjPYIqRaaaAwN1xJP1YTmRpj7c
	 CaOE8yMsmZRwHI293oJQhdPUEcp4MPBjjdpGaEye0HsZhUqI0x70r+QVRc1zSfJNB0LZu
	 Ixux3IGXnIuxly2hU0uBOYnZa6hn64FtPTHAPVmUPe3A4rjBZ8nQvsKAfNY51EVfcwQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MpNOmiBz;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 94876F8011B
	for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2026 15:23:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94876F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MpNOmiBz
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id BBABC600D2;
	Thu, 27 Aug 2026 13:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EB5C91F000E9;
	Thu, 27 Aug 2026 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787836990;
	bh=j42Ftv0SC1OUWcgy6ui//FzXdBesogup0aH3DH/2bCY=;
	h=From:To:Cc:Subject:Date;
	b=MpNOmiBzxqc84TwO+mbGZDhk2Lh/xag3yHA6eWyv1aBRfb5nSRMXldEQYkM9TN8Nb
	 XIixHlk87VfQ+le635mHaQzUMYuoYQyqgnJ3akQy280rpMSk/AGIU+9KYm9KwIRJ/5
	 2kA8nIW+9QyNS9oo0yubCBRYc1MWHZOfTnq9A1YJRM3x3dDPJQ9YoehqCBHfQ/K7CE
	 0Zp86u4TGFxseb6i/088O7O0eU6Yv1+SUByrg6mqNmaD6Cja6HyxFoMsI9l0P5BNj9
	 ehOzCRyN/YaxD942bFKV5aGXuMNZiVslxu8zl8wpqMEYahSJMrW3c+NId0uCfZHgzH
	 uTIAysrSiM/Wg==
Message-ID: <b334f5b2d0e7c0c73107f54bfee509b1@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-merge-window
Date: Thu, 27 Aug 2026 14:22:59 +0100
Message-ID-Hash: NNZGT44ICJQ32E23YB4SEZZUU23L46IQ
X-Message-ID-Hash: NNZGT44ICJQ32E23YB4SEZZUU23L46IQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NNZGT44ICJQ32E23YB4SEZZUU23L46IQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 0c7aeb0f5eceb95b5887bd8e83fef865e5a49a13:

  ASoC: tas2783-sdw: do not treat read-only Controls as writable (2026-08-14 16:20:47 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-merge-window

for you to fetch changes up to 15596a87fcc6fa07a162858e5fd00ba31752096b:

  ASoC: amd: acp-config: change quirks to cover all ASUS FA401EA variants (2026-08-27 00:15:37 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.3

A fairly big batch of fixes that came in during the merge window.
There's a lot of quirks for x86 systems and a bunch of driver specific
fixes, the most critical being the fixes for Tegra's register
definitions.  It turned out that they had been relying on the regmap
default handling bugs that were fixed in v7.2 and so audio was fairly
badly broken, unfortunately the issue wasn't noticed in time for
release.

----------------------------------------------------------------
Andrey Golovko (2):
      ASoC: sdw_utils: prepare the stream again when resuming
      ASoC: tas2783-sdw: power the Function up before preparing the port

Binbin Zhou (1):
      ASoC: loongson: Fix naming of machine event and DAPM widgets

Christopher Tolang (1):
      ASoC: amd: yc: Add DMI entry for MSI Thin A15 B7UC

HyeongJun An (1):
      ASoC: dapm: Fix off-by-one check on the second enum channel

Jack Yu (2):
      ASoC: sdw_utils: fix double put_device() on aggregated amps
      ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV mode

Jon Hunter (4):
      ASoC: tegra: Fix the I2S enable default value
      ASoC: tegra: Fix the MIXER enable default value
      ASoC: tegra: Sort ADMAIF register defaults
      ASoC: tegra: Sort MBDRC register defaults

Julian Braha (1):
      ASoC: fix unmet dependencies on PPC_BESTCOMM and SND_SOC_AC97_BUS

Kuninori Morimoto (1):
      ASoC: codec: max98926: fixup invert setup mask

Mark Brown (3):
      ASoC: qcom: Fix AudioReach TDM review findings
      ASoC: tas2783: prepare the port again on the resume path
      ASoC: tegra: Fixes for issues exposed in Linux v7.2

Mehmet Aysel (2):
      ASoC: amd: acp-config: Add HVY-WXX9/M1060 DMI quirk
      ASoC: amd: acp3x-es83xx: Add HVY-WXX9/M1060 DMI quirk

Niranjan H Y (3):
      ASoC: sdw_utils: Set component_name for tac5xx2 codec family
      ASoC: tac5xx2-sdw: Rename gain and volume macros
      ASoC: tac5xx2-sdw: update default regmap registers

Prasad Kumpatla (4):
      ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Rename QAIF clock IDs
      ASoC: qcom: qdsp6: Zero-initialize AudioReach module config
      ASoC: qcom: common: Distinguish missing and invalid TDM slot configuration
      ASoC: qcom: sc8280xp: Fix TDM hw_params error handling

Sehat Mahde (1):
      ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 16

Shengyu Qu (1):
      ASoC: amd: acp-config: change quirks to cover all ASUS FA401EA variants

Shuming Fan (1):
      ASoC: rt766: add RT766/RT767 VA1 device IDs

Zhang Heng (1):
      ASoC: amd: yc: Add DMI entry for Alienware m18 R1 AMD

bui duc phuc (1):
      ASoC: soc-generic-dmaengine: Fix DMA channel request warning

 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |  56 +++---
 sound/soc/amd/acp-config.c                         |  23 ++-
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |   8 +
 sound/soc/amd/yc/acp6x-mach.c                      |  14 ++
 sound/soc/codecs/max98926.c                        |   2 +-
 sound/soc/codecs/rt712-sdca.c                      |   1 +
 sound/soc/codecs/rt712-sdca.h                      |   1 +
 sound/soc/codecs/rt766-sdca-sdw.c                  |   2 +
 sound/soc/codecs/tac5xx2-sdw.c                     | 118 ++++++------
 sound/soc/codecs/tac5xx2.h                         |   5 +-
 sound/soc/codecs/tas2783-sdw.c                     |  20 ++
 sound/soc/fsl/Kconfig                              |   4 +-
 sound/soc/fsl/efika-audio-fabric.c                 |   2 -
 sound/soc/fsl/pcm030-audio-fabric.c                |   2 -
 sound/soc/loongson/loongson_card.c                 |  14 +-
 sound/soc/qcom/common.c                            |   6 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   4 +-
 sound/soc/qcom/qdsp6/q6prm-clocks.c                |  56 +++---
 sound/soc/qcom/qdsp6/q6prm.h                       |  56 +++---
 sound/soc/qcom/sc8280xp.c                          |  21 ++-
 sound/soc/sdw_utils/soc_sdw_rt_amp.c               |   2 +
 sound/soc/sdw_utils/soc_sdw_utils.c                |  28 ++-
 sound/soc/soc-dapm.c                               |   2 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |  20 +-
 sound/soc/tegra/tegra210_admaif.c                  | 208 ++++++++++++++-------
 sound/soc/tegra/tegra210_i2s.c                     |  20 +-
 sound/soc/tegra/tegra210_i2s.h                     |   1 +
 sound/soc/tegra/tegra210_mbdrc.c                   |  42 ++---
 sound/soc/tegra/tegra210_mixer.c                   |  10 +-
 29 files changed, 461 insertions(+), 287 deletions(-)
