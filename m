From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: enable acp3x drivers build" to the asoc tree
Date: Tue, 13 Nov 2018 19:45:21 +0000 (GMT)
Message-ID: <20181113194521.5AEE8440079@finisterre.ee.mobilebroadband>
References: <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Vishnuvardhanrao.Ravulapati@amd.comMark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Akshu Agrawal <akshu.agrawal@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: enable acp3x drivers build

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

>From 818ba93b0e9ed4a08cba575dd49c1391ef4b7776 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:05:02 +0530
Subject: [PATCH] ASoC: amd: enable acp3x drivers build

ACP3x drivers can be built by selecting necessary kernel config option.
The patch enables build support of the same.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig        | 5 +++++
 sound/soc/amd/Makefile       | 1 +
 sound/soc/amd/raven/Makefile | 4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 sound/soc/amd/raven/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 58c1dcb4d255..5f3b56087ba1 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -19,3 +19,8 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for rt5645.
+
+config SND_SOC_AMD_ACP3x
+	tristate "AMD Audio Coprocessor-v3.x support"
+	help
+	 This option enables ACP v3.x I2S support on AMD platform
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 79b0622fa5d3..8e1c571c3161 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -5,3 +5,4 @@ snd-soc-acp-rt5645-mach-objs := acp-rt5645.o
 obj-$(CONFIG_SND_SOC_AMD_ACP) += acp_audio_dma.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH) += snd-soc-acp-da7219mx98357-mach.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
new file mode 100644
index 000000000000..8c03e6fccf6a
--- /dev/null
+++ b/sound/soc/amd/raven/Makefile
@@ -0,0 +1,4 @@
+snd-pci-acp3x-objs	:= pci-acp3x.o
+snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-acp3x-pcm-dma.o
-- 
2.19.1
