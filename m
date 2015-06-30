From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] ASoC: tlv320aic32x4: Make mclk optional
Date: Tue, 30 Jun 2015 13:25:10 +0300
Message-ID: <e69e005ac9f0d86b65c3d443610b4231ff30a281.1435569929.git.kimmo.saarela@gmail.com>
References: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

In case mclk is not given, assume that HW works without it, only print
warning instead of error for missing mclk.

Signed-off-by: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ad6cb90..ce0972f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -500,13 +500,14 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* Switch on master clock */
-		ret = clk_prepare_enable(aic32x4->mclk);
-		if (ret) {
-			dev_err(codec->dev, "Failed to enable master clock\n");
-			return ret;
+		if (aic32x4->mclk) {
+			/* Switch on master clock */
+			ret = clk_prepare_enable(aic32x4->mclk);
+			if (ret) {
+				dev_err(codec->dev, "Failed to enable master clock\n");
+				return ret;
+			}
 		}
-
 		/* Switch on PLL */
 		snd_soc_update_bits(codec, AIC32X4_PLLPR,
 				    AIC32X4_PLLEN, AIC32X4_PLLEN);
@@ -558,8 +559,10 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, AIC32X4_PLLPR,
 				    AIC32X4_PLLEN, 0);
 
-		/* Switch off master clock */
-		clk_disable_unprepare(aic32x4->mclk);
+		if (aic32x4->mclk) {
+			/* Switch off master clock */
+			clk_disable_unprepare(aic32x4->mclk);
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		break;
@@ -816,8 +819,8 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 
 	aic32x4->mclk = devm_clk_get(&i2c->dev, "mclk");
 	if (IS_ERR(aic32x4->mclk)) {
-		dev_err(&i2c->dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
-		return PTR_ERR(aic32x4->mclk);
+		dev_warn(&i2c->dev, "Failed getting the mclk.\n");
+		aic32x4->mclk = NULL;
 	}
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
