From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: make common.c as proper module"
	to the asoc tree
Date: Mon,  6 Aug 2018 12:51:01 +0100 (BST)
Message-ID: <20180806115101.1147E1124240@debutante.sirena.org.uk>
References: <20180806101209.15167-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D00267858
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:51:01 +0200 (CEST)
In-Reply-To: <20180806101209.15167-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: make common.c as proper module

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

>From 8e3684f66e15c354dba5544c2af8ce973ed40cf6 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 6 Aug 2018 11:12:05 +0100
Subject: [PATCH] ASoC: qcom: make common.c as proper module

This patch converts common helper functions in to proper module
and also fixes below warning.

WARNING: sound/soc/qcom/snd-soc-sdm845: 'qcom_snd_parse_of' exported twice.
Previous export was in sound/soc/qcom/snd-soc-apq8096.ko

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0
