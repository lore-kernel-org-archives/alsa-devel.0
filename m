From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/4] ASoC: hdmi-codec: fixes and improvements
Date: Mon,  6 May 2019 11:58:11 +0200
Message-ID: <20190506095815.24578-1-jbrunet@baylibre.com>
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

Changes since v1:
* Drop already applied patches
* Rebase patchset on sound/for-next

Jerome Brunet (4):
  ASoC: hdmi-codec: remove function name debug traces
  ASoC: hdmi-codec: remove reference to the current substream
  ASoC: hdmi-codec: remove reference to the dai drivers in the private
    data
  ASoC: hdmi-codec: remove ops dependency on the dai id

 sound/soc/codecs/hdmi-codec.c | 188 ++++++++++++++++------------------
 1 file changed, 91 insertions(+), 97 deletions(-)

-- 
2.20.1
