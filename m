From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: pass direction to dma allocation"
	to the asoc tree
Date: Sun, 21 Feb 2016 02:15:01 +0900
Message-ID: <E1aXB7V-0008Ib-Eb@finisterre>
References: <1455099519-490-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BCE26151C
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:14 +0100 (CET)
In-Reply-To: <1455099519-490-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: pass direction to dma allocation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 73c847b6d3670e4521cd3f603102332614d0b640 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:37 +0000
Subject: [PATCH] ASoC: qcom: pass direction to dma allocation

This patch updates the internal dma allocation callbacks to take the
stream direction so that it can allocate channels suitable for that
stream direction. Before the capture support this was not necessary.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-apq8016.c  | 3 ++-
 sound/soc/qcom/lpass-ipq806x.c  | 2 +-
 sound/soc/qcom/lpass-platform.c | 3 ++-
 sound/soc/qcom/lpass.h          | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 6cc7e72..99061f4 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -133,7 +133,8 @@ static struct snd_soc_dai_driver apq8016_lpass_cpu_dai_driver[] = {
 	},
 };
 
-static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata)
+static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
+					   int direction)
 {
 	struct lpass_variant *v = drvdata->variant;
 	int chan = find_first_zero_bit(&drvdata->rdma_ch_bit_map,
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 7a41679..119048c 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -63,7 +63,7 @@ static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
 	.ops    = &asoc_qcom_lpass_cpu_dai_ops,
 };
 
-static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata)
+static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata, int dir)
 {
 	return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
 }
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 7245c2e..69c5ad8 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -457,7 +457,8 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 		return -ENOMEM;
 
 	if (v->alloc_dma_channel)
-		data->rdma_ch = v->alloc_dma_channel(drvdata);
+		data->rdma_ch = v->alloc_dma_channel(drvdata,
+						SNDRV_PCM_STREAM_PLAYBACK);
 
 	if (IS_ERR_VALUE(data->rdma_ch))
 		return data->rdma_ch;
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 412399a..8475b60 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -84,7 +84,7 @@ struct lpass_variant {
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-	int (*alloc_dma_channel)(struct lpass_data *data);
+	int (*alloc_dma_channel)(struct lpass_data *data, int direction);
 	int (*free_dma_channel)(struct lpass_data *data, int ch);
 
 	/* SOC specific dais */
-- 
2.7.0
