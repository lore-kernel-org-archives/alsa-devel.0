From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] slimbus: qcom-ctrl: Fix
 devm_ioremap_resource() error handling
Date: Tue, 9 Jan 2018 12:26:44 +0300
Message-ID: <20180109092644.wa4ubwxkcvc3lyza@mwanda>
References: <20180109092616.mfha2rs56oaxfjaz@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 857A726717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:26:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180109092616.mfha2rs56oaxfjaz@mwanda>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

devm_ioremap_resource() returns error pointers, not NULL so the check
needs to be fixed.

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 3ab59209cbdc..6bf95bf33299 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -528,9 +528,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (!ctrl->base) {
+	if (IS_ERR(ctrl->base)) {
 		dev_err(&pdev->dev, "IOremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(ctrl->base);
 	}
 
 	sctrl->set_laddr = qcom_set_laddr;
