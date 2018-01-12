From: Mark Brown <broonie@kernel.org>
Subject: Applied "gpio: merrifield: Add support of ACPI enabled
	platforms" to the asoc tree
Date: Fri, 12 Jan 2018 20:01:22 +0000
Message-ID: <E1ea5Vy-0008R8-Hz@debutante>
References: <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 697C1266F23
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 21:01:34 +0100 (CET)
In-Reply-To: <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   gpio: merrifield: Add support of ACPI enabled platforms

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

>From dd1dbf94d2826a045fbbe2649d84b27d48620d56 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 5 Jan 2018 18:09:34 +0200
Subject: [PATCH] gpio: merrifield: Add support of ACPI enabled platforms

The driver needs the pin control device name for ACPI.

We are looking through ACPI namespace and return first found device
based on ACPI HID for Intel Merrifield FLIS (pin control device).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpio/gpio-merrifield.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index dd67a31ac337..c38624ea0251 100644
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
 
+static const char *mrfld_gpio_get_pinctrl_dev_name(void)
+{
+	const char *dev_name = acpi_dev_get_first_match_name("INTC1002", NULL, -1);
+	return dev_name ? dev_name : "pinctrl-merrifield";
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
 
+	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name();
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
