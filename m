From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 4/8] ASoC: tlv320aic3x: Fix the reset GPIO
	OF name
Date: Wed, 29 Nov 2017 11:13:55 -0600
Message-ID: <20171129171359.29382-5-afd@ti.com>
References: <20171129171359.29382-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F813267463
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

Fixes: c24fdc886fde ("ASoC: tlv320aic3x: Add device tree bindings")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 06f92571eba4..b751cad545da 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1804,11 +1804,18 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		if (!ai3x_setup)
 			return -ENOMEM;
 
-		ret = of_get_named_gpio(np, "gpio-reset", 0);
-		if (ret >= 0)
+		ret = of_get_named_gpio(np, "reset-gpios", 0);
+		if (ret >= 0) {
 			aic3x->gpio_reset = ret;
-		else
-			aic3x->gpio_reset = -1;
+		} else {
+			ret = of_get_named_gpio(np, "gpio-reset", 0);
+			if (ret > 0) {
+				dev_warn(&i2c->dev, "Using deprecated property \"gpio-reset\", please update your DT");
+				aic3x->gpio_reset = ret;
+			} else {
+				aic3x->gpio_reset = -1;
+			}
+		}
 
 		if (of_property_read_u32_array(np, "ai3x-gpio-func",
 					ai3x_setup->gpio_func, 2) >= 0) {
-- 
2.15.0
