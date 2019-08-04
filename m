From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Add of_node_put()
	before return
Date: Sun,  4 Aug 2019 21:52:01 +0530
Message-ID: <20190804162201.5838-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B488F800F4
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 18:22:15 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id d1so5606402pgp.4
 for <alsa-devel@alsa-project.org>; Sun, 04 Aug 2019 09:22:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: agross@kernel.org, srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a return from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
return in two places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f3585777324c..29fbab55c3b3 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1338,12 +1338,15 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			continue;
 
 		ngd = kzalloc(sizeof(*ngd), GFP_KERNEL);
-		if (!ngd)
+		if (!ngd) {
+			of_node_put(node);
 			return -ENOMEM;
+		}
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
 		if (!ngd->pdev) {
 			kfree(ngd);
+			of_node_put(node);
 			return -ENOMEM;
 		}
 		ngd->id = id;
-- 
2.19.1
