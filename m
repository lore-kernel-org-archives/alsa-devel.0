From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: enable audio formatter driver
	build" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:29 +0000 (GMT)
Message-ID: <20190104140129.B915311270A3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF99267C63
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:30 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: enable audio formatter driver build

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

>From b31daa15af760747b91dbb76c80306d77d8ae05f Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Fri, 21 Dec 2018 14:27:29 +0530
Subject: [PATCH] ASoC: xlnx: enable audio formatter driver build

Enable audio formatter driver build.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 723a583a8d57..ac48d6a00c36 100644
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
index 6c1209b9ee75..432693b1cc79 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
+snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
+obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
-- 
2.20.1
