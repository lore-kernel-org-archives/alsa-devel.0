From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date: Thu,  8 Aug 2019 15:45:00 +0100
Message-ID: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, broonie@kernel.org
Cc: bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
Amplifier which is SoundWire interfaced.
This also adds support to some missing bits in SoundWire bus layer like
Device Tree support and module_sdw_driver macro.

This patchset along with DB845c machine driver and WCD934x codec driver
has been tested on SDM845 SoC based DragonBoard DB845c with two
WSA8810 speakers.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Add thermal sensor support in WSA881x.

This patchset also depends on the soundwire Kconfig patch
https://lkml.org/lkml/2019/7/18/834 from Pierre

Thanks,
srini

Changes since v1 RFC:
- bindings document renamed to slave.txt
- fix error code from dt slave parsing

Srinivas Kandagatla (4):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.txt           |   27 +
 .../devicetree/bindings/soundwire/slave.txt   |   46 +
 drivers/soundwire/bus.c                       |    2 +
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   47 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
 8 files changed, 1295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0
