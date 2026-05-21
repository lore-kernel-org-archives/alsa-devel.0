Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5010ACD5BBF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:02:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F80460212;
	Mon, 25 May 2026 10:02:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F80460212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779696173;
	bh=YqwSO/MQDWyaoQkaHdID6NQLU0sTUDpnPtqk3XxXZfc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Iv+Z4Wq3nXvO5fAoo9GLilvZskNthVtif00YT7PVM8/TUx+6eVW+SEMPg+OP5Zaw7
	 th46+VTxFrCy5AqBCQdJp/qnfSKYafiS6VJrirwaJZ72VmWV0v6R9jfzakx1f/TVMd
	 84SwCMT15qV57AsB89IRsI0WtOsCN9yaGLBthkRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFB16F805F7; Mon, 25 May 2026 10:02:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 594A8F805EE;
	Mon, 25 May 2026 10:02:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 076E4F80557; Mon, 25 May 2026 10:02:13 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 1E6EBF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E6EBF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bk4dCSb8
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 13A15600FF;
	Thu, 21 May 2026 23:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3A5531F000E9;
	Thu, 21 May 2026 23:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779405739;
	bh=v3hcNsL54Fo5jmpIUL+/cFjwHOgQS2YcPjVL3GyRvXI=;
	h=From:To:Cc:Subject:Date;
	b=bk4dCSb8l0r3/9UX7qeFo7+XtbotiG0CwWCnk0eadOmcm1wlJfCtZrtwMwjrhQzGY
	 49u43ni3wYOtDSjAzK/DbtmLJTRhB2EGne5dRGZ+rBOtARHUZfCB2u/6eAN6kt6OIv
	 w3ZfihVl6qxdhl7OVo43N5gvX0+dbb3WF3NjoR0hQCZvwzcsnrjhCaX4Sbui1901lF
	 tRSGXRoRu9QM/+nDa7V2fW9IESMaysP4OfR5Zsx318lCQlEi5eZKA3If7kWi0iGsfV
	 ntweIGoIOzVx2vdMWHJc2fQGFg/buRlyuQD69xabRilctcdL2irzQ0MNmjnR60RzC8
	 OKVOm/qO2dXQw==
Message-ID: <330b62a00eb5358e06742f419308fa7e@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc4
Date: Fri, 22 May 2026 00:22:11 +0100
Message-ID-Hash: F2LY4VK74NTWIHHV7XSR7WYKOIXODA7P
X-Message-ID-Hash: F2LY4VK74NTWIHHV7XSR7WYKOIXODA7P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F2LY4VK74NTWIHHV7XSR7WYKOIXODA7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc4

