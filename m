Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C2C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:50:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1E864E89
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1E864E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE975168D;
	Thu, 18 Mar 2021 13:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE975168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616071815;
	bh=iGCRMpLwbAe4TrnERiqxoCSDaM7Ui7JaTjOfCUL2ffs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=skHNNWxdNzpjm+tx1+y+maKrUaWufidzz58W3XCJpyQjuc7YzxwrAtGhaXtbEdm3g
	 q1VhreUWCI6lC/RLmX3+a/b0GSa0nbt4hrDSb/mW0imiF8RkiuBTw/az8l1+TZLqxG
	 4Ube0j/1jq2QCLK7YW2KZyKYKMg4qbPjONzsGKKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EFEAF800C8;
	Thu, 18 Mar 2021 13:49:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC9C8F80165; Thu, 18 Mar 2021 13:49:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BEA0F80124
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 13:49:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BEA0F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ix4cPIxf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 923FB64E28;
 Thu, 18 Mar 2021 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616071755;
 bh=iGCRMpLwbAe4TrnERiqxoCSDaM7Ui7JaTjOfCUL2ffs=;
 h=From:To:Cc:Subject:Date:From;
 b=ix4cPIxfMCpElVAeaPA7NiKAoCsx9o+AT+lYaFbh/JENMKFPhh93+nLmGYJ6aSbeH
 Z3vbF/s731P7K9O7frUiebXrAqsT79jPcOgGzz+M43j/x0ydf/OmddQg/pPZRspo+y
 kFx6vzQar4JHIm7Jk4V/BVG6d7GZjqB4rp8X6+wcjvkjhKWkqPE/zppa3yrPr/U/fo
 qfJvQqcLFFcSXfS9c56bzRM1rt79k1b75a1a5lTcVRHIigieHUiW3vRZOnoO7U9+kx
 TCqzUc21QYnOW4yLLN9lQ8tVrtKDhmHUuqt+aYTbtXWiUpojkd1TtWnj8vlfaUIfVB
 5rji2m2+dRvDA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v5.12-rc2
Date: Thu, 18 Mar 2021 12:49:00 +0000
Message-Id: <20210318124914.923FB64E28@mail.kernel.org>
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

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.12-rc2

