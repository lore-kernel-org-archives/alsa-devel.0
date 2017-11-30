From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Use standard reset GPIO
	OF name" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:14 +0000
Message-ID: <E1eKO1i-0000cz-GY@debutante>
References: <20171129171359.29382-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 839F32679D3
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:20 +0100 (CET)
In-Reply-To: <20171129171359.29382-4-afd@ti.com>
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

   ASoC: tlv320aic31xx: Use standard reset GPIO OF name

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

>From a825f31f93281bbe7126b25801deb476d07aaf82 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 11:13:54 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Use standard reset GPIO OF name

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

[Retitled for accuracy -- broonie]

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
