From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 0/3] add Xilinx SPDIF audio driver
Date: Thu, 3 Jan 2019 23:39:50 +0530
Message-ID: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SPDIF IP supports playback and capture of audio in AES format. Each IP
instance can only work in either transmit or receive mode exclusively.
The patchset adds support for playback and capture functionality.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,spdif: Document spdif bindings
  ASoC: xlnx: add SPDIF audio driver
  ASoC: xlnx: enable SPDIF driver build

 .../devicetree/bindings/sound/xlnx,spdif.txt       |  28 ++
 sound/soc/xilinx/Kconfig                           |   7 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_spdif.c                      | 339 +++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 sound/soc/xilinx/xlnx_spdif.c

-- 
2.7.4
