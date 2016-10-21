From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 12/14] regmap: SoundWire: Add regmap support for SoundWire bus
Date: Fri, 21 Oct 2016 18:11:10 +0530
Message-ID: <1477053673-16021-13-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/Kconfig      |    3 +
 drivers/base/regmap/Makefile     |    1 +
 drivers/base/regmap/regmap-sdw.c |  240 ++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           |   37 ++++++
 4 files changed, 281 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sdw.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index db9d00c3..1d650c1 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -29,3 +29,6 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_SDW
+	depends on SOUND_SDW
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 609e4c8..ee041e0 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
+obj-$(CONFIG_REGMAP_SDW) += regmap-sdw.o
diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
new file mode 100644
index 0000000..d76ee12
--- /dev/null
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -0,0 +1,240 @@
+/*
+ *  regmap-sdw.c - Register map access API - SoundWire support.
+ *
+ *  Copyright (C) 2015-2016 Intel Corp
+ *  Author: Hardik Shah <hardik.t.shah@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#include <linux/regmap.h>
+#include <sound/sdw_bus.h>
+#include <sound/sdw_master.h>
+#include <sound/sdw_slave.h>
+#include <linux/module.h>
+#include <sound/sdw/sdw_registers.h>
+
+#include "internal.h"
+
+
+static inline void get_t_size(size_t *t_val_size, size_t *t_size,
+						int *reg_addr,
+						int *offset,
+						size_t *val_size)
+{
+
+		*t_val_size += *t_size;
+		*offset += *t_size;
+
+		*t_size = *val_size - *t_val_size;
+		*t_size = min_t(size_t, *t_size, 65535);
+
+		*reg_addr += *t_size;
+
+
+}
+
+static int regmap_sdw_read(void *context,
+			   const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct sdw_slave *sdw = to_sdw_slave(dev);
+	struct sdw_msg xfer;
+	int ret, scp_addr1, scp_addr2;
+	int reg_command;
+	int reg_addr = *(u32 *)reg;
+	size_t t_val_size = 0, t_size;
+	int offset;
+	u8 *t_val;
+
+	/* SoundWire registers are 32-bit addressed */
+	if (reg_size != 4)
+		return -ENOTSUPP;
+
+	xfer.dev_num = sdw->dev_num;
+	xfer.xmit_on_ssp = 0;
+	xfer.r_w_flag = SDW_MSG_FLAG_READ;
+	xfer.len = 0;
+	t_val = val;
+
+	offset = 0;
+	reg_command = (reg_addr >> SDW_REGADDR_SHIFT) &
+					SDW_REGADDR_MASK;
+	if (val_size > SDW_MAX_REG_ADDR)
+		t_size = SDW_MAX_REG_ADDR - reg_command;
+	else
+		t_size = val_size;
+
+	while (t_val_size < val_size) {
+
+		scp_addr1 = (reg_addr >> SDW_SCP_ADDRPAGE1_SHIFT) &
+				SDW_SCP_ADDRPAGE1_MASK;
+		scp_addr2 = (reg_addr >> SDW_SCP_ADDRPAGE2_SHIFT) &
+				SDW_SCP_ADDRPAGE2_MASK;
+		xfer.addr_page1 = scp_addr1;
+		xfer.addr_page2 = scp_addr2;
+		xfer.addr = reg_command;
+		xfer.len += t_size;
+		xfer.buf = &t_val[offset];
+		ret = snd_sdw_slave_transfer(sdw->mstr, &xfer, 1);
+		if (ret < 0)
+			return ret;
+		else if (ret != 1)
+			return -EIO;
+
+		get_t_size(&t_val_size, &t_size, &reg_addr, &offset,
+								&val_size);
+
+		reg_command = (reg_addr >> SDW_REGADDR_SHIFT) &
+					SDW_REGADDR_MASK;
+	}
+	return 0;
+}
+
+static int regmap_sdw_gather_write(void *context,
+			   const void *reg, size_t reg_size,
+			   const void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct sdw_slave *sdw = to_sdw_slave(dev);
+	struct sdw_msg xfer;
+	int ret, scp_addr1, scp_addr2;
+	int reg_command;
+	int reg_addr = *(u32 *)reg;
+	size_t t_val_size = 0, t_size;
+	int offset;
+	u8 *t_val;
+
+	/* All registers are 4 byte on SoundWire bus */
+	if (reg_size != 4)
+		return -ENOTSUPP;
+
+	if (!sdw)
+		return 0;
+
+	xfer.dev_num = sdw->dev_num;
+	xfer.xmit_on_ssp = 0;
+	xfer.r_w_flag = SDW_MSG_FLAG_WRITE;
+	xfer.len = 0;
+	t_val = (u8 *)val;
+
+	offset = 0;
+	reg_command = (reg_addr >> SDW_REGADDR_SHIFT) &
+					SDW_REGADDR_MASK;
+	if (val_size > SDW_MAX_REG_ADDR)
+		t_size = SDW_MAX_REG_ADDR - reg_command;
+	else
+		t_size = val_size;
+	while (t_val_size < val_size) {
+
+		scp_addr1 = (reg_addr >> SDW_SCP_ADDRPAGE1_SHIFT) &
+				SDW_SCP_ADDRPAGE1_MASK;
+		scp_addr2 = (reg_addr >> SDW_SCP_ADDRPAGE2_SHIFT) &
+				SDW_SCP_ADDRPAGE2_MASK;
+		xfer.addr_page1 = scp_addr1;
+		xfer.addr_page2 = scp_addr2;
+		xfer.addr = reg_command;
+		xfer.len += t_size;
+		xfer.buf = &t_val[offset];
+		ret = snd_sdw_slave_transfer(sdw->mstr, &xfer, 1);
+		if (ret < 0)
+			return ret;
+		else if (ret != 1)
+			return -EIO;
+
+		get_t_size(&t_val_size, &t_size, &reg_addr, &offset,
+							&val_size);
+
+		reg_command = (reg_addr >> SDW_REGADDR_SHIFT) &
+					SDW_REGADDR_MASK;
+	}
+	return 0;
+}
+
+static int regmap_sdw_write(void *context, const void *data, size_t count)
+{
+	/* 4-byte register address for the soundwire */
+	unsigned int offset = 4;
+
+	if (count <= offset)
+		return -EINVAL;
+
+	return regmap_sdw_gather_write(context, data, 4,
+					data + offset, count - offset);
+}
+
+static struct regmap_bus regmap_sdw = {
+	.write = regmap_sdw_write,
+	.gather_write = regmap_sdw_gather_write,
+	.read = regmap_sdw_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static int regmap_sdw_config_check(const struct regmap_config *config)
+{
+	/* All register are 8-bits wide as per MIPI Soundwire 1.0 Spec */
+	if (config->val_bits != 8)
+		return -ENOTSUPP;
+	/* Registers are 32 bit in size, based on SCP_ADDR1 and SCP_ADDR2
+	 * implementation address range may vary in slave.
+	 */
+	if (config->reg_bits != 32)
+		return -ENOTSUPP;
+	/* SoundWire register address are contiguous. */
+	if (config->reg_stride != 0)
+		return -ENOTSUPP;
+	if (config->pad_bits != 0)
+		return -ENOTSUPP;
+
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
+	return __regmap_init(&sdw->dev, &regmap_sdw, &sdw->dev, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_sdw);
+
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
+	return __devm_regmap_init(&sdw->dev, &regmap_sdw, &sdw->dev, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 9adc7b2..5c192f7 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -29,6 +29,7 @@
 struct regmap_range_cfg;
 struct regmap_field;
 struct snd_ac97;
+struct sdw_slave;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -456,6 +457,10 @@ struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
 				  const char *lock_name);
+struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -489,6 +494,10 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
 				       const char *lock_name);
+struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -623,6 +632,20 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
 /**
+ * regmap_init_sdw(): Initialise register map
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
  * devm_regmap_init(): Initialise managed register map
  *
  * @dev: Device that will be interacted with
@@ -737,6 +760,20 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	__regmap_lockdep_wrapper(__devm_regmap_init_ac97, #config,	\
 				ac97, config)
 
+/**
+ * devm_regmap_init_sdw(): Initialise managed register map
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
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
1.7.9.5
