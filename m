From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v8] regmap: Add SoundWire bus support
Date: Mon,  8 Jan 2018 15:50:59 +0530
Message-ID: <1515406859-8999-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF9C2668F0
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 11:16:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark <broonie@kernel.org>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, ALSA <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SoundWire bus provides sdw_read() and sdw_write() APIs for Slave
devices to program the registers. Provide support in regmap for
SoundWire bus.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
changes in v8:
 drop bad merge artifcat

changes in v7:
 drop SDW bus select
 drop stride check

 drivers/base/regmap/Kconfig      |  4 ++
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/regmap-sdw.c | 88 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           | 37 +++++++++++++++++
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sdw.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 0368fd7b3a41..067073e4beb1 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -37,3 +37,7 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_SOUNDWIRE
+	tristate
+	depends on SOUNDWIRE_BUS
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 0d298c446108..22d263cca395 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
+obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
new file mode 100644
index 000000000000..50a66382d87d
--- /dev/null
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-17 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/soundwire/sdw.h>
+#include "internal.h"
+
+static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	return sdw_write(slave, reg, val);
+}
+
+static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int read;
+
+	read = sdw_read(slave, reg);
+	if (read < 0)
+		return read;
+
+	*val = read;
+	return 0;
+}
+
+static struct regmap_bus regmap_sdw = {
+	.reg_read = regmap_sdw_read,
+	.reg_write = regmap_sdw_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static int regmap_sdw_config_check(const struct regmap_config *config)
+{
+	/* All register are 8-bits wide as per MIPI Soundwire 1.0 Spec */
+	if (config->val_bits != 8)
+		return -ENOTSUPP;
+
+	/* Registers are 32 bits wide */
+	if (config->reg_bits != 32)
+		return -ENOTSUPP;
+
+	if (config->pad_bits != 0)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
+{
+	int ret;
+
+	ret = regmap_sdw_config_check(config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return __regmap_init(&sdw->dev, &regmap_sdw,
+			&sdw->dev, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_sdw);
+
+struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
+{
+	int ret;
+
+	ret = regmap_sdw_config_check(config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return __devm_regmap_init(&sdw->dev, &regmap_sdw,
+			&sdw->dev, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw);
+
+MODULE_DESCRIPTION("Regmap SoundWire Module");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 671515911b03..27e242bed62c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -30,6 +30,7 @@ struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
 struct snd_ac97;
+struct sdw_slave;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -531,6 +532,10 @@ struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
 				  const char *lock_name);
+struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -568,6 +573,10 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
 				       const char *lock_name);
+struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -717,6 +726,20 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
 /**
+ * regmap_init_sdw() - Initialise register map
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_sdw(sdw, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_sdw, #config,		\
+				sdw, config)
+
+
+/**
  * devm_regmap_init() - Initialise managed register map
  *
  * @dev: Device that will be interacted with
@@ -846,6 +869,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_ac97, #config,	\
 				ac97, config)
 
+/**
+ * devm_regmap_init_sdw() - Initialise managed register map
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_sdw(sdw, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_sdw, #config,	\
+				sdw, config)
+
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
2.7.4
