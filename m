From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 03/10] gpio: merrifield: Convert to use
	acpi_dev_get_first_match_dev()
Date: Thu, 28 Mar 2019 19:17:22 +0200
Message-ID: <20190328171729.44002-4-andriy.shevchenko@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04FD3F80C16
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:37 +0100 (CET)
In-Reply-To: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

acpi_dev_get_first_match_name() is deprecated and going to be removed
because it leaks a reference.

Convert the driver to use acpi_dev_get_first_match_dev() instead.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpio-merrifield.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 7c659fdaa6d5..2383dc78b123 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -377,10 +377,20 @@ static void mrfld_irq_init_hw(struct mrfld_gpio *priv)
 	}
 }
 
-static const char *mrfld_gpio_get_pinctrl_dev_name(void)
+static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
 {
-	const char *dev_name = acpi_dev_get_first_match_name("INTC1002", NULL, -1);
-	return dev_name ? dev_name : "pinctrl-merrifield";
+	struct acpi_device *adev;
+	const char *name;
+
+	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
+	if (adev) {
+		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
+		put_device(&adev->dev);
+	} else {
+		name = "pinctrl-merrifield";
+	}
+
+	return name;
 }
 
 static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -441,7 +451,7 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		return retval;
 	}
 
-	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name();
+	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name(priv);
 	for (i = 0; i < ARRAY_SIZE(mrfld_gpio_ranges); i++) {
 		range = &mrfld_gpio_ranges[i];
 		retval = gpiochip_add_pin_range(&priv->chip,
-- 
2.20.1
