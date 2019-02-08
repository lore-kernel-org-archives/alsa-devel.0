From: Mark Brown <broonie@kernel.org>
Subject: Applied "gpiolib: acpi: Introduce
	ACPI_GPIO_QUIRK_ONLY_GPIOIO" to the asoc tree
Date: Fri,  8 Feb 2019 17:34:55 +0000 (GMT)
Message-ID: <20190208173455.90E3A1127F2F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C61267437
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 18:34:56 +0100 (CET)
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
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO

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

>From 4d1f7a6eabd45639d9de22a8a004f3c208d13c1a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 6 Feb 2019 22:49:46 +0200
Subject: [PATCH] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO

New quirk enforces search for GPIO based on its type,
i.e. iterate over GpioIo resources only.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c           | 15 ++++--
 include/linux/acpi.h                  |  7 +++
 sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
 3 files changed, 27 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 259cf6ab969b..4d291b75cb9f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -530,17 +530,24 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
 
-	if (lookup->n++ == lookup->index && !lookup->desc) {
+	if (!lookup->desc) {
 		const struct acpi_resource_gpio *agpio = &ares->data.gpio;
-		int pin_index = lookup->pin_index;
+		bool gpioint = agpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT;
+		int pin_index;
 
+		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
+			lookup->index++;
+
+		if (lookup->n++ != lookup->index)
+			return 1;
+
+		pin_index = lookup->pin_index;
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
 		lookup->desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
 					      agpio->pin_table[pin_index]);
-		lookup->info.gpioint =
-			agpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT;
+		lookup->info.gpioint = gpioint;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..03b4c4f225d0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1014,6 +1014,13 @@ struct acpi_gpio_mapping {
 
 /* Ignore IoRestriction field */
 #define ACPI_GPIO_QUIRK_NO_IO_RESTRICTION	BIT(0)
+/*
+ * When ACPI GPIO mapping table is in use the index parameter inside it
+ * refers to the GPIO resource in _CRS method. That index has no
+ * distinction of actual type of the resource. When consumer wants to
+ * get GpioIo type explicitly, this quirk may be used.
+ */
+#define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
 
 	unsigned int quirks;
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c3b7732929cc..b0a4d297176e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -844,74 +844,18 @@ static const struct x86_cpu_id cherrytrail_cpu_ids[] = {
 	{}
 };
 
-static const struct acpi_gpio_params first_gpio = { 0, 0, false };
-static const struct acpi_gpio_params second_gpio = { 1, 0, false };
+static const struct acpi_gpio_params ext_amp_enable_gpios = { 0, 0, false };
 
-static const struct acpi_gpio_mapping byt_rt5651_amp_en_first[] = {
-	{ "ext-amp-enable-gpios", &first_gpio, 1 },
-	{ },
-};
-
-static const struct acpi_gpio_mapping byt_rt5651_amp_en_second[] = {
-	{ "ext-amp-enable-gpios", &second_gpio, 1 },
+static const struct acpi_gpio_mapping cht_rt5651_gpios[] = {
+	/*
+	 * Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources,
+	 * other boards may  have I2cSerialBusV2, GpioInt, GpioIo instead.
+	 * We want the GpioIo one for the ext-amp-enable-gpio.
+	 */
+	{ "ext-amp-enable-gpios", &ext_amp_enable_gpios, 1, ACPI_GPIO_QUIRK_ONLY_GPIOIO },
 	{ },
 };
 
-/*
- * Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources, other
- * boards may  have I2cSerialBusV2, GpioInt, GpioIo instead. We want the
- * GpioIo one for the ext-amp-enable-gpio and both count for the index in
- * acpi_gpio_params index.  So we have 2 different mappings and the code
- * below figures out which one to use.
- */
-struct byt_rt5651_acpi_resource_data {
-	int gpio_count;
-	int gpio_int_idx;
-};
-
-static int snd_byt_rt5651_acpi_resource(struct acpi_resource *ares, void *arg)
-{
-	struct byt_rt5651_acpi_resource_data *data = arg;
-
-	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
-		return 0;
-
-	if (ares->data.gpio.connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
-		data->gpio_int_idx = data->gpio_count;
-
-	data->gpio_count++;
-	return 0;
-}
-
-static void snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(struct device *codec)
-{
-	struct byt_rt5651_acpi_resource_data data = { 0, -1 };
-	LIST_HEAD(resources);
-	int ret;
-
-	ret = acpi_dev_get_resources(ACPI_COMPANION(codec), &resources,
-				     snd_byt_rt5651_acpi_resource, &data);
-	if (ret < 0) {
-		dev_warn(codec, "Failed to get ACPI resources, not adding external amplifier GPIO mapping\n");
-		return;
-	}
-
-	/* All info we need is gathered during the walk */
-	acpi_dev_free_resource_list(&resources);
-
-	switch (data.gpio_int_idx) {
-	case 0:
-		byt_rt5651_gpios = byt_rt5651_amp_en_second;
-		break;
-	case 1:
-		byt_rt5651_gpios = byt_rt5651_amp_en_first;
-		break;
-	default:
-		dev_warn(codec, "Unknown GpioInt index %d, not adding external amplifier GPIO mapping\n",
-			 data.gpio_int_idx);
-	}
-}
-
 struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
 	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
@@ -1038,7 +982,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (x86_match_cpu(cherrytrail_cpu_ids) && !byt_rt5651_gpios)
-		snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(codec_dev);
+		byt_rt5651_gpios = cht_rt5651_gpios;
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-- 
2.20.1
