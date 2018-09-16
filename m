From: srinivas.kandagatla@linaro.org
Subject: [PATCH 1/7] slimbus: core: add support to uevent
Date: Sun, 16 Sep 2018 16:45:40 -0700
Message-ID: <20180916234546.29661-2-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by alsa0.perex.cz (Postfix) with ESMTP id F3B262677FC
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 01:45:58 +0200 (CEST)
Received: by mail-io1-f66.google.com with SMTP id r196-v6so10087554iod.0
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2018 16:45:58 -0700 (PDT)
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to uevent to help automatic module loading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 95b00d2..31f2910 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slimbus.h>
 #include "slimbus.h"
@@ -57,11 +58,24 @@ static int slim_device_remove(struct device *dev)
 	return 0;
 }
 
+static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != -ENODEV)
+		return ret;
+
+	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
+}
+
 struct bus_type slimbus_bus = {
 	.name		= "slimbus",
 	.match		= slim_device_match,
 	.probe		= slim_device_probe,
 	.remove		= slim_device_remove,
+	.uevent		= slim_device_uevent,
 };
 EXPORT_SYMBOL_GPL(slimbus_bus);
 
-- 
2.9.3
