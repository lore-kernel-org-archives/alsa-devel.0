From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/11] ASoC: qdsp6: q6routing: add proper error
	check
Date: Mon, 25 Jun 2018 15:31:15 +0100
Message-ID: <20180625143115.8346-12-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C295267822
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 16:33:59 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id i139-v6so2585334wmf.4
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:33:59 -0700 (PDT)
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

q6adm_open can return error pointer or a null in error cases.
Fix this check this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index caf2f847a886..c18f808c7730 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -310,7 +310,7 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 			      session->channels, topology, perf_mode,
 			      session->bits_per_sample, 0, 0);
 
-	if (!copp) {
+	if (IS_ERR_OR_NULL(copp)) {
 		mutex_unlock(&routing_data->lock);
 		return -EINVAL;
 	}
-- 
2.16.2
