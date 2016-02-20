From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: rename rdmactl_audif_start to
	dmactrl_audif_start" to the asoc tree
Date: Sun, 21 Feb 2016 02:15:22 +0900
Message-ID: <E1aXB7q-0008JE-KU@finisterre>
References: <1455193050-1620-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 046D826517C
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:38 +0100 (CET)
In-Reply-To: <1455193050-1620-1-git-send-email-srinivas.kandagatla@linaro.org>
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

   ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start

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

>From ec5b82878c36f8c7c6d0d85eacd5185633e6c91b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:30 +0000
Subject: [PATCH] ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start

This patch renames rdmactl_audif_start to dmactrl_audif_start as this
is common for both rdma and wrdma. Without this patch the name would be
bit misleading to the readers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-apq8016.c  | 2 +-
 sound/soc/qcom/lpass-platform.c | 4 ++--
 sound/soc/qcom/lpass.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 94efc01..6cc7e72 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -212,7 +212,7 @@ static struct lpass_variant apq8016_data = {
 	.rdma_reg_base		= 0x8400,
 	.rdma_reg_stride	= 0x1000,
 	.rdma_channels		= 2,
-	.rdmactl_audif_start	= 1,
+	.dmactl_audif_start	= 1,
 	.dai_driver		= apq8016_lpass_cpu_dai_driver,
 	.num_dai		= ARRAY_SIZE(apq8016_lpass_cpu_dai_driver),
 	.init			= apq8016_lpass_init,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index ec2414d..7245c2e 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	int bitwidth;
-	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
+	int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -101,7 +101,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	regval = LPAIF_RDMACTL_BURSTEN_INCR4 |
-			LPAIF_RDMACTL_AUDINTF(rdma_port) |
+			LPAIF_RDMACTL_AUDINTF(dma_port) |
 			LPAIF_RDMACTL_FIFOWM_8;
 
 	switch (bitwidth) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 024a771..412399a 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -79,7 +79,7 @@ struct lpass_variant {
 	 * on SOCs like APQ8016 the channel control bits start
 	 * at different offset to ipq806x
 	 **/
-	u32	rdmactl_audif_start;
+	u32	dmactl_audif_start;
 	u32	wrdma_channel_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
-- 
2.7.0
