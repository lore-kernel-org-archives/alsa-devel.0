From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/11] ASoC: qdsp6: q6adm: use
	of_platform_populate/depopulate()
Date: Mon, 25 Jun 2018 15:31:08 +0100
Message-ID: <20180625143115.8346-5-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F642675C8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 16:33:51 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so10273734wmg.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:33:51 -0700 (PDT)
In-Reply-To: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 9983c665a941..dfd5bc3ddd52 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -588,7 +588,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
 static int q6adm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6adm *adm;
 
 	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
@@ -605,22 +604,12 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	dais_np = of_get_child_by_name(dev->of_node, "routing");
-	if (dais_np) {
-		adm->pdev_routing = of_platform_device_create(dais_np,
-							   "q6routing", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6adm_remove(struct apr_device *adev)
 {
-	struct q6adm *adm = dev_get_drvdata(&adev->dev);
-
-	if (adm->pdev_routing)
-		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2
