Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFAC79FB7
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:41:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8192160295;
	Wed,  9 Sep 2026 15:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8192160295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788961300;
	bh=Oh6LCs69HrQa/5CPiYGxJu2O5OytHwOBnLQZTrlelB8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RiekcUoFBCuskyJTY4xyq7xMMZ637zy6OYFa6NMonWdpYD58zABK/Q48UuSeg9n66
	 etNZrkiBO96aGqO1xNBSbbaNn+/kJC/eDQAV4Z7EoT9rSwdG/rCcgjbdg5O4x/ll5g
	 N0vNOG8Wpp1bKajxfdfESyyf6NYE8TyY0oL13zPY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53A2AF80692; Wed,  9 Sep 2026 14:25:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCDABF80682;
	Wed,  9 Sep 2026 14:25:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E56CAF80676; Wed,  9 Sep 2026 14:25:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788956704;
	b=qTP+Vq6CN/MLWs8kJD+thdELsvgEMM0j/pZjKVShVeyvss7TyJCMTkLCepAbA5i0E8I5
	 khpAaFAczEcLZOITG9wcnJiJgE5STyIsjp3MmhqZe41wQKdaFbFcAMvr2hN6RokCS1ItI
	 KG0WtuTAI8uFAmcZ4TZKbK60rTZoqAMKlXU6q5hpO1NlmL4uYUGm4RgxNDxUwx0/IALZv
	 N0O8ESvyQSGZMK6XtsNzTD+wuGcPcuCLuPpzUBK5HM2/6Xd6DQqUcPoU7m3uDnlQBStK+
	 K0MANHeiPMRm1l2Nau7hKM5ayDY8RuWF/OVqwIFEHwR+63yy4wHI5XYgXzEuH2J7Z+w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788956704;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=Oh6LCs69HrQa/5CPiYGxJu2O5OytHwOBnLQZTrlelB8=;
	b=pq5AZvt+oer1/qkDj2EQAN8YHGi4Gg11PgDrP++8Qj/y4cPlBnsqQzTVPRos3kr487YW
	 sLgKF2aV6apaW77GHnf5Z3KWc1wqA1StwrmgglMNTs0Y+px+IWKivKCrBZtEahAuEcQmV
	 jG5LbvR6enrET147mr8ppKvehLx6tQQH+R4L1N+E/h/QlxbCJRct/HUXxZM+7c8Xsry0m
	 WpK9NS4jsE9bG+y8z6WUcHNIk1WKyo5+guTXD4O2Leue5MxK3fdLdod6isEf5GP7B00JG
	 ji3ovpaASOOMIWJXWmp3yj4Syhl4r2ihNb9kYovU8Bt/ekEwG4ui86pr1MPxYDW7UYQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YDvOr0NA;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id D32FEF80607
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 14:25:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D32FEF80607
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YDvOr0NA
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 1DFBE60230;
	Wed,  9 Sep 2026 12:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AFE11F00A3A;
	Wed,  9 Sep 2026 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788956699;
	bh=lKRybCl3ZB8PHNRXZYkUpM6tYQN9bvZm8Q3Xz0YWvtY=;
	h=From:To:Cc:Subject:Date;
	b=YDvOr0NAjhaAWVoMJwuhffZN+cfovm0C++C0SBIk2GcXznzwO5vOZgXvLZBNvjY4D
	 B6MS+BGBYjvqsaV4TlxNNIU/ufofW3637xsq/3ND0ZGFiT88WLyz/r6sIS4+NsVuli
	 /C5Eq6zZ1ErF+Y/aO+7FZ5onHZ/Z4C6YkmPZ9fSOUd1YGvb6+kCS3ZdxJiDQPmTM9+
	 TJr75YX3o8aqK/uK03Rb8CQXkViWxXQX2ap61F6V/YYlWLy0fPfWr5vte1iMMtZiPo
	 nXqKvtnNANWiMB2ZrXuIMYd3jsE6g8GeXPeh16rho6KS1Lmx4gmvMp8h67Zkh2B1Ho
	 0STHcgxe8kggA==
