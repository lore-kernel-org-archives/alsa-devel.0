From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: ipq806x: add wrdma related
	register offsets" to the asoc tree
Date: Sun, 21 Feb 2016 02:14:45 +0900
Message-ID: <E1aXB7F-0008Gx-7z@finisterre>
References: <1454347729-10592-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C095E2606F5
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:14:55 +0100 (CET)
In-Reply-To: <1454347729-10592-1-git-send-email-srinivas.kandagatla@linaro.org>
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

   ASoC: qcom: ipq806x: add wrdma related register offsets

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

>From 0a14a1bf2e81a75c5b814a3904f971fb5a53c068 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:57 +0000
Subject: [PATCH] ASoC: qcom: ipq806x: add wrdma related register offsets

This patch adds wrdma related register offsets to the lpass variant data
of ipq806x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 29a3529..608c1a9 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -86,6 +86,10 @@ static struct lpass_variant ipq806x_data = {
 	.rdma_reg_base		= 0x6000,
 	.rdma_reg_stride	= 0x1000,
 	.rdma_channels		= 4,
+	.wrdma_reg_base		= 0xB000,
+	.wrdma_reg_stride	= 0x1000,
+	.wrdma_channel_start	= 5,
+	.wrdma_channels		= 4,
 	.dai_driver		= &ipq806x_lpass_cpu_dai_driver,
 	.num_dai		= 1,
 	.alloc_dma_channel	= ipq806x_lpass_alloc_dma_channel,
-- 
2.7.0
