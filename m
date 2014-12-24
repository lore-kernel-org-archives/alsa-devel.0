From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 08/10] ASoC: qcom: Add ability to build QCOM drivers
Date: Wed, 24 Dec 2014 08:42:08 -0800
Message-ID: <1419439330-2303-9-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Now all drivers are in place, allow them to build.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig  | 27 +++++++++++++++++++++++++++
 sound/soc/qcom/Makefile |  6 ++++++
 2 files changed, 33 insertions(+)
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..847530a7fe5caa980b763fc3f77889825c20f47b
--- /dev/null
+++ b/sound/soc/qcom/Kconfig
@@ -0,0 +1,27 @@
+config SND_SOC_QCOM
+	tristate "SoC Audio support for QCOM platforms"
+	help
+          Support for audio in Qualcomm Technologies SOC-based systems.
+          Say Y if you want to use audio devices such as I2S, PCM,
+          S/PDIF, etc.
+
+config SND_SOC_CPU_MI2S
+	tristate
+	depends on SND_SOC_QCOM
+
+config SND_SOC_IPQ806X
+	tristate "SoC Audio support for IPQ806x based platforms"
+	depends on SND_SOC_QCOM || ARCH_QCOM || COMPILE_TEST
+        select SND_SIMPLE_CARD
+	select SND_SOC_PCM_MI2S
+	select SND_SOC_CPU_MI2S
+        select SND_SOC_MAX98357A
+	help
+          Support for Qualcomm Technologies LPASS audio block in
+          IPQ806X SOC-based systems.
+          Say Y if you want to use audio devices such as I2S, PCM,
+          S/PDIF, etc.
+
+config SND_SOC_PCM_MI2S
+	tristate
+	depends on SND_SOC_QCOM
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..214f3617d016386b445466e14e47288f9179590a
--- /dev/null
+++ b/sound/soc/qcom/Makefile
@@ -0,0 +1,6 @@
+# Platform
+snd-soc-lpass-pcm-mi2s-objs := lpass-pcm-mi2s.o
+snd-soc-lpass-cpu-mi2s-objs := lpass-cpu-mi2s.o
+
+obj-$(CONFIG_SND_SOC_PCM_MI2S) += snd-soc-lpass-pcm-mi2s.o
+obj-$(CONFIG_SND_SOC_CPU_MI2S) += snd-soc-lpass-cpu-mi2s.o
-- 
1.8.2.1
