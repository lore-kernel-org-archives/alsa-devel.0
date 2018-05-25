From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 8/8] slimbus: core: add of_slim_device_get() helper
Date: Fri, 25 May 2018 15:36:18 +0100
Message-ID: <20180525143618.820-9-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On SLIMBus controllers like Qcom NGD(non ported device), controller
can request logical address once the remote side is powered, having a
helper function like this to explicitly enumerate the bus is helpful.
Also codec drivers which are taking to interface device would need
such a helper too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 7ddfc675b131..88248a4ecad9 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -356,6 +356,45 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
+static int of_slim_match_dev(struct device *dev, void *data)
+{
+	struct device_node *np = data;
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	return (sbdev->dev.of_node == np);
+}
+
+static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
+					       struct device_node *np)
+{
+	struct slim_device *sbdev;
+	struct device *dev;
+
+	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
+	if (dev) {
+		sbdev = to_slim_device(dev);
+		return sbdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * of_slim_get_device() - get handle to a device using dt node.
+ *
+ * @ctrl: Controller on which this device will be added/queried
+ * @np: node pointer to device
+ *
+ * Return: pointer to a device if it has already reported. Creates a new
+ * device and returns pointer to it if the device has not yet enumerated.
+ */
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np)
+{
+	return of_find_slim_device(ctrl, np);
+}
+EXPORT_SYMBOL_GPL(of_slim_get_device);
+
 static int slim_device_alloc_laddr(struct slim_device *sbdev,
 				   bool report_present)
 {
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 90af9eb26615..63801bcc5e60 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -138,6 +138,8 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
 	dev_set_drvdata(&dev->dev, data);
 }
 
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np);
 struct slim_device *slim_get_device(struct slim_controller *ctrl,
 				    struct slim_eaddr *e_addr);
 int slim_get_logical_addr(struct slim_device *sbdev);
-- 
2.16.2