for you to fetch changes up to f9dc51cc6676e0360dfcb1836b3d426a3ccf3093:

  Merge series "Do not handle MCLK device clock in simple-card-utils" from Sameer Pujar <spujar@nvidia.com>: (2021-03-16 17:55:37 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.12

Quite a lot of mostly platform specific fixes here, the only one which
is generic is a fix for regressions on devices with more complex
clocking support with simple-card.  There's also a few new device IDs
and platform quirks.

----------------------------------------------------------------
Alexander Shiyan (1):
      ASoC: fsl_ssi: Fix TDM slot setup for I2S mode

Bard Liao (1):
      ASoC: rt711: add snd_soc_component remove callback

Benjamin Rood (1):
      ASoC: sgtl5000: set DAP_AVC_CTRL register to correct default value on probe

Colin Ian King (1):
      ASoC: codecs: lpass-rx-macro: Fix uninitialized variable ec_tx

Hans de Goede (8):
      ASoC: rt5670: Remove 'OUT Channel Switch' control
      ASoC: rt5670: Remove 'HP Playback Switch' control
      ASoC: rt5670: Remove ADC vol-ctrl mute bits poking from Sto1 ADC mixer settings
      ASoC: rt5670: Add emulated 'DAC1 Playback Switch' control
      ASoC: Intel: bytcr_rt5640: Fix HP Pavilion x2 10-p0XX OVCD current threshold
      ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor of 10
      ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor of 10
      ASoC: es8316: Simplify adc_pga_gain_tlv table

Jack Yu (2):
      ASoC: rt1015: fix i2c communication error
      ASoC: rt1015: enable BCLK detection after calibration

Jiaxin Yu (1):
      ASoC: mediatek: mt8192: fix tdm out data is valid on rising edge

Jon Hunter (1):
      ASoC: soc-core: Prevent warning if no DMI table is present

Jonathan Marek (2):
      ASoC: codecs: lpass-va-macro: mute/unmute all active decimators
      ASoC: codecs: lpass-wsa-macro: fix RX MIX input controls

Lucas Tanure (5):
      ASoC: cs42l42: Fix Bitclock polarity inversion
      ASoC: cs42l42: Fix channel width support
      ASoC: cs42l42: Fix mixer volume control
      ASoC: cs42l42: Don't enable/disable regulator at Bias Level
      ASoC: cs42l42: Always wait at least 3ms after reset

Mark Brown (5):
      Merge series "ASoC: rt5670: Various kcontrol fixes" from Hans de Goede <hdegoede@redhat.com>:
      Merge series "AsoC: rt5640/rt5651: Volume control fixes" from Hans de Goede <hdegoede@redhat.com>:
      Merge series "Report jack and button detection + Capture Support" from Lucas Tanure <tanureal@opensource.cirrus.com>:
      Merge series "ASoC: sdm845: array out of bound issues" from Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
      Merge series "Do not handle MCLK device clock in simple-card-utils" from Sameer Pujar <spujar@nvidia.com>:

Meng Li (1):
      spi: cadence: set cqspi to the driver_data field of struct device

Pan Xiuli (1):
      ASoC: SOF: intel: fix wrong poll bits in dsp power down

Peter Robinson (1):
      ASoC: remove remnants of sirf prima/atlas audio codec

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: unregister DMIC device on probe error

Sameer Pujar (2):
      ASoC: simple-card-utils: Do not handle device clock
      ASoC: rt5659: Update MCLK rate in set_sysclk()

Shengjiu Wang (3):
      ASoC: ak4458: Add MODULE_DEVICE_TABLE
      ASoC: ak5558: Add MODULE_DEVICE_TABLE
      ASoC: dt-bindings: fsl_spdif: Add compatible string for new platforms

Srinivas Kandagatla (3):
      ASoC: qcom: sdm845: Fix array out of bounds access
      ASoC: qcom: sdm845: Fix array out of range on rx slim channels
      ASoC: codecs: wcd934x: add a sanity check in set channel map

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-cpu: Fix lpass dai ids parse

 .../devicetree/bindings/sound/fsl,spdif.yaml       |   4 +
 drivers/spi/spi-cadence-quadspi.c                  |   1 +
 sound/soc/codecs/Kconfig                           |   5 -
 sound/soc/codecs/ak4458.c                          |   1 +
 sound/soc/codecs/ak5558.c                          |   1 +
 sound/soc/codecs/cs42l42.c                         | 112 ++++++-------------
 sound/soc/codecs/cs42l42.h                         |  13 ++-
 sound/soc/codecs/es8316.c                          |   9 +-
 sound/soc/codecs/lpass-rx-macro.c                  |   2 +-
 sound/soc/codecs/lpass-va-macro.c                  |  28 +++--
 sound/soc/codecs/lpass-wsa-macro.c                 |  20 ++--
 sound/soc/codecs/rt1015.c                          |   2 +
 sound/soc/codecs/rt5640.c                          |   4 +-
 sound/soc/codecs/rt5651.c                          |   4 +-
 sound/soc/codecs/rt5659.c                          |   5 +
 sound/soc/codecs/rt5670.c                          | 110 +++++++++++++++---
 sound/soc/codecs/rt5670.h                          |   9 +-
 sound/soc/codecs/rt711.c                           |   8 ++
 sound/soc/codecs/sgtl5000.c                        |   2 +-
 sound/soc/codecs/sirf-audio-codec.h                | 124 ---------------------
 sound/soc/codecs/wcd934x.c                         |   6 +
 sound/soc/fsl/fsl_ssi.c                            |   6 +-
 sound/soc/generic/simple-card-utils.c              |  13 ++-
 sound/soc/intel/boards/bytcr_rt5640.c              |   2 +-
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c         |   4 +-
 sound/soc/mediatek/mt8192/mt8192-reg.h             |   8 +-
 sound/soc/qcom/lpass-cpu.c                         |   2 +-
 sound/soc/qcom/sdm845.c                            |   6 +-
 sound/soc/soc-core.c                               |   4 +
 sound/soc/sof/intel/hda-dsp.c                      |   2 +-
 sound/soc/sof/intel/hda.c                          |   1 +
 31 files changed, 232 insertions(+), 286 deletions(-)
 delete mode 100644 sound/soc/codecs/sirf-audio-codec.h
