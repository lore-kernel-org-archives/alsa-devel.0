From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/2] Simplify the CODEC ASoC probe code.
Date: Fri, 28 Feb 2014 13:06:47 +0800
Message-ID: <1393564009-15968-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: vinod.koul@intel.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, timur@tabi.org, mr.swami.reddy@ti.com, vishwas.a.deshpande@ti.com, fabio.estevam@freescale.com, kuninori.morimoto.gx@renesas.com, sachin.kamat@linaro.org, Adam.Thomson.Opensource@diasemi.com, dgreid@chromium.org, abrestic@chromium.org, swarren@nvidia.com, shc_work@mail.ru, s.trumtrar@pengutronix.de, bardliao@realtek.com, shawn.guo@linaro.org, LW@KARO-electronics.de, mpa@pengutronix.de, peter.ujfalusi@ti.com, Andreas.Irestal@axis.com, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, viresh.kumar@linaro.org, axel.lin@ingics.com, alban.bedel@avionic-design.de, voice.shen@atmel.com, jic23@kernel.org, mahaijuns@gmail.com, mike.dyer@md-soft.co.uk, b42378@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.ker
List-Id: alsa-devel@alsa-project.org

Most of the CODECs' ASoC probe code could be simplified directly, while
for wm5110 and wm8997 CODEC drivers need much more research and examination.



Xiubo Li (2):
  ASoC: codec: Simplify ASoC probe code.
  ASoC: io: Remove reduntant params of snd_soc_codec_set_cache_io()

 include/sound/soc.h              |  1 -
 sound/soc/codecs/ad193x.c        |  7 -------
 sound/soc/codecs/adau1373.c      |  6 ------
 sound/soc/codecs/adav80x.c       |  6 ------
 sound/soc/codecs/ak4535.c        |  6 ------
 sound/soc/codecs/ak4641.c        |  6 ------
 sound/soc/codecs/ak4642.c        |  6 ------
 sound/soc/codecs/ak4671.c        |  6 ------
 sound/soc/codecs/alc5623.c       |  7 -------
 sound/soc/codecs/alc5632.c       |  8 --------
 sound/soc/codecs/cq93vc.c        |  2 --
 sound/soc/codecs/cs4270.c        |  9 ---------
 sound/soc/codecs/cs42l51.c       |  6 ------
 sound/soc/codecs/cs42l52.c       |  6 ------
 sound/soc/codecs/cs42l73.c       |  8 --------
 sound/soc/codecs/da7210.c        |  7 -------
 sound/soc/codecs/da7213.c        |  7 -------
 sound/soc/codecs/da732x.c        |  8 --------
 sound/soc/codecs/da9055.c        |  7 -------
 sound/soc/codecs/isabelle.c      | 16 ----------------
 sound/soc/codecs/lm49453.c       | 17 -----------------
 sound/soc/codecs/max9768.c       |  5 -----
 sound/soc/codecs/max98088.c      |  6 ------
 sound/soc/codecs/max98090.c      |  8 --------
 sound/soc/codecs/max98095.c      |  6 ------
 sound/soc/codecs/max9850.c       |  6 ------
 sound/soc/codecs/mc13783.c       |  7 -------
 sound/soc/codecs/ml26124.c       |  7 -------
 sound/soc/codecs/rt5631.c        |  8 --------
 sound/soc/codecs/rt5640.c        |  7 -------
 sound/soc/codecs/sn95031.c       |  2 --
 sound/soc/codecs/ssm2518.c       |  7 -------
 sound/soc/codecs/ssm2602.c       |  7 -------
 sound/soc/codecs/sta32x.c        | 10 ----------
 sound/soc/codecs/sta529.c        |  7 -------
 sound/soc/codecs/tlv320aic23.c   |  6 ------
 sound/soc/codecs/tlv320aic26.c   |  2 --
 sound/soc/codecs/tlv320aic32x4.c |  2 --
 sound/soc/codecs/tlv320aic3x.c   |  6 ------
 sound/soc/codecs/wm2000.c        |  2 --
 sound/soc/codecs/wm2200.c        |  7 -------
 sound/soc/codecs/wm5100.c        |  7 -------
 sound/soc/codecs/wm5102.c        |  6 ------
 sound/soc/codecs/wm5110.c        |  2 +-
 sound/soc/codecs/wm8350.c        |  4 ----
 sound/soc/codecs/wm8400.c        |  3 ---
 sound/soc/codecs/wm8510.c        |  6 ------
 sound/soc/codecs/wm8523.c        |  6 ------
 sound/soc/codecs/wm8580.c        |  6 ------
 sound/soc/codecs/wm8711.c        |  6 ------
 sound/soc/codecs/wm8728.c        |  7 -------
 sound/soc/codecs/wm8731.c        |  7 -------
 sound/soc/codecs/wm8737.c        |  6 ------
 sound/soc/codecs/wm8741.c        |  6 ------
 sound/soc/codecs/wm8750.c        |  6 ------
 sound/soc/codecs/wm8753.c        |  7 -------
 sound/soc/codecs/wm8770.c        |  6 ------
 sound/soc/codecs/wm8776.c        |  6 ------
 sound/soc/codecs/wm8804.c        |  8 --------
 sound/soc/codecs/wm8900.c        |  6 ------
 sound/soc/codecs/wm8903.c        |  7 -------
 sound/soc/codecs/wm8904.c        |  8 --------
 sound/soc/codecs/wm8940.c        |  6 ------
 sound/soc/codecs/wm8955.c        |  8 --------
 sound/soc/codecs/wm8960.c        |  6 ------
 sound/soc/codecs/wm8961.c        |  6 ------
 sound/soc/codecs/wm8962.c        |  7 -------
 sound/soc/codecs/wm8971.c        |  6 ------
 sound/soc/codecs/wm8974.c        |  6 ------
 sound/soc/codecs/wm8978.c        |  6 ------
 sound/soc/codecs/wm8983.c        |  6 ------
 sound/soc/codecs/wm8985.c        |  7 -------
 sound/soc/codecs/wm8988.c        |  7 -------
 sound/soc/codecs/wm8990.c        |  6 ------
 sound/soc/codecs/wm8991.c        |  6 ------
 sound/soc/codecs/wm8993.c        |  7 -------
 sound/soc/codecs/wm8994.c        |  3 ---
 sound/soc/codecs/wm8995.c        |  7 -------
 sound/soc/codecs/wm8996.c        |  8 --------
 sound/soc/codecs/wm8997.c        |  2 +-
 sound/soc/codecs/wm9081.c        |  8 --------
 sound/soc/codecs/wm9090.c        |  7 -------
 sound/soc/soc-core.c             |  2 +-
 sound/soc/soc-io.c               |  4 ----
 84 files changed, 3 insertions(+), 524 deletions(-)

-- 
1.8.4
