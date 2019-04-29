From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/6] ASoC: hdmi-codec: fixes and improvements
Date: Mon, 29 Apr 2019 15:29:37 +0200
Message-ID: <20190429132943.16269-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset is a collection of fixes and improvement on the hdmi
codec driver. It should be completely transparent for the current users
of the codec.

The most important change is removal the current_substream pointer which
allows the codec to be used on codec-to-codec links. I plan to use this
for the HDMI sound support of the Amlogic g12a SoC family.

Jerome Brunet (6):
  ASoC: hdmi-codec: remove function name debug traces
  ASoC: hdmi-codec: unlock the device on startup errors
  ASoC: hdmi-codec: stream is already locked in hw_params
  ASoC: hdmi-codec: remove reference to the current substream
  ASoC: hdmi-codec: remove reference to the dai drivers in the private
    data
  ASoC: hdmi-codec: remove ops dependency on the dai id

 sound/soc/codecs/hdmi-codec.c | 259 ++++++++++++++++------------------
 1 file changed, 125 insertions(+), 134 deletions(-)

-- 
2.20.1
