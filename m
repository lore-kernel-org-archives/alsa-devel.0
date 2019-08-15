From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs42l56: remove unused variable 'adc_swap_enum'
Date: Thu, 15 Aug 2019 17:24:36 +0800
Message-ID: <20190815092436.34632-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/cs42l56.c:206:30: warning:
 adc_swap_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs42l56.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index b4d7627..ac569ab 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -199,14 +199,6 @@ static const struct soc_enum beep_bass_enum =
 	SOC_ENUM_SINGLE(CS42L56_BEEP_TONE_CFG, 1,
 			ARRAY_SIZE(beep_bass_text), beep_bass_text);
 
-static const char * const adc_swap_text[] = {
-	"None", "A+B/2", "A-B/2", "Swap"
-};
-
-static const struct soc_enum adc_swap_enum =
-	SOC_ENUM_SINGLE(CS42L56_MISC_ADC_CTL, 3,
-			ARRAY_SIZE(adc_swap_text), adc_swap_text);
-
 static const char * const pgaa_mux_text[] = {
 	"AIN1A", "AIN2A", "AIN3A"};
 
-- 
2.7.4
