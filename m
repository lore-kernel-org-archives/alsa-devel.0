From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date: Thu, 14 Jun 2018 13:11:36 +0200
Message-ID: <20180614111138.8923-6-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

of_platform_device_destroy is only defined when building
with CONFIG_OF=y. Add a depends on OF.

sound/soc/qcom/qdsp6/q6afe.o: In function `q6afe_remove':
q6afe.c:(.text+0x363): undefined reference to `of_platform_device_destroy'
sound/soc/qcom/qdsp6/q6adm.o: In function `q6adm_remove':
q6adm.c:(.text+0x216): undefined reference to `of_platform_device_destroy'
sound/soc/qcom/qdsp6/q6asm.o: In function `q6asm_remove':
q6asm.c:(.text+0x723): undefined reference to `of_platform_device_destroy'

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 87838fa27997..3989ec856441 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -67,7 +67,7 @@ config SND_SOC_QDSP6_ASM_DAI
 
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
-	depends on QCOM_APR && HAS_DMA
+	depends on QCOM_APR && HAS_DMA && OF
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
-- 
2.17.1
