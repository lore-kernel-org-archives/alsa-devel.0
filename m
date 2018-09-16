From: srinivas.kandagatla@linaro.org
Subject: [PATCH 3/7] slimbus: core: match device tree based devices correctly
Date: Sun, 16 Sep 2018 16:45:42 -0700
Message-ID: <20180916234546.29661-4-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device_id for device tree based devices come from dt compatible string,
such drivers need not provide non dt style device id table.

Match those device using compatible strings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 262591f..55eda58 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -33,6 +33,10 @@ static int slim_device_match(struct device *dev, struct device_driver *drv)
 	struct slim_device *sbdev = to_slim_device(dev);
 	struct slim_driver *sbdrv = to_slim_driver(drv);
 
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
 	return !!slim_match(sbdrv->id_table, sbdev);
 }
 
@@ -106,7 +110,7 @@ EXPORT_SYMBOL_GPL(slimbus_bus);
 int __slim_driver_register(struct slim_driver *drv, struct module *owner)
 {
 	/* ID table and probe are mandatory */
-	if (!drv->id_table || !drv->probe)
+	if (!(drv->driver.of_match_table || drv->id_table) || !drv->probe)
 		return -EINVAL;
 
 	drv->driver.bus = &slimbus_bus;
-- 
2.9.3
