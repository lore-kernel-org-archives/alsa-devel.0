From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: enable SPDIF driver build" to the asoc tree
Date: Mon,  7 Jan 2019 18:57:43 +0000 (GMT)
Message-ID: <20190107185743.B90241127491@debutante.sirena.org.uk>
References: <1546538993-55473-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546538993-55473-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: enable SPDIF driver build

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 47caf048a017ecc95cdd0802bc3b015a1559e601 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Thu, 3 Jan 2019 23:39:53 +0530
Subject: [PATCH] ASoC: xlnx: enable SPDIF driver build

Added SPDIF driver build related changes.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index ac48d6a00c36..47f606b924e4 100644
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
index 432693b1cc79..d79fd38b094b 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -2,3 +2,5 @@ snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
 snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
 obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
+snd-soc-xlnx-spdif-objs := xlnx_spdif.o
+obj-$(CONFIG_SND_SOC_XILINX_SPDIF) += snd-soc-xlnx-spdif.o
-- 
2.20.1
