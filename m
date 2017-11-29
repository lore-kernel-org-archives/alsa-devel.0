From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 05/19] ASoC: tlv320aic31xx: Fix GPIO1
	register definition
Date: Wed, 29 Nov 2017 15:32:46 -0600
Message-ID: <20171129213300.20021-6-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 3290726796D
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:03 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

GPIO1 control register is number 51, fix this here.

Fixes: bafcbfe429eb ("ASoC: tlv320aic31xx: Make the register values human readable")
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index a9ea2f99eba0..6efea0485392 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -109,7 +109,7 @@ struct aic31xx_pdata {
 /* INT2 interrupt control */
 #define AIC31XX_INT2CTRL	AIC31XX_REG(0, 49)
 /* GPIO1 control */
-#define AIC31XX_GPIO1		AIC31XX_REG(0, 50)
+#define AIC31XX_GPIO1		AIC31XX_REG(0, 51)
 
 #define AIC31XX_DACPRB		AIC31XX_REG(0, 60)
 /* ADC Instruction Set Register */
-- 
2.15.0
