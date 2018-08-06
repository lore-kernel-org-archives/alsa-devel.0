From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] ASoC: qcom: make common.c as proper module
Date: Mon,  6 Aug 2018 11:12:05 +0100
Message-ID: <20180806101209.15167-2-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch converts common helper functions in to proper module
and also fixes below warning.

WARNING: sound/soc/qcom/snd-soc-sdm845: 'qcom_snd_parse_of' exported twice.
Previous export was in sound/soc/qcom/snd-soc-apq8096.ko

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig  | 5 +++++
 sound/soc/qcom/Makefile | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f03312ef007..2a4c912d1e48 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -41,6 +41,9 @@ config SND_SOC_APQ8016_SBC
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
 
+config SND_SOC_QCOM_COMMON
+	tristate
+
 config SND_SOC_QDSP6_COMMON
 	tristate
 
@@ -86,6 +89,7 @@ config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
@@ -95,6 +99,7 @@ config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index f0e94d48ba98..41b2c7a23a4d 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,13 +13,15 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
-snd-soc-apq8096-objs := apq8096.o common.o
-snd-soc-sdm845-objs := sdm845.o common.o
+snd-soc-apq8096-objs := apq8096.o
+snd-soc-sdm845-objs := sdm845.o
+snd-soc-qcom-common-objs := common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
+obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
-- 
2.16.2
