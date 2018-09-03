From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Add short circuit
	detection support" to the asoc tree
Date: Mon,  3 Sep 2018 14:46:59 +0100 (BST)
Message-ID: <20180903134659.5F72D11227AE@debutante.sirena.org.uk>
References: <20180831182434.14499-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 726C22678DD
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:47:00 +0200 (CEST)
In-Reply-To: <20180831182434.14499-1-afd@ti.com>
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

   ASoC: tlv320aic31xx: Add short circuit detection support

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

>From 80863ee222d37b1797cea74d2257ad6d68444d30 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Fri, 31 Aug 2018 13:24:31 -0500
Subject: [PATCH] ASoC: tlv320aic31xx: Add short circuit detection support

These devices support detecting and reporting short circuits across
the output stages. Add support for reporting these issue. Do this
by registering an interrupt if available and enabling this error
to trigger that interrupt in the device.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h | 16 ++++++++++
 2 files changed, 71 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index bf92d36b8f8a..2abe51d9f879 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -167,6 +167,7 @@ struct aic31xx_priv {
 	u8 p_div;
 	int rate_div_line;
 	bool master_dapm_route_applied;
+	int irq;
 };
 
 struct aic31xx_rate_divs {
@@ -1391,6 +1392,40 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
+static irqreturn_t aic31xx_irq(int irq, void *data)
+{
+	struct aic31xx_priv *aic31xx = data;
+	struct device *dev = aic31xx->dev;
+	unsigned int value;
+	bool handled = false;
+	int ret;
+
+	ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read interrupt mask: %d\n", ret);
+		goto exit;
+	}
+
+	if (value)
+		handled = true;
+	else
+		goto exit;
+
+	if (value & AIC31XX_HPLSCDETECT)
+		dev_err(dev, "Short circuit on Left output is detected\n");
+	if (value & AIC31XX_HPRSCDETECT)
+		dev_err(dev, "Short circuit on Right output is detected\n");
+	if (value & ~(AIC31XX_HPLSCDETECT |
+		      AIC31XX_HPRSCDETECT))
+		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
+
+exit:
+	if (handled)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -1413,6 +1448,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	aic31xx->dev = &i2c->dev;
+	aic31xx->irq = i2c->irq;
 
 	aic31xx->codec_type = id->driver_data;
 
@@ -1456,6 +1492,25 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (aic31xx->irq > 0) {
+		regmap_update_bits(aic31xx->regmap, AIC31XX_GPIO1,
+				   AIC31XX_GPIO1_FUNC_MASK,
+				   AIC31XX_GPIO1_INT1 <<
+				   AIC31XX_GPIO1_FUNC_SHIFT);
+
+		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_SC);
+
+		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
+						NULL, aic31xx_irq,
+						IRQF_ONESHOT, "aic31xx-irq",
+						aic31xx);
+		if (ret) {
+			dev_err(aic31xx->dev, "Unable to request IRQ\n");
+			return ret;
+		}
+	}
+
 	if (aic31xx->codec_type & DAC31XX_BIT)
 		return devm_snd_soc_register_component(&i2c->dev,
 				&soc_codec_driver_aic31xx,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 0b587585b38b..52e171988906 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -191,6 +191,22 @@ struct aic31xx_pdata {
 #define AIC31XX_SC			BIT(3)
 #define AIC31XX_ENGINE			BIT(2)
 
+/* AIC31XX_GPIO1 */
+#define AIC31XX_GPIO1_FUNC_MASK		GENMASK(5, 2)
+#define AIC31XX_GPIO1_FUNC_SHIFT	2
+#define AIC31XX_GPIO1_DISABLED		0x00
+#define AIC31XX_GPIO1_INPUT		0x01
+#define AIC31XX_GPIO1_GPI		0x02
+#define AIC31XX_GPIO1_GPO		0x03
+#define AIC31XX_GPIO1_CLKOUT		0x04
+#define AIC31XX_GPIO1_INT1		0x05
+#define AIC31XX_GPIO1_INT2		0x06
+#define AIC31XX_GPIO1_ADC_WCLK		0x07
+#define AIC31XX_GPIO1_SBCLK		0x08
+#define AIC31XX_GPIO1_SWCLK		0x09
+#define AIC31XX_GPIO1_ADC_MOD_CLK	0x10
+#define AIC31XX_GPIO1_SDOUT		0x11
+
 /* AIC31XX_DACSETUP */
 #define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
 
-- 
2.19.0.rc1
