From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 0/3] Add Xilinx I2S driver
Date: Sat, 8 Dec 2018 00:02:35 +0530
Message-ID: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Xilinx I2S IP enables I2S audio. Each IP can either work in playback
or capture mode exclusively. The driver supports both by reading the
configuration in device tree.
Patchset includes devicetree bindings documentation, driver and build
enablement.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,i2s: Document i2s bindings
  ASoC: xlnx: Add i2s driver
  ASoC: xlnx: enable i2s driver build

 .../devicetree/bindings/sound/xlnx,i2s.txt         |  28 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/xilinx/Kconfig                           |   8 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_i2s.c                        | 185 +++++++++++++++++++++
 6 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

-- 
2.7.4
