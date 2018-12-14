From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/7] slimbus: ngd: mark PM functions as __maybe_unused
Date: Fri, 14 Dec 2018 23:10:09 +0100
Message-ID: <20181214221023.3878670-5-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 2e6ae11dd0d1c37f44cec51a58fb2092e55ed0f5 upstream.

qcom_slim_ngd_runtime_suspend is protected by an #ifdef,
qcom_slim_ngd_runtime_idle is now, which causes a build time warning:

drivers/slimbus/qcom-ngd-ctrl.c:1470:12: error: 'qcom_slim_ngd_runtime_idle' defined but not used [-Werror=unused-function]

Marking both as __maybe_unused lets us get rid of the warning
as well as the #ifdef.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8be4d6786c61..14a9d18306cb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1467,7 +1467,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_slim_ngd_runtime_idle(struct device *dev)
+static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 
@@ -1477,8 +1477,7 @@ static int qcom_slim_ngd_runtime_idle(struct device *dev)
 	return -EAGAIN;
 }
 
-#ifdef CONFIG_PM
-static int qcom_slim_ngd_runtime_suspend(struct device *dev)
+static int __maybe_unused qcom_slim_ngd_runtime_suspend(struct device *dev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1491,7 +1490,6 @@ static int qcom_slim_ngd_runtime_suspend(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-- 
2.20.0
