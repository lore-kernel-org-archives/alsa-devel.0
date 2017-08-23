From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 00/10] Remove unnecessary function
Date: Wed, 23 Aug 2017 05:17:06 -0700
Message-ID: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, matthias.bgg@gmail.com, nicolas.ferre@microchip.com, pierre-louis.bossart@linux.intel.com, heiko@sntech.de, plai@codeaurora.org, bgoswami@codeaurora.org, wens@csie.org, thierry.reding@gmail.com, jonathanh@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

When calling the function devm_snd_soc_register_card to
register a sound card,the address of snd_soc_card will be
assigned to dev->driver_data automatically,so there is no
extra need to call platform_set_drvdata.

Peng Donglin (10):
  ASoC: s3c24xx_uda134x: Remove unnecessary function call
  ASoC: mediatek: Remove unnecessary function call
  ASoC: Intel: Remove unnecessary function call
  ASoC: atmel: Remove unnecessary function call
  ASoC: rockchip: Remove unnecessary function call
  ASoC: mxs-sgtl5000: Remove unnecessary function call
  ASoC: qcom: Remove useless function call
  ASoC: sun4i-codec: Remove unnecessary function call
  ASoC: tegra: Remove unnecessary function call
  ASoC: ux500: Remove unnecessary function call

 sound/soc/atmel/atmel-classd.c                   | 1 -
 sound/soc/atmel/atmel-pdmic.c                    | 1 -
 sound/soc/intel/boards/bytcht_da7213.c           | 6 ++----
 sound/soc/intel/boards/bytcht_es8316.c           | 6 ++----
 sound/soc/intel/boards/bytcht_nocodec.c          | 6 ++----
 sound/soc/intel/boards/bytcr_rt5640.c            | 7 ++-----
 sound/soc/intel/boards/bytcr_rt5651.c            | 7 ++-----
 sound/soc/intel/boards/cht_bsw_max98090_ti.c     | 6 ++----
 sound/soc/intel/boards/cht_bsw_rt5645.c          | 6 ++----
 sound/soc/intel/boards/cht_bsw_rt5672.c          | 6 ++----
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 sound/soc/mxs/mxs-sgtl5000.c                     | 7 ++-----
 sound/soc/qcom/apq8016_sbc.c                     | 1 -
 sound/soc/qcom/storm.c                           | 1 -
 sound/soc/rockchip/rk3288_hdmi_analog.c          | 6 +-----
 sound/soc/samsung/s3c24xx_uda134x.c              | 1 -
 sound/soc/sunxi/sun4i-codec.c                    | 1 -
 sound/soc/tegra/tegra_alc5632.c                  | 1 -
 sound/soc/tegra/tegra_max98090.c                 | 1 -
 sound/soc/tegra/tegra_rt5640.c                   | 1 -
 sound/soc/tegra/tegra_rt5677.c                   | 1 -
 sound/soc/tegra/tegra_sgtl5000.c                 | 1 -
 sound/soc/tegra/tegra_wm8753.c                   | 1 -
 sound/soc/tegra/tegra_wm8903.c                   | 1 -
 sound/soc/tegra/tegra_wm9712.c                   | 1 -
 sound/soc/tegra/trimslice.c                      | 1 -
 sound/soc/ux500/mop500.c                         | 1 -
 29 files changed, 19 insertions(+), 63 deletions(-)

-- 
2.14.1
