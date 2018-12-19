From: Maruthi Srinivas Bayyavarapu
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 3/3] ASoC: xlnx: enable audio formatter driver build
Date: Wed, 19 Dec 2018 22:49:09 +0530
Message-ID: <1545239949-112845-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Enable audio formatter driver build.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 723a583..ac48d6a 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -6,3 +6,10 @@ config SND_SOC_XILINX_I2S
 	  mode, IP receives audio in AES format, extracts PCM and sends
 	  PCM data. In receiver mode, IP receives PCM audio and
 	  encapsulates PCM in AES format and sends AES data.
+
+config SND_SOC_XILINX_AUDIO_FORMATTER
+        tristate "Audio support for the the Xilinx audio formatter"
+        help
+          Select this option to enable Xilinx audio formatter
+          support. This provides DMA platform device support for
+          audio functionality.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
index 6c1209b..432693b 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
+snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
+obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
-- 
2.7.4
