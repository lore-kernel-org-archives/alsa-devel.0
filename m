From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: add i2c dependency for SND_SOC_SDM845" to the asoc tree
Date: Thu, 14 Mar 2019 15:53:45 +0000 (GMT)
Message-ID: <20190314155345.858DA1126E64@debutante.sirena.org.uk>
References: <20190304203114.1894822-3-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304203114.1894822-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>, Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rohit kumar <rohitkr@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>Cheng-Yi Chiang <cychiang@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: add i2c dependency for SND_SOC_SDM845

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

>From 686174a0989b1c33698b26523a1e4ccdcc84cf22 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Mar 2019 21:30:52 +0100
Subject: [PATCH] ASoC: qcom: add i2c dependency for SND_SOC_SDM845

We must not select SND_SOC_MAX98927 unless CONFIG_I2C
is also enabled:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
