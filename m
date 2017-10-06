From: srinivas.kandagatla@linaro.org
Subject: [Patch v6 6/7] regmap: add SLIMBUS support
Date: Fri,  6 Oct 2017 17:51:35 +0200
Message-ID: <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to read/write slimbus value elements.
Currently it only supports byte read/write. Adding this support in
regmap would give codec drivers more flexibility when there are more
than 2 control interfaces like slimbus, i2c.

Without this patch each codec driver has to directly call slimbus value
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
index 073c0b7..b79de7c 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -19,6 +19,10 @@ config REGMAP_I2C
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
index 0cf4abc..b16d367 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_REGCACHE_COMPRESSED) += regcache-lzo.o
 obj-$(CONFIG_DEBUG_FS) += regmap-debugfs.o
 obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
+obj-$(CONFIG_REGMAP_SLIMBUS) += regmap-slimbus.o
 obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
new file mode 100644
index 0000000..5ae24ab
--- /dev/null
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -0,0 +1,89 @@
+/*
+ * Register map access API - slimbus support
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
+	struct slim_device *slim = context;
+	struct slim_val_inf msg = {0,};
+
+	msg.start_offset = reg;
+	msg.num_bytes = 1;
+	msg.rbuf = (void *)val;
+
+	return slim_request_val_element(slim, &msg);
+}
+
+static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
+					 unsigned int val)
+{
+	struct slim_device *slim = context;
+	struct slim_val_inf msg = {0,};
+
+	msg.start_offset = reg;
+	msg.num_bytes = 1;
+	msg.wbuf = (void *)&val;
+
+	return slim_change_val_element(slim, &msg);
+}
+
+static struct regmap_bus regmap_slimbus_bus = {
+	.reg_write = regmap_slimbus_byte_reg_write,
+	.reg_read = regmap_slimbus_byte_reg_read,
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
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 978abfb..49c8db1 100644
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
@@ -449,6 +450,10 @@ struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
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
@@ -566,6 +571,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 				i2c, config)
 
 /**
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
+/**
  * regmap_init_spi() - Initialise register map
  *
  * @dev: Device that will be interacted with
-- 
2.9.3
