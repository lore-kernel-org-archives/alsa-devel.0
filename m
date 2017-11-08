From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 8/9] ASoC: tlv320aic31xx: Fix the reset GPIO OF name
Date: Wed, 8 Nov 2017 15:25:04 -0600
Message-ID: <20171108212505.28320-9-afd@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108212505.28320-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpio", fix this here.

Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 54a87a905eb6..359eba15bb89 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1279,7 +1279,7 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 		aic31xx->pdata.micbias_vg = MICBIAS_2_0V;
 	}
 
-	ret = of_get_named_gpio(np, "gpio-reset", 0);
+	ret = of_get_named_gpio(np, "reset-gpio", 0);
 	if (ret > 0)
 		aic31xx->pdata.gpio_reset = ret;
 }
-- 
2.15.0
