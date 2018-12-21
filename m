From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/4] ASoC: qdsp6: q6asm-dai: Fix a small memory
	leak
Date: Fri, 21 Dec 2018 12:06:10 +0300
Message-ID: <20181221090610.GC2735@kadam>
References: <20181221090442.GA2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CAE3267AB2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 10:06:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181221090442.GA2735@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

We can't return directly if snd_dma_alloc_pages() fails; we first need
to free prtd->audio_client and prtd.

Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 3407e51b8861..548eb4fa2da6 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -573,8 +573,7 @@ static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
 	if (IS_ERR(prtd->audio_client)) {
 		dev_err(dev, "Could not allocate memory\n");
 		ret = PTR_ERR(prtd->audio_client);
-		kfree(prtd);
-		return ret;
+		goto free_prtd;
 	}
 
 	size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE *
@@ -583,7 +582,7 @@ static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
 				  &prtd->dma_buffer);
 	if (ret) {
 		dev_err(dev, "Cannot allocate buffer(s)\n");
-		return ret;
+		goto free_client;
 	}
 
 	if (pdata->sid < 0)
@@ -596,6 +595,13 @@ static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
 	runtime->private_data = prtd;
 
 	return 0;
+
+free_client:
+	q6asm_audio_client_free(prtd->audio_client);
+free_prtd:
+	kfree(prtd);
+
+	return ret;
 }
 
 static int q6asm_dai_compr_free(struct snd_compr_stream *stream)
-- 
2.17.1
