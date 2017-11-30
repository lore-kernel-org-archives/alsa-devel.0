From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 08/13] regmap: add SLIMbus support
Date: Thu, 30 Nov 2017 17:41:55 +0000
Message-ID: <20171130174200.6684-9-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to read/write SLIMbus value elements.
Currently it only supports byte read/write. Adding this support in
regmap would give codec drivers more flexibility when there are more
than 2 control interfaces like SLIMbus, i2c.

Without this patch each codec driver has to directly call SLIMbus value
element apis, and this could would get messy once we want to add i2c
interface to it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/Kconfig          |  4 ++
 drivers/base/regmap/Makefile         |  1 +
 drivers/base/regmap/regmap-slimbus.c | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h               | 18 ++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-slimbus.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 3a1535d812d8..cc162b48c6d7 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -21,6 +21,10 @@ config REGMAP_I2C
 	tristate
 	depends on I2C
 
+config REGMAP_SLIMBUS
+	tristate
+	depends on SLIMBUS
+
 config REGMAP_SPI
 	tristate
 	depends on SPI
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 0d298c446108..63dec9222892 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_REGCACHE_COMPRESSED) += regcache-lzo.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
+obj-$(CONFIG_REGMAP_SLIMBUS) += regmap-slimbus.o
 obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
new file mode 100644
index 000000000000..d0dab1c5b663
--- /dev/null
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -0,0 +1,89 @@
+/*
+ * Register map access API - SLIMbus support
+ *
+ * Copyright 2017 Linaro Inc
+ *
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/regmap.h>
+#include <linux/slimbus.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
+					unsigned int *val)
+{
+	struct slim_device *sdev = context;
+	int v;
+
+	v = slim_readb(sdev, reg);
+
+	if (v < 0)
+		return v;
+
+	*val = v;
+
+	return 0;
+}
+
+static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
+					 unsigned int val)
+{
+	struct slim_device *sdev = context;
+
+	return slim_writeb(sdev, reg, val);
+}
+
+static struct regmap_bus regmap_slimbus_bus = {
+	.reg_write = regmap_slimbus_byte_reg_write,
+	.reg_read = regmap_slimbus_byte_reg_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static const struct regmap_bus *regmap_get_slimbus(struct slim_device *slim,
+					const struct regmap_config *config)
+{
+	if (config->val_bits == 8 && config->reg_bits == 8)
+		return &regmap_slimbus_bus;
+
+	return ERR_PTR(-ENOTSUPP);
+}
+
+struct regmap *__regmap_init_slimbus(struct slim_device *slimbus,
+				     const struct regmap_config *config,
+				     struct lock_class_key *lock_key,
+				     const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_slimbus(slimbus, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&slimbus->dev, bus, &slimbus->dev, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_slimbus);
+
+struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
+					  const struct regmap_config *config,
+					  struct lock_class_key *lock_key,
+					  const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_slimbus(slimbus, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 15eddc1353ba..b2207737a159 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -24,6 +24,7 @@ struct module;
 struct device;
 struct i2c_client;
 struct irq_domain;
+struct slim_device;
 struct spi_device;
 struct spmi_device;
 struct regmap;
@@ -499,6 +500,10 @@ struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__regmap_init_slimbus(struct slim_device *slimbus,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 struct regmap *__regmap_init_spi(struct spi_device *dev,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
@@ -615,6 +620,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	__regmap_lockdep_wrapper(__regmap_init_i2c, #config,		\
 				i2c, config)
 
+/**
+ * regmap_init_slimbus() - Initialise register map
+ *
+ * @slimbus: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_slimbus(slimbus, config)				\
+	__regmap_lockdep_wrapper(__regmap_init_slimbus, #config,	\
+				slimbus, config)
+
 /**
  * regmap_init_spi() - Initialise register map
  *
-- 
2.15.0
