From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/5] ASoC: codecs: Add WSA881x Smart Speaker amplifier support
Date: Tue, 11 Jun 2019 11:40:38 +0100
Message-ID: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bgoswami@quicinc.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Thanks,
srini

Srinivas Kandagatla (5):
  dt-bindings: soundwire: add slave bindings
  soundwire: core: add device tree support for slave devices
  soundwire: add module_sdw_driver helper macro
  dt-bindings: ASoC: Add WSA881x bindings
  ASoC: codecs: add wsa881x amplifier support

 .../bindings/sound/qcom,wsa881x.txt           |   27 +
 .../devicetree/bindings/soundwire/bus.txt     |   48 +
 drivers/soundwire/bus.c                       |    2 +-
 drivers/soundwire/bus.h                       |    1 +
 drivers/soundwire/slave.c                     |   54 +-
 include/linux/soundwire/sdw_type.h            |   11 +
 sound/soc/codecs/Kconfig                      |    9 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
 9 files changed, 1312 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
 create mode 100644 sound/soc/codecs/wsa881x.c

-- 
2.21.0
