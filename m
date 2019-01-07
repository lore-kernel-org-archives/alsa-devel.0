From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Add support for GPIO
	mode of the pins" to the asoc tree
Date: Mon,  7 Jan 2019 12:25:51 +0000 (GMT)
Message-ID: <20190107122551.424D31127490@debutante.sirena.org.uk>
References: <20190103140552.29809-4-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42DFE267B50
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:25:52 +0100 (CET)
In-Reply-To: <20190103140552.29809-4-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins

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

>From 540f1ba7b3a5596827a3bfeaae9c5e754347c933 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 16:05:52 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Add support for GPIO mode of the
 pins

All McASP pin can be configured as GPIO.
Add gpiochip support for McASP and only enable it when the
gpio-controller is present in the DT node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 159 ++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a6a470a76900..a3a67a8f0f54 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/math64.h>
 #include <linux/bitmap.h>
+#include <linux/gpio/driver.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -54,6 +55,7 @@ static u32 context_regs[] = {
 	DAVINCI_MCASP_AHCLKXCTL_REG,
 	DAVINCI_MCASP_AHCLKRCTL_REG,
 	DAVINCI_MCASP_PDIR_REG,
+	DAVINCI_MCASP_PFUNC_REG,
 	DAVINCI_MCASP_RXMASK_REG,
 	DAVINCI_MCASP_TXMASK_REG,
 	DAVINCI_MCASP_RXTDM_REG,
@@ -108,6 +110,10 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
+
 #ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
@@ -818,9 +824,6 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	if (mcasp->version < MCASP_VERSION_3)
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
-	/* All PINS as McASP */
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
-
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
@@ -1845,6 +1848,147 @@ static u32 davinci_mcasp_rxdma_offset(struct davinci_mcasp_pdata *pdata)
 	return offset;
 }
 
+#ifdef CONFIG_GPIOLIB
+static int davinci_mcasp_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (mcasp->num_serializer && offset < mcasp->num_serializer &&
+	    mcasp->serial_dir[offset] != INACTIVE_MODE) {
+		dev_err(mcasp->dev, "AXR%u pin is  used for audio\n", offset);
+		return -EBUSY;
+	}
+
+	/* Do not change the PIN yet */
+
+	return pm_runtime_get_sync(mcasp->dev);
+}
+
+static void davinci_mcasp_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	/* Set the direction to input */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+	/* Set the pin as McASP pin */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+	pm_runtime_put_sync(mcasp->dev);
+}
+
+static int davinci_mcasp_gpio_direction_out(struct gpio_chip *chip,
+					    unsigned offset, int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+		/* Set the direction to output */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static void davinci_mcasp_gpio_set(struct gpio_chip *chip, unsigned offset,
+				  int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+}
+
+static int davinci_mcasp_gpio_direction_in(struct gpio_chip *chip,
+					   unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the direction to input */
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDSET_REG);
+	if (val & BIT(offset))
+		return 1;
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get_direction(struct gpio_chip *chip,
+					    unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+	if (val & BIT(offset))
+		return 0;
+
+	return 1;
+}
+
+static const struct gpio_chip davinci_mcasp_template_chip = {
+	.owner			= THIS_MODULE,
+	.request		= davinci_mcasp_gpio_request,
+	.free			= davinci_mcasp_gpio_free,
+	.direction_output	= davinci_mcasp_gpio_direction_out,
+	.set			= davinci_mcasp_gpio_set,
+	.direction_input	= davinci_mcasp_gpio_direction_in,
+	.get			= davinci_mcasp_gpio_get,
+	.get_direction		= davinci_mcasp_gpio_get_direction,
+	.base			= -1,
+	.ngpio			= 32,
+};
+
+static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	if (!of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
+		return 0;
+
+	mcasp->gpio_chip = davinci_mcasp_template_chip;
+	mcasp->gpio_chip.label = dev_name(mcasp->dev);
+	mcasp->gpio_chip.parent = mcasp->dev;
+#ifdef CONFIG_OF_GPIO
+	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
+#endif
+
+	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
+}
+
+#else /* CONFIG_GPIOLIB */
+static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	return 0;
+}
+#endif /* CONFIG_GPIOLIB */
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2069,6 +2213,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
+	/* All PINS as McASP */
+	pm_runtime_get_sync(mcasp->dev);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	pm_runtime_put(mcasp->dev);
+
+	ret = davinci_mcasp_init_gpiochip(mcasp);
+	if (ret)
+		goto err;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
2.20.1
