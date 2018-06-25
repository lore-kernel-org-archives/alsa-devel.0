From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/11] ASoC: qdsp6: q6afe: use
	of_platform_populate/depopulate()
Date: Mon, 25 Jun 2018 15:31:10 +0100
Message-ID: <20180625143115.8346-7-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CF67B2677FC
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 16:33:53 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so9527122wmc.3
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:33:53 -0700 (PDT)
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
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 01f43218984b..621b67b34db9 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -316,7 +316,6 @@ struct q6afe {
 	struct mutex lock;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
-	struct platform_device *pdev_dais;
 };
 
 struct afe_port_cmd_device_start {
@@ -1438,7 +1437,6 @@ static int q6afe_probe(struct apr_device *adev)
 {
 	struct q6afe *afe;
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
@@ -1453,22 +1451,12 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		afe->pdev_dais = of_platform_device_create(dais_np,
-							   "q6afe-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6afe_remove(struct apr_device *adev)
 {
-	struct q6afe *afe = dev_get_drvdata(&adev->dev);
-
-	if (afe->pdev_dais)
-		of_platform_device_destroy(&afe->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2
