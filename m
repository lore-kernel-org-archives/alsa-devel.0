From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/6] ASoC: Intel: bytcr_rt5651: Fix using the
	wrong GPIO for the ext-amp on some boards
Date: Wed, 18 Jul 2018 22:55:38 +0200
Message-ID: <20180718205542.12364-3-hdegoede@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 58FD7267822
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:49 +0200 (CEST)
In-Reply-To: <20180718205542.12364-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources, other
boards may  have I2cSerialBusV2, GpioInt, GpioIo instead. We want the
GpioIo one for the ext-amp-enable-gpio.

So far we've been assuming that the GpioIo one always comes first, this
commit adds code to detect which one comes first and to add the right
gpio-mapping.

This fixes sound not working on the Vios LTH17 laptop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 69 +++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b687043c8425..601e47c33ba8 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -747,13 +747,74 @@ static const struct x86_cpu_id cherrytrail_cpu_ids[] = {
 	{}
 };
 
-static const struct acpi_gpio_params ext_amp_enable_gpios = { 0, 0, false };
+static const struct acpi_gpio_params first_gpio = { 0, 0, false };
+static const struct acpi_gpio_params second_gpio = { 1, 0, false };
 
-static const struct acpi_gpio_mapping byt_rt5651_gpios[] = {
-	{ "ext-amp-enable-gpios", &ext_amp_enable_gpios, 1 },
+static const struct acpi_gpio_mapping byt_rt5651_amp_en_first[] = {
+	{ "ext-amp-enable-gpios", &first_gpio, 1 },
 	{ },
 };
 
+static const struct acpi_gpio_mapping byt_rt5651_amp_en_second[] = {
+	{ "ext-amp-enable-gpios", &second_gpio, 1 },
+	{ },
+};
+
+/*
+ * Some boards have I2cSerialBusV2, GpioIo, GpioInt as ACPI resources, other
+ * boards may  have I2cSerialBusV2, GpioInt, GpioIo instead. We want the
+ * GpioIo one for the ext-amp-enable-gpio and both count for the index in
+ * acpi_gpio_params index.  So we have 2 different mappings and the code
+ * below figures out which one to use.
+ */
+struct byt_rt5651_acpi_resource_data {
+	int gpio_count;
+	int gpio_int_idx;
+};
+
+static int snd_byt_rt5651_acpi_resource(struct acpi_resource *ares, void *arg)
+{
+	struct byt_rt5651_acpi_resource_data *data = arg;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
+		return 0;
+
+	if (ares->data.gpio.connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
+		data->gpio_int_idx = data->gpio_count;
+
+	data->gpio_count++;
+	return 0;
+}
+
+static void snd_byt_rt5651_mc_add_amp_en_gpio_mapping(struct device *codec)
+{
+	struct byt_rt5651_acpi_resource_data data = { 0, -1 };
+	LIST_HEAD(resources);
+	int ret;
+
+	ret = acpi_dev_get_resources(ACPI_COMPANION(codec), &resources,
+				     snd_byt_rt5651_acpi_resource, &data);
+	if (ret < 0) {
+		dev_warn(codec, "Failed to get ACPI resources, not adding external amplifier GPIO mapping\n");
+		return;
+	}
+
+	/* All info we need is gathered during the walk */
+	acpi_dev_free_resource_list(&resources);
+
+	switch (data.gpio_int_idx) {
+	case 0:
+		devm_acpi_dev_add_driver_gpios(codec, byt_rt5651_amp_en_second);
+		break;
+	case 1:
+		devm_acpi_dev_add_driver_gpios(codec, byt_rt5651_amp_en_first);
+		break;
+	default:
+		dev_warn(codec, "Unknown GpioInt index %d, not adding external amplifier GPIO mapping\n",
+			 data.gpio_int_idx);
+	}
+}
+
 struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
 	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
@@ -876,7 +937,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (x86_match_cpu(cherrytrail_cpu_ids)) {
-		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
+		snd_byt_rt5651_mc_add_amp_en_gpio_mapping(codec_dev);
 		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
 						&pdev->dev, "ext-amp-enable", 0,
 						codec_dev->fwnode,
-- 
2.17.1
