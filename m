From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/14] regmap: Add SoundWire bus support
Date: Thu, 19 Oct 2017 08:33:23 +0530
Message-ID: <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

SoundWire bus provides sdw_read() and sdw_write() APIs for Slave
devices to program the registers. Provide support in regmap for
SoundWire bus.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/base/regmap/Kconfig      |   4 ++
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-sdw.c | 146 +++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/Kconfig        |   1 +
 include/linux/regmap.h           |  37 ++++++++++
 5 files changed, 189 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sdw.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 073c0b77e5b3..d0310fbaa8e7 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -36,3 +36,7 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_SOUNDWIRE
+	tristate
+	depends on SOUNDWIRE_BUS
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 0cf4abc8fbf1..13004c979881 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
+obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
new file mode 100644
index 000000000000..37983d7c9ceb
--- /dev/null
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -0,0 +1,146 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  GPL LICENSE SUMMARY
+ *
+ *  Copyright(c) 2015-17 Intel Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of version 2 of the GNU General Public License as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015-17 Intel Corporation.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Intel Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include "internal.h"
+
+static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	/* Check for Slave */
+	if (!slave)
+		return 0;
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
+	/* Check for Slave */
+	if (!slave)
+		return 0;
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
+EXPORT_SYMBOL(__regmap_init_sdw);
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
+EXPORT_SYMBOL(__devm_regmap_init_sdw);
+
+MODULE_DESCRIPTION("Regmap SoundWire Module");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 35792728c0aa..d63295015331 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -18,5 +18,6 @@ comment "SoundWire Devices"
 config SOUNDWIRE_BUS
 	tristate
 	default SOUNDWIRE
+	select REGMAP_SOUNDWIRE
 
 endif
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 978abfbac617..d5eecf2e9697 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -30,6 +30,7 @@ struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
 struct snd_ac97;
+struct sdw_slave;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -474,6 +475,10 @@ struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
 				  const char *lock_name);
+struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -511,6 +516,10 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
 				       const char *lock_name);
+struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -660,6 +669,20 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
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
  * devm_regmap_init() - Initialise managed register map
  *
  * @dev: Device that will be interacted with
@@ -789,6 +812,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
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
2.7.4
