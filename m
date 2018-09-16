From: srinivas.kandagatla@linaro.org
Subject: [PATCH 2/7] slimbus: core: update device status in probe
Date: Sun, 16 Sep 2018 16:45:41 -0700
Message-ID: <20180916234546.29661-3-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device status update can be racy with probe in some cases, so make sure
it take lock during the probe. Also after probe the device is expected
to be ready for communications, so make sure that a logical address
can be assigned to it after probe. If it fails to do so then probe
defer such instances.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 31f2910..262591f 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -40,8 +40,23 @@ static int slim_device_probe(struct device *dev)
 {
 	struct slim_device	*sbdev = to_slim_device(dev);
 	struct slim_driver	*sbdrv = to_slim_driver(dev->driver);
+	int ret;
+
+	ret = sbdrv->probe(sbdev);
+	if (ret)
+		return ret;
 
-	return sbdrv->probe(sbdev);
+	/* try getting the logical address after probe */
+	ret = slim_get_logical_addr(sbdev);
+	if (!ret) {
+		if (sbdrv->device_status)
+			sbdrv->device_status(sbdev, sbdev->status);
+	} else {
+		dev_err(&sbdev->dev, "Failed to get logical address\n");
+		ret = -EPROBE_DEFER;
+	}
+
+	return ret;
 }
 
 static int slim_device_remove(struct device *dev)
-- 
2.9.3
