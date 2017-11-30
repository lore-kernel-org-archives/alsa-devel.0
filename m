From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Use standard reset GPIO OF
	name" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:07 +0000
Message-ID: <E1eKO1b-0000Zw-TA@debutante>
References: <20171129171359.29382-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FFD92679E6
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:14 +0100 (CET)
In-Reply-To: <20171129171359.29382-5-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Use standard reset GPIO OF name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 025f8449818c46770f5652a0263f8cfb89d01455 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 11:13:55 -0600
Subject: [PATCH] ASoC: tlv320aic3x: Use standard reset GPIO OF name

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
