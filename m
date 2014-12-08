From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 09/11] ASoC: qcom: Add ability to build QCOM drivers
Date: Mon,  8 Dec 2014 14:01:11 -0800
Message-ID: <1418076073-12623-10-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Now all drivers are in place, allow them to build.

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
index 0000000000000000000000000000000000000000..cd4d88bc079c02d3a665b163aefca798fa8a08dc
--- /dev/null
+++ b/sound/soc/qcom/Kconfig
@@ -0,0 +1,25 @@
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
+	depends on SND_SOC_QCOM || ARCH_QCOM
+	select SND_SOC_PCM_MI2S
+	select SND_SOC_CPU_MI2S
+        select SND_SOC_MAX98357A
+	help
+          Support for Qualcomm Technologies LPASS audio block in IPQ806X SOC-based systems.
+          Say Y if you want to use audio devices such as I2S, PCM,
+          S/PDIF, etc.
+
+config SND_SOC_PCM_MI2S
+	tristate
+	depends on SND_SOC_QCOM
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0c5779a72c8ef95e3d6da12c76303997d91d11a6
--- /dev/null
+++ b/sound/soc/qcom/Makefile
@@ -0,0 +1,11 @@
+# Platform
+snd-soc-lpass-pcm-mi2s-objs := lpass-pcm-mi2s.o
+snd-soc-lpass-cpu-mi2s-objs := lpass-cpu-mi2s.o
+
+obj-$(CONFIG_SND_SOC_PCM_MI2S) += snd-soc-lpass-pcm-mi2s.o
+obj-$(CONFIG_SND_SOC_CPU_MI2S) += snd-soc-lpass-cpu-mi2s.o
+
+# Machine
+snd-soc-ipq806x-objs := ipq806x.o
+
+obj-$(CONFIG_SND_SOC_IPQ806X) += snd-soc-ipq806x.o
-- 
1.8.2.1
