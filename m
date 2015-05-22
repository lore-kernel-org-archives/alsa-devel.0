From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/3] ASoC: qcom: fix STORM board Kconfig
Date: Fri, 22 May 2015 16:54:17 +0100
Message-ID: <1432310057-5358-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Arnd Bergmann <arnd@arndb.de>

This patch is a fixup to correct dependencies in patch 9bae4880acee
("ASoC: qcom: move ipq806x specific bits out of lpass driver.")

Originally this change-set was suggested by Arnd on mailing list.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 6ecac6c..f50197e 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -26,7 +26,7 @@ config SND_SOC_LPASS_APQ8016
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
+	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
-- 
1.9.1
