From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 3/7] staging: max98927: Updated volatile register list
Date: Mon, 19 Jun 2017 15:07:22 -0700
Message-ID: <1497910046-3369-3-git-send-email-ryans.lee@maximintegrated.com>
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
 sound/soc/codecs/max98927.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index cdee3a3..585b8d0 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -586,6 +586,13 @@ static bool max98927_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98927_R0001_INT_RAW1 ... MAX98927_R0009_INT_FLAG3:
+	case MAX98927_R004C_MEAS_ADC_CH0_READ:
+	case MAX98927_R004D_MEAS_ADC_CH1_READ:
+	case MAX98927_R004E_MEAS_ADC_CH2_READ:
+	case MAX98927_R0051_BROWNOUT_STATUS:
+	case MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ:
+	case MAX98927_R01FF_REV_ID:
+	case MAX98927_R0100_SOFT_RESET:
 		return true;
 	default:
 		return false;
-- 
2.7.4