Message-ID: <ef950e391b7a5d9d8054cc53d4f88da1@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc2
Date: Wed, 09 Sep 2026 13:24:52 +0100
Message-ID-Hash: 4RGI4V3AITHBYMS4XH33WPHBAP7C7NSL
X-Message-ID-Hash: 4RGI4V3AITHBYMS4XH33WPHBAP7C7NSL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RGI4V3AITHBYMS4XH33WPHBAP7C7NSL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc2

for you to fetch changes up to 7e125889f1705fc6326679a3db3b4159f7a8c87e:

  ASoC: amd: acp-da7219-max98357a: don't bind on Raven/Picasso boards (2026-09-08 15:59:06 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.3

An unusually large batch of fixes here, partly due to me not sending a
pull request last week and partly due to Linus' fixes for the Ericsson
systems.  I'm fairly sure he's the only user there so it seemed low risk
to handle as fixes.  We also have a batch of error handling fixes from
Cezary and issues with uninitialised stream_config->type from Shuming
both of which had user error reports attached.  Otherwise everything is
a fairly normal combination of quirks and device specific fixes.

----------------------------------------------------------------
Aaron Welwood (1):
      ASoC: amd: yc: add quirk for Acer Nitro AN17-41 internal mic

Antoine Monnet (1):
      ASoC: tas2783-sdw: split a stereo stream across the two mono amps

Cezary Rojewski (10):
      ALSA: hda: ext: Clean up links if their initialization fails
      ALSA: hda: ext: Clean up streams if their initialization fails
      ASoC: Intel: avs: Clean up the bus when its initialization fails
      ASoC: Intel: avs: Clean up the bus when fetching ML caps fails
      ASoC: Intel: avs: Clean up streams if their initialization fails
      ASoC: Intel: avs: Do not ignore -ENOENT when loading a topology
      ASoC: Intel: avs: Cancel d0ix_work asynchrounously during recovery
      ASoC: Intel: avs: Fix unbalanced module reference count
      ASoC: Intel: avs: Refactor and fix init_config access
      ASoC: Intel: avs: hda: Constrain MSBs on startup

Jack Yu (1):
      ASoC: rt721-sdca: Adjust latency control to fix no-sound issue

Jairaj Arava (1):
      ASoC: Intel: sof_rt5682: Add support for nvl_max98360a_rt5682

Linus Walleij (15):
      ASoC: ab8500: Reset the audio block before configuring it
      ASoC: ab8500: Repair the DAPM capture graph
      ASoC: ab8500: Correct digital interface format setup
      ASoC: ab8500: Validate and program TDM slots correctly
      ASoC: ab8500: Remove the nonfunctional sidetone apply control
      ASoC: ab8500: Skip missing DMIC GPIOs on AB8505
      ASoC: ux500: Fix MSP stream lifecycle handling
      ASoC: ux500: Propagate MSP setup errors
      ASoC: ux500: Correct MSP frame and bit clock setup
      ASoC: ux500: Validate MSP DAI configuration
      ASoC: ux500: Deassert the MSP reset during probe
      ASoC: ux500: Request the MSP MMIO resource
      ASoC: ux500: Remove obsolete PRCMU QoS calls
      ASoC: ux500: Allow repeated MSP prepare calls
      ASoC: ux500: Program the MSP FIFO watermarks

Mark Brown (3):
      ASoC: ab8500: Fix codec reset, routing and DAI setup
      ASoC: ux500: Fix MSP lifecycle, clocking and resources
      ALSA/ASoC: Intel: avs: HDAudio bus and general fixes

Niranjan H Y (1):
      ASoC: Intel: sof_sdw: add tac5xx2-sdw family

Richard Fitzgerald (3):
      ASoC: cs35l56: Fix pm_runtime imbalance if suspending before first attach
      ASoC: cs35l56: Fix probe deadlock waiting for SoundWire enumeration
      ASoC: cs35l56: Fix race between kexec and snd_soc_register_component()

Runyu Xiao (1):
      ASoC: sti: initialize IRQ lock before requesting IRQ

