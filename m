Return-Path: <SRS0=d1MO=G5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95401C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C0723129
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C0723129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B74E1782;
	Tue, 26 Jan 2021 13:45:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B74E1782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611665172;
	bh=CiWHN0CbV9rxRFCFnscZNg6KS1bLPd4KZofuaGHRrPU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dGGEOZrq2t5BUJACbqnnCbVfXWVOPIju9rdbwxy+vUA5nw4WqCkAJDOJPFwIRMqaC
	 V7vX72CTUEWzAj1vs+KhXk2nV/J9JOqy4m1ic2PcTGLS/8wz9e2qjcMPUAJPUyDXIv
	 0PGjTKTPi0y9VVfrRXtflZTlwceyuOs75+fuLpIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1E01F80158;
	Tue, 26 Jan 2021 13:45:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AFB8F8015B; Tue, 26 Jan 2021 13:45:19 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B9D6F80130
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2021 13:45:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B9D6F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ehde1K3m"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E518923104;
 Tue, 26 Jan 2021 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611665107;
 bh=CiWHN0CbV9rxRFCFnscZNg6KS1bLPd4KZofuaGHRrPU=;
 h=From:To:Cc:Subject:Date:From;
 b=Ehde1K3mrYNBYof4d9hIZ+Osf9xNOuf85EQYBT4+NPz7mz3W7u0psA3T352ucZ4hA
 zZvYX7Ig+cT/ptdUmdXqcj0Q3APUsObNoBYn28chQ8Y7Js6TCOBigwaA9Waob8oWv2
 bPqshpvGGpdQ6AptKUpQRRO2c1lNXJzt/aF7OMLrPj+9hmutea0f8RO0+BoZcr5Tja
 6wNWHf+/07vcEFXX3ZnJgY2EpQr8TVyPEYcOUwpi86MhKcf7jYRBVXaUZCk7DK2Ntg
 4vfqGuxHi6nE7k7/W9J637ocY5TPuPIrRmkbCT1ygSNywuYeHmtV/2jj37hVQxLAz6
 U0TzCNtWWp+0w==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.11-rc5
Date: Tue, 26 Jan 2021 12:44:09 +0000
Message-Id: <20210126124506.E518923104@mail.kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The following changes since commit 7505c06dabb5e814bda610c8d83338544f15db45:

  MAINTAINERS: update qcom ASoC drivers list (2021-01-15 17:25:35 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.11-rc5

for you to fetch changes up to 5413dfd8ce0d5d997d442440701814a8ce7025d9:

  Merge series "ASoC: SOF: partial fix to Kconfig issues" from Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>: (2021-01-25 14:15:12 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.11

More fixes for v5.11, almost all driver specific issues including new
device IDs - there's one error handling fix for the topology stuff too.

----------------------------------------------------------------
Amadeusz Sławiński (1):
      ASoC: topology: Properly unregister DAI on removal

Dan Carpenter (1):
      ASoC: topology: Fix memory corruption in soc_tplg_denum_create_values()

Eliot Blennerhassett (1):
      ASoC: ak4458: correct reset polarity

James Schulman (1):
      ASoC: wm_adsp: Fix control name parsing for multi-fw

Jaroslav Kysela (1):
      ASoC: AMD Renoir - refine DMI entries for some Lenovo products

Jonathan Neuschäfer (1):
      ASoC: dt-bindings: mt8192-mt6359: Fix indentation

Libin Yang (1):
      ASoC: Intel: sof_sdw: set proper flags for Dell TGL-H SKU 0A5E

Mark Brown (4):
      Merge series "Add KUNIT tests for ASoC topology" from Amadeusz Sławiński<amadeuszx.slawinski@linux.intel.com>:
      Merge series "ASoC: mediatek: mt8183: ignore TDM DAI link by by default" from Tzung-Bi Shih <tzungbi@google.com>:
      Merge series "ASoC: qcom: Fix broken lpass driver" from Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
      Merge series "ASoC: SOF: partial fix to Kconfig issues" from Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: soundwire: fix select/depend unmet dependencies
      ASoC: SOF: SND_INTEL_DSP_CONFIG dependency

Ricardo Ribalda (2):
      ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
      ASoC: Intel: Skylake: Zero snd_ctl_elem_value

Srinivas Kandagatla (3):
      ASoC: dt-bindings: lpass: Fix and common up lpass dai ids
      ASoC: qcom: Fix broken support to MI2S TERTIARY and QUATERNARY
      ASoC: qcom: lpass-ipq806x: fix bitwidth regmap field

Stephan Gerhold (1):
      ASoC: qcom: lpass: Fix out-of-bounds DAI ID lookup

Stephen Boyd (1):
      ASoC: qcom: Fix number of HDMI RDMA channels on sc7180

Tzung-Bi Shih (3):
      ASoC: mediatek: mt8183-mt6358: ignore TDM DAI link by default
      ASoC: mediatek: mt8183-da7219: ignore TDM DAI link by default
      ASoC: mediatek: mt8192-mt6359: add format constraints for RT5682

 .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |  4 +-
 include/dt-bindings/sound/apq8016-lpass.h          |  7 ++--
 include/dt-bindings/sound/qcom,lpass.h             | 15 +++++++
 include/dt-bindings/sound/sc7180-lpass.h           |  6 +--
 sound/soc/amd/renoir/rn-pci-acp3x.c                | 18 +++++++-
 sound/soc/codecs/ak4458.c                          | 22 ++++------
 sound/soc/codecs/wm_adsp.c                         |  3 ++
 sound/soc/intel/boards/sof_sdw.c                   | 10 +++++
 sound/soc/intel/skylake/skl-topology.c             | 15 +++----
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c |  5 ++-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        |  5 ++-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  | 49 ++++++++++++++++++++++
 sound/soc/qcom/lpass-cpu.c                         | 22 ++++++++++
 sound/soc/qcom/lpass-ipq806x.c                     |  2 +-
 sound/soc/qcom/lpass-lpaif-reg.h                   |  2 +-
 sound/soc/qcom/lpass-platform.c                    | 12 ++++++
 sound/soc/qcom/lpass-sc7180.c                      | 11 ++---
 sound/soc/qcom/lpass.h                             |  2 +-
 sound/soc/soc-topology.c                           | 11 ++---
 sound/soc/sof/intel/Kconfig                        |  3 +-
 sound/soc/sof/sof-acpi-dev.c                       | 11 ++---
 sound/soc/sof/sof-pci-dev.c                        | 10 +++--
 22 files changed, 184 insertions(+), 61 deletions(-)
 create mode 100644 include/dt-bindings/sound/qcom,lpass.h
