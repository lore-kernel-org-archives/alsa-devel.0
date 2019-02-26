From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Kconfig: fix dependency for sdm845" to the asoc tree
Date: Tue, 26 Feb 2019 12:06:16 +0000 (GMT)
Message-ID: <20190226120616.C2A2A11284E3@debutante.sirena.org.uk>
References: <20190225135405.108052-1-cychiang@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225135405.108052-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, ncrews@chromium.orgrdunlap@infradead.org, tzungbi@chromium.orgMark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>enric.balletbo@collabora.com, dgreid@chromium.org, bleung@chromium.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Kconfig: fix dependency for sdm845

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

>From cdcdba5d624fc3fbad224230ca318c6ddf73795a Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 25 Feb 2019 21:54:05 +0800
Subject: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845

SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
warning.

Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8f206cb4fcc0..75ceb04d8bf0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR
+	depends on QCOM_APR && MFD_CROS_EC
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.1
