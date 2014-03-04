From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFC][PATCH 0/3] Remove set_cache_io entirely from ASoC probe
Date: Tue, 4 Mar 2014 16:25:26 +0800
Message-ID: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


Xiubo Li (3):
  ASoC: core: Move the default regmap I/O setting to
    snd_soc_register_codec()
  ASoc: codec: remove the set_cache_io() entirely from CODEC ASoC probe.
  ASoC: core: remove the default regmap I/O setting up from
    soc_probe_codec()

 include/sound/soc.h        |  3 +++
 sound/soc/codecs/cq93vc.c  |  6 ++++--
 sound/soc/codecs/mc13783.c | 10 ++--------
 sound/soc/codecs/wm5102.c  |  6 ++----
 sound/soc/codecs/wm5110.c  |  6 ++----
 sound/soc/codecs/wm8350.c  |  6 ++++--
 sound/soc/codecs/wm8400.c  |  6 ++++--
 sound/soc/codecs/wm8994.c  |  4 ++--
 sound/soc/codecs/wm8997.c  |  7 ++-----
 sound/soc/soc-core.c       | 21 +++++++++++----------
 10 files changed, 36 insertions(+), 39 deletions(-)

-- 
1.8.4
