From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lpass-ipq806x: Staticise local symbols"
	to the asoc tree
Date: Wed, 29 Jul 2015 15:13:09 +0100
Message-ID: <E1ZKS6X-0004ZZ-H2@finisterre>
References: <1437987388-9706-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A687026590E
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:21 +0200 (CEST)
In-Reply-To: <1437987388-9706-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lpass-ipq806x: Staticise local symbols

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

>From eccad574ef2d74e7519a092d9822932a27c6f165 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 27 Jul 2015 10:56:24 +0200
Subject: [PATCH] ASoC: lpass-ipq806x: Staticise local symbols

ipq806x_data is not used outside this file, so it can be static.
Fixes the following sparse warning:

	sound/soc/qcom/lpass-ipq806x.c:76:22: warning: symbol 'ipq806x_data'
		was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 7356d3a..7a41679 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -73,7 +73,7 @@ static int ipq806x_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 	return 0;
 }
 
-struct lpass_variant ipq806x_data = {
+static struct lpass_variant ipq806x_data = {
 	.i2sctrl_reg_base	= 0x0010,
 	.i2sctrl_reg_stride	= 0x04,
 	.i2s_ports		= 5,
-- 
2.1.4
