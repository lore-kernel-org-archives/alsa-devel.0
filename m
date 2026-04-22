Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97703FA1FFB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:03:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88B6A60206;
	Wed, 22 Apr 2026 23:03:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88B6A60206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776891836;
	bh=osEm2UT3TXX8sIhn9WZoRrKU1bI47Kn9yWLweybEHUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=O29UAENbpun9gYbdRnRO3NsuL7B2kIyRPjcnFs3pf4NQSrRUwG/FrdQQuEeovDG12
	 FKc6XZPSwcr1M0G2c74nB3TmPR66JIN/AfxHfqC/+aykPxMVHt+hb1AqCG+XROROcf
	 iEz+u8ELrlDaXoA+egiuDG+FcNe5wGG4CxDsMXPE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EDBDF805EC; Wed, 22 Apr 2026 23:03:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 738C0F805F4;
	Wed, 22 Apr 2026 23:03:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 438BCF80526; Wed, 22 Apr 2026 23:03:14 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 863A6F800AE
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2026 23:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 863A6F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SGIlNUF3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09DFB61868;
	Wed, 22 Apr 2026 21:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F387C19425;
	Wed, 22 Apr 2026 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776891785;
	bh=osEm2UT3TXX8sIhn9WZoRrKU1bI47Kn9yWLweybEHUw=;
	h=From:To:Cc:Subject:Date:From;
	b=SGIlNUF3v8ElA3papXrPw0k3H7lFbuluSHs4MJ3rTRO+4Cacr37APqWzvvZtcyscJ
	 CVEJBchpTBuscNPmDRQioN1hV6RSIJ3U8w3v8cY+LHy+CnmgeeSxg73EfjbFoD1WGB
	 tilCxdDz68l8A33a/lHti+5+si2D4nalQcTpHezqGBFoeKviTWRMEmBrlKYxYxl8Cb
	 ZQe3zqKIKd8aUYyXKNgspjg5LdtPtFLw/7epWqziYk3o0g5R6OL8RBfFn7m8BnyWGl
	 3rsXqaNHoCq6PvM6f2CaYsMlTDaV4uhwUQAezuBkOmWpTrlvUp5yyUa/XAqzmKBBob
	 HQtBVNGU93R0Q==
Message-ID: <101ba0b3f4dd2e7213d3ef9dbb8a2140@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-merge-window
Date: Wed, 22 Apr 2026 22:02:58 +0100
Message-ID-Hash: MJBBUR3F6WULDRBTIBSNX5L5KMUBSKKM
X-Message-ID-Hash: MJBBUR3F6WULDRBTIBSNX5L5KMUBSKKM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MJBBUR3F6WULDRBTIBSNX5L5KMUBSKKM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-merge-window

