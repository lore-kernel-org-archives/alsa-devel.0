From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/12] ASoC: qdsp6: q6routing: support dt
	based module loading
Date: Tue, 26 Jun 2018 10:20:13 +0100
Message-ID: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1EB267889
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:22:33 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so1024545wmc.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:22:33 -0700 (PDT)
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..ab696bf8d1d3 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6pcm_routing_device_id[] = {
+	{ .compatible = "qcom,q6adm-routing" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
+
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
 		.name = "q6routing",
+		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
 	},
 	.probe = q6pcm_routing_probe,
 	.remove = q6pcm_routing_remove,
-- 
2.16.2
