From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: core: use slim_device_update_status() to update status
Date: Mon, 14 Jan 2019 13:44:48 +0000
Message-ID: <20190114134449.15367-4-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

use slim_device_update_status() instead of directly calling
the device_status() callback. Move slim_device_update_status() before
probe to avoid forward declaration too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 1ba08b5f2e78..8ffdc9876223 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -42,6 +42,23 @@ static int slim_device_match(struct device *dev, struct device_driver *drv)
 	return !!slim_match(sbdrv->id_table, sbdev);
 }
 
+static void slim_device_update_status(struct slim_device *sbdev,
+				      enum slim_device_status status)
+{
+	struct slim_driver *sbdrv;
+
+	if (sbdev->status == status)
+		return;
+
+	sbdev->status = status;
+	if (!sbdev->dev.driver)
+		return;
+
+	sbdrv = to_slim_driver(sbdev->dev.driver);
+	if (sbdrv->device_status)
+		sbdrv->device_status(sbdev, sbdev->status);
+}
+
 static int slim_device_probe(struct device *dev)
 {
 	struct slim_device	*sbdev = to_slim_device(dev);
@@ -55,8 +72,7 @@ static int slim_device_probe(struct device *dev)
 	/* try getting the logical address after probe */
 	ret = slim_get_logical_addr(sbdev);
 	if (!ret) {
-		if (sbdrv->device_status)
-			sbdrv->device_status(sbdev, sbdev->status);
+		slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_UP);
 	} else {
 		dev_err(&sbdev->dev, "Failed to get logical address\n");
 		ret = -EPROBE_DEFER;
@@ -297,23 +313,6 @@ int slim_unregister_controller(struct slim_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(slim_unregister_controller);
 
-static void slim_device_update_status(struct slim_device *sbdev,
-				      enum slim_device_status status)
-{
-	struct slim_driver *sbdrv;
-
-	if (sbdev->status == status)
-		return;
-
-	sbdev->status = status;
-	if (!sbdev->dev.driver)
-		return;
-
-	sbdrv = to_slim_driver(sbdev->dev.driver);
-	if (sbdrv->device_status)
-		sbdrv->device_status(sbdev, sbdev->status);
-}
-
 /**
  * slim_report_absent() - Controller calls this function when a device
  *	reports absent, OR when the device cannot be communicated with
-- 
2.20.1