for you to fetch changes up to 09e8f9a9aa19aa8c1b0cc7a0ebc68f6ecf86a660:

  ASoC: codecs: pcm512x: fix null-ptr dereference in pcm512x_overclock_xxx_put() (2026-05-21 19:28:24 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.1

A bigger batch of fixes than usual due to -next not happeing last week,
this is mostly stuff for laptops - a lot of quirks and small fixes,
mainly for x86 and SoundWire.  Nothing too big or exciting individually,
just two week's worth.

----------------------------------------------------------------
Alexander A. Klimov (1):
      ASoC: codecs: fs210x: fix possible buffer overflow

Andy Shevchenko (1):
      ASoC: cs35l56: Drop malformed default N from Kconfig

Balamurugan C (1):
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in NVL match table.

Charles Keepax (2):
      ASoC: soc-acpi-intel-ptl-match: Make Chrome matches conditional
      ASoC: Intel: soc-acpi-intel-ptl-match: Remove unnecessary cs42l43 match

Cássio Gabriel (2):
      ASoC: sdw_utils: Check speaker component string allocation
      ASoC: amd: acp-sdw-legacy: check CPU DAI name before logging

Gary C Wang (1):
      ASoC: soc-acpi-intel-arl-match: add rt712_l0_rt1320_l3 support

Ingyu Jang (1):
      ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in omap_dmic_select_fclk()

Jairaj Arava (1):
      ASoC: Intel: sof_sdw: Add support for nvlrvp in NVL platform

Jang Pyohwan (1):
      ASoC: Intel: soc-acpi: add LG Gram 16Z90U RT713 + single RT1320 quirk

Jasper Smet (1):
      ASoC: amd: acp: Add DMI quirk for ASUS Zenbook S16 UM5606GA

Jeongjun Park (1):
      ASoC: codecs: pcm512x: fix null-ptr dereference in pcm512x_overclock_xxx_put()

Krishnamoorthi M (1):
      spi: amd: Set correct bus number in ACPI probe path

Mac Chiang (3):
      ASoC: Intel: soc-acpi-intel-arl-match: Reorder ACPI machine tables
      ASoC: sdw_utils: Add quirk to ignore RT712 CODEC_MIC
      ASoC: sdw_utils: Add quirk to ignore RT721 CODEC_MIC

Mario Limonciello (1):
      ASoC: SOF: amd: Fix error code handling in psp_send_cmd()

Mark Brown (3):
      ASoC: soc-acpi-intel-arl-match: add rt712_l0_rt1320_l3 support
      ASoC: sdw_utils: make RT712/RT721 CODEC_MIC be optional
      ASoC: cs-amp-lib: Some bug and typo fixes

Peter Ujfalusi (2):
      MAINTAINERS: ASoC/ti: Remove myself and add Sen Wang as maintainer
      MAINTAINERS: ASoC: Intel/SOF: Remove Ranjani Sridharan as maintainer

Richard Fitzgerald (5):
      ASoC: cs35l56: Check for successful runtime-resume in cs35l56_dsp_work()
      ASoC: cs35l56: Fix flushing of IRQ work in cs35l56_sdw_remove()
      ASoC: cs-amp-lib: Fix wrong sizeof() in _cs_amp_set_efi_calibration_data()
      ASoC: cs-amp-lib: Fix missing dput() after debugfs_lookup()
      ASoC: cs-amp-lib: Fix typo in error message: write -> read

Rob Herring (Arm) (1):
      ASoC; dt-bindings: mediatek,mt8173-rt5650-rt5514: Fix mediatek,audio-codec constraints

Robertus Diawan Chris (1):
      ASoC: soc-utils: Add missing va_end in snd_soc_ret()

Shengjiu Wang (1):
      ASoC: fsl_sai: Eliminate possible interrupt storm during probe

Simon Trimmer (1):
      ASoC: cs35l56: Log SoundWire status updates only on changes

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm-dai: Allocate an extra page for PCM buffers

 .../sound/mediatek,mt8173-rt5650-rt5514.yaml       |   2 +
 MAINTAINERS                                        |  11 +-
 drivers/spi/spi-amd.c                              |   2 +-
 sound/soc/amd/acp-config.c                         |   7 ++
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |   2 +-
 sound/soc/codecs/Kconfig                           |   3 -
 sound/soc/codecs/cs-amp-lib.c                      |  17 ++-
 sound/soc/codecs/cs35l56-sdw.c                     |   8 +-
 sound/soc/codecs/cs35l56.c                         |  13 +-
 sound/soc/codecs/fs210x.c                          |   2 +-
 sound/soc/codecs/pcm512x.c                         |   6 +-
 sound/soc/fsl/fsl_sai.c                            |  43 +++++--
 sound/soc/intel/boards/sof_sdw.c                   |   8 ++
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |  71 ++++++++---
 sound/soc/intel/common/soc-acpi-intel-nvl-match.c  |  13 ++
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  | 134 +++------------------
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.c  |  16 +++
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.h  |   1 +
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   7 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                |  14 ++-
 sound/soc/soc-utils.c                              |   1 +
 sound/soc/sof/amd/acp.c                            |   2 +-
 sound/soc/ti/omap-dmic.c                           |   2 +-
 23 files changed, 209 insertions(+), 176 deletions(-)
