From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 03/17] ASoC: tlv320aic31xx: Fix GPIO1 register
	definition
Date: Wed, 8 Nov 2017 18:27:27 -0600
Message-ID: <20171109002741.10897-4-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 9857A2675BB
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 01:27:44 +0100 (CET)
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
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
index db95eeae966b..4f126cd82add 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -82,7 +82,7 @@ struct aic31xx_pdata {
 #define AIC31XX_INTRADCFLAG2	AIC31XX_REG(0, 47) /* ADC Interrupt flags 2 */
 #define AIC31XX_INT1CTRL	AIC31XX_REG(0, 48) /* INT1 interrupt control */
 #define AIC31XX_INT2CTRL	AIC31XX_REG(0, 49) /* INT2 interrupt control */
-#define AIC31XX_GPIO1		AIC31XX_REG(0, 50) /* GPIO1 control */
+#define AIC31XX_GPIO1		AIC31XX_REG(0, 51) /* GPIO1 control */
 #define AIC31XX_DACPRB		AIC31XX_REG(0, 60)
 #define AIC31XX_ADCPRB		AIC31XX_REG(0, 61) /* ADC Instruction Set Register */
 #define AIC31XX_DACSETUP	AIC31XX_REG(0, 63) /* DAC channel setup register */
-- 
2.15.0
