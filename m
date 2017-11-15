From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 05/13] slimbus: core: add support to device tree helper
Date: Wed, 15 Nov 2017 14:10:35 +0000
Message-ID: <20171115141043.29202-6-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to parse slim devices from device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d31a9c4fe7e9..f7b14961c7e3 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 #include <linux/slimbus.h>
 #include "slimbus.h"
 
@@ -128,6 +129,9 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->dev.driver = NULL;
 	sbdev->ctrl = ctrl;
 
+	if (node)
+		sbdev->dev.of_node = of_node_get(node);
+
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
 				  sbdev->e_addr.prod_code,
@@ -160,6 +164,50 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
 	return sbdev;
 }
 
+static void of_register_slim_devices(struct slim_controller *ctrl)
+{
+	struct device *dev = ctrl->dev;
+	struct device_node *node;
+
+	if (!ctrl->dev->of_node)
+		return;
+
+	for_each_child_of_node(ctrl->dev->of_node, node) {
+		struct slim_device *sbdev;
+		struct slim_eaddr e_addr;
+		const char *compat = NULL;
+		int reg[2], ret;
+		int manf_id, prod_code;
+
+		compat = of_get_property(node, "compatible", NULL);
+		if (!compat)
+			continue;
+
+		ret = sscanf(compat, "slim%x,%x", &manf_id, &prod_code);
+		if (ret != 2) {
+			dev_err(dev, "Manf ID & Product code not found %s\n",
+				compat);
+			continue;
+		}
+
+		ret = of_property_read_u32_array(node, "reg", reg, 2);
+		if (ret) {
+			dev_err(dev, "Device and Instance id not found:%d\n",
+				ret);
+			continue;
+		}
+
+		e_addr.dev_index = reg[0];
+		e_addr.instance = reg[1];
+		e_addr.manf_id = manf_id;
+		e_addr.prod_code = prod_code;
+
+		sbdev = slim_alloc_device(ctrl, &e_addr, node);
+		if (!sbdev)
+			continue;
+	}
+}
+
 /*
  * slim_register_controller() - Controller bring-up and registration.
  *
@@ -191,6 +239,8 @@ int slim_register_controller(struct slim_controller *ctrl)
 	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
 		ctrl->name, ctrl->dev);
 
+	of_register_slim_devices(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(slim_register_controller);
-- 
2.15.0
