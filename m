From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 08/13] regmap: add SLIMbus support
Date: Wed, 15 Nov 2017 14:10:38 +0000
Message-ID: <20171115141043.29202-9-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B29C52675E6
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:13:38 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id q66so20557202wrb.13
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 06:13:38 -0800 (PST)
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
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
 drivers/base/regmap/regmap-slimbus.c | 95 ++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h               | 18 +++++++
 4 files changed, 118 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-slimbus.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 0368fd7b3a41..344440768205 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -20,6 +20,10 @@ config REGMAP_I2C
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
index 000000000000..bbccad3f8b3a
--- /dev/null
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -0,0 +1,95 @@
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
+	struct slim_device *sdev = context;
+	int v;
+
+	if (!sdev)
+		return 0;
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
+	if (!sdev)
+		return 0;
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
index 978abfbac617..49c8db1dd0ce 100644
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
@@ -565,6 +570,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
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
