From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "IIO: ADC: add sigma delta modulator support" to the asoc tree
Date: Wed, 10 Jan 2018 11:13:14 +0000
Message-ID: <E1eZEJm-0004yz-Go@debutante>
References: <1512744566-13233-7-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512744566-13233-7-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   IIO: ADC: add sigma delta modulator support

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

>From 8a5f0b6f6c4f1a0ff98b5ca1f83cbe34cdebd96e Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Wed, 10 Jan 2018 11:13:08 +0100
Subject: [PATCH] IIO: ADC: add sigma delta modulator support

Add generic driver to support sigma delta modulators.
Typically, this device is hardware connected to
an IIO device in charge of the conversion. Devices are
bonded through the hardware consumer API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/iio/adc/Kconfig            | 12 +++++++
 drivers/iio/adc/Makefile           |  1 +
 drivers/iio/adc/sd_adc_modulator.c | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ef86296b8b0d..5f9d04a8ba53 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -629,6 +629,18 @@ config SPEAR_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called spear_adc.
 
+config SD_ADC_MODULATOR
+	tristate "Generic sigma delta modulator"
+	depends on OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Select this option to enables sigma delta modulator. This driver can
+	  support generic sigma delta modulators.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sd_adc_modulator.
+
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9572c1090f35..fa5e7949f642 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -82,3 +82,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
new file mode 100644
index 000000000000..560d8c7d9d86
--- /dev/null
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic sigma delta modulator driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+static const struct iio_info iio_sd_mod_iio_info;
+
+static const struct iio_chan_spec iio_sd_mod_ch = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 1,
+		.shift = 0,
+	},
+};
+
+static int iio_sd_mod_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *iio;
+
+	iio = devm_iio_device_alloc(dev, 0);
+	if (!iio)
+		return -ENOMEM;
+
+	iio->dev.parent = dev;
+	iio->dev.of_node = dev->of_node;
+	iio->name = dev_name(dev);
+	iio->info = &iio_sd_mod_iio_info;
+	iio->modes = INDIO_BUFFER_HARDWARE;
+
+	iio->num_channels = 1;
+	iio->channels = &iio_sd_mod_ch;
+
+	platform_set_drvdata(pdev, iio);
+
+	return devm_iio_device_register(&pdev->dev, iio);
+}
+
+static const struct of_device_id sd_adc_of_match[] = {
+	{ .compatible = "sd-modulator" },
+	{ .compatible = "ads1201" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sd_adc_of_match);
+
+static struct platform_driver iio_sd_mod_adc = {
+	.driver = {
+		.name = "iio_sd_adc_mod",
+		.of_match_table = of_match_ptr(sd_adc_of_match),
+	},
+	.probe = iio_sd_mod_probe,
+};
+
+module_platform_driver(iio_sd_mod_adc);
+
+MODULE_DESCRIPTION("Basic sigma delta modulator");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
