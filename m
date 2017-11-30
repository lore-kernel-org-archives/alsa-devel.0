From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 05/13] slimbus: core: add support to device
	tree helper
Date: Thu, 30 Nov 2017 17:41:52 +0000
Message-ID: <20171130174200.6684-6-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E334267B33
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 18:45:55 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id l141so14609150wmg.1
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 09:45:55 -0800 (PST)
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, srinivas.kandagatla@linaro.org, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to parse slim devices from device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 41e83c15591a..0c66f76b1a85 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 #include <linux/slimbus.h>
 #include "slimbus.h"
 
@@ -120,6 +121,9 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->dev.driver = NULL;
 	sbdev->ctrl = ctrl;
 
+	if (node)
+		sbdev->dev.of_node = of_node_get(node);
+
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
 				  sbdev->e_addr.prod_code,
@@ -150,6 +154,50 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
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
@@ -181,6 +229,8 @@ int slim_register_controller(struct slim_controller *ctrl)
 	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
 		ctrl->name, ctrl->dev);
 
+	of_register_slim_devices(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(slim_register_controller);
-- 
2.15.0
