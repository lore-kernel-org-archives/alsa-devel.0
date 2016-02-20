From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: ipq806x: add error in dma
	allocation." to the asoc tree
Date: Sun, 21 Feb 2016 02:14:59 +0900
Message-ID: <E1aXB7T-0008I6-6P@finisterre>
References: <1455099533-532-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 015DB265068
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:05 +0100 (CET)
In-Reply-To: <1455099533-532-1-git-send-email-srinivas.kandagatla@linaro.org>
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

   ASoC: qcom: ipq806x: add error in dma allocation.

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

>From 0a536400ad2ea72c80e6257fa71aa78d17bd43e3 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:45 +0000
Subject: [PATCH] ASoC: qcom: ipq806x: add error in dma allocation.

ipq806x is only ever tested for playback so return error in dma allocation
if the stream direction is capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-ipq806x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 119048c..29a3529 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -65,7 +65,10 @@ static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
 
 static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata, int dir)
 {
-	return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
+	else	/* Capture currently not implemented */
+		return -EINVAL;
 }
 
 static int ipq806x_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
-- 
2.7.0
