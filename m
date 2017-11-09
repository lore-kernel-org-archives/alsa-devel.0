From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 08/17] ASoC: tlv320aic31xx: Check clock and divider before division
Date: Wed, 8 Nov 2017 18:27:32 -0600
Message-ID: <20171109002741.10897-9-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

If our set_sysclk DAI callback has not been called yet p_div will be 0
and dividing by this will cause an error. Print an error message and
leave before this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e8eb3de7af7b..95518eabd7e8 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -763,11 +763,17 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int bclk_score = snd_soc_params_to_frame_size(params);
-	int mclk_p = aic31xx->sysclk / aic31xx->p_div;
+	int mclk_p;
 	int bclk_n = 0;
 	int match = -1;
 	int i;
 
+	if (!aic31xx->sysclk || !aic31xx->p_div) {
+		dev_err(codec->dev, "Master clock not supplied\n");
+		return -EINVAL;
+	}
+	mclk_p = aic31xx->sysclk / aic31xx->p_div;
+
 	/* Use PLL as CODEC_CLKIN and DAC_CLK as BDIV_CLKIN */
 	snd_soc_update_bits(codec, AIC31XX_CLKMUX,
 			    AIC31XX_CODEC_CLKIN_MASK, AIC31XX_CODEC_CLKIN_PLL);
-- 
2.15.0
