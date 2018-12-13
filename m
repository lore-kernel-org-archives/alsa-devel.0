From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: enable i2s driver build" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:14 +0000 (GMT)
Message-ID: <20181213181114.1210211254D1@debutante.sirena.org.uk>
References: <1544207558-72508-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544207558-72508-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: enable i2s driver build

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

>From 33f8db9a89200c18ff65d494a3dbd325d129e15e Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:38 +0530
Subject: [PATCH] ASoC: xlnx: enable i2s driver build

Enabled i2s driver build option.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig         | 1 +
 sound/soc/Makefile        | 1 +
 sound/soc/xilinx/Kconfig  | 8 ++++++++
 sound/soc/xilinx/Makefile | 2 ++
 4 files changed, 12 insertions(+)
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1cf11cf51e1d..d21659f5a7e2 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -73,6 +73,7 @@ source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/uniphier/Kconfig"
 source "sound/soc/ux500/Kconfig"
+source "sound/soc/xilinx/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87c3cfc..aff7b1989436 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= uniphier/
 obj-$(CONFIG_SND_SOC)	+= ux500/
+obj-$(CONFIG_SND_SOC)	+= xilinx/
 obj-$(CONFIG_SND_SOC)	+= xtensa/
 obj-$(CONFIG_SND_SOC)	+= zte/
diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
new file mode 100644
index 000000000000..25e287feb58c
--- /dev/null
+++ b/sound/soc/xilinx/Kconfig
@@ -0,0 +1,8 @@
+config SND_SOC_XILINX_I2S
+	tristate "Audio support for the the Xilinx I2S"
+	help
+	  Select this option to enable Xilinx I2S Audio. This enables
+	  I2S playback and capture using xilinx soft IP. In transmitter
+	  mode, IP receives audio in AES format, extracts PCM and sends
+	  PCM data. In receiver mode, IP receives PCM audio and
+	  encapsulates PCM in AES format and sends AES data.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
new file mode 100644
index 000000000000..6c1209b9ee75
--- /dev/null
+++ b/sound/soc/xilinx/Makefile
@@ -0,0 +1,2 @@
+snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
+obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
-- 
2.19.0.rc2
