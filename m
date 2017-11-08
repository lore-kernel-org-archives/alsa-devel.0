From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 9/9] ASoC: tlv320aic3x: Fix the reset GPIO OF name
Date: Wed, 8 Nov 2017 15:25:05 -0600
Message-ID: <20171108212505.28320-10-afd@ti.com>
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

Fixes: c24fdc886fde ("ASoC: tlv320aic3x: Add device tree bindings")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 06f92571eba4..6a8b450d2431 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1804,7 +1804,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		if (!ai3x_setup)
 			return -ENOMEM;
 
-		ret = of_get_named_gpio(np, "gpio-reset", 0);
+		ret = of_get_named_gpio(np, "reset-gpio", 0);
 		if (ret >= 0)
 			aic3x->gpio_reset = ret;
 		else
-- 
2.15.0
