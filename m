From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: rename rdma_ch_bit_map to
	dma_ch_bit_map" to the asoc tree
Date: Sun, 21 Feb 2016 02:14:56 +0900
Message-ID: <E1aXB7Q-0008HW-Nk@finisterre>
References: <1454347747-10758-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F60265051
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:03 +0100 (CET)
In-Reply-To: <1454347747-10758-1-git-send-email-srinivas.kandagatla@linaro.org>
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

   ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map

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

>From 4d809fb12189aef9419f7337bb1767de85699003 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:51 +0000
Subject: [PATCH] ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map

rdma_ch_bit_map can be reused for wrdma channel allocations as wrdma
channel numbering start after rdma channel numbers.
With capture support referring rdma_ch_bit_map for wrdma channel allocation
is confusing, so renaming rdma_ch_bit_map to dma_ch_bit_map makes sense.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-apq8016.c | 6 +++---
 sound/soc/qcom/lpass.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 99061f4..ca3bbd5 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -137,20 +137,20 @@ static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
 					   int direction)
 {
 	struct lpass_variant *v = drvdata->variant;
-	int chan = find_first_zero_bit(&drvdata->rdma_ch_bit_map,
+	int chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
 					v->rdma_channels);
 
 	if (chan >= v->rdma_channels)
 		return -EBUSY;
 
-	set_bit(chan, &drvdata->rdma_ch_bit_map);
+	set_bit(chan, &drvdata->dma_ch_bit_map);
 
 	return chan;
 }
 
 static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 {
-	clear_bit(chan, &drvdata->rdma_ch_bit_map);
+	clear_bit(chan, &drvdata->dma_ch_bit_map);
 
 	return 0;
 }
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 8475b60..30714ad 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -50,7 +50,7 @@ struct lpass_data {
 	struct lpass_variant *variant;
 
 	/* bit map to keep track of static channel allocations */
-	unsigned long rdma_ch_bit_map;
+	unsigned long dma_ch_bit_map;
 
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
-- 
2.7.0
