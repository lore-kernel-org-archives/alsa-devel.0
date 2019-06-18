From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] slimbus: core: generate uevent for non-dt only
Date: Mon, 17 Jun 2019 22:26:44 -0700
Message-ID: <20190618052644.32446-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9109AF89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 07:26:49 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id d126so6952490pfd.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 22:26:49 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Rely on MODULE_ALIAS() for automatic kernel module loading, rather than
basing it on the OF compatible. This ensures that drivers without
of_device_id table, such as wcd9335, will be automatically loaded.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[bjorn: Added commit message]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/slimbus/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index b2f07d2043eb..526e3215d8fe 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -98,11 +98,6 @@ static int slim_device_remove(struct device *dev)
 static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct slim_device *sbdev = to_slim_device(dev);
-	int ret;
-
-	ret = of_device_uevent_modalias(dev, env);
-	if (ret != -ENODEV)
-		return ret;
 
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
-- 
2.18.0
