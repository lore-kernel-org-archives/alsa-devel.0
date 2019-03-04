From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] ASoC: qcom: add i2c dependency for SND_SOC_SDM845
Date: Mon,  4 Mar 2019 21:30:52 +0100
Message-ID: <20190304203114.1894822-3-arnd@arndb.de>
References: <20190304203114.1894822-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We must not select SND_SOC_MAX98927 unless CONFIG_I2C
is also enabled:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 75ceb04d8bf0..b1764af858ba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && MFD_CROS_EC
+	depends on QCOM_APR && MFD_CROS_EC && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.0
