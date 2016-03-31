From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: Fix some static checker warnings
Date: Thu, 31 Mar 2016 12:21:52 +0100
Message-ID: <1459423312-6334-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA5A2612CC
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 13:21:55 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id 20so109438649wmh.1
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 04:21:55 -0700 (PDT)
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

This patch fixes below static checker warning plus suggestions from Dan.

sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
error: uninitialized symbol 'ret'.

sound/soc/qcom/lpass-platform.c
515          csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
516          if (csubstream) {
517                  if (v->alloc_dma_channel)
518                          data->wrdma_ch = v->alloc_dma_channel(drvdata,
519                                              SNDRV_PCM_STREAM_CAPTURE);
520
521                  if (IS_ERR_VALUE(data->wrdma_ch))
522                          goto capture_alloc_err;

 wrdma_ch is an int so this should just be:

			if (data->wrdma_ch < 0) {
				ret = data->wrdma_ch;
				goto capture_alloc_err;
			}

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 6e86654..db000c6 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -474,7 +474,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret;
+	int ret = -EINVAL;
 	struct lpass_pcm_data *data;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
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
