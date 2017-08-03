From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] ASoC: make snd_soc_codec_driver structures const
Date: Thu,  3 Aug 2017 21:30:18 +0530
Message-ID: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lars@metafoo.de, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, mr.swami.reddy@ti.com, vishwas.a.deshpande@ti.com, peda@axentia.se, bardliao@realtek.com, baohua@kernel.org, peter.ujfalusi@ti.com, patches@opensource.cirrus.com
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_soc_codec_driver structures as const.

Bhumika Goyal (2):
  ASoC: codecs: add const to snd_soc_codec_driver structures
  ASoC: sunxi: make snd_soc_codec_driver structures as const

 sound/soc/codecs/88pm860x-codec.c      | 2 +-
 sound/soc/codecs/ab8500-codec.c        | 2 +-
 sound/soc/codecs/ac97.c                | 2 +-
 sound/soc/codecs/ad1836.c              | 2 +-
 sound/soc/codecs/ad193x.c              | 2 +-
 sound/soc/codecs/ad1980.c              | 2 +-
 sound/soc/codecs/ad73311.c             | 2 +-
 sound/soc/codecs/adau1373.c            | 2 +-
 sound/soc/codecs/adau1701.c            | 2 +-
 sound/soc/codecs/adau1977.c            | 2 +-
 sound/soc/codecs/adav80x.c             | 2 +-
 sound/soc/codecs/ads117x.c             | 2 +-
 sound/soc/codecs/ak4104.c              | 2 +-
 sound/soc/codecs/ak4535.c              | 2 +-
 sound/soc/codecs/ak4554.c              | 2 +-
 sound/soc/codecs/ak4613.c              | 2 +-
 sound/soc/codecs/ak4641.c              | 2 +-
 sound/soc/codecs/ak4642.c              | 2 +-
 sound/soc/codecs/ak4671.c              | 2 +-
 sound/soc/codecs/ak5386.c              | 2 +-
 sound/soc/codecs/alc5623.c             | 2 +-
 sound/soc/codecs/bt-sco.c              | 2 +-
 sound/soc/codecs/cq93vc.c              | 2 +-
 sound/soc/codecs/cs35l33.c             | 2 +-
 sound/soc/codecs/cs35l34.c             | 2 +-
 sound/soc/codecs/cs35l35.c             | 2 +-
 sound/soc/codecs/cs4271.c              | 2 +-
 sound/soc/codecs/cs42l51.c             | 2 +-
 sound/soc/codecs/cs4349.c              | 2 +-
 sound/soc/codecs/cs47l24.c             | 2 +-
 sound/soc/codecs/cs53l30.c             | 2 +-
 sound/soc/codecs/cx20442.c             | 2 +-
 sound/soc/codecs/da7210.c              | 2 +-
 sound/soc/codecs/da7213.c              | 2 +-
 sound/soc/codecs/da7218.c              | 2 +-
 sound/soc/codecs/da7219.c              | 2 +-
 sound/soc/codecs/da732x.c              | 2 +-
 sound/soc/codecs/da9055.c              | 2 +-
 sound/soc/codecs/dmic.c                | 2 +-
 sound/soc/codecs/es7134.c              | 2 +-
 sound/soc/codecs/es8316.c              | 2 +-
 sound/soc/codecs/es8328.c              | 2 +-
 sound/soc/codecs/hdac_hdmi.c           | 2 +-
 sound/soc/codecs/hdmi-codec.c          | 2 +-
 sound/soc/codecs/ics43432.c            | 2 +-
 sound/soc/codecs/inno_rk3036.c         | 2 +-
 sound/soc/codecs/isabelle.c            | 2 +-
 sound/soc/codecs/jz4740.c              | 2 +-
 sound/soc/codecs/lm49453.c             | 2 +-
 sound/soc/codecs/max98088.c            | 2 +-
 sound/soc/codecs/max98090.c            | 2 +-
 sound/soc/codecs/max98095.c            | 2 +-
 sound/soc/codecs/max98357a.c           | 2 +-
 sound/soc/codecs/max9850.c             | 2 +-
 sound/soc/codecs/max9860.c             | 2 +-
 sound/soc/codecs/max9867.c             | 2 +-
 sound/soc/codecs/max98926.c            | 2 +-
 sound/soc/codecs/mc13783.c             | 2 +-
 sound/soc/codecs/ml26124.c             | 2 +-
 sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 sound/soc/codecs/nau8540.c             | 2 +-
 sound/soc/codecs/nau8810.c             | 2 +-
 sound/soc/codecs/nau8824.c             | 2 +-
 sound/soc/codecs/nau8825.c             | 2 +-
 sound/soc/codecs/pcm1681.c             | 2 +-
 sound/soc/codecs/pcm179x.c             | 2 +-
 sound/soc/codecs/pcm3008.c             | 2 +-
 sound/soc/codecs/pcm512x.c             | 2 +-
 sound/soc/codecs/rt274.c               | 2 +-
 sound/soc/codecs/rt286.c               | 2 +-
 sound/soc/codecs/rt298.c               | 2 +-
 sound/soc/codecs/rt5514.c              | 2 +-
 sound/soc/codecs/rt5616.c              | 2 +-
 sound/soc/codecs/rt5631.c              | 2 +-
 sound/soc/codecs/rt5640.c              | 2 +-
 sound/soc/codecs/rt5645.c              | 2 +-
 sound/soc/codecs/rt5651.c              | 2 +-
 sound/soc/codecs/rt5659.c              | 2 +-
 sound/soc/codecs/rt5660.c              | 2 +-
 sound/soc/codecs/rt5663.c              | 2 +-
 sound/soc/codecs/rt5665.c              | 2 +-
 sound/soc/codecs/rt5670.c              | 2 +-
 sound/soc/codecs/rt5677.c              | 2 +-
 sound/soc/codecs/sgtl5000.c            | 2 +-
 sound/soc/codecs/si476x.c              | 2 +-
 sound/soc/codecs/sirf-audio-codec.c    | 2 +-
 sound/soc/codecs/sn95031.c             | 2 +-
 sound/soc/codecs/spdif_receiver.c      | 2 +-
 sound/soc/codecs/spdif_transmitter.c   | 2 +-
 sound/soc/codecs/ssm2518.c             | 2 +-
 sound/soc/codecs/ssm2602.c             | 2 +-
 sound/soc/codecs/ssm4567.c             | 2 +-
 sound/soc/codecs/stac9766.c            | 2 +-
 sound/soc/codecs/tas2552.c             | 2 +-
 sound/soc/codecs/tas5086.c             | 2 +-
 sound/soc/codecs/tas5720.c             | 2 +-
 sound/soc/codecs/tlv320aic23.c         | 2 +-
 sound/soc/codecs/tlv320aic26.c         | 2 +-
 sound/soc/codecs/tlv320aic31xx.c       | 2 +-
 sound/soc/codecs/tlv320aic32x4.c       | 2 +-
 sound/soc/codecs/tlv320aic3x.c         | 2 +-
 sound/soc/codecs/tlv320dac33.c         | 2 +-
 sound/soc/codecs/twl4030.c             | 2 +-
 sound/soc/codecs/twl6040.c             | 2 +-
 sound/soc/codecs/uda134x.c             | 2 +-
 sound/soc/codecs/uda1380.c             | 2 +-
 sound/soc/codecs/wl1273.c              | 2 +-
 sound/soc/codecs/zx_aud96p22.c         | 2 +-
 sound/soc/sunxi/sun4i-codec.c          | 6 +++---
 sound/soc/sunxi/sun8i-codec.c          | 2 +-
 111 files changed, 113 insertions(+), 113 deletions(-)

-- 
1.9.1
