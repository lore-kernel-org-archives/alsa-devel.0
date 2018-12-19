From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 0/3] add Xilinx audio formatter driver
Date: Wed, 19 Dec 2018 22:49:06 +0530
Message-ID: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Audio formatter IP supports two streaming interfaces - MM2S for playback
and S2MM for capture. The driver enables DMA functionality for both the interfaces.
Patchset includes devicetree bindings documentation, driver and build enablement.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,audio-formatter: Document audio formatter
    bindings
  ASoC: xlnx: add pcm formatter platform driver
  ASoC: xlnx: enable audio formatter driver build

 .../bindings/sound/xlnx,audio-formatter.txt        |  29 ++
 sound/soc/xilinx/Kconfig                           |   7 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_formatter_pcm.c              | 561 +++++++++++++++++++++
 4 files changed, 599 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c

-- 
2.7.4