Shuming Fan (6):
      ASoC: rt766: fix uninitialized stream_config->type
      ASoC: rt712: fix uninitialized stream_config->type
      ASoC: rt1320: fix uninitialized stream_config->type
      ASoC: rt1318: fix uninitialized stream_config->type
      ASoC: rt721: fix uninitialized stream_config->type
      ASoC: rt722: fix uninitialized stream_config->type

Syed Saba Kareem (1):
      ASoC: amd: yc: Add DMI entry for HP 255R G10 laptop

Tianchu Chen (1):
      ASoC: sprd: validate compress buffer sizes against fixed allocations

Yorick Rommers (1):
      ASoC: amd: acp-da7219-max98357a: don't bind on Raven/Picasso boards

Zhang Yi (2):
      ASoC: codecs: ES8326: issue about capture pop
      ASoC: codecs: ES8389: Prevent enable_count underflow in clk_core_disable

hpp.iscas (3):
      ASoC: bcm: bcm63xx: Publish the OF module aliases
      ASoC: Intel: SST: Publish the PCI module aliases
      ASoC: mt6351: Publish the OF module alias

wangdicheng (2):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits
      ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

Ștefan Ghețu (1):
      ASoC: fsl_micfil: balance mclk enable/disable

 sound/hda/core/ext/controller.c                   |   4 +-
 sound/hda/core/ext/stream.c                       |   5 +-
 sound/soc/amd/acp-da7219-max98357a.c              |  23 +
 sound/soc/amd/renoir/acp3x-pdm-dma.c              |   2 +-
 sound/soc/amd/yc/acp6x-mach.c                     |  14 +
 sound/soc/amd/yc/acp6x-pdm-dma.c                  |   2 +
 sound/soc/bcm/bcm63xx-i2s-whistler.c              |   1 +
 sound/soc/codecs/ab8500-codec.c                   | 682 +++++++++-------------
 sound/soc/codecs/cs35l56-sdw.c                    |   7 +-
 sound/soc/codecs/cs35l56.c                        | 116 +++-
 sound/soc/codecs/cs35l56.h                        |   2 +
 sound/soc/codecs/es8326.c                         |  19 +-
 sound/soc/codecs/es8389.c                         |  34 +-
 sound/soc/codecs/mt6351.c                         |   1 +
 sound/soc/codecs/rt1318-sdw.c                     |  24 +-
 sound/soc/codecs/rt1320-sdw.c                     |   2 +-
 sound/soc/codecs/rt712-sdca.c                     |  17 +-
 sound/soc/codecs/rt721-sdca.c                     |  17 +-
 sound/soc/codecs/rt722-sdca.c                     |  16 +-
 sound/soc/codecs/rt766-sdca.c                     |   5 +-
 sound/soc/codecs/tas2783-sdw.c                    |  25 +
 sound/soc/fsl/fsl_micfil.c                        |  21 +-
 sound/soc/intel/atom/sst/sst_pci.c                |   1 +
 sound/soc/intel/avs/boards/hdaudio.c              |  17 +
 sound/soc/intel/avs/core.c                        |  59 +-
 sound/soc/intel/avs/debugfs.c                     |  12 +-
 sound/soc/intel/avs/ipc.c                         |   6 +-
 sound/soc/intel/avs/path.c                        |  11 +-
 sound/soc/intel/avs/pcm.c                         |  34 +-
 sound/soc/intel/avs/topology.c                    |  49 +-
 sound/soc/intel/avs/topology.h                    |   5 +-
 sound/soc/intel/boards/Kconfig                    |   4 +-
 sound/soc/intel/boards/sof_rt5682.c               |   8 +
 sound/soc/intel/common/soc-acpi-intel-nvl-match.c |   8 +-
 sound/soc/sprd/sprd-pcm-compress.c                |  15 +-
 sound/soc/sti/uniperif_reader.c                   |   4 +-
 sound/soc/ux500/ux500_msp_dai.c                   | 189 +++---
 sound/soc/ux500/ux500_msp_dai.h                   |  14 +-
 sound/soc/ux500/ux500_msp_i2s.c                   | 264 ++++++---
 sound/soc/ux500/ux500_msp_i2s.h                   |  12 +-
 40 files changed, 955 insertions(+), 796 deletions(-)
