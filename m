From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 03/11] IIO: ADC: add sigma delta modulator
	support
Date: Fri, 17 Mar 2017 15:08:16 +0100
Message-ID: <1489759704-30217-4-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C07EA266A0A
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 15:08:53 +0100 (CET)
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Add generic driver to support sigma delta modulators.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V2 -> V3 :
	-Rename to suppress "simple"
        - add "ads1201" compatibility
 
 drivers/iio/adc/Kconfig            | 11 +++++
 drivers/iio/adc/Makefile           |  1 +
 drivers/iio/adc/sd_adc_modulator.c | 98 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e0b3c09..d411d66 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -419,6 +419,17 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config SD_ADC_MODULATOR
+	tristate "Basic sigma delta modulator"
+	depends on OF
+        select IIO_BUFFER
+        select IIO_TRIGGERED_BUFFER
+	help
+	  Select this option to enables generic sigma delta modulator.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called simple-sd-adc.
+
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 8e02a94..c68819c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
new file mode 100644
index 0000000..4a25642
--- /dev/null
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -0,0 +1,98 @@
+/*
+ * Basic sigma delta modulator driver
+ *
+ * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
+ *
+ * License type: GPLv2
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/iio/triggered_buffer.h>
+
+static int iio_sd_mod_of_xlate(struct iio_dev *iio,
+			       const struct of_phandle_args *iiospec)
+{
+	dev_dbg(&iio->dev, "%s:\n", __func__);
+	if (iiospec->args[0] != 0) {
+		dev_err(&iio->dev, "Only one channel supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct iio_info iio_sd_mod_iio_info = {
+	.of_xlate = iio_sd_mod_of_xlate,
+};
+
+static const struct iio_chan_spec stm32_dfsdm_ch = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.scan_index = 0,
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
+	dev_dbg(&pdev->dev, "%s:\n", __func__);
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
+	iio->channels = &stm32_dfsdm_ch;
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
+MODULE_DEVICE_TABLE(of, adc081c_of_match);
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
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
