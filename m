From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: byt-max98090: Add GPIO ACPI
	mapping table" to the asoc tree
Date: Tue, 13 Jun 2017 22:08:00 +0100
Message-ID: <E1dKt2e-0000MZ-0A@debutante>
References: <20170610163741.49214-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDD4267045
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:07 +0200 (CEST)
In-Reply-To: <20170610163741.49214-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Porcel <nicolasporcel06@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: byt-max98090: Add GPIO ACPI mapping table

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7c197881e163f34679b941c75500a6c85560b7c9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 10 Jun 2017 19:37:41 +0300
Subject: [PATCH] ASoC: Intel: byt-max98090: Add GPIO ACPI mapping table

In order to make GPIO ACPI library stricter prepare users of
gpiod_get_index() to correctly behave when there no mapping is
provided by firmware.

Here we add explicit mapping between _CRS GpioIo() resources and
their names used in the driver.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Nicolas Porcel <nicolasporcel06@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/byt-max98090.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index d9f81b8d915d..047be7fa0ce9 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -67,20 +67,27 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 
 static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 	{
-		.name		= "hp-gpio",
-		.idx		= 0,
+		.name		= "hp",
 		.report		= SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
 		.debounce_time	= 200,
 	},
 	{
-		.name		= "mic-gpio",
-		.idx		= 1,
+		.name		= "mic",
 		.invert		= 1,
 		.report		= SND_JACK_MICROPHONE,
 		.debounce_time	= 200,
 	},
 };
 
+static const struct acpi_gpio_params hp_gpios = { 0, 0, false };
+static const struct acpi_gpio_params mic_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_byt_max98090_gpios[] = {
+	{ "hp-gpios", &hp_gpios, 1 },
+	{ "mic-gpios", &mic_gpios, 1 },
+	{},
+};
+
 static int byt_max98090_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
@@ -140,8 +147,9 @@ static struct snd_soc_card byt_max98090_card = {
 
 static int byt_max98090_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
+	struct device *dev = &pdev->dev;
 	struct byt_max98090_private *priv;
+	int ret_val;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
@@ -149,6 +157,10 @@ static int byt_max98090_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ret_val = devm_acpi_dev_add_driver_gpios(dev->parent, acpi_byt_max98090_gpios);
+	if (ret_val)
+		dev_dbg(dev, "Unable to add GPIO mapping table\n");
+
 	byt_max98090_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&byt_max98090_card, priv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_max98090_card);
@@ -158,7 +170,7 @@ static int byt_max98090_probe(struct platform_device *pdev)
 		return ret_val;
 	}
 
-	return ret_val;
+	return 0;
 }
 
 static int byt_max98090_remove(struct platform_device *pdev)
-- 
2.11.0
