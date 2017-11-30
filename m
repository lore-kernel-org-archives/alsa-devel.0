From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 13/15] soundwire: intel: Add Intel Master driver
Date: Thu, 30 Nov 2017 15:27:08 +0530
Message-ID: <1512035830-29161-14-git-send-email-vinod.koul@intel.com>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Some Intel platforms have SoundWire Master, so add Intel SoundWire
Master driver which uses Cadence module. This patch adds probe and
initialization routines for Intel Master driver.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Kconfig           |  11 +
 drivers/soundwire/Makefile          |   4 +
 drivers/soundwire/intel.c           | 395 ++++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.h           |  71 +++++++
 include/linux/soundwire/sdw_intel.h |  68 +++++++
 5 files changed, 549 insertions(+)
 create mode 100644 drivers/soundwire/intel.c
 create mode 100644 drivers/soundwire/intel.h
 create mode 100644 include/linux/soundwire/sdw_intel.h

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 34361952310e..b46084b4b1f8 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -23,4 +23,15 @@ config SOUNDWIRE_BUS
 config SOUNDWIRE_CADENCE
 	tristate
 
+config SOUNDWIRE_INTEL
+	tristate "Intel SoundWire Master driver"
+	select SOUNDWIRE_CADENCE
+	select SOUNDWIRE_BUS
+	depends on X86 && ACPI
+	---help---
+	  SoundWire Intel Master driver.
+	  If you have an Intel platform which has a SoundWire Master then
+	  enable this config option to get the SoundWire support for that
+	  device.
+
 endif
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index f9a1ce3a860e..0813b2c74426 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -9,3 +9,7 @@ obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
+
+#Intel driver
+soundwire-intel-objs :=	intel.o
+obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
new file mode 100644
index 000000000000..2c021cc6e521
--- /dev/null
+++ b/drivers/soundwire/intel.c
@@ -0,0 +1,395 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
+/*
+ * Soundwire Intel Master Driver
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
+#include "intel.h"
+
+/* Intel SHIM Registers Definition */
+#define SDW_SHIM_LCAP			0x0
+#define SDW_SHIM_LCTL			0x4
+#define SDW_SHIM_IPPTR			0x8
+#define SDW_SHIM_SYNC			0xC
+
+#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * x)
+#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * x)
+#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * x)
+#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * x)
+#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * x)
+#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * x)
+
+#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * x) + (0x2 * y))
+#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * x) + (0x2 * y))
+#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * x)
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * x)
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * x)
+
+#define SDW_SHIM_WAKEEN			0x190
+#define SDW_SHIM_WAKESTS		0x192
+
+#define SDW_SHIM_LCTL_SPA		BIT(0)
+#define SDW_SHIM_LCTL_CPA		BIT(8)
+
+#define SDW_SHIM_SYNC_SYNCPRD_VAL	0x176F
+#define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
+#define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
+#define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
+#define SDW_SHIM_SYNC_CMDSYNC		BIT(16)
+#define SDW_SHIM_SYNC_SYNCGO		BIT(24)
+
+#define SDW_SHIM_PCMSCAP_ISS		GENMASK(3, 0)
+#define SDW_SHIM_PCMSCAP_OSS		GENMASK(7, 4)
+#define SDW_SHIM_PCMSCAP_BSS		GENMASK(12, 8)
+
+#define SDW_SHIM_PCMSYCM_LCHN		GENMASK(3, 0)
+#define SDW_SHIM_PCMSYCM_HCHN		GENMASK(7, 4)
+#define SDW_SHIM_PCMSYCM_STREAM		GENMASK(13, 8)
+#define SDW_SHIM_PCMSYCM_DIR		BIT(15)
+
+#define SDW_SHIM_PDMSCAP_ISS		GENMASK(3, 0)
+#define SDW_SHIM_PDMSCAP_OSS		GENMASK(7, 4)
+#define SDW_SHIM_PDMSCAP_BSS		GENMASK(12, 8)
+#define SDW_SHIM_PDMSCAP_CPSS		GENMASK(15, 13)
+
+#define SDW_SHIM_IOCTL_MIF		BIT(0)
+#define SDW_SHIM_IOCTL_CO		BIT(1)
+#define SDW_SHIM_IOCTL_COE		BIT(2)
+#define SDW_SHIM_IOCTL_DO		BIT(3)
+#define SDW_SHIM_IOCTL_DOE		BIT(4)
+#define SDW_SHIM_IOCTL_BKE		BIT(5)
+#define SDW_SHIM_IOCTL_WPDD		BIT(6)
+#define SDW_SHIM_IOCTL_CIBD		BIT(8)
+#define SDW_SHIM_IOCTL_DIBD		BIT(9)
+
+#define SDW_SHIM_CTMCTL_DACTQE		BIT(0)
+#define SDW_SHIM_CTMCTL_DODS		BIT(1)
+#define SDW_SHIM_CTMCTL_DOAIS		GENMASK(4, 3)
+
+#define SDW_SHIM_WAKEEN_ENABLE		BIT(0)
+#define SDW_SHIM_WAKESTS_STATUS		BIT(0)
+
+/* Intel ALH Register definitions */
+#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * x))
+
+#define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
+#define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
+#define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
+
+struct sdw_intel {
+	struct sdw_cdns cdns;
+	int instance;
+	struct sdw_intel_link_res *res;
+};
+
+#define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
+
+/*
+ * Read, write helpers for HW registers
+ */
+static inline int intel_readl(void __iomem *base, int offset)
+{
+	return readl(base + offset);
+}
+
+static inline void intel_writel(void __iomem *base, int offset, int value)
+{
+	writel(value, base + offset);
+}
+
+static inline u16 intel_readw(void __iomem *base, int offset)
+{
+	return readw(base + offset);
+}
+
+static inline void intel_writew(void __iomem *base, int offset, u16 value)
+{
+	writew(value, base + offset);
+}
+
+static int intel_clear_bit(void __iomem *base, int offset, u32 value, u32 mask)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	writel(value, base + offset);
+	do {
+		reg_read = readl(base + offset);
+		if (!(reg_read & mask))
+			return 0;
+
+		timeout--;
+		usleep_range(1, 50);
+
+	} while (timeout != 0);
+
+	return -EAGAIN;
+}
+
+static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	writel(value, base + offset);
+	do {
+		reg_read = readl(base + offset);
+		if (reg_read & mask)
+			return 0;
+
+		timeout--;
+		usleep_range(1, 50);
+
+	} while (timeout != 0);
+
+	return -EAGAIN;
+}
+
+/*
+ * shim ops
+ */
+
+static int intel_link_power_up(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->res->shim;
+	int spa_mask, cpa_mask;
+	int link_control, ret;
+
+	/* Link power up sequence */
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+	spa_mask = (SDW_SHIM_LCTL_SPA << link_id);
+	cpa_mask = (SDW_SHIM_LCTL_SPA << link_id);
+	link_control |=  spa_mask;
+
+	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	if (ret < 0)
+		return ret;
+
+	sdw->cdns.link_up = true;
+	return 0;
+}
+
+static int intel_shim_init(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->res->shim;
+	unsigned int link_id = sdw->instance;
+	int sync_reg, ret;
+	u16 ioctl = 0, act = 0;
+
+	/* Initialize Shim */
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl |= SDW_SHIM_IOCTL_WPDD;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl |= SDW_SHIM_IOCTL_DO;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl |= SDW_SHIM_IOCTL_DOE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	/* Switch to MIP from Glue logic */
+	ioctl = intel_readw(shim,  SDW_SHIM_IOCTL(link_id));
+
+	ioctl &= ~(SDW_SHIM_IOCTL_DOE);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_DO);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl |= (SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_BKE);
+	ioctl &= ~(SDW_SHIM_IOCTL_COE);
+
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	act |= 0x1 << SDW_REG_SHIFT(SDW_SHIM_CTMCTL_DOAIS);
+	act |= SDW_SHIM_CTMCTL_DACTQE;
+	act |= SDW_SHIM_CTMCTL_DODS;
+	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
+
+	/* Now set SyncPRD period */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+	sync_reg |= (SDW_SHIM_SYNC_SYNCPRD_VAL <<
+			SDW_REG_SHIFT(SDW_SHIM_SYNC_SYNCPRD));
+
+	/* Set SyncCPU bit */
+	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
+	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
+				SDW_SHIM_SYNC_SYNCCPU);
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "Failed to set sync period: %d", ret);
+
+	return ret;
+}
+
+static int intel_prop_read(struct sdw_bus *bus)
+{
+	/* Initialize with default handler to read all DisCo properties */
+	sdw_master_read_prop(bus);
+
+	/* BIOS is not giving some values correctly. So, lets override them */
+	bus->prop.num_freq = 1;
+	bus->prop.freq = devm_kcalloc(bus->dev, sizeof(*bus->prop.freq),
+					bus->prop.num_freq, GFP_KERNEL);
+	if (!bus->prop.freq)
+		return -ENOMEM;
+
+	bus->prop.freq[0] = bus->prop.max_freq;
+	bus->prop.err_threshold = 5;
+
+	return 0;
+}
+
+/*
+ * probe and init
+ */
+static int intel_probe(struct platform_device *pdev)
+{
+	struct sdw_intel *sdw;
+	int ret;
+
+	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
+	if (!sdw)
+		return -ENOMEM;
+
+	sdw->instance = pdev->id;
+	sdw->res = dev_get_platdata(&pdev->dev);
+	sdw->cdns.dev = &pdev->dev;
+	sdw->cdns.registers = sdw->res->registers;
+	sdw->cdns.instance = sdw->instance;
+	sdw->cdns.msg_count = 0;
+	sdw->cdns.bus.dev = &pdev->dev;
+	sdw->cdns.bus.link_id = pdev->id;
+
+	sdw_cdns_probe(&sdw->cdns);
+
+	/* Set property read ops */
+	sdw_cdns_master_ops.read_prop = intel_prop_read;
+	sdw->cdns.bus.ops = &sdw_cdns_master_ops;
+
+	platform_set_drvdata(pdev, sdw);
+
+	ret = sdw_add_bus_master(&sdw->cdns.bus);
+	if (ret) {
+		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
+		goto err_master_reg;
+	}
+
+	/* Initialize shim and controller */
+	intel_link_power_up(sdw);
+	intel_shim_init(sdw);
+
+	ret = sdw_cdns_init(&sdw->cdns);
+	if (ret)
+		goto err_init;
+
+	sdw_cdns_enable_interrupt(&sdw->cdns);
+	if (ret)
+		goto err_init;
+
+	/* Acquire IRQ */
+	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq,
+			sdw_cdns_thread, IRQF_SHARED, KBUILD_MODNAME,
+			&sdw->cdns);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
+				sdw->res->irq);
+		goto err_init;
+	}
+
+	return 0;
+
+err_init:
+	sdw_delete_bus_master(&sdw->cdns.bus);
+err_master_reg:
+	return ret;
+}
+
+static int intel_remove(struct platform_device *pdev)
+{
+	struct sdw_intel *sdw;
+
+	sdw = platform_get_drvdata(pdev);
+
+	free_irq(sdw->res->irq, sdw);
+	sdw_delete_bus_master(&sdw->cdns.bus);
+
+	return 0;
+}
+
+static struct platform_driver sdw_intel_drv = {
+	.probe = intel_probe,
+	.remove = intel_remove,
+	.driver = {
+		.name = "int-sdw",
+
+	},
+};
+
+module_platform_driver(sdw_intel_drv);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:int-sdw");
+MODULE_DESCRIPTION("Intel Soundwire Master Driver");
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
new file mode 100644
index 000000000000..2856f569cb67
--- /dev/null
+++ b/drivers/soundwire/intel.h
@@ -0,0 +1,71 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
+#ifndef __SDW_INTEL_LOCAL_H
+#define __SDW_INTEL_LOCAL_H
+
+/**
+ * struct sdw_intel_res - Soundwire link resources
+ * @registers: Link IO registers base
+ * @shim: Audio shim pointer
+ * @alh: ALH (Audio Link Hub) pointer
+ * @irq: Interrupt line
+ *
+ * This is set as pdata for each link instance.
+ */
+struct sdw_intel_link_res {
+	void __iomem *registers;
+	void __iomem *shim;
+	void __iomem *alh;
+	int irq;
+};
+
+#endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
new file mode 100644
index 000000000000..59c3546cfe36
--- /dev/null
+++ b/include/linux/soundwire/sdw_intel.h
@@ -0,0 +1,68 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
+ */
+
+#ifndef __SDW_INTEL_H
+#define __SDW_INTEL_H
+
+/**
+ * struct sdw_intel_res - Soundwire Intel resource structure
+ * @mmio_base: mmio base of SoundWire registers
+ * @irq: interrupt number
+ * @handle: ACPI parent handle
+ * @parent: parent device
+ */
+struct sdw_intel_res {
+	void __iomem *mmio_base;
+	int irq;
+	acpi_handle handle;
+	struct device *parent;
+};
+
+#endif
-- 
2.7.4
