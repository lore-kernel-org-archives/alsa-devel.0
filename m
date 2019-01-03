From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 3/3] ASoC: xlnx: enable SPDIF driver build
Date: Thu, 3 Jan 2019 23:39:53 +0530
Message-ID: <1546538993-55473-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Added SPDIF driver build related changes.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index ac48d6a..47f606b9 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -13,3 +13,10 @@ config SND_SOC_XILINX_AUDIO_FORMATTER
           Select this option to enable Xilinx audio formatter
           support. This provides DMA platform device support for
           audio functionality.
+
+config SND_SOC_XILINX_SPDIF
+        tristate "Audio support for the the Xilinx SPDIF"
+        help
+          Select this option to enable Xilinx SPDIF Audio.
+          This provides playback and capture of SPDIF audio in
+          AES format.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
index 432693b..d79fd38 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -2,3 +2,5 @@ snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
 snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
 obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
+snd-soc-xlnx-spdif-objs := xlnx_spdif.o
+obj-$(CONFIG_SND_SOC_XILINX_SPDIF) += snd-soc-xlnx-spdif.o
-- 
2.7.4
