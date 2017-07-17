From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-digital: constify
	snd_soc_dai_ops structure" to the asoc tree
Date: Mon, 17 Jul 2017 17:04:35 +0100
Message-ID: <E1dX8Vf-0004UQ-JC@debutante>
References: <f41455c6c14bb0a662e4fdcce03138974072d12c.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9752C266FE1
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:05:02 +0200 (CEST)
In-Reply-To: <f41455c6c14bb0a662e4fdcce03138974072d12c.1499974826.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-digital: constify snd_soc_dai_ops structure

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

>From a9689bb890ce633c3015ed51e4e2c6ee320fe4dc Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 15:38:14 -0500
Subject: [PATCH] ASoC: codecs: msm8916-wcd-digital: constify snd_soc_dai_ops
 structure

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442af8c9..7e3794fb8c2c 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -788,7 +788,7 @@ static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK, 0);
 }
 
-static struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
+static const struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
 	.startup = msm8916_wcd_digital_startup,
 	.shutdown = msm8916_wcd_digital_shutdown,
 	.hw_params = msm8916_wcd_digital_hw_params,
-- 
2.13.2
