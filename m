From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 11/11] ASoC: amd: enable acp3x drivers build
Date: Mon, 12 Nov 2018 11:05:02 +0530
Message-ID: <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: vijendar.mukunda@amd.com, Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Alex Deucher <alexander.deucher@amd.com>, open list <linux-kernel@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ACP3x drivers can be built by selecting necessary kernel config option.
The patch enables build support of the same.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/Kconfig        | 5 +++++
 sound/soc/amd/Makefile       | 1 +
 sound/soc/amd/raven/Makefile | 4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 sound/soc/amd/raven/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 58c1dcb..5f3b560 100644
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
index 79b0622..8e1c571 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -5,3 +5,4 @@ snd-soc-acp-rt5645-mach-objs := acp-rt5645.o
 obj-$(CONFIG_SND_SOC_AMD_ACP) += acp_audio_dma.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH) += snd-soc-acp-da7219mx98357-mach.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
new file mode 100644
index 0000000..8c03e6f
--- /dev/null
+++ b/sound/soc/amd/raven/Makefile
@@ -0,0 +1,4 @@
+snd-pci-acp3x-objs	:= pci-acp3x.o
+snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-acp3x-pcm-dma.o
-- 
2.7.4
