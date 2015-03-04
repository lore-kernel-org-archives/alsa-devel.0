From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V7 08/10] ASoC: qcom: Add ability to build QCOM drivers
Date: Tue,  3 Mar 2015 16:21:57 -0800
Message-ID: <1425428519-12224-9-git-send-email-kwestfie@codeaurora.org>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Define the LPASS platform driver, the LPASS
CPU DAI driver and the Storm machine driver
configurations, and how to build them.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig  | 25 +++++++++++++++++++++++++
 sound/soc/qcom/Makefile | 11 +++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..5f58e4f1bca98b5c4c4c951dce24036aafa2d694
--- /dev/null
+++ b/sound/soc/qcom/Kconfig
@@ -0,0 +1,25 @@
+config SND_SOC_QCOM
+	tristate "ASoC support for QCOM platforms"
+	help
+          Say Y or M if you want to add support to use audio devices
+          in Qualcomm Technologies SOC-based platforms.
+
+config SND_SOC_LPASS_CPU
+	tristate
+	depends on SND_SOC_QCOM
+	select REGMAP_MMIO
+
+config SND_SOC_LPASS_PLATFORM
+	tristate
+	depends on SND_SOC_QCOM
+	select REGMAP_MMIO
+
+config SND_SOC_STORM
+	tristate "ASoC I2S support for Storm boards"
+	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
+	select SND_SOC_LPASS_CPU
+	select SND_SOC_LPASS_PLATFORM
+	select SND_SOC_MAX98357A
+	help
+          Say Y or M if you want add support for SoC audio on the
+          Qualcomm Technologies IPQ806X-based Storm board.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c5ce96c761c47b3a1b98e27d863fe0b5b9bc019e
--- /dev/null
+++ b/sound/soc/qcom/Makefile
@@ -0,0 +1,11 @@
+# Platform
+snd-soc-lpass-cpu-objs := lpass-cpu.o
+snd-soc-lpass-platform-objs := lpass-platform.o
+
+obj-$(CONFIG_SND_SOC_LPASS_CPU) += snd-soc-lpass-cpu.o
+obj-$(CONFIG_SND_SOC_LPASS_PLATFORM) += snd-soc-lpass-platform.o
+
+# Machine
+snd-soc-storm-objs := storm.o
+
+obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
