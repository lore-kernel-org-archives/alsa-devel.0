From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: qcom: remove IS_ERR_VALUE usage
	on int.
Date: Thu, 31 Mar 2016 19:23:15 +0100
Message-ID: <1459448595-18620-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459448595-18620-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 3226C2667D1
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:23:24 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id f198so12431770wme.0
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 11:23:24 -0700 (PDT)
In-Reply-To: <1459448595-18620-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kwestfie@codeaurora.org
Cc: plai@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

IS_ERR_VALUE should be used only with unsigned long type,
signed types should use comparison 'ret < 0'

This patch removes such usages.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1
	- split the patch into two as suggested by Mark.

 sound/soc/qcom/lpass-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index f5cae01..db000c6 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -491,7 +491,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 			data->rdma_ch = v->alloc_dma_channel(drvdata,
 						SNDRV_PCM_STREAM_PLAYBACK);
 
-		if (IS_ERR_VALUE(data->rdma_ch))
+		if (data->rdma_ch < 0)
 			return data->rdma_ch;
 
 		drvdata->substream[data->rdma_ch] = psubstream;
@@ -518,8 +518,10 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 			data->wrdma_ch = v->alloc_dma_channel(drvdata,
 						SNDRV_PCM_STREAM_CAPTURE);
 
-		if (IS_ERR_VALUE(data->wrdma_ch))
+		if (data->wrdma_ch < 0) {
+			ret = data->wrdma_ch;
 			goto capture_alloc_err;
+		}
 
 		drvdata->substream[data->wrdma_ch] = csubstream;
 
-- 
2.5.0
