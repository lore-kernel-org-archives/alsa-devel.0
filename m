From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: remove IS_ERR_VALUE usage on
	int." to the asoc tree
Date: Thu, 31 Mar 2016 11:45:09 -0700
Message-ID: <E1alhaf-0005JD-Aj@finisterre>
References: <1459448595-18620-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C38D0266742
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 20:45:22 +0200 (CEST)
In-Reply-To: <1459448595-18620-3-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: remove IS_ERR_VALUE usage on int.

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

>From cef794f76485f4a4e6affd851ae9f9d0eb4287a5 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 31 Mar 2016 19:23:15 +0100
Subject: [PATCH] ASoC: qcom: remove IS_ERR_VALUE usage on int.

IS_ERR_VALUE should be used only with unsigned long type,
signed types should use comparison 'ret < 0'

This patch removes such usages.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index f5cae01d18bd..db000c6987a1 100644
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
2.8.0.rc3
