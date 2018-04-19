From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 45/61] slimbus: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:15 +0200
Message-ID: <20180419140641.27926-46-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DA9267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:07:08 +0200 (CEST)
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/slimbus/qcom-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ffb46f915334..45c38fff15d2 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -655,8 +655,7 @@ static int qcom_slim_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int qcom_slim_runtime_suspend(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
@@ -673,8 +672,7 @@ static int qcom_slim_runtime_suspend(struct device *device)
 
 static int qcom_slim_runtime_resume(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret = 0;
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
-- 
2.11.0
