From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 7/9] ASoC: qcom: Add ability to build QCOM drivers
Date: Wed, 19 Nov 2014 10:52:47 -0800
Message-ID: <1416423169-21865-8-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Now all drivers are in place, allow them to build.

Change-Id: I16b9c4c2796bc1cf86aecae5fc500e685906fa8f
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig  | 43 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/Makefile | 11 +++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 sound/soc/qcom/Kconfig
 create mode 100644 sound/soc/qcom/Makefile

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..00cbdf8b29e68d32154a854a8bbfe2ac13b8b985
--- /dev/null
+++ b/sound/soc/qcom/Kconfig
@@ -0,0 +1,43 @@
+#
+# Copyright (c) 2013-2014 The Linux Foundation. All rights reserved.
+#
+# Permission to use, copy, modify, and/or distribute this software for any
+# purpose with or without fee is hereby granted, provided that the above
+# copyright notice and this permission notice appear in all copies.
+#
+# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+config SND_SOC_CPU_DAI
+	bool
+	depends on SND_SOC_QCOM
+
+config SND_SOC_IPQ806X
+	bool "SoC Audio support for IPQ806x based platforms"
+	depends on SND_SOC_QCOM || ARCH_QCOM
+	select SND_SOC_PCM_I2S
+	select SND_SOC_CPU_DAI
+	select SND_SOC_LPAIF
+	help
+          Support for Qualcomm Technologies LPASS audio block in IPQ806X SOC-based systems.
+          Say Y if you want to use audio devices that will run on these boards.
+
+config SND_SOC_LPAIF
+	bool
+	depends on SND_SOC_QCOM
+
+config SND_SOC_PCM_I2S
+	bool
+	depends on SND_SOC_QCOM
+
+config SND_SOC_QCOM
+	bool "SoC Audio support for QCOM platforms"
+	help
+          Support for audio in Qualcomm Technologies SOC-based systems.
+          Say Y if you want to use audio devices that will run on IPQ806x and similar SOCs.
+
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0a74177df75f7aa5f7fbaab35da9b92689fa3d6a
--- /dev/null
+++ b/sound/soc/qcom/Makefile
@@ -0,0 +1,11 @@
+#QCOM SOUNDCARDS
+
+snd-soc-ipq806x-objs := ipq806x.o
+snd-soc-lpass-pcm-mi2s-objs := lpass-pcm-mi2s.o
+snd-soc-lpass-cpu-dai-objs := lpass-cpu-dai.o
+snd-soc-lpass-lpaif-objs := lpass-lpaif.o
+
+obj-$(CONFIG_SND_SOC_IPQ806X) += snd-soc-ipq806x.o
+obj-$(CONFIG_SND_SOC_PCM_I2S) += snd-soc-lpass-pcm-mi2s.o
+obj-$(CONFIG_SND_SOC_CPU_DAI) += snd-soc-lpass-cpu-dai.o
+obj-$(CONFIG_SND_SOC_LPAIF) += snd-soc-lpass-lpaif.o
-- 
1.8.2.1
