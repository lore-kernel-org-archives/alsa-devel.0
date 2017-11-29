From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 3/8] ASoC: tlv320aic31xx: Fix the reset GPIO
	OF name
Date: Wed, 29 Nov 2017 11:13:54 -0600
Message-ID: <20171129171359.29382-4-afd@ti.com>
References: <20171129171359.29382-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 0922B267426
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 18:14:01 +0100 (CET)
In-Reply-To: <20171129171359.29382-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e2862372c26e..4837f25b0760 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1279,9 +1279,16 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 		aic31xx->pdata.micbias_vg = MICBIAS_2_0V;
 	}
 
-	ret = of_get_named_gpio(np, "gpio-reset", 0);
-	if (ret > 0)
+	ret = of_get_named_gpio(np, "reset-gpios", 0);
+	if (ret > 0) {
 		aic31xx->pdata.gpio_reset = ret;
+	} else {
+		ret = of_get_named_gpio(np, "gpio-reset", 0);
+		if (ret > 0) {
+			dev_warn(aic31xx->dev, "Using deprecated property \"gpio-reset\", please update your DT");
+			aic31xx->pdata.gpio_reset = ret;
+		}
+	}
 }
 #else /* CONFIG_OF */
 static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
-- 
2.15.0
