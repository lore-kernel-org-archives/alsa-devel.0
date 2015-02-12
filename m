From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V5 10/12] ASoC: qcom: Add ability to build QCOM drivers
Date: Wed, 11 Feb 2015 18:10:13 -0800
Message-ID: <1423707015-14527-11-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Define the LPASS platform driver and the LPASS
CPU DAI driver configuration, and how to build
them.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig  | 26 ++++++++++++++++++++++++++
 sound/soc/qcom/Makefile | 11 +++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..803fc204d65ae1916f30477bdaf926b650320c8a
--- /dev/null
+++ b/sound/soc/qcom/Kconfig
@@ -0,0 +1,26 @@
+config SND_SOC_QCOM
+	tristate "SoC Audio support for QCOM platforms"
+	help
+          Support for audio in Qualcomm Technologies SOC-based systems.
+          Say Y if you want to use audio devices such as I2S, PCM,
+          S/PDIF, etc.
+
+config SND_SOC_LPASS_CPU
+	tristate
+	depends on SND_SOC_QCOM
+
+config SND_SOC_IPQ806X_MAX98357A
+	tristate "SoC Audio support for IPQ806x based platforms"
+	depends on SND_SOC_QCOM || ARCH_QCOM || COMPILE_TEST
+	select SND_SOC_LPASS_CPU
+	select SND_SOC_LPASS_PLATFORM
+	select SND_SOC_MAX98357A
+	help
+          Support for Qualcomm Technologies LPASS audio block in
+          IPQ806X SOC-based systems.
+          Say Y if you want to use audio devices such as I2S, PCM,
+          S/PDIF, etc.
+
+config SND_SOC_LPASS_PLATFORM
+	tristate
+	depends on SND_SOC_QCOM
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..b2811496b0df654a451c0dc231ab5bff84ca2850
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
+snd-soc-ipq806x-max98357a-objs := ipq806x-max98357a.o
+
+obj-$(CONFIG_SND_SOC_IPQ806X_MAX98357A) += snd-soc-ipq806x-max98357a.o
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
