From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/14] constify asoc snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:35:57 +0530
Message-ID: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Arvind Yadav (14):
  [PATCH 01/14] ASoC: blackfin: constify snd_soc_dai_ops structures
  [PATCH 02/14] ASoC: codecs: constify snd_soc_dai_ops structures
  [PATCH 03/14] ASoC: dwc: constify snd_soc_dai_ops structures
  [PATCH 04/14] ASoC: fsl: constify snd_soc_dai_ops structures
  [PATCH 05/14] ASoC: hisilicon: constify snd_soc_dai_ops structures
  [PATCH 06/14] ASoC: intel: constify snd_soc_dai_ops structures
  [PATCH 07/14] ASoC: mediatek: constify snd_soc_dai_ops structures
  [PATCH 08/14] ASoC: pxa: constify snd_soc_dai_ops structures
  [PATCH 09/14] ASoC: rockchip: constify snd_soc_dai_ops structures
  [PATCH 10/14] ASoC: spear: constify snd_soc_dai_ops structures
  [PATCH 11/14] ASoC: sunxi: constify snd_soc_dai_ops structures
  [PATCH 12/14] ASoC: tegra: constify snd_soc_dai_ops structures
  [PATCH 13/14] ASoC: ux500: constify snd_soc_dai_ops structures
  [PATCH 14/14] ASoC: zte: constify snd_soc_dai_ops structures

 sound/soc/blackfin/bf6xx-i2s.c               | 2 +-
 sound/soc/codecs/cs42l42.c                   | 2 +-
 sound/soc/codecs/es8316.c                    | 2 +-
 sound/soc/codecs/hdac_hdmi.c                 | 2 +-
 sound/soc/codecs/inno_rk3036.c               | 2 +-
 sound/soc/codecs/max9867.c                   | 2 +-
 sound/soc/codecs/max98926.c                  | 2 +-
 sound/soc/codecs/msm8916-wcd-analog.c        | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c       | 2 +-
 sound/soc/codecs/rt5616.c                    | 2 +-
 sound/soc/codecs/rt5663.c                    | 2 +-
 sound/soc/codecs/tas5720.c                   | 2 +-
 sound/soc/codecs/zx_aud96p22.c               | 2 +-
 sound/soc/dwc/dwc-i2s.c                      | 2 +-
 sound/soc/fsl/fsl_asrc.c                     | 2 +-
 sound/soc/fsl/fsl_esai.c                     | 2 +-
 sound/soc/fsl/fsl_spdif.c                    | 2 +-
 sound/soc/hisilicon/hi6210-i2s.c             | 2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 6 +++---
 sound/soc/intel/skylake/skl-pcm.c            | 8 ++++----
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c   | 2 +-
 sound/soc/pxa/mmp-sspa.c                     | 2 +-
 sound/soc/rockchip/rockchip_pdm.c            | 2 +-
 sound/soc/spear/spdif_in.c                   | 2 +-
 sound/soc/sunxi/sun8i-codec.c                | 2 +-
 sound/soc/tegra/tegra30_i2s.c                | 2 +-
 sound/soc/ux500/ux500_msp_dai.c              | 2 +-
 sound/soc/zte/zx-i2s.c                       | 2 +-
 sound/soc/zte/zx-spdif.c                     | 2 +-
 sound/soc/zte/zx-tdm.c                       | 2 +-
 30 files changed, 35 insertions(+), 35 deletions(-)

-- 
1.9.1
