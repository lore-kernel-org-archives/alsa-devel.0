From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] slimbus: ngd: mark PM functions as
	__maybe_unused
Date: Mon, 20 Aug 2018 11:35:37 +0200
Message-ID: <20180820093605.3760472-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 4620826773F
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2018 11:36:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

qcom_slim_ngd_runtime_suspend is protected by an #ifdef,
qcom_slim_ngd_runtime_idle is now, which causes a build time warning:

drivers/slimbus/qcom-ngd-ctrl.c:1470:12: error: 'qcom_slim_ngd_runtime_idle' defined but not used [-Werror=unused-function]

Marking both as __maybe_unused lets us get rid of the warning
as well as the #ifdef.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.18.0
