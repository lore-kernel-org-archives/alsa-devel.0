From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch" to the asoc tree
Date: Mon, 31 Oct 2016 12:31:32 -0600
Message-ID: <E1c1HMq-0002Ou-O6@finisterre>
References: <1477913145-8259-3-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477913145-8259-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgKenneth Westfield <kwestfie@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch

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

>From 4314f928f79f816367a4f09539aeebf7c5b4f5fa Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 31 Oct 2016 11:25:44 +0000
Subject: [PATCH] ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch

This patch cleans up usage of wrdma_ch and rdma_ch variables into a
common variable dma_ch, As there is no real use of tracking the dma
channel in two different variables based on stream direction.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 46 ++++++++---------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 07000f53db44..ca5e19f55a28 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -25,8 +25,7 @@
 #include "lpass.h"
 
 struct lpass_pcm_data {
-	int rdma_ch;
-	int wrdma_ch;
+	int dma_ch;
 	int i2s_port;
 };
 
@@ -91,10 +90,7 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 			return ret;
 	}
 
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		data->rdma_ch = dma_ch;
-	else
-		data->wrdma_ch = dma_ch;
+	data->dma_ch = dma_ch;
 
 	snd_soc_set_runtime_hwparams(substream, &lpass_platform_pcm_hardware);
 
@@ -121,20 +117,12 @@ static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	struct lpass_pcm_data *data;
-	int dma_ch, dir = substream->stream;
 
 	data = runtime->private_data;
 	v = drvdata->variant;
-
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_ch = data->rdma_ch;
-	else
-		dma_ch = data->wrdma_ch;
-
-	drvdata->substream[dma_ch] = NULL;
-
+	drvdata->substream[data->dma_ch] = NULL;
 	if (v->free_dma_channel)
-		v->free_dma_channel(drvdata, dma_ch);
+		v->free_dma_channel(drvdata, data->dma_ch);
 
 	return 0;
 }
@@ -155,10 +143,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	int bitwidth;
 	int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -245,11 +230,7 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	unsigned int reg;
 	int ret;
 
-	if (substream->stream ==  SNDRV_PCM_STREAM_PLAYBACK)
-		reg = LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch);
-	else
-		reg = LPAIF_WRDMACTL_REG(v, pcm_data->wrdma_ch);
-
+	reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream);
 	ret = regmap_write(drvdata->lpaif_map, reg, 0);
 	if (ret)
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
@@ -269,10 +250,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir),
@@ -324,10 +302,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -402,10 +377,7 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	unsigned int base_addr, curr_addr;
 	int ret, ch, dir = substream->stream;
 
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	ret = regmap_read(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir), &base_addr);
-- 
2.10.1
