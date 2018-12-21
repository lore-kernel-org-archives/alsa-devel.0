From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: Fix a small memory
	leak" to the asoc tree
Date: Fri, 21 Dec 2018 13:42:25 +0000 (GMT)
Message-ID: <20181221134225.EDCC51121B93@debutante.sirena.org.uk>
References: <20181221090610.GC2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3068267ABE
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:42:26 +0100 (CET)
In-Reply-To: <20181221090610.GC2735@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6asm-dai: Fix a small memory leak

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 686a6dace3bd783ef9f747e9c2cff68038be0e3a Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Dec 2018 12:06:10 +0300
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: Fix a small memory leak

We can't return directly if snd_dma_alloc_pages() fails; we first need
to free prtd->audio_client and prtd.

Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
