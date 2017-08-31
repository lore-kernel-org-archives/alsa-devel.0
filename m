From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Modified chip default register values" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:48 +0100
Message-ID: <E1dnO3c-0000kK-38@debutante>
References: <1497910046-3369-6-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497910046-3369-6-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Modified chip default register values

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 848844b87a26265019215dbb7fb588a5fac0a110 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:30:58 -0700
Subject: [PATCH] ASoC: max98927: Modified chip default register values

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index f74cdb065bf2..5b853604120a 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -44,9 +44,9 @@ static struct reg_default max98927_reg[] = {
 	{MAX98927_R0011_CLK_MON,  0x00},
 	{MAX98927_R0012_WDOG_CTRL,  0x00},
 	{MAX98927_R0013_WDOG_RST,  0x00},
-	{MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH,  0x00},
-	{MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH,  0x00},
-	{MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS,  0x00},
+	{MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH,  0x75},
+	{MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH,  0x8c},
+	{MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS,  0x08},
 	{MAX98927_R0017_PIN_CFG,  0x55},
 	{MAX98927_R0018_PCM_RX_EN_A,  0x00},
 	{MAX98927_R0019_PCM_RX_EN_B,  0x00},
@@ -82,14 +82,14 @@ static struct reg_default max98927_reg[] = {
 	{MAX98927_R003A_AMP_EN,  0x00},
 	{MAX98927_R003B_SPK_SRC_SEL,  0x00},
 	{MAX98927_R003C_SPK_GAIN,  0x00},
-	{MAX98927_R003D_SSM_CFG,  0x01},
+	{MAX98927_R003D_SSM_CFG,  0x04},
 	{MAX98927_R003E_MEAS_EN,  0x00},
 	{MAX98927_R003F_MEAS_DSP_CFG,  0x04},
 	{MAX98927_R0040_BOOST_CTRL0,  0x00},
 	{MAX98927_R0041_BOOST_CTRL3,  0x00},
 	{MAX98927_R0042_BOOST_CTRL1,  0x00},
 	{MAX98927_R0043_MEAS_ADC_CFG,  0x00},
-	{MAX98927_R0044_MEAS_ADC_BASE_MSB,  0x00},
+	{MAX98927_R0044_MEAS_ADC_BASE_MSB,  0x01},
 	{MAX98927_R0045_MEAS_ADC_BASE_LSB,  0x00},
 	{MAX98927_R0046_ADC_CH0_DIVIDE,  0x00},
 	{MAX98927_R0047_ADC_CH1_DIVIDE,  0x00},
-- 
2.14.1
