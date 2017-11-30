From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Fix GPIO1 register
	definition" to the asoc tree
Date: Thu, 30 Nov 2017 12:32:41 +0000
Message-ID: <E1eKO1B-0000Qa-A0@debutante>
References: <20171129213300.20021-6-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A8F26698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:32:47 +0100 (CET)
In-Reply-To: <20171129213300.20021-6-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Fix GPIO1 register definition

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

>From 737e0b7b67bdfe24090fab2852044bb283282fc5 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:46 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Fix GPIO1 register definition

GPIO1 control register is number 51, fix this here.

Fixes: bafcbfe429eb ("ASoC: tlv320aic31xx: Make the register values human readable")
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/tlv320aic31xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 730fb2058869..1ff3edb7bbb6 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -116,7 +116,7 @@ struct aic31xx_pdata {
 /* INT2 interrupt control */
 #define AIC31XX_INT2CTRL	AIC31XX_REG(0, 49)
 /* GPIO1 control */
-#define AIC31XX_GPIO1		AIC31XX_REG(0, 50)
+#define AIC31XX_GPIO1		AIC31XX_REG(0, 51)
 
 #define AIC31XX_DACPRB		AIC31XX_REG(0, 60)
 /* ADC Instruction Set Register */
-- 
2.15.0
