From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 01/13] ASoC: qcom: make lpass driver depend on OF
Date: Wed, 13 May 2015 13:00:17 +0100
Message-ID: <1431518417-7265-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

lpass driver only support DT so make this explicit in the kconfig.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f58e4f..05b9840 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -6,12 +6,12 @@ config SND_SOC_QCOM
 
 config SND_SOC_LPASS_CPU
 	tristate
-	depends on SND_SOC_QCOM
+	depends on SND_SOC_QCOM && OF
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
-	depends on SND_SOC_QCOM
+	depends on SND_SOC_QCOM && OF
 	select REGMAP_MMIO
 
 config SND_SOC_STORM
-- 
1.9.1