for you to fetch changes up to 24fcdc81dd7e1560e57eff75b618e5b00054b714:

  ASoC: dt-bindings: ti,tas2781: Add TAS5832 support (2026-04-22 21:15:55 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.1

A fairly small collection of fixes, device IDs and quirks that came in
during the merge window, the most remarkable of which is one for SDCA
boolean firmware flags which is remarkable mainly because it is
partially in regmap.

----------------------------------------------------------------
Arnd Bergmann (1):
      ASoC: tas2781: fix unused-const-variable warning

Baojun Xu (2):
      ASoC: dt-bindings: ti,tas2781: Add TAS5832 support
      ASoC: tas2781: Add tas5832 support

Bard Liao (2):
      ASoC: SOF: Intel: NVL: add platform name
      ASoC: SOF: Intel: NVL-S: add platform name

Charles Keepax (2):
      regmap: sdw-mbq: Allow defers on undeferrable controls
      ASoC: SDCA: Fix reading of mipi-sdca-control-deferrable

Hsieh Hung-En (2):
      ASoC: es8311: Check regcache_sync() error in resume
      ASoC: es8311: Fix clock leak and check update_bits in set_bias_level()

Maciej Strozek (1):
      ASoC: sdw_utils: cs42l43: allow spk component names to be combined

Mark Brown (3):
      ASoC: SOF: Intel: NVL/NVL-S: add platform name
      ASoC: Correct bug parsing DisCo booleans
      ASoC: dt-bindings: ti,tas2781: Add TAS5832 support

Peng Fan (1):
      ASoC: pxa2xx-ac97: fix error handling for reset GPIO descriptor

Shuming Fan (1):
      ASoC: rt1320: fix the warning 'rae_fw' from request_firmware() not released

Tobias Heider (1):
      ASoC: qcom: x1e80100: limit speaker volumes

 .../devicetree/bindings/sound/adi,ssm2305.txt      |   14 -
 .../devicetree/bindings/sound/adi,ssm2305.yaml     |   46 +
 .../devicetree/bindings/sound/awinic,aw88395.yaml  |    4 +
 .../devicetree/bindings/sound/cirrus,cs42l43.yaml  |    3 +
 .../bindings/sound/hisilicon,hi6210-i2s.txt        |   42 -
 .../bindings/sound/hisilicon,hi6210-i2s.yaml       |   80 ++
 .../devicetree/bindings/sound/imx-audio-card.yaml  |    9 +-
 .../bindings/sound/mediatek,mt2701-wm8960.yaml     |    4 +-
 .../bindings/sound/mediatek,mt7986-wm8960.yaml     |    4 +-
 .../sound/mediatek,mt8173-rt5650-rt5514.yaml       |   41 +
 .../bindings/sound/mediatek,mt8188-mt6359.yaml     |    4 +-
 .../bindings/sound/mt8173-rt5650-rt5514.txt        |   15 -
 .../bindings/sound/nvidia,tegra-audio-cpcap.yaml   |   90 ++
 .../sound/nvidia,tegra-audio-max9808x.yaml         |    5 +
 .../bindings/sound/nvidia,tegra-audio-wm8962.yaml  |   88 ++
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |    5 +-
 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   22 -
 .../bindings/sound/rockchip,rk3399-gru-sound.yaml  |   60 +
 .../sound/rockchip,rockchip-audio-max98090.yaml    |   59 +
 .../bindings/sound/rockchip-max98090.txt           |   42 -
 .../devicetree/bindings/sound/simple-card.yaml     |   14 +-
 .../devicetree/bindings/sound/tdm-slot.txt         |   29 -
 .../devicetree/bindings/sound/tdm-slot.yaml        |   52 +
 .../devicetree/bindings/sound/ti,tas2770.yaml      |    4 +-
 .../devicetree/bindings/sound/ti,tas2781.yaml      |    7 +-
 arch/arm/mach-s3c/mach-crag6410-module.c           |    6 +-
 drivers/base/regmap/regmap-sdw-mbq.c               |   36 +-
 drivers/firmware/cirrus/cs_dsp.c                   |  117 +-
 drivers/firmware/cirrus/cs_dsp.h                   |    4 +-
 drivers/firmware/cirrus/test/cs_dsp_test_bin.c     |   25 +-
 .../firmware/cirrus/test/cs_dsp_test_bin_error.c   |   22 +-
 .../cirrus/test/cs_dsp_test_control_cache.c        |    5 +
 .../cirrus/test/cs_dsp_test_control_parse.c        |    5 +
 .../firmware/cirrus/test/cs_dsp_test_control_rw.c  |    5 +
 drivers/firmware/cirrus/test/cs_dsp_test_wmfw.c    |   32 +-
 .../firmware/cirrus/test/cs_dsp_test_wmfw_error.c  |   30 +-
 drivers/mfd/cs42l43-i2c.c                          |    7 +-
 drivers/mfd/cs42l43-sdw.c                          |    4 +-
 drivers/mfd/cs42l43.c                              |   93 +-
 drivers/mfd/cs42l43.h                              |    2 +-
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |   12 +
 include/linux/firmware/cirrus/cs_dsp.h             |    3 +
 include/linux/mfd/arizona/pdata.h                  |   10 -
 include/linux/mfd/cs42l43-regs.h                   |   76 ++
 include/linux/mfd/cs42l43.h                        |    1 +
 include/sound/cs35l56.h                            |    7 +-
 include/sound/sdca_asoc.h                          |   43 +-
 include/sound/simple_card_utils.h                  |    6 +
 include/sound/soc-component.h                      |   11 +-
 include/sound/soc-dai.h                            |   22 +
 include/sound/soc-dapm.h                           |    1 +
 include/sound/soc.h                                |   33 +-
 include/sound/soc_sdw_utils.h                      |    5 +
 include/sound/tas2781.h                            |    1 +
 include/sound/uda1380.h                            |   19 -
 sound/arm/pxa2xx-ac97-lib.c                        |   15 +-
 sound/hda/codecs/side-codecs/Kconfig               |    1 +
 sound/soc/amd/Kconfig                              |   10 -
 sound/soc/amd/Makefile                             |    1 -
 sound/soc/amd/acp-da7219-max98357a.c               |    5 +-
 sound/soc/amd/acp-es8336.c                         |    1 -
 sound/soc/amd/acp-pcm-dma.c                        |    2 +-
 sound/soc/amd/acp-rt5645.c                         |   22 +-
 sound/soc/amd/acp/acp-platform.c                   |    2 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |   10 +-
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |    1 -
 sound/soc/amd/acp3x-rt5682-max9836.c               |    1 -
 sound/soc/amd/include/acp_2_2_d.h                  |   18 +-
 sound/soc/amd/include/acp_2_2_enum.h               |   18 +-
 sound/soc/amd/include/acp_2_2_sh_mask.h            |   18 +-
 sound/soc/amd/ps/ps-pdm-dma.c                      |    3 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    2 +-
 sound/soc/amd/raven/acp3x-pcm-dma.c                |    2 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c               |    2 +-
 sound/soc/amd/rpl/Makefile                         |    5 -
 sound/soc/amd/rpl/rpl-pci-acp6x.c                  |  227 ----
 sound/soc/amd/rpl/rpl_acp6x.h                      |   36 -
 sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h     |   30 -
 sound/soc/amd/vangogh/acp5x-pcm-dma.c              |    2 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   28 +
 sound/soc/amd/yc/acp6x-pdm-dma.c                   |    2 +-
 sound/soc/amd/yc/pci-acp6x.c                       |   12 +
 sound/soc/apple/Kconfig                            |    1 +
 sound/soc/apple/Makefile                           |    1 +
 sound/soc/apple/mca.c                              |    4 +-
 sound/soc/atmel/atmel-pcm-pdc.c                    |    2 +-
 sound/soc/au1x/dbdma2.c                            |    2 +-
 sound/soc/au1x/dma.c                               |    2 +-
 sound/soc/bcm/bcm63xx-pcm-whistler.c               |    2 +-
 sound/soc/bcm/cygnus-pcm.c                         |    2 +-
 sound/soc/codecs/Kconfig                           |   64 +-
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ak5558.c                          |    1 -
 sound/soc/codecs/arizona-jack.c                    |   95 +-
 sound/soc/codecs/arizona.h                         |    1 +
 sound/soc/codecs/aw87390.c                         |    3 +-
 sound/soc/codecs/aw88081.c                         |    3 +-
 sound/soc/codecs/aw88166.c                         |   12 +-
 sound/soc/codecs/aw88261.c                         |   16 +-
 sound/soc/codecs/cros_ec_codec.c                   |    2 +-
 sound/soc/codecs/cs-amp-lib-test.c                 |    1 -
 sound/soc/codecs/cs-amp-lib.c                      |    2 +
 sound/soc/codecs/cs35l41.c                         |    5 +
 sound/soc/codecs/cs35l45.c                         |    3 +
 sound/soc/codecs/cs35l56-sdw.c                     |   34 +-
 sound/soc/codecs/cs35l56-shared-test.c             |  240 ++++
 sound/soc/codecs/cs35l56-shared.c                  |    9 +
 sound/soc/codecs/cs35l56-test.c                    |  101 +-
 sound/soc/codecs/cs35l56.c                         |   99 +-
 sound/soc/codecs/cs35l56.h                         |    4 +
 sound/soc/codecs/cs4270.c                          |    6 +-
 sound/soc/codecs/cs42l43.c                         |  756 +++++++++---
 sound/soc/codecs/cs42l43.h                         |    4 +-
 sound/soc/codecs/cs42l84.c                         |   20 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |    5 +-
 sound/soc/codecs/cs42xx8.c                         |   27 +-
 sound/soc/codecs/cs42xx8.h                         |    5 +-
 sound/soc/codecs/da7219-aad.c                      |    3 +-
 sound/soc/codecs/da7219-aad.h                      |    5 +
 sound/soc/codecs/es8311.c                          |   22 +-
 sound/soc/codecs/jz4725b.c                         |   18 +-
 sound/soc/codecs/jz4760.c                          |   20 +-
 sound/soc/codecs/jz4770.c                          |   20 +-
 sound/soc/codecs/max98390.c                        |    6 +-
 sound/soc/codecs/max98520.c                        |    4 +-
 sound/soc/codecs/nau8315.c                         |    1 -
 sound/soc/codecs/peb2466.c                         |   19 +-
 sound/soc/codecs/rt1318.c                          |    1 -
 sound/soc/codecs/rt1320-sdw.c                      |   68 +-
 sound/soc/codecs/rt1320-sdw.h                      |   14 +
 sound/soc/codecs/rt5514-spi.c                      |    2 +-
 sound/soc/codecs/rt5575.c                          |    1 -
 sound/soc/codecs/rt5640.c                          |    5 +
 sound/soc/codecs/rt5677-spi.c                      |    9 +-
 sound/soc/codecs/rt5677.c                          |   40 +-
 sound/soc/codecs/rt5677.h                          |    2 +-
 sound/soc/codecs/sta529.c                          |    5 +-
 sound/soc/codecs/tas2552.c                         |   10 +-
 sound/soc/codecs/tas2764.c                         |   95 ++
 sound/soc/codecs/tas2764.h                         |   11 +
 sound/soc/codecs/tas2770.c                         |   75 ++
 sound/soc/codecs/tas2770.h                         |   12 +
 sound/soc/codecs/tas2781-i2c.c                     |  119 +-
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/ts3a227e.c                        |    1 -
 sound/soc/codecs/uda1380.c                         |  112 +-
 sound/soc/codecs/wcd-clsh-v2.c                     |    3 -
 sound/soc/codecs/wcd9335.c                         |    2 +-
 sound/soc/codecs/wm_adsp.c                         |  246 ++--
 sound/soc/codecs/wm_adsp.h                         |   20 +
 sound/soc/codecs/wm_adsp_fw_find_test.c            | 1223 ++++++++++++++++++++
 sound/soc/dwc/dwc-i2s.c                            |    5 +-
 sound/soc/dwc/dwc-pcm.c                            |    7 +-
 sound/soc/dwc/local.h                              |    5 +-
 sound/soc/fsl/efika-audio-fabric.c                 |    5 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |    2 +-
 sound/soc/fsl/fsl_dma.c                            |   12 +-
 sound/soc/fsl/fsl_easrc.c                          |  125 +-
 sound/soc/fsl/fsl_micfil.c                         |   72 +-
 sound/soc/fsl/fsl_qmc_audio.c                      |    6 +-
 sound/soc/fsl/fsl_sai.c                            |   66 ++
 sound/soc/fsl/fsl_sai.h                            |    4 +
 sound/soc/fsl/fsl_utils.c                          |  131 +++
 sound/soc/fsl/fsl_utils.h                          |   48 +
 sound/soc/fsl/fsl_xcvr.c                           |   86 +-
 sound/soc/fsl/fsl_xcvr.h                           |   18 +
 sound/soc/fsl/imx-pcm-fiq.c                        |    4 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |    2 +-
 sound/soc/fsl/imx-rpmsg.c                          |   48 +
 sound/soc/fsl/mpc5200_dma.c                        |   13 +-
 sound/soc/generic/audio-graph-card.c               |    2 +-
 sound/soc/generic/simple-card-utils.c              |   95 +-
 sound/soc/generic/simple-card.c                    |   52 +-
 sound/soc/generic/test-component.c                 |   12 +-
 sound/soc/google/chv3-i2s.c                        |    6 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    2 +-
 sound/soc/intel/avs/pcm.c                          |    8 +-
 sound/soc/intel/avs/probes.c                       |    2 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    4 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    6 +-
 sound/soc/intel/boards/ehl_rt5660.c                |    2 -
 sound/soc/intel/catpt/Makefile                     |    1 +
 sound/soc/intel/catpt/core.h                       |    2 +-
 sound/soc/intel/catpt/device.c                     |    2 +-
 sound/soc/intel/catpt/ipc.c                        |    3 +
 sound/soc/intel/catpt/loader.c                     |    2 +
 sound/soc/intel/catpt/messages.h                   |    3 +
 sound/soc/intel/catpt/pcm.c                        |  390 +++----
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |  100 --
 sound/soc/intel/keembay/Makefile                   |    1 +
 sound/soc/intel/keembay/kmb_platform.c             |    2 +-
 sound/soc/kirkwood/kirkwood-dma.c                  |    2 +-
 sound/soc/loongson/loongson_dma.c                  |    2 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    2 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c         |    4 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    5 +-
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    2 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    2 +-
 sound/soc/qcom/common.c                            |    6 +
 sound/soc/qcom/common.h                            |    3 +
 sound/soc/qcom/lpass-platform.c                    |    2 +-
 sound/soc/qcom/lpass.h                             |    3 +-
 sound/soc/qcom/qdsp6/audioreach.c                  |   65 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |    5 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |    6 +
 sound/soc/qcom/qdsp6/q6afe.c                       |    8 +
 sound/soc/qcom/qdsp6/q6afe.h                       |    3 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |  115 +-
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |   48 +-
 sound/soc/qcom/qdsp6/q6apm.c                       |  182 ++-
 sound/soc/qcom/qdsp6/q6apm.h                       |   20 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |    2 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c           |   76 ++
 sound/soc/qcom/qdsp6/topology.c                    |    8 +-
 sound/soc/qcom/x1e80100.c                          |   19 +
 sound/soc/renesas/dma-sh7760.c                     |    5 +-
 sound/soc/renesas/fsi.c                            |    2 +-
 sound/soc/renesas/rcar/core.c                      |    2 +-
 sound/soc/renesas/rcar/msiof.c                     |    2 +-
 sound/soc/renesas/rz-ssi.c                         |    2 +-
 sound/soc/renesas/siu_pcm.c                        |    5 +-
 sound/soc/rockchip/rockchip_sai.c                  |    4 +
 sound/soc/samsung/idma.c                           |    4 +-
 sound/soc/samsung/spdif.c                          |   29 +-
 sound/soc/sdca/sdca_asoc.c                         |  118 +-
 sound/soc/sdca/sdca_class.c                        |   36 +-
 sound/soc/sdca/sdca_class_function.c               |   12 +-
 sound/soc/sdca/sdca_fdl.c                          |    5 -
 sound/soc/sdca/sdca_functions.c                    |   13 +-
 sound/soc/sdca/sdca_interrupts.c                   |   24 +-
 sound/soc/sdw_utils/Makefile                       |    1 +
 sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c       |    6 -
 sound/soc/sdw_utils/soc_sdw_cs42l43.c              |   20 +-
 sound/soc/sdw_utils/soc_sdw_cs47l47.c              |   80 ++
 sound/soc/sdw_utils/soc_sdw_rt_dmic.c              |   46 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                |  254 +++-
 sound/soc/soc-component.c                          |   25 +-
 sound/soc/soc-compress.c                           |    4 +-
 sound/soc/soc-core.c                               |   84 +-
 sound/soc/soc-dai.c                                |   40 +
 sound/soc/soc-dapm.c                               |   11 +
 sound/soc/soc-generic-dmaengine-pcm.c              |    4 +-
 sound/soc/soc-ops.c                                |   83 +-
 sound/soc/soc-pcm.c                                |    4 +-
 sound/soc/soc-topology.c                           |   73 +-
 sound/soc/sof/compress.c                           |   15 +-
 sound/soc/sof/intel/hda-stream.c                   |   10 +-
 sound/soc/sof/intel/hda.c                          |   17 +-
 sound/soc/sof/intel/nvl.c                          |    2 +
 sound/soc/sof/ipc4-topology.c                      |   13 +-
 sound/soc/sof/pcm.c                                |   10 +-
 sound/soc/sof/sof-audio.h                          |   13 +-
 sound/soc/sof/sof-priv.h                           |    2 +
 sound/soc/sof/topology.c                           |   36 +-
 sound/soc/spear/spdif_in.c                         |    5 +-
 sound/soc/spear/spdif_out.c                        |    5 +-
 sound/soc/spear/spear_pcm.c                        |    5 +-
 sound/soc/sprd/sprd-pcm-dma.c                      |    2 +-
 sound/soc/starfive/Makefile                        |    1 +
 sound/soc/sti/uniperif_player.c                    |    9 +-
 sound/soc/stm/stm32_adfsdm.c                       |    2 +-
 sound/soc/sunxi/sun4i-spdif.c                      |   13 +-
 sound/soc/tegra/Kconfig                            |   19 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra186_asrc.c                    |   14 +-
 sound/soc/tegra/tegra186_dspk.c                    |   22 +-
 sound/soc/tegra/tegra20_spdif.h                    |    2 +-
 sound/soc/tegra/tegra210_admaif.c                  |   28 +-
 sound/soc/tegra/tegra210_adx.c                     |   20 +-
 sound/soc/tegra/tegra210_ahub.c                    |   33 +-
 sound/soc/tegra/tegra210_amx.c                     |   16 +-
 sound/soc/tegra/tegra210_dmic.c                    |   21 +-
 sound/soc/tegra/tegra210_i2s.c                     |   25 +-
 sound/soc/tegra/tegra210_mbdrc.c                   |   35 +-
 sound/soc/tegra/tegra210_mixer.c                   |   14 +-
 sound/soc/tegra/tegra210_mvc.c                     |   14 +-
 sound/soc/tegra/tegra210_ope.c                     |   22 +-
 sound/soc/tegra/tegra210_peq.c                     |   23 +-
 sound/soc/tegra/tegra210_sfc.c                     |   14 +-
 sound/soc/tegra/tegra_asoc_machine.c               |  143 ++-
 sound/soc/tegra/tegra_audio_graph_card.c           |   21 +-
 sound/soc/tegra/tegra_pcm.c                        |    6 +-
 sound/soc/tegra/tegra_pcm.h                        |    4 +-
 sound/soc/tegra/tegra_wm8962.c                     |  165 +++
 sound/soc/ti/davinci-mcasp.c                       |   47 +-
 sound/soc/uniphier/aio-dma.c                       |    2 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |    2 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |    2 +-
 sound/usb/qcom/Makefile                            |    1 +
 sound/x86/intel_hdmi_audio.h                       |   22 +-
 294 files changed, 6781 insertions(+), 2674 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi6210-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650-rt5514.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5514.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-cpcap.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8962.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98090.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.yaml
 delete mode 100644 include/sound/uda1380.h
 delete mode 100644 sound/soc/amd/rpl/Makefile
 delete mode 100644 sound/soc/amd/rpl/rpl-pci-acp6x.c
 delete mode 100644 sound/soc/amd/rpl/rpl_acp6x.h
 delete mode 100644 sound/soc/amd/rpl/rpl_acp6x_chip_offset_byte.h
 create mode 100644 sound/soc/codecs/wm_adsp_fw_find_test.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_cs47l47.c
 create mode 100644 sound/soc/tegra/tegra_wm8962.c
