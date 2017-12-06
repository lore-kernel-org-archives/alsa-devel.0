From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 14/15] soundwire: intel: Add Intel init module
Date: Wed,  6 Dec 2017 21:17:10 +0530
Message-ID: <1512575231-4154-15-git-send-email-vinod.koul@intel.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The SoundWire Master is implemented as part of Audio controller in
Intel platforms. Add a init module which creates SoundWire Master
platform devices based on the links supported in the hardware.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile          |   3 +
 drivers/soundwire/intel_init.c      | 198 ++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |   3 +
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/soundwire/intel_init.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 0813b2c74426..94272c965d6c 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -13,3 +13,6 @@ obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 #Intel driver
 soundwire-intel-objs :=	intel.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
+
+soundwire-intel-init-objs := intel_init.o
+obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel-init.o
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
new file mode 100644
index 000000000000..6f2bb99526f2
--- /dev/null
+++ b/drivers/soundwire/intel_init.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-17 Intel Corporation.
+
+/*
+ * SDW Intel Init Routines
+ *
+ * Initializes and creates SDW devices based on ACPI and Hardware values
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "intel.h"
+
+#define SDW_MAX_LINKS		4
+#define SDW_SHIM_LCAP		0x0
+#define SDW_SHIM_BASE		0x2C000
+#define SDW_ALH_BASE		0x2C800
+#define SDW_LINK_BASE		0x30000
+#define SDW_LINK_SIZE		0x10000
+
+struct sdw_link_data {
+	struct sdw_intel_link_res res;
+	struct platform_device *pdev;
+};
+
+struct sdw_intel_ctx {
+	int count;
+	struct sdw_link_data *links;
+};
+
+static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
+{
+	struct sdw_link_data *link = ctx->links;
+	int i;
+
+	if (!link)
+		return 0;
+
+	for (i = 0; i < ctx->count; i++) {
+		if (link->pdev)
+			platform_device_unregister(link->pdev);
+		link++;
+	}
+
+	kfree(ctx->links);
+	ctx->links = NULL;
+
+	return 0;
+}
+
+static struct sdw_intel_ctx
+*sdw_intel_add_controller(struct sdw_intel_res *res)
+{
+	struct platform_device_info pdevinfo;
+	struct platform_device *pdev;
+	struct sdw_link_data *link;
+	struct sdw_intel_ctx *ctx;
+	struct acpi_device *adev;
+	int ret, i;
+	u8 count;
+	u32 caps;
+
+	if (acpi_bus_get_device(res->handle, &adev))
+		return NULL;
+
+	/* Found controller, find links supported */
+	count = 0;
+	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
+				  "mipi-sdw-master-count", &count, 1);
+
+	/* Don't fail on error, continue and use hw value */
+	if (ret) {
+		dev_err(&adev->dev,
+			"Failed to read mipi-sdw-master-count: %d\n", ret);
+		count = SDW_MAX_LINKS;
+	}
+
+	/* Check SNDWLCAP.LCOUNT */
+	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
+
+	/* Check HW supported vs property value and use min of two */
+	count = min_t(u8, caps, count);
+
+	/* Check count is within bounds */
+	if (count > SDW_MAX_LINKS) {
+		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
+						count, SDW_MAX_LINKS);
+		return NULL;
+	}
+
+	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->count = count;
+	ctx->links = kcalloc(ctx->count, sizeof(*ctx->links), GFP_KERNEL);
+	if (!ctx->links)
+		goto link_err;
+
+	link = ctx->links;
+
+	/* Create SDW Master devices */
+	for (i = 0; i < count; i++) {
+
+		link->res.irq = res->irq;
+		link->res.registers = res->mmio_base + SDW_LINK_BASE
+					+ (SDW_LINK_SIZE * i);
+		link->res.shim = res->mmio_base + SDW_SHIM_BASE;
+		link->res.alh = res->mmio_base + SDW_ALH_BASE;
+
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+		pdevinfo.parent = res->parent;
+		pdevinfo.name = "int-sdw";
+		pdevinfo.id = i;
+		pdevinfo.fwnode = acpi_fwnode_handle(adev);
+		pdevinfo.data = &link->res;
+		pdevinfo.size_data = sizeof(link->res);
+
+		pdev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(pdev)) {
+			dev_err(&adev->dev,
+				"platform device creation failed: %ld\n",
+				PTR_ERR(pdev));
+			goto pdev_err;
+		}
+
+		link->pdev = pdev;
+		link++;
+	}
+
+	return ctx;
+
+pdev_err:
+	sdw_intel_cleanup_pdev(ctx);
+link_err:
+	kfree(ctx);
+	return NULL;
+}
+
+static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
+					void *cdata, void **return_value)
+{
+	struct sdw_intel_res *res = cdata;
+	struct acpi_device *adev;
+
+	if (acpi_bus_get_device(handle, &adev)) {
+		dev_err(&adev->dev, "Couldn't find ACPI handle\n");
+		return AE_NOT_FOUND;
+	}
+
+	res->handle = handle;
+	return AE_OK;
+}
+
+/**
+ * sdw_intel_init() - SoundWire Intel init routine
+ * @parent_handle: ACPI parent handle
+ * @res: resource data
+ *
+ * This scans the namespace and creates SoundWire link controller devices
+ * based on the info queried.
+ */
+void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
+{
+	acpi_status status;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
+					parent_handle, 1,
+					sdw_intel_acpi_cb,
+					NULL, res, NULL);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	return sdw_intel_add_controller(res);
+}
+EXPORT_SYMBOL(sdw_intel_init);
+
+/**
+ * sdw_intel_exit() - SoundWire Intel exit
+ * @arg: callback context
+ *
+ * Delete the controller instances created and cleanup
+ */
+void sdw_intel_exit(void *arg)
+{
+	struct sdw_intel_ctx *ctx = arg;
+
+	sdw_intel_cleanup_pdev(ctx);
+	kfree(ctx);
+}
+EXPORT_SYMBOL(sdw_intel_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Intel Soundwire Init Library");
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 370cc52d8d1e..4b37528f592d 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -18,4 +18,7 @@ struct sdw_intel_res {
 	struct device *parent;
 };
 
+void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res);
+void sdw_intel_exit(void *arg);
+
 #endif
-- 
2.7.4
