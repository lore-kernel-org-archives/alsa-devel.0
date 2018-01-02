From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] slimbus: qcom: Fix return value check in
	qcom_slim_probe()
Date: Tue, 2 Jan 2018 01:46:11 +0000
Message-ID: <1514857571-84018-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C12267219
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 02:40:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 35ad70d..96fefd6 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -530,9 +530,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (!ctrl->base) {
+	if (IS_ERR(ctrl->base)) {
 		dev_err(&pdev->dev, "IOremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(ctrl->base);
 	}
 
 	sctrl->set_laddr = qcom_set_laddr;
