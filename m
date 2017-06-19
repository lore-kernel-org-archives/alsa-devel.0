From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 6/7] staging: max98927: Modified chip default register values
Date: Mon, 19 Jun 2017 15:07:25 -0700
Message-ID: <1497910046-3369-6-git-send-email-ryans.lee@maximintegrated.com>
References: <1497910046-3369-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497910046-3369-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 5e33956..36be29c 100644
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
2.7.4
