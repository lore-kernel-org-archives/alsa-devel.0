From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/6] ASoC: Remove unused control_data field from private
 struct
Date: Tue, 27 Sep 2011 20:38:48 +0800
Message-ID: <1317127128.7207.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This serial removes unused control_data field from private struct.
The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Note: I don't have these hardware, only compile test on these patches.

Axel Lin (6):
  ASoC: Remove unused "control_data" field of struct wm8904_priv
  ASoC: Remove unused "control_data" field of struct wm8940_priv
  ASoC: Remove unused "control_data" field of struct wm8960_priv
  ASoC: Remove unused "control_data" field of struct wm8978_priv
  ASoC: Remove unused "control_data" field of struct wm9081_priv
  ASoC: Remove unused "control_data" field of struct wm9090_priv

 sound/soc/codecs/wm8904.c |    2 --
 sound/soc/codecs/wm8940.c |    3 ---
 sound/soc/codecs/wm8960.c |    3 ---
 sound/soc/codecs/wm8978.c |    3 ---
 sound/soc/codecs/wm9081.c |    3 ---
 sound/soc/codecs/wm9090.c |    3 ---
 6 files changed, 0 insertions(+), 17 deletions(-)

-- 
1.7.4.1
