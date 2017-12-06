From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 07/15] regmap: Add SoundWire bus support
Date: Wed,  6 Dec 2017 21:17:03 +0530
Message-ID: <1512575231-4154-8-git-send-email-vinod.koul@intel.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 54FEC267981
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:44:03 +0100 (CET)
In-Reply-To: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

SoundWire bus provides sdw_read() and sdw_write() APIs for Slave
devices to program the registers. Provide support in regmap for
SoundWire bus.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/base/regmap/Kconfig      |  4 ++
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/regmap-sdw.c | 92 ++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/Kconfig        |  1 +
 include/linux/regmap.h           | 37 ++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sdw.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 3a1535d812d8..71dc88a48cfa 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -41,3 +41,7 @@ config REGMAP_IRQ
 
 config REGMAP_HWSPINLOCK
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
index 000000000000..3a72039e94ea
--- /dev/null
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -0,0 +1,92 @@
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
+	/* SoundWire register address are contiguous */
+	if (config->reg_stride != 0)
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
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index d7d3908f4913..92a2c3bad87f 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -18,5 +18,6 @@ comment "SoundWire Devices"
 
 config SOUNDWIRE_BUS
 	tristate
+	select REGMAP_SOUNDWIRE
 
 endif
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 15eddc1353ba..97a9c6563bb1 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -30,6 +30,7 @@ struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
 struct snd_ac97;
+struct sdw_slave;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -524,6 +525,10 @@ struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
 				  const char *lock_name);
+struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -561,6 +566,10 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
 				       const char *lock_name);
+struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -710,6 +719,20 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
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
@@ -839,6 +862,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
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
