From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/8] ASoC: fix resource leak in error paths
Date: Thu, 25 Nov 2010 15:06:25 +0800
Message-ID: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Jon Smirl <jonsmirl@gmail.com>, Sergey Lapin <slapin@ossfans.org>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Jaswinder Singh Brar <jassi.brar@samsung.com>, Mika Westerberg <mika.westerberg@iki.fi>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

This serial of patches fix resource leak in error paths.

Axel Lin (8):
  ASoC: efika-audio-fabric: fix resource leak in efika_fabric_init
    error path
  ASoC: pcm030-audio-fabric: fix resource leak in pcm030_fabric_init
    error path
  ASoC: snd-soc-afeb9260: remove unneeded platform_device_del in error
    path
  ASoC: sam9g20_wm8731: fix resource leak in at91sam9g20ek_init error
    path
  ASoC: smdk_wm9713: fix resource leak in smdk_init error path
  ASoC: simone: fix resource leak in simone_init error path
  ASoC: imx-ssi: fix resource leak
  ASoC: phycore-ac97: fix resource leak

 sound/soc/atmel/sam9g20_wm8731.c    |    5 ++++-
 sound/soc/atmel/snd-soc-afeb9260.c  |    1 -
 sound/soc/ep93xx/simone.c           |   18 ++++++++++--------
 sound/soc/fsl/efika-audio-fabric.c  |    1 +
 sound/soc/fsl/pcm030-audio-fabric.c |    1 +
 sound/soc/imx/imx-ssi.c             |   15 +++++++++++----
 sound/soc/imx/phycore-ac97.c        |   28 +++++++++++++++++++++-------
 sound/soc/samsung/smdk_wm9713.c     |   17 ++++++++++-------
 8 files changed, 58 insertions(+), 28 deletions(-)

-- 
1.7.2
