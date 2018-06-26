From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 12/12] ASoC: qdsp6: q6asm: remove unused struct q6asm member
Date: Tue, 26 Jun 2018 10:20:16 +0100
Message-ID: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

pcmdev in struct q6asm seems be left over and unused, so just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index c4fd28f168d5..2b2c7233bb5f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -174,7 +174,6 @@ struct q6asm {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	wait_queue_head_t mem_wait;
-	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
 };
-- 
2.16.2
