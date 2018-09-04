From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Add overflow detection
	support" to the asoc tree
Date: Tue,  4 Sep 2018 17:22:30 +0100 (BST)
Message-ID: <20180904162230.7F50E11227D8@debutante.sirena.org.uk>
References: <20180904153619.2199-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3FF72676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 18:22:30 +0200 (CEST)
In-Reply-To: <20180904153619.2199-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Add overflow detection support

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

>From 18d545bb2599d6e5b0747351eaeebb0160d261f9 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 4 Sep 2018 10:36:17 -0500
Subject: [PATCH] ASoC: tlv320aic31xx: Add overflow detection support

Similar to short circuit detection, when the ADC/DAC is saturated and
overflows poor audio quality can result and should be reported to the
user. This device support Automatic Dynamic Range Compression (DRC)
to reduce this but it is not enabled currently in this driver.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 34 ++++++++++++++++++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  7 +++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 2abe51d9f879..608ad49ad978 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1409,7 +1409,7 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	if (value)
 		handled = true;
 	else
-		goto exit;
+		goto read_overflow;
 
 	if (value & AIC31XX_HPLSCDETECT)
 		dev_err(dev, "Short circuit on Left output is detected\n");
@@ -1419,6 +1419,35 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		      AIC31XX_HPRSCDETECT))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
+read_overflow:
+	ret = regmap_read(aic31xx->regmap, AIC31XX_OFFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read overflow flag: %d\n", ret);
+		goto exit;
+	}
+
+	if (value)
+		handled = true;
+	else
+		goto exit;
+
+	if (value & AIC31XX_DAC_OF_LEFT)
+		dev_warn(dev, "Left-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_RIGHT)
+		dev_warn(dev, "Right-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_SHIFTER)
+		dev_warn(dev, "DAC barrel shifter overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF)
+		dev_warn(dev, "ADC overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF_SHIFTER)
+		dev_warn(dev, "ADC barrel shifter overflow has occurred\n");
+	if (value & ~(AIC31XX_DAC_OF_LEFT |
+		      AIC31XX_DAC_OF_RIGHT |
+		      AIC31XX_DAC_OF_SHIFTER |
+		      AIC31XX_ADC_OF |
+		      AIC31XX_ADC_OF_SHIFTER))
+		dev_warn(dev, "Unknown overflow interrupt flags: 0x%08x\n", value);
+
 exit:
 	if (handled)
 		return IRQ_HANDLED;
@@ -1499,7 +1528,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
-			     AIC31XX_SC);
+			     AIC31XX_SC |
+			     AIC31XX_ENGINE);
 
 		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
 						NULL, aic31xx_irq,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 52e171988906..2636f2c6bc79 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -173,6 +173,13 @@ struct aic31xx_pdata {
 #define AIC31XX_HPRDRVPWRSTATUS_MASK	BIT(1)
 #define AIC31XX_SPRDRVPWRSTATUS_MASK	BIT(0)
 
+/* AIC31XX_OFFLAG */
+#define AIC31XX_DAC_OF_LEFT		BIT(7)
+#define AIC31XX_DAC_OF_RIGHT		BIT(6)
+#define AIC31XX_DAC_OF_SHIFTER		BIT(5)
+#define AIC31XX_ADC_OF			BIT(3)
+#define AIC31XX_ADC_OF_SHIFTER		BIT(1)
+
 /* AIC31XX_INTRDACFLAG */
 #define AIC31XX_HPLSCDETECT		BIT(7)
 #define AIC31XX_HPRSCDETECT		BIT(6)
-- 
2.19.0.rc1
