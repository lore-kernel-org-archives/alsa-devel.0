From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ASoC: codecs: msm8916: fix invalid cast to bool type
Date: Tue,  2 May 2017 22:33:01 +0900
Message-ID: <20170502133303.19622-3-o-takashi@sakamocchi.jp>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, "# 4 . 10+" <stable@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

A function snd_soc_update_bits() is an application of
regmap_update_bits_base(). This function takes some arguments for bitmask
and new value, thus the arguments should be a type which has width.
However bool is used to variable for the argument. This brings truncation
and results in invalid operation.

This commit fixes this bug by using unsigned int type, instead of bool.
This bug is detected by sparse:

smsm8916-wcd-analog.c:809:43: warning: odd constant _Bool cast (40 becomes 1)
smsm8916-wcd-analog.c:814:43: warning: odd constant _Bool cast (40 becomes 1)

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: <stable@vger.kernel.org> # 4.10+
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d8e8590..a788029 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -223,8 +223,8 @@ struct pm8916_wcd_analog_priv {
 	u16 codec_version;
 	struct clk *mclk;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
-	bool micbias1_cap_mode;
-	bool micbias2_cap_mode;
+	unsigned int micbias1_cap_mode;
+	unsigned int micbias2_cap_mode;
 };
 
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
@@ -285,7 +285,7 @@ static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 
 static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_codec
 						 *codec, int event,
-						 int reg, u32 cap_mode)
+						 int reg, unsigned int cap_mode)
 {
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-- 
2.9.3
