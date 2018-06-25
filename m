From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/11] ASoC: qdsp6: q6asm: use
	of_platform_populate/depopulate()
Date: Mon, 25 Jun 2018 15:31:09 +0100
Message-ID: <20180625143115.8346-6-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id A723D2675C8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 16:33:52 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id c13-v6so3979748wrq.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:33:52 -0700 (PDT)
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
 sound/soc/qcom/qdsp6/q6asm.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 530852385cad..2b2c7233bb5f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -174,10 +174,8 @@ struct q6asm {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	wait_queue_head_t mem_wait;
-	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
-	struct platform_device *pdev_dais;
 };
 
 struct audio_client {
@@ -1344,7 +1342,6 @@ EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
 static int q6asm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6asm *q6asm;
 
 	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
@@ -1359,22 +1356,12 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		q6asm->pdev_dais = of_platform_device_create(dais_np,
-							   "q6asm-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6asm_remove(struct apr_device *adev)
 {
-	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
-
-	if (q6asm->pdev_dais)
-		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2
