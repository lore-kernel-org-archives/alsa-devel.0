From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ak4104: move to GPIO consumer
	API" to the asoc tree
Date: Thu,  6 Dec 2018 20:25:55 +0000 (GMT)
Message-ID: <20181206202555.1F4E611252F7@debutante.sirena.org.uk>
References: <20181206122457.28269-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 944BB267CC4
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:25:55 +0100 (CET)
In-Reply-To: <20181206122457.28269-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ak4104: move to GPIO consumer API

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

>From d8f2c8592b95fd1fb06f0fea19738bf447bbc5f2 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Thu, 6 Dec 2018 13:24:57 +0100
Subject: [PATCH] ASoC: codecs: ak4104: move to GPIO consumer API

Get the reset GPIO through the GPIO consumer API. This allows specifying the
DT property as "reset-gpios" without breaking existing DT users.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4104.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 32bc545c19cf..6dec8a65eafc 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -268,8 +268,8 @@ static const struct regmap_config ak4104_regmap = {
 
 static int ak4104_spi_probe(struct spi_device *spi)
 {
-	struct device_node *np = spi->dev.of_node;
 	struct ak4104_private *ak4104;
+	struct gpio_desc *reset_gpiod;
 	unsigned int val;
 	int ret;
 
@@ -297,19 +297,11 @@ static int ak4104_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	if (np) {
-		enum of_gpio_flags flags;
-		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
-
-		if (gpio_is_valid(gpio)) {
-			ret = devm_gpio_request_one(&spi->dev, gpio,
-				     flags & OF_GPIO_ACTIVE_LOW ?
-					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				     "ak4104 reset");
-			if (ret < 0)
-				return ret;
-		}
-	}
+	reset_gpiod = devm_gpiod_get_optional(&spi->dev, "reset",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod) &&
+	    PTR_ERR(reset_gpiod) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	/* read the 'reserved' register - according to the datasheet, it
 	 * should contain 0x5b. Not a good way to verify the presence of
-- 
2.19.0.rc2
