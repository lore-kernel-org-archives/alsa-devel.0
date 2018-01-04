From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] gpio: merrifield: Add support of ACPI enabled platforms
Date: Thu,  4 Jan 2018 18:47:09 +0200
Message-ID: <20180104164709.64387-4-andriy.shevchenko@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The driver needs the pin control device name for ACPI.

We are looking through ACPI namespace and return first found device
based on ACPI HID for Intel Merrifield FLIS.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-merrifield.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index dd67a31ac337..68320d57d5f0 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
@@ -380,9 +381,16 @@ static void mrfld_irq_init_hw(struct mrfld_gpio *priv)
 	}
 }
 
+static const char *mrfld_gpio_get_pinctrl_dev_name(const char *fallback)
+{
+	const char *dev_name = acpi_dev_get_dev_name("INTC1002", NULL, -1);
+	return dev_name ? dev_name : fallback;
+}
+
 static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	const struct mrfld_gpio_pinrange *range;
+	const char *pinctrl_dev_name;
 	struct mrfld_gpio *priv;
 	u32 gpio_base, irq_base;
 	void __iomem *base;
@@ -439,10 +447,11 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		return retval;
 	}
 
+	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name("pinctrl-merrifield");
 	for (i = 0; i < ARRAY_SIZE(mrfld_gpio_ranges); i++) {
 		range = &mrfld_gpio_ranges[i];
 		retval = gpiochip_add_pin_range(&priv->chip,
-						"pinctrl-merrifield",
+						pinctrl_dev_name,
 						range->gpio_base,
 						range->pin_base,
 						range->npins);
-- 
2.15.1

