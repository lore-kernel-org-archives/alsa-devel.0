From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 01/10] ASoC: qcom: make lpass driver depend on OF
Date: Thu, 21 May 2015 22:52:41 +0100
Message-ID: <1432245161-8990-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

lpass driver only support DT so make this explicit in the kconfig.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b30c2ba..190c27d 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -6,10 +6,12 @@ config SND_SOC_QCOM
 
 config SND_SOC_LPASS_CPU
 	tristate
+	depends on OF
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
+	depends on OF
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_IPQ806X
-- 
1.9.1
